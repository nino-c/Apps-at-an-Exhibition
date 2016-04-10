angular.module('Exhibition', [
  'ngRoute',
  'ui.bootstrap',
  'ui.codemirror',
  'ngMaterial',
  'ngMessages',
  'ngResource',
  'ngAnimate',
  'ngCookies',
  'colorpicker.module',
  'ng.deviceDetector',
  'ngSilent',
  'ngRoute'
  ])
  .value('ui.config', {
    codemirror: {
      lineWrapping : true,
      lineNumbers: true,
      indentWithTabs: true,
      //theme: "monokai",
      viewportMargin: Infinity,
      mode: 'javascript',
      matchBrackets: true,
      //gutters: ['codemirror-gutters']
    }
  }).config(
    function($mdThemingProvider, $routeProvider, $resourceProvider) {

      // $mdThemingProvider.theme('default')
      //     .primaryPalette('light-green', {
      //       'default': '200',
      //       'hue-1': '100',
      //       'hue-2': '500',
      //       'hue-3': 'A200'
      //     })
      //     .accentPalette('lime', {
      //       'default': '500'
      //     })

      $mdThemingProvider.theme('default')
        .primaryPalette('blue-grey')
        .accentPalette('orange')

      $routeProvider
        .when('/', {
          templateUrl: '/static/AaaE/views/categories.html'
        })
        .when('/category/:id/', {
          templateUrl: '/static/AaaE/views/category-list.html'
        })
        .when('/apps/new/', {
          templateUrl: '/static/AaaE/views/app-editor.html'
        })
        .when('/apps/:id/', {
          templateUrl: '/static/AaaE/views/app-details.html'
        })
        .when('/apps/:id/edit/', {
          templateUrl: '/static/AaaE/views/app-editor.html'
        })
        .when('/instance/:app_id/:instance_id/', {
          templateUrl: '/static/AaaE/views/app-display.html',
          reloadOnSearch: false
        })
        .otherwise({
          redirectTo: '/'
        })

        $resourceProvider.defaults.stripTrailingSlashes = false;




  })
  .run(function($rootScope, $location, $http, $cookies, 
      $timeout, $mdToast, $window, AppService) {

    $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
    $http.defaults.xsrfCookieName = 'csrftoken';
    $http.defaults.xsrfHeaderName = 'X-CSRFToken';

    console.log('cookies', $cookies.getAll())

    $rootScope.showBGCanvas = true;
    $rootScope.showAppCanvas = false;

    var history = [];
    $rootScope.$on( "$routeChangeStart", function($event, next, current) {
          
      console.log("routechange", $location.path())
      history.push($location.$$path);

      if ($location.path().indexOf('/instance/') == -1) {
        $rootScope.showAppCanvas = false;
        $rootScope.showBGCanvas = true;
      } else {
        $rootScope.showAppCanvas = true;
        $rootScope.showBGCanvas = false;
      }

      
    })

    // root-scope vars

    $rootScope.scriptTypes = [
        'text/javascript', 
        'text/coffeescript', 
        'text/paperscript'
      ]

    $rootScope.userLoggedIn = isNaN(parseInt($window.USER_ID)) ? false : true;

    $rootScope.$on('$routeChangeSuccess', function() {
        history.push($location.$$path);
        $timeout(function() {
          MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
        }, 500);
    });

    $rootScope.back = function () {
        var prevUrl = history.length > 1 ? history.splice(-2)[0] : "/";
        $location.path(prevUrl);
    };

    $rootScope.toast = function(message) {
      $mdToast.show(
        $mdToast.simple()
          .textContent(message)
          .position('top')
        );
    }

    

    //paper.setup('big-canvas');
    //paper.setup(document.getElementById('bg-canvas'));
    //paper.setup('big-canvas');
    //paper.install($window);

  })
