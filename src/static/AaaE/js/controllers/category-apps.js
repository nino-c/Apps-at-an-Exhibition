
  angular
    .module('Exhibition')
    .controller('AppListController', ['$scope', '$location', '$route', 'CategoryWithApps',
      function ($scope, $location, $route, CategoryWithApps) {

        $scope.loading = true;

        CategoryWithApps.get({id:$route.current.params.id})
          .$promise.then(function(catapps) {
            $scope.category = catapps;
            $scope.apps = catapps.apps;
            
            $scope.loading = false;

          })
        //$scope.categories = CategoryService.query()

        $scope.selectApp = function(chosenApp) {
          $scope.selectedApp = chosenApp
          $location.path('/apps/'+chosenApp.id)
        }


    }])
