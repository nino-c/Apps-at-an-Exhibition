angular.module('Exhibition', [
  'ngRoute',
  'ui.bootstrap',
  'ui.codemirror',
  'ngMaterial',
  'ngMessages',
  'ngResource',
  'ngAnimate',
  'ngCookies',
  'colorpicker.module'
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
          templateUrl: 'views/app-list.html'
        })
        .when('/apps/new/', {
          templateUrl: 'views/app-editor.html'
        })
        .when('/apps/:id/', {
          templateUrl: 'views/app-details.html'
        })
        .when('/apps/:id/edit/', {
          templateUrl: 'views/app-editor.html'
        })
        // .when('/instance/new/', {
        //   templateUrl: 'views/app-display.html'
        // })
        .when('/instance/:app_id/:instance_id/', {
          templateUrl: 'views/app-display.html'
        })
        .otherwise({
          redirectTo: '/'
        })

        $resourceProvider.defaults.stripTrailingSlashes = false;




  })
  .run(function($rootScope, $location, $http, $cookies) {

    $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
    $http.defaults.xsrfCookieName = 'csrftoken';
    $http.defaults.xsrfHeaderName = 'X-CSRFToken';

    var history = [];
    $rootScope.$on( "$routeChangeStart", function($event, next, current) {
          
      console.log("routechange", $location.path())
      history.push($location.$$path);

      if ($location.path().indexOf('/instance/') == -1) {
        $rootScope.showCanvas = false;
      } else {
        $rootScope.showCanvas = true;
      }
      
    })

    $rootScope.$on('$routeChangeSuccess', function() {
        history.push($location.$$path);
        MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
    });

    $rootScope.back = function () {
        var prevUrl = history.length > 1 ? history.splice(-2)[0] : "/";
        $location.path(prevUrl);
    };

    $rootScope.scriptTypes = [
        'text/javascript', 
        'text/coffeescript', 
        'text/paperscript'
      ]

    paper.setup('big-canvas');

  })
