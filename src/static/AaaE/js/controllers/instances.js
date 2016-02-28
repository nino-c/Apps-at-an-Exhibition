angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', 
    '$location', 
    '$route', 
    'AppService',  
    'InstanceService',
    ($scope, $location, $route, AppService, InstanceService) => {

    $scope.app = AppService.get({id:$route.current.params.id})
    //$scope.instances = InstanceService.get({id:$route.current.params.id})

    $scope.selectInstance = (chosenInstance) => {
        $scope.selectedInstance = chosenInstance 
        $location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
    }

  }
])
