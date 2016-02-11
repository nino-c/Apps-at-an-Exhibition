(() => {
  'use strict'

  angular
    .module('app', [
      'app.core',
      'app.exhibition',
      //'app.layout',
      //'app.components',
      'ngCookies'
    ])
    .run(['$http', '$cookies', function ($http, $cookies) {
      $http.defaults.headers.common['X-CSRFToken'] = $cookies['csrftoken']
    }])

})();
