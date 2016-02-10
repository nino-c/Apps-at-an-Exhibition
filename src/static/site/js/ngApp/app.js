'use strict'

var Exhibition = angular.module('Exhibition', ['ui.bootstrap', 'ngCookies'], function ($interpolateProvider) {
        $interpolateProvider.startSymbol('{[{')
        $interpolateProvider.endSymbol('}]}')
    }
)

Exhibition.run(function ($http, $cookies) {
    $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
})

Exhibition.config(function ($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: '/static/site/js/ngApp/views/feed.html',
            controller: 'FeedController',
            resolve: {
                apps: function (ExhibitionService) {
                    return ExhibitionService.list()
                }
            }
        })
        .when('/app/:id', {
            templateUrl: '/static/site/js/ngApp/views/view.html',
            controller: 'ExhibitionController',
            resolve: {
                app: function ($route, ExhibitionService) {
                    var appId = $route.current.params.id
                    return ExhibitionService.get(appId)
                }
            }
        })
        .otherwise({
            redirectTo: '/'
        })
})
