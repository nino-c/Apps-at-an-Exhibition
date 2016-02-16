(() => {
    'use strict';

    /**
     * @ngdoc module
     * @name app.exhibition
     * @requires dependencies
     * @description
     *
     * The `exhibition` description.
     *
     */
    angular
        .module('app.exhibition', [
          'ui.bootstrap',
          'ui.codemirror',
          'ngMaterial',
          'ngMessages',
          'ngResource',
          'ngRoute',
          'ngAnimate'
        ]);
})();
