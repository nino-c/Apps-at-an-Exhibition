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

        $scope.transformSeed = function() {
            $scope._seed = JSON.parse($scope.instance.seed)
            $scope.seedStructure = JSON.parse($scope.instance.game.seedStructure)
           
            // add values into seedStructure to create
            // object to pass into directive
            
            $scope.hasAsynchType = false;
            $scope.asynchToWaitUpon = 0;
            $scope._seed = _.mapObject($scope.seedStructure, function(val, key) {

                if (val.type == 'math') {

                    $scope.hasAsynchType = true;
                    $scope.asynchToWaitUpon++;

                    var _val = $scope._seed[key];
                    if (typeof val.value != "object") {

                        // assume that value is string
                        val.value = {
                            string: _val,
                            javascript: '',
                            latex: ''
                        }

                        $http({
                            method: 'POST',
                            url: "/symbolic_math/latex/",
                            data: {
                                expressionString: _val
                            },
                            headers: {
                                'Content-Type': 'application/json'
                            }
                        }).then(function(response) {

                            val.value.javascript = response.javascript;
                            val.value.latex = '$'+response.latex+'$';

                            $scope.asynchToWaitUpon--;

                        }, function(response) {
                            alert("Could not parse expression.")
                          });

                    }
                } else {
                    val.value = $scope._seed[key];
                }



                return val;
            })
            //console.log($scope._seed)
            
            // then convert to array for ng-repeat 
            $scope.seedList = _.pairs($scope._seed);
            //console.log($scope.seedList)
        }

        $scope.evaluateSource = function() {
            // prepare code to eval
            // first evaluate the seed to extract the variables inside the dict
            var seedline = "var seed = " + $scope.instance.seed + ";"
            eval(seedline)

            // line-by-line for the system-generated part
            var seedcodelines = [seedline]

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
            for (attr in seed) {

                var line;
                if (typeof seed[attr] == 'string') {

                    // if color field, add colorpicker to form
                    // if (seed[attr].toString().indexOf("rgba(") === 0) {
                    //  if ($("#color_"+attr.toString())) {
                    //      $("#color_"+attr.toString()).colorpicker();
                    //  }
                    // }

                    line = "var " + attr + " = \""
                        + seed[attr].toString() + "\";"
                } else {
                    line = "var " + attr + " = " + seed[attr].toString() + ";"
                }
                seedcodelines.push(line);

            }

            var source = seedcodelines.join("\n") + "\n"
                + $scope.instance.sourcecode
                + "\n try { start(); } catch(e) {}"

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


        // $scope.execute = function() {
        //     if ($scope.instance.seed) {

        //         $scope.transformSeed();
                
        //         if (!$scope.hasAsynchType) {
        //             $scope.evaluateSource();
        //         } else {
        //             $interval(function() {

        //             }, 100)
        //         }

        //     }
        // }
    
        $scope.execute = function() {
            if ($scope.instance.seed) {

                $scope._seed = JSON.parse($scope.instance.seed)
                console.log("_seed", $scope._seed)

                var seedComponents = [];
                for (var key in $scope._seed) {
                    seedComponents.push({property: key, value: $scope._seed[key]})
                }
                $scope.seedComponents = seedComponents;
                console.log('seedComponents', seedComponents)

                // prepare code to eval

                // first evaluate the seed to extract the variables inside the dict
                var seedline = "var seed = " + $scope.instance.seed + ";"
                eval(seedline)

                // line-by-line for the system-generated part
                var seedcodelines = [seedline]

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
                for (attr in seed) {

                    var line;
                    if (typeof seed[attr] == 'string') {

                        // if color field, add colorpicker to form
                        // if (seed[attr].toString().indexOf("rgba(") === 0) {
                        //  if ($("#color_"+attr.toString())) {
                        //      $("#color_"+attr.toString()).colorpicker();
                        //  }
                        // }

                        line = "var " + attr + " = \""
                            + seed[attr].toString() + "\";"
                    } else {
                        line = "var " + attr + " = " + seed[attr].toString() + ";"
                    }
                    seedcodelines.push(line);

                }

                var source = seedcodelines.join("\n") + "\n"
                    + $scope.instance.sourcecode
                    + "\n try { start(); } catch(e) {}"

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
