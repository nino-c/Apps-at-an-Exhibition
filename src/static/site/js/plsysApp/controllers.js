
// controllers

// Exhibition.controller('ExhibitionController', ['$scope', 'AppService',
//   function ($scope, AppService, apps) {
//     $scope.apps = apps
//   }])

angular
  .module('Exhibition')
  .controller('ExhibitionController', ['$scope', 'AppService',
    function($scope, AppService) {

      $scope.apps = AppService.query()

      // options for forms
      $scope.scriptTypes = [
        {value:'text/javascript', label: 'javascript'},
        {value:'text/coffeescript', label: 'coffeescript'},
        {value:'text/paperscript', label: 'paperscript'}
      ]

      //options for modals
      $scope.opts = {
          backdropFade: true,
          dialogFade: true
      }
      $scope.open = function (action) {
        if (action === 'edit') $scope.appModalEdit = true
      }
      $scope.close = function (action) {
        if (action === 'edit') $scope.appModalEdit = false
      }
      //calling board service
      var failureCb = function (status) { $console.log(status) }
      $scope.update = function () {
          AppService.update($scope.app).then(function (data) {
              $scope.app = data
              $scope.appModalEdit = false
          }, failureCb)
    }

  }])
  .controller('AppController', ['$scope', '$route', 'AppService',
    function($scope, $route, AppService) {

      $scope.app = AppService.get({id:$route.current.params.id})

      $scope.opts = {
          backdropFade: true,
          dialogFade: true
      }

      // options for forms
      $scope.scriptTypes = [
        {value:'text/javascript', label: 'javascript'},
        {value:'text/coffeescript', label: 'coffeescript'},
        {value:'text/paperscript', label: 'paperscript'}
      ]

      //open modals
      $scope.open = function (action) {
          console.log('open', action)
          if (action === 'create'){
              $scope.appModalCreate = true
              $scope.app = new Object()
              //$scope.app.tags = [];
              //$scope.app.tags_details = [];
          };
      }
      //close modals
      $scope.close = function (action) {
          if (action === 'create'){
              $scope.appModalCreate = false
          };
      }
      //calling board service
      $scope.create = function () {
          console.log('create feed', $score.app)
          ExhibitionService.save($scope.app).then(function (data) {
              $scope.app = data
              $scope.apps.push(data)
              $scope.appModalCreate = false
          }, function(status){
              console.log(status)
          })
      }

    }])
