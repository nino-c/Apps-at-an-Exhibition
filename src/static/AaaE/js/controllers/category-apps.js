
angular
    .module('Exhibition')
    .controller('AppListController', ['$scope', 
    	'$http', 
    	'$location', 
    	'$route', 
    	'CategoryWithApps',
        function ($scope, $http, $location, $route, CategoryWithApps) {

            $scope.loading = true;

            CategoryWithApps.get({id:$route.current.params.id})
                .$promise.then(function(catapps) {
                    $scope.category = catapps;
                    $scope.apps = catapps.apps;
                    $scope.loading = false;
                })
            

            $scope.initialize = function() {
            	// $http({
            	// 	method: 'GET',
            	// 	url: '/game/increment-popularity/category/' + $route.current.params.id + '/'
            	// }).then(function successCallback(response) {
            	// 	console.log('increment response', response);
            	// }, function errorCallback(error) {
            	// 	console.log('increment response', error);
            	// });
            }

            $scope.selectApp = function(chosenApp) {
                $scope.selectedApp = chosenApp
                $location.path('/apps/'+chosenApp.id)
            }


    }])
