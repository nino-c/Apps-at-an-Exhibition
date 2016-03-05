angular
    .module('Exhibition')
    .controller('AppEditorController', ['$rootScope', '$scope', '$location',
        '$route', '$mdToast', 'AppService', 'CategoryService',
        function($rootScope, $scope, $location, $route, $mdToast,
            AppService, 
            CategoryService) {
            
            $scope.categories = CategoryService.query()
            $scope.scriptTypes = $rootScope.scriptTypes

            $scope.app = AppService.get({id:$route.current.params.id})

            $scope.cmOptions = {
              lineWrapping: true,
              lineNumbers: true,
              indentWithTabs: true,
              theme: "monokai",
              mode: 'javascript',
              matchBrackets: true
            }

            $scope.cm2Options = angular.copy($scope.cmOptions);

            $scope.saveapp = function(event) {
                $scope.app.$update().then(
                    (app, putResponse) => {
                        $mdToast.showSimple("App saved.")
                    })
            }

        }])
