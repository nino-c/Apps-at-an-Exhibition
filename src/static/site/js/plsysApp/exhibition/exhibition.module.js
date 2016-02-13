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
          'app.core',
          'app.components',
          'ui.bootstrap',
          'ngResource',
          'ngRoute'
        ]);
})();
