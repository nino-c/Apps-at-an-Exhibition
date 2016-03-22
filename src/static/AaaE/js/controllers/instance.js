angular
  .module('Exhibition')
  .controller('InstanceController', ['$rootScope', '$window', '$document', '$scope', 
    '$interval', '$location', '$route', '$resource', '$mdToast', 
    '$timeout', '$http',
    'AppService',
    'InstanceService',
    ($rootScope, $window, $document, $scope, $interval, $location, $route, 
        $resource, $mdToast, $timeout, $http,
        AppService, InstanceService) => {

        var timer;

        $scope.loading = true;
        $scope.timeElapsed = 0;
        $scope.seedTouched = false;
        $scope.readyToSave = false;

        //$scope.app = AppService.get({id:$route.current.params.app_id})
        $scope.instance = InstanceService.get({id:$route.current.params.instance_id})

        $scope.instance.$promise.then(function() {
            $scope.seedStructure = $scope.instance.game.seedStructure
            $scope.execute();
        })

        $scope.seedChange = function($event) {
            $scope.seedTouched = true;
            $scope.readyToSave = true;
        }

        $scope.seedChangeAsynch = function($event, seedkey) {
            console.log('seedkey', seedkey);
            var val = $event.currentTarget.value;
            $.post("/symbolic_math/latex/", {
                expressionString: val
            }, function(data) {
                console.log(data);
                $scope._seed[seedkey].string = val;
                $scope._seed[seedkey].javascript = data.javascript;
                $scope._seed[seedkey].latex = data.latex;

                $scope.seedList = _.pairs($scope._seed);
                $timeout(function() {
                    MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
                }, 1000);
            });
           
            
        }

        $scope.execute = function() {
            if ($scope.instance.seed) {

                // prepare code to eval
                // line-by-line for the system-generated part
                $scope._seed = JSON.parse($scope.instance.seed)
                var seedcodelines = [];

                // canvas declarations
                seedcodelines.push( 'var canvas = $("#big-canvas");' )
                seedcodelines.push( 'var Canvas = document.getElementById("big-canvas");' )

                // control panels
                //controlPanel = $("#floating-display-control");
                //controlPanel.css({'display':'block'});

                // canvas declarations
                seedcodelines.push( 'canvas.css({\'display\':\'block\'});' )
                seedcodelines.push( 'Canvas.width = $(window).width();' )
                seedcodelines.push( 'Canvas.height = $(window).height()-50;' )
                seedcodelines.push( 'console.log(Canvas);' )
                seedcodelines.push( 'console.log(canvas);' )

                // import seed attributes into local namespace
                for (attr in $scope._seed) {
                    
                    var line = '';
                    switch ($scope._seed[attr].type) {
                        case 'string':
                        case 'color':
                            line = "var " + attr + " = \""
                                + $scope._seed[attr].value.toString() + "\";"
                            break;
                        case 'math':
                             line = "var " + attr + " = "
                                + JSON.stringify($scope._seed[attr]) + ";"
                            break;
                        case 'number':
                            line = "var " + attr + " = "
                                + $scope._seed[attr].value.toString() + ";"
                            break;
                    }

                    seedcodelines.push(line);

                }

                $scope.seedList = _.pairs($scope._seed)

                var source = seedcodelines.join("\n") + "\n"
                    + $scope.instance.sourcecode
                    + "\n try { start(); } catch(e) {}"

                console.log('ready to run', seedcodelines.join("\n"));

                function updateElapsedTime() {
                    $scope.timeElapsed = ((new Date()).getTime() - $scope.appstart.getTime()) / 1000;
                }

                $scope.appstart = new Date();
                timer = $interval(updateElapsedTime, 1000);

                // execute seed code and game script
                if ($scope.instance.game.scriptType == "text/paperscript") {

                    $scope.clearPaperCanvas();
                    
                    eval( seedcodelines.join("\n") );
                    $scope.loading = false;
                    $scope.gameFunction = new Function('Canvas', 'canvas', 
                        'paper', 
                        'with (paper) { ' + source 
                            + '}')
                    $scope.gameFunction(Canvas, canvas, paper)
                    

                } else {

                    $scope.clearCanvas();

                    console.log(seedcodelines.join("\n"));
                    eval( seedcodelines.join("\n") );
                    $scope.loading = false;
                    $scope.gameFunction = new Function('Canvas', 'canvas', source)
                    $scope.gameFunction(Canvas, canvas)

                }

            }
        }
    

        $scope.snapshot = function() {

            var canvas = $("#big-canvas");
            var Canvas = document.getElementById("big-canvas");

            if (window._renderer) {
                var snapshot = window._renderer.domElement.toDataURL("image/png");  
            } else {
                var snapshot = Canvas.toDataURL("image/png");
            }
            var url = "/game/snapshot/";
            $.post(url, {
                    instance: $scope.instance.id,
                    time: $scope.timeElapsed,
                    image: snapshot
                },
                function(data) {
                    $mdToast.showSimple("Snapshot saved.")
                    console.log(data);
                }
            );
            //App.editors = [];
        }

        $scope.saveAsNewInstance = function() {
            var req = {
              method: 'POST',
              data: $scope._seed,
              url: '/game/app-instantiate/' + $scope.app.id + '/',
              headers: {
                'Content-Type': 'application/json'
              }
            }
            $http(req).then(function successCallback(response) {
              console.log(response)
              //$location.path('/instance/'+$scope.app.id+'/'+response.data.id+'/')
              $mdToast.showSimple("Saved as new instance.");
              $scope.readyToSave = false;
            }, function errorCallback(response) {
              console.log('error', response)
            });
        }

        $scope.clearCanvas = function() {
            try {
                var _canvas = document.getElementById('big-canvas');
                if (_canvas) {
                    var context = _canvas.getContext('2d')
                    if (context) {
                        context.fillStyle = '#ffffff';
                        context.fillRect(0,0,_canvas.width, _canvas.height);
                        context.clearRect(0,0,_canvas.width, _canvas.height);
                        console.log('clear canvas')
                    }    
                }
            } catch (e) {
                console.log(e);
            }
        }

        $scope.clearPaperCanvas = function() {
            try {
                with (paper) {
                    if (project) {
                        project.layers.forEach(function(lay) {
                            lay.removeChildren();
                            lay.remove();
                        });
                        project.clear();
                    }
                }
            } catch (e) { } 
        }

        $scope.clearEvalScope = function() {
            // try to delete all vars in scope of previously eval()-ed app 
            if ($scope.gameFunction) {
                delete $scope.gameFunction;
                console.log('deleting gameFunction')
            }
        }



        // $scope.$on("$destroy", function() {
        //     $scope._destroy();
        // })

        $scope.updateInstance = function() {

            $scope.seedComponents.forEach(function(comp) {
                $scope._seed[comp.property] = comp.value;
            })
            $scope.instance.seed = JSON.stringify($scope._seed)
            
            $scope.clearCanvas();
            $scope.clearPaperCanvas();
            $scope.clearEvalScope();

            $scope.seedTouched = false;
            $timeout($scope.execute, 500)
            //$timeout($scope.snapshot, 2000)
        }

        // $scope.$on( "$routeChangeStart", function($event, next, current) {
        //   console.log("routechange", $event)
          
        // })

  }
])
