(() => {
    'use strict';

    /**
     * @ngdoc function
     * @name controller
     * @module app.components
     * @description
     *
     * The `controller` controller description.
     *
     */
    angular
        .module('app.components')
        .controller('AppEditor', ['$scope', '$mdDialog', '$mdMedia', ($scope, $mdDialog, $mdMedia) => {
          $scope.showAdvanced = function(ev) {
            $mdDialog.show({
              controller: ($scope, $mdDialog) => {
                $scope.hide = function() {
                  $mdDialog.hide();
                };
                $scope.cancel = function() {
                  $mdDialog.cancel();
                };
                $scope.answer = function(answer) {
                  $mdDialog.hide(answer);
                };
              },
              templateUrl: '/static/site/js/plsysApp/components/app-editor.html',
              parent: angular.element(document.body),
              targetEvent: ev,
              clickOutsideToClose:true,
              fullscreen: true
            })
          };
        }])






})();
