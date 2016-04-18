angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', 
    '$location', 
    '$route', 
    '$http',
    '$window',
    '$mdToast',
    '$timeout',
    'AppService',  
    'InstanceService',
    function ($scope, $location, $route, $http, $window, $mdToast, $timeout,
      AppService, InstanceService) {

        $scope.loading = true;

        //var apps = AppService.get({id:$route.current.params.id});
        // well, don't' like them loops, but oh well
        AppService.get({id:$route.current.params.id})
            .$promise.then(function(a) {

                $scope.app = a;

                for (var i=0; i<$scope.app.instances.length; i++) {
                    $scope.app.instances[i]._seed = 
                        JSON.parse($scope.app.instances[i].seed);

                    $scope.app.instances[i].seedlist = 
                        _.pairs($scope.app.instances[i]._seed); 
                }

                $scope.images = _.flatten(
                    _.map($scope.app.instances, function(inst) {
                        return inst.images;
                    })
                );
                
                if ($scope.images.length > 9) {
                    $scope.images = $scope.images.slice(0,9);
                }

                $scope.loading = false;
                

            });

        $scope.selectFirstInstance = function() {
            if ($scope.app.instances.length > 0) {
                $scope.selectInstance($scope.app.instances[0]);
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
