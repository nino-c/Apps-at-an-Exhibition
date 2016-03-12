angular
    .module('Exhibition')
    .controller('AppEditorController', ['$rootScope', '$scope', '$location',
        '$route', '$mdToast', '$interval', 'AppService', 'CategoryService',
        function($rootScope, $scope, $location, $route, $mdToast, $interval,
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

            // var editor1 = $("#source_textarea");
            // var editor2 = $("#seed_textarea");
            // var interval = $interval(function() {
            //     editor1.refresh();
            //     editor2.refresh();
            //     console.log('ref')
            // }, 500)    
            
            

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
