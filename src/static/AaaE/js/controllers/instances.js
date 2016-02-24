angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', '$location', '$route', 'AppService', 
    ($scope, $location, $route, AppService) => {

    $scope.app = AppService.get({id:$route.current.params.id})

    $scope.selectInstance = (chosenInstance) => {
        $scope.selectedInstance = chosenInstance
        $location.path('/instance/'+$scope.app.id+'/'+chosenInstance.id+'/')
    }

  }
])
