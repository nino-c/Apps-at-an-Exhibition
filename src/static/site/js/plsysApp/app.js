'use strict'

angular
  .module('Exhibition', [
    'ui.bootstrap',
    'ngResource',
    'ngCookies',
    'ngMaterial',
    'services'
  ])


angular
  .module('Exhibition')
  .run(function ($http, $cookies) {
    $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
    })
  .config(function ($routeProvider) {
    var appPath = '/static/site/js/plsysApp/'
    $routeProvider
      .when('/', {
        templateUrl: appPath + 'views/main.html',
        controller: 'ExhibitionController',
      })
      .when('/apps/:id', {
        templateUrl: appPath + 'views/app.html',
        controller: 'AppController',
      })
      .when('/instances/:id', {
        templateUrl: appPath + 'views/instance.html',
        controller: 'InstanceController',
      })
      .otherwise({
        redirectTo: '/',
      })
  })
