angular.module('DummyApp', [
	'ngMaterial'
	])
	.run(function($rootScope) {
		$rootScope.isAngularApp = false;
	});