(() => {
  'use strict'

  /**
  * @ngdoc module
  * @name core
  * @requires dependencies
  * @description
  *
  * The `core` description.
  *
  */

  angular
    .module('app.core', [
      'ngRoute',
      'app.exhibition'
    ])
    .constant('appPath', '/static/site/js/plsysApp/')


})();
