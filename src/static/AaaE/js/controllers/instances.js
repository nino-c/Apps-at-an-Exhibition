angular
  .module('Exhibition')
  .controller('InstancesController', ['$scope', '$route', 'AppService', 'InstanceService',
  ($scope, $route, AppService, InstanceService) => {

    $scope.app = AppService.get({id:$route.current.params.id})

  }
])
