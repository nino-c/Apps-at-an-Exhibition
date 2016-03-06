angular
    .module('Exhibition')
    .controller('AppEditorController', ['$rootScope', '$scope', '$location',
        '$route', '$mdToast', 'AppService', 'CategoryService',
        function($rootScope, $scope, $location, $route, $mdToast,
            AppService, 
            CategoryService) {
            
            $scope.categories = CategoryService.query()
            $scope.scriptTypes = $rootScope.scriptTypes

            if ($location.path().indexOf('/apps/new/') > -1) {
                $scope.app = new AppService({
                    title: "New App",
                    source: "function start() {\n\n}",
                    seedStructure: "{\"param1\":{\"default\":\"\"}}"
                });
            } else {
                $scope.app = AppService.get({id:$route.current.params.id})
            }

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
                if ($location.path().indexOf('/apps/new/') > -1) {
                    console.log($scope.app)
                    $scope.app.$save().then(
                        function(app, responseHeaders) {
                            console.log(app);
                            console.log(responseHeaders);
                            $mdToast.showSimple("New app created.")
                        }
                    )
                } else {
                    console.log($scope.app)
                    $scope.app.$update().then(
                        (app, putResponse) => {
                            $mdToast.showSimple("App saved.")
                        })
                }
            }

        }])
