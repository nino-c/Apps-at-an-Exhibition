(() => {
    'use strict';

    /**
     * @ngdoc function
     * @name Main
     * @module app.core
     * @description
     *
     * The `Main` Main description.
     *
     */
    angular
      .module('app.core')
      .controller('Main', ['$scope', ($scope) => {
        $scope.appPath = '/static/site/js/plsysApp/'
      }])
      .config(['$controllerProvider', '$routeProvider',
        ($controllerProvider, $routeProvider) => {

          var appPath = '/static/site/js/plsysApp/'
          $routeProvider
            .when('/', {
              templateUrl: appPath + 'exhibition/applist.html',
            })
            .when('/apps/:id', {
              templateUrl: appPath + 'exhibition/app.html',
              //controller: 'AppDisplay',
            })
            .when('/instances/:id', {
              templateUrl: appPath + 'components/instance.html',
              //controller: 'InstanceController',
            })
            .otherwise({
              redirectTo: '/',
            })

        }])


})();
