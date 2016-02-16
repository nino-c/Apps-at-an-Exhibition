(() => {
    'use strict';

    /**
     * @ngdoc service
     * @name AppService
     * @module app.exhibition
     * @requires dependencies
     * @description
     *
     * The `service` service description.
     *
     */
    angular
        .module('app.exhibition')
        .factory('AppService', ['$resource', ($resource) => {
          return $resource('/exhibitions/api/apps/:id', {id:'@id'})
        }])
        .factory('InstanceService', ['$resource', ($resource) => {
          return $resource('/exhibitions/api/instances/:id', {id:'@id'})
        }])
        .factory('CategoryService', ['$resource', ($resource) => {
          return $resource('/exhibitions/api/categories', {id:'@id'})
        }])

})();
