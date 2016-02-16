
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
    .config(['$mdThemingProvider', ($mdThemingProvider) => {

        $mdThemingProvider.theme('default')
            .primaryPalette('light-green', {
              'default': '200',
              'hue-1': '100',
              'hue-2': '500',
              'hue-3': 'A200'
            })
            .accentPalette('lime', {
              'default': '500'
            })

    }])
    .controller('Exhibition', ['$rootScope', '$scope', '$location', '$mdDialog', 'AppService', 'CategoryService',
        ($rootScope, $scope, $location, $mdDialog, AppService, CategoryService) => {

        $scope.apps = AppService.query()

        // options for forms
        $rootScope.scriptTypes = [
          {name:'text/javascript', label: 'javascript'},
          {name:'text/coffeescript', label: 'coffeescript'},
          {name:'text/paperscript', label: 'paperscript'}
        ]

        $scope.categories = CategoryService.query()

        $scope.selectApp = (chosenApp) => {
          $location.path('/apps/'+chosenApp.id)
        }

        $scope.createApp = (event) => {

          // create new app
          $scope.app = {
            title:'New App',
            description:'',
            scriptType: "text/javascript",
            source:"",
            seedStructure:'{"property": {"default":""}}',
            extraIncludes: []
          }

          $mdDialog.show({
              controller: ($rootScope, $scope) => {

                $scope.scriptTypes = $rootScope.scriptTypes

                $scope.editorOptions = {
                  lineWrapping : true,
                  lineNumbers: true,
                  indentWithTabs: true,
                  theme: "monokai",
                  mode: 'javascript',
                  matchBrackets: true
                }

                $scope.cmModel = "function startApp() {\n\n}"

              },
              parent: angular.element(document.body),
              targetEvent: event,
              templateUrl: '/static/site/js/plsysApp/components/app-editor-material.html',
              clickOutsideToClose:true,
              fullscreen: false
          })
        }
    }])
    .controller('AppDisplay', ['$scope', '$route', 'AppService', ($scope, $route, AppService) => {

        $scope.app = AppService.get({id:$route.current.params.id})

        // options for forms
        $scope.scriptTypes = $rootScope.scriptTypes
      }
    ])
    .controller('InstanceDisplay', [
      '$scope', '$route', 'InstanceService', ($scope, $route, InstanceService) => {

        $scope.app = InstanceService.get({id:$route.current.params.id})

        // options for forms
        $scope.scriptTypes = [
          {value:'text/javascript', label: 'javascript'},
          {value:'text/coffeescript', label: 'coffeescript'},
          {value:'text/paperscript', label: 'paperscript'}
        ]
      }
    ])


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
