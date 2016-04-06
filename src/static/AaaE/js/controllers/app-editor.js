angular
    .module('Exhibition')
    .controller('AppEditorController', ['$rootScope', '$scope', 
        '$location', '$route', '$mdToast', '$interval', 
        '$timeout', 
        'AppService', 
        'CategoryService',
        'CodeModuleService',
        function($rootScope, $scope, $location, $route, 
            $mdToast, $interval, $timeout,
            AppService, CategoryService, CodeModuleService) {
            
            $scope.isLoading = true;
            $scope.categories = CategoryService.query()
            $scope.codeModules = CodeModuleService.query()
            $scope.scriptTypes = $rootScope.scriptTypes

            $scope.codeModules.$promise.then(function(response) {
                _.each($scope.codeModules, function(mod) {
                    mod.selected = false;
                })
            });

            if ($location.path().indexOf('/apps/new/') > -1) {

                $scope.app = new AppService({
                    title: "New App",
                    source: "function start() {\n\n}",
                    seedStructure: "{\"param1\":{\"default\":\"\"}}"
                });

                $scope.isLoading = false;

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

                    $scope.isLoading = false;

                    var lang = $scope.app.scriptType.split('text/').join('');
                    if (lang == 'paperscript') { lang = 'javascript'; }

                    $scope.cmOptions = {
                      lineWrapping: true,
                      lineNumbers: true,
                      indentWithTabs: true,
                      viewportMargin: Infinity,
                      //theme: "monokai",
                      mode: lang,
                      matchBrackets: true,
                    }

                    $scope.cm2Options = {
                      lineWrapping: true,
                      lineNumbers: true,
                      indentWithTabs: true,
                      viewportMargin: Infinity,
                      //theme: "monokai",
                      mode: 'javascript',
                      matchBrackets: true,
                    }
                })
            }

            


            $scope.saveapp = function(event) {

                // check syntax of seedStructure
                try {
                    var seedcheck = JSON.parse($scope.app.seedStructure);
                    console.log('seedcheck', seedcheck)
                } catch (e) {
                    console.log('syntax error', e);
                }

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
                        function(app, putResponse) {
                            $mdToast.showSimple("App saved.")
                            $location.path('/apps/'+app.id)
                        })
                }
            }

        }])
