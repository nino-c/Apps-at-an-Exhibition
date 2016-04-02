
  angular
    .module('Exhibition')
    .controller('AppListController', ['$scope', '$location', '$route', 'CategoryWithApps',
      ($scope, $location, $route, CategoryWithApps) => {

        CategoryWithApps.get({id:$route.current.params.id})
          .$promise.then(function(catapps) {
            $scope.category = catapps;
            $scope.apps = catapps.apps;
            console.log($scope.category)
          })
        //$scope.categories = CategoryService.query()

        $scope.selectApp = (chosenApp) => {
          $scope.selectedApp = chosenApp
          $location.path('/apps/'+chosenApp.id)
        }


    }])
