angular
	.module('Exhibition')
	.controller('CategoriesController', ['$scope', '$location', 'CategoryWithApps', 
		'MultivariatePolynomial',
		function($scope, $location, CategoryWithApps, MultivariatePolynomial) {
		
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

		// var terms = ["y", "y^2", "y^3", "y^4", "y^5", "x", "xy", "xy^2", "xy^3", 
		// 	"xy^4", "x^2", "x^2y", "x^2y^2", "x^2y^3", "x^3", "x^3y", "x^3y^2", "x^4", "x^4y", "x^5"];
		// var seed = _.object(terms, _.map(terms, function(t) { return {"type":"number", "default":1} }));
		// console.log(JSON.stringify(seed))

		// {
		// 	"y":{"type":"number", "default":1},
		// 	"y^2":{"type":"number", "default":1},
		// 	"y^3":{"type":"number", "default":1},
		// 	"y^4":{"type":"number", "default":1},
		// 	"y^5":{"type":"number", "default":1},
		// 	"x":{"type":"number", "default":1},
		// 	"xy":{"type":"number", "default":1},
		// 	"xy^2":{"type":"number", "default":1},
		// 	"xy^3":{"type":"number", "default":1},
		// 	"xy^4":{"type":"number", "default":1},
		// 	"x^2":{"type":"number", "default":1},
		// 	"x^2y":{"type":"number", "default":1},
		// 	"x^2y^2":{"type":"number", "default":1},
		// 	"x^2y^3":{"type":"number", "default":1},
		// 	"x^3":{"type":"number", "default":1},
		// 	"x^3y":{"type":"number", "default":1},
		// 	"x^3y^2":{"type":"number", "default":1},
		// 	"x^4":{"type":"number", "default":1},
		// 	"x^4y":{"type":"number", "default":1},
		// 	"x^5":{"type":"number", "default":1}
		// }

		$scope.selectCategory = function(cat) {
			$location.path('/category/'+cat.id);
		}
		
	}]);