angular
    .module('Exhibition')
    .controller('AppEditorController', ['$rootScope', '$scope', '$location',
        '$route', '$mdToast', '$interval', '$timeout', 'AppService', 'CategoryService',
        function($rootScope, $scope, $location, $route, $mdToast, $interval, $timeout,
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
                $timeout(function() {
                    $scope.editor1 = true;
                    $scope.editor2 = true;
                }, 500)
                
            } else {
                $scope.app = AppService.get({id:$route.current.params.id})
                $scope.app.$promise.then(function() {
                    console.log('loaded app')
                    $scope.editor1 = true;
                    $scope.editor2 = true;
                })
            }

            $scope.cmOptions = {
              lineWrapping: true,
              lineNumbers: true,
              indentWithTabs: true,
              theme: "monokai",
              mode: 'javascript',
              matchBrackets: true,
            }

            $scope.cm2Options = {
              lineWrapping: true,
              lineNumbers: true,
              indentWithTabs: true,
              theme: "monokai",
              mode: 'javascript',
              matchBrackets: true,
            }

            $scope.initializeEditor = function() {
                // console.log('initEdit')
                // $scope.editor1 = true;
                // $scope.editor2 = true;
            }

            

            $scope.saveapp = function(event) {
                if ($location.path().indexOf('/apps/new/') > -1) {
                    console.log($scope.app)
                    $scope.app.$save().then(
                        function(app, responseHeaders) {
                            $mdToast.showSimple("New app created.");
                            $location.path('/apps/'+app.id)
                        }
                    )
                } else {
                    console.log($scope.app)
                    $scope.app.$update().then(
                        (app, putResponse) => {
                            $mdToast.showSimple("App saved.")
                            $location.path('/apps/'+app.id)
                        })
                }
            }

        }])
