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
      var app = AppService.get({id:$route.current.params.id}); //apps;
      app.$promise.then(function(a) {
        for (var i=0; i<app.instances.length; i++) {
          console.log(app.instances[i].seed)
          app.instances[i]._seed = JSON.parse(app.instances[i].seed);
        }

      })
      
      $scope.app = app;
      //console.log($scope.app)

      $scope.selectInstance = (chosenInstance) => {
        $scope.selectedInstance = chosenInstance 
        $location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
        //$window.location = 'index.html#/instance/'+$scope.app.id+'/'+chosenInstance.id+'/';
      }

      // $scope.instantiate = function() {
      //   var seed = {}; 
      //   var struct = JSON.parse($scope.app.seedStructure)
      //   var seed = _.mapObject(struct, (v,k) => {
      //     return v.default;
      //   })
      //   var newInstance = new InstanceService({
      //     game_id: $scope.app.id,
      //     seed: JSON.stringify(seed)
      //   })
      //   console.log(newInstance)
      //   newInstance.$save().then(
      //       function(instance, responseHeaders) {
      //           console.log(instance);
      //           console.log(responseHeaders);
      //           $mdToast.showSimple("New instance created.")
      //       }
      //   )
      // }

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

   



  }
])
