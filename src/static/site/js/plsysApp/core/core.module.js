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
      'ngMaterial',
      'ngRoute',
      'app.exhibition'
    ])
    .constant('appPath', '/static/site/js/plsysApp/')


})();
