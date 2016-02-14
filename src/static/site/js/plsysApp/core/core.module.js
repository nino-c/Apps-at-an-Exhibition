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
      'ui.bootstrap',
      'ngRoute',
      'app.exhibition'
    ])
    .constant('appPath', '/static/site/js/plsysApp/')


})();
