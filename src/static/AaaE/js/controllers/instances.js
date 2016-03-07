angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', 
    '$location', 
    '$route', 
    '$window',
    'AppService',  
    'InstanceService',
    ($scope, $location, $route, $window, AppService, InstanceService) => {

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

      // $scope.selectInstance = (chosenInstance) => {
      //   $scope.selectedInstance = chosenInstance 
      //   //$location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
      //   $window.location = 'index.html#/instance/'+$scope.app.id+'/'+chosenInstance.id+'/';
      // }

  }
])
