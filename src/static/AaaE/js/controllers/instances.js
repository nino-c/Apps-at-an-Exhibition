angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', 
    '$location', 
    '$route', 
    '$http',
    '$window',
    '$mdToast',
    '$timeout',
    'OrderedInstanceService',  
    'AppServiceMinimal',
    'InstanceService',
    function ($scope, $location, $route, $http, $window, $mdToast, $timeout,
      OrderedInstanceService, AppServiceMinimal, InstanceService) {

        $scope.loading = true;
        $scope.loadingInstances = true;

        AppServiceMinimal.get({id:$route.current.params.id})
            .$promise.then(function(app_min) {

                $scope.app = app_min;
                $scope.loading = false;                

                OrderedInstanceService.query({id:$route.current.params.id})
                    .$promise.then(function(instances) {
                        
                        $scope.instances = instances;

                        for (var i=0; i<$scope.instances.length; i++) {
                            $scope.instances[i]._seed = JSON.parse($scope.instances[i].seed);
                            $scope.instances[i].seedlist = _.pairs($scope.instances[i]._seed); 
                        }

                        $scope.loadingInstances = false;

                        $http({
                            method: 'GET',
                            url: '/game/increment-popularity/app/' + $scope.app.id + '/'
                        }).then(function successCallback(response) {
                            console.log('increment response', response);
                        }, function errorCallback(error) {
                            console.log('increment response', error);
                        });

                    });

            });


        $scope.selectFirstInstance = function() {
            if ($scope.instances.length > 0) {
                $scope.selectInstance($scope.instances[0]);
            } else {
                $scope.instantiate();
            }
        };

        $scope.playApp = function() {
            
        }

        $scope.selectInstance = function(chosenInstance) {
            $scope.selectedInstance = chosenInstance
            $location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
        };

        $scope.instantiate = function() {
            InstanceService.save()
                .$promise.then(function(response) {
                    if (response.data.id) {

                        $location.path('/instance/'+$scope.app.id+'/'+response.data.id+'/');
                        $rootScope.toast("New instance created");
                    }
                });
        };

        $scope.delete = function() {
            if (confirm("Are you sure you want to delete this app?")) {
                AppService.$delete({id:$scope.app.id}).$promise.then(function(response) {
                // $scope.app = _.reject(
                //   $scope.app, function(a) {
                //     return a.id == $scope.app.id;
                //   })
                console.log(response);
              });
            }
        };

    $scope.deleteInstance = function($event, instance) {
        
        $event.stopPropagation();
        $event.preventDefault();

        if (confirm("Are you sure you want to delete this instance?")) {
          
            InstanceService.remove({id:instance.id}, function(response) {
                console.log('deleted', response)
                $scope.app.instances = _.reject(
                    $scope.app.instances, function(inst) {
                    return inst.id == instance.id;
                });
            })

        }
    };

   
  }
])
