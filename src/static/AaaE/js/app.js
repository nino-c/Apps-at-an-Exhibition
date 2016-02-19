angular.module('Exhibition', [
  'ngRoute',
  'ui.bootstrap',
  'ui.codemirror',
  'ngMaterial',
  'ngMessages',
  'ngResource',
  'ngAnimate',
  'ngCookies'
  ])
  .value('ui.config', {
    codemirror: {
      lineWrapping : true,
      lineNumbers: true,
      indentWithTabs: true,
      theme: "monokai",
      mode: 'javascript',
      matchBrackets: true
    }
  }).config(
    ($mdThemingProvider, $routeProvider, $resourceProvider) => {

      $mdThemingProvider.theme('default')
          .primaryPalette('light-green', {
            'default': '200',
            'hue-1': '100',
            'hue-2': '500',
            'hue-3': 'A200'
          })
          .accentPalette('lime', {
            'default': '500'
          })

      $routeProvider
        .when('/', {
          templateUrl: 'views/app-list.html',
        })
        .when('/apps/:id', {
          templateUrl: 'views/instances.html',
        })
        .when('/instance/:id', {
          templateUrl: 'views/instance.html',
        })
        .otherwise({
          redirectTo: '/',
        })

        $resourceProvider.defaults.stripTrailingSlashes = false;

  })
  .run(function($http, $cookies) {
    // $rootScope.$on('$routeChangeError', function(event, current, previous, rejection) {
    //   console.log(event, current, previous, rejection)
    // })
    $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
  })
