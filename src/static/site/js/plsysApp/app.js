'use strict'

// declare main module
var Exhibition = angular.module('Exhibition', ['ui.bootstrap', 'ngResource', 'ngCookies', 'services'])


// declare constants
var appPath = '/static/site/js/plsysApp/'

Exhibition.run(function ($http, $cookies) {
  $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
})

Exhibition.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: appPath + 'views/main.html',
      controller: 'ExhibitionController',
    })
    .when('/apps/:id', {
      templateUrl: appPath + 'views/app.html',
      controller: 'AppController',
    })
    // .when('/apps/:id', {
    //   templateUrl: appPath + 'views/app.html',
    //   controller: 'AppController',
    //   resolve: {
    //     app: function ($route, AppService) {
    //       var appId = $route.current.params.id
    //       return AppService.get({id:appId})
    //     }
    //   }
    // })
    .otherwise({
      redirectTo: '/',
    })
})
