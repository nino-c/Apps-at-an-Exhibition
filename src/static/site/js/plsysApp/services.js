
// services

angular.module('services', [])

angular
  .module('services')
  .factory('AppService', ['$resource',
    function ($resource) {
      return $resource('/exhibitions/api/apps/:id', {id:'@id'})
    }])
  .factory('InstanceService', ['$resource',
    function ($resource) {
      return $resource('/exhibitions/api/instances/:id', {id:'@id'})
    }])
