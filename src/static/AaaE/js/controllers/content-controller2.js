angular
	.module('DummyApp')
	.controller('ContentController2', ['$rootScope', '$scope', function($rootScope, $scope) {
		
		$scope.isAngularApp = $rootScope.isAngularApp;
		
	}]);