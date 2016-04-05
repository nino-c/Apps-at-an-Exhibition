angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', 
    '$location', 
    '$route', 
    '$http',
    '$window',
    '$mdToast',
    'AppService',  
    'InstanceService',
    ($scope, $location, $route, $http, $window, $mdToast, 
      AppService, InstanceService) => {

      //var apps = AppService.get({id:$route.current.params.id});
      // well, don't' like them loops, but oh well
      $scope.app = AppService.get({id:$route.current.params.id}); 
      $scope.app.$promise.then(function(a) {
        
        for (var i=0; i<$scope.app.instances.length; i++) {
          $scope.app.instances[i]._seed = 
            JSON.parse($scope.app.instances[i].seed);

          $scope.app.instances[i].seedlist = _.pairs($scope.app.instances[i]._seed); 
        }

        $scope.snapshots = _.flatten(
          _.map($scope.app.instances, function(inst) {
            return inst.snapshots;
          })
        );
        if ($scope.snapshots.length > 9) {
          $scope.snapshots = $scope.snapshots.slice(0,9);
        }

      })

      $scope.selectFirstInstance = function() {
        if ($scope.app.instances.length > 0) {
          $scope.selectInstance($scope.app.instances[0]);
        } else {
          $scope.instantiate();
        }
      };

      $scope.selectInstance = (chosenInstance) => {
        $scope.selectedInstance = chosenInstance 
        $location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
        //$window.location = 'index.html#/instance/'+$scope.app.id+'/'+chosenInstance.id+'/';
      }

      $scope.instantiate = function() {
        $http({
          method: 'GET',
          url: '/game/app-instantiate/' + $scope.app.id + '/'
        }).then(function successCallback(response) {
          console.log(response)
          $location.path('/instance/'+$scope.app.id+'/'+response.data.id+'/')
          $mdToast.showSimple("New instance created");
        }, function errorCallback(response) {
          console.log('error', response)
        });
      }

      $scope.delete = function() {
        if (confirm("Are you sure you want to delete this app?")) {
          $scope.app.$remove().then(function successCallback(response) {
            console.log(response)
            //$location.path('/instance/'+$scope.app.id+'/'+response.data.id+'/')
            $mdToast.showSimple("App deleted successfully");
          }, function errorCallback(response) {
            console.log('error', response)
          });
        }
      }

      $scope.deleteInstance = function($event, instance) {
        
        $event.stopPropagation();
        $event.preventDefault();

        if (confirm("Are you sure you want to delete this instance?")) {
          
          InstanceService.remove({id:instance.id}, function(response) {
            console.log('deleted', response)
            $scope.app.instances = _.reject(
              $scope.app.instances, function(inst) {
                return inst.id == instance.id;
              })
          })

        }
      }

   



  }
])
