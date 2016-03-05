
    angular
        .module('Exhibition')
        .factory('AppService', ['$resource', ($resource) => {
          return $resource('/game/api/apps/:id/', {id:'@id'}, { 
              update: {
                  method: 'PUT'
              }
          })
        }])
        .factory('InstanceService', ['$resource', ($resource) => {
          return $resource('/game/api/instances/:id/', {id:'@id'})
        }])
        .factory('CategoryService', ['$resource', ($resource) => {
          return $resource('/game/api/categories/:id/', {id:'@id'})
        }])
