
// controllers

// Exhibition.controller('ExhibitionController', ['$scope', 'AppService',
//   function ($scope, AppService, apps) {
//     $scope.apps = apps
//   }])

Exhibition.controller('ExhibitionController', ['$scope', 'AppService',
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
      //open modals
      $scope.open = function (action) {
          if (action === 'edit'){
              $scope.appModalEdit = true
          };
      }
      //close modals
      $scope.close = function (action) {
          if (action === 'edit'){
              $scope.appModalEdit = false
          };
      }
      //calling board service
      $scope.update = function () {
          AppService.update($scope.app).then(function (data) {
              $scope.app = data
              $scope.appModalEdit = false
          }, failureCb)
    }

    var failureCb = function (status) { console.log(status) }

    }])
  .controller('AppController', ['$scope', '$route', 'AppService',
    function($scope, $route, AppService) {
      var appId = $route.current.params.id
      $scope.app = AppService.get({id:appId})
    }])

// Exhibition.controller('AppController',
//   function ($scope, app) {
//     $scope.app = app
//   })
