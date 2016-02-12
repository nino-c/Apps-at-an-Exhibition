
(() => {
  'use strict';

  /**
  * @ngdoc function
  * @name Exhibition
  * @module app.exhibition
  * @description
  *
  * The `controller` controller description.
  *
  */
  angular
    .module('app.exhibition')
    .controller('Exhibition', [
      '$scope', 'AppService', ($scope, AppService) => {

        $scope.apps = AppService.query()

        // options for forms
        $scope.scriptTypes = [
          {value:'text/javascript', label: 'javascript'},
          {value:'text/coffeescript', label: 'coffeescript'},
          {value:'text/paperscript', label: 'paperscript'}
        ]
      }
    ])
    .controller('AppDisplay', [
      '$scope', '$route', 'AppService', ($scope, $route, AppService) => {

        $scope.app = AppService.get({id:$route.current.params.id})

        // options for forms
        $scope.scriptTypes = [
          {value:'text/javascript', label: 'javascript'},
          {value:'text/coffeescript', label: 'coffeescript'},
          {value:'text/paperscript', label: 'paperscript'}
        ]
      }
    ])
    .config(['$mdThemingProvider', '$mdIconProvider',
      ($mdThemingProvider, $mdIconProvider) => {

        $mdIconProvider
          .defaultIconSet("/static/site/js/plsysApp/assets/svg/avatars.svg", 128)
          .icon("menu", "/static/site/js/plsysApp/assets/svg/menu.svg", 24)
          .icon("share", "/static/site/js/plsysApp/assets/svg/share.svg", 24)
          .icon("google_plus", "/static/site/js/plsysApp/assets/svg/google_plus.svg", 512)
          .icon("hangouts", "/static/site/js/plsysApp/assets/svg/hangouts.svg", 512)
          .icon("twitter", "/static/site/js/plsysApp/assets/svg/twitter.svg", 512)
          .icon("phone", "/static/site/js/plsysApp/assets/svg/phone.svg", 512);

        $mdThemingProvider.theme('default')
            .primaryPalette('brown')
            .accentPalette('red');
    }])

})();

//
// angular
// .module('Exhibition')
// .Exhibition('ExhibitionController', ['$scope', 'AppService',
// function($scope, AppService) {
//
//   $scope.apps = AppService.query()
  //
  // // options for forms
  // $scope.scriptTypes = [
  //   {value:'text/javascript', label: 'javascript'},
  //   {value:'text/coffeescript', label: 'coffeescript'},
  //   {value:'text/paperscript', label: 'paperscript'}
  // ]
//
//   //options for modals
//   $scope.opts = {
//     backdropFade: true,
//     dialogFade: true
//   }
//   $scope.open = function (action) {
//     if (action === 'edit') $scope.appModalEdit = true
//   }
//   $scope.close = function (action) {
//     if (action === 'edit') $scope.appModalEdit = false
//   }
//   //calling board service
//   var failureCb = function (status) { $console.log(status) }
//   $scope.update = function () {
//     AppService.update($scope.app).then(function (data) {
//       $scope.app = data
//       $scope.appModalEdit = false
//     }, failureCb)
//   }
//
// }])
// .Exhibition('AppController', ['$scope', '$route', 'AppService',
// function($scope, $route, AppService) {
//
//   $scope.app = AppService.get({id:$route.current.params.id})
//
//   $scope.opts = {
//     backdropFade: true,
//     dialogFade: true
//   }
//
//   // options for forms
//   $scope.scriptTypes = [
//     {value:'text/javascript', label: 'javascript'},
//     {value:'text/coffeescript', label: 'coffeescript'},
//     {value:'text/paperscript', label: 'paperscript'}
//   ]
//
//   //open modals
//   $scope.open = function (action) {
//     console.log('open', action)
//     if (action === 'create'){
//       $scope.appModalCreate = true
//       $scope.app = new Object()
//       //$scope.app.tags = [];
//       //$scope.app.tags_details = [];
//     };
//   }
//   //close modals
//   $scope.close = function (action) {
//     if (action === 'create'){
//       $scope.appModalCreate = false
//     };
//   }
//   //calling board service
//   $scope.create = function () {
//     console.log('create feed', $score.app)
//     ExhibitionService.save($scope.app).then(function (data) {
//       $scope.app = data
//       $scope.apps.push(data)
//       $scope.appModalCreate = false
//     }, function(status){
//       console.log(status)
//     })
//   }
//
// }])
