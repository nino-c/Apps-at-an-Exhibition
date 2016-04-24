angular
	.module('Exhibition')
	.controller('CategoriesController', ['$rootScope', '$scope', 
		'$location', 'CategoryService', 
		function($rootScope, $scope, $location, CategoryService) {
		
		$scope.loading = true;

		CategoryService.query().$promise.then(function(cats) {
			$scope.categories = cats;
			$scope.loading = false;
		});

		$scope.selectCategory = function(cat) {
			$location.path('/category/'+cat.id);
		}

		$scope.onGridLayout = function($event) {
			//console.log($event)
		}
		
		$scope.init = function() {
			console.log('scope init');
		}

	}]);