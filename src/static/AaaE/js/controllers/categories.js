angular
	.module('Exhibition')
	.controller('CategoriesController', ['$scope', '$location', 'CategoryWithApps', 
		function($scope, $location, CategoryWithApps) {
		
		CategoryWithApps.query().$promise.then(function(cats) {
			$scope.categories = _.map(cats, function(cat) {
				cat.images = _.flatten(
					_.map(cat.apps, function(app) {
						return app.snapshots;
					})
				);
				if (cat.images.length > 15) {
					cat.images = cat.images.slice(0,15);
				}
				return cat;
			});
		});

		$scope.selectCategory = function(cat) {
			$location.path('/category/'+cat.id);
		}
		
	}]);