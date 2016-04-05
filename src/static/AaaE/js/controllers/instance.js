angular
  .module('Exhibition')
  .controller('InstanceController', ['$rootScope', '$window', '$document', '$scope', 
    '$interval', '$location', '$route', '$resource', '$mdToast', 
    '$timeout', '$http', '$mdDialog', 
    'AppService',
    'InstanceService',
    ($rootScope, $window, $document, $scope, $interval, $location, $route, 
        $resource, $mdToast, $timeout, $http, $mdDialog,
        AppService, InstanceService) => {

        //paper.setup('big-canvas');

        var timer;

        $scope.loading = true;
        $scope.timeElapsed = 0;
        $scope.seedTouched = false;
        $scope.readyToSave = false;

        $scope.instance = InstanceService.get({id:$route.current.params.instance_id})

        $scope.instance.$promise.then(function(inst) {
            $scope.seedStructure = JSON.parse(inst.game.seedStructure);
            $scope.execute();
        })

        $scope.initialize = function() {
            //paper.setup('big-canvas');
            $window.renderingDone = function() {
                $timeout(function() {
                    $scope.renderingDone();
                }, 500)
            }
        }

        $scope.renderingDone = function() {

        }

        $scope.cycleParam = function(param, min, max) {

        }

        $scope.parseSeedList = function(setToFalse) {
            if (setToFalse === undefined) setToFalse = false;
            $scope._seed = _.mapObject(
                $scope._seed, function(s) {
                    if (s.parsing === undefined) s.parsing = false;
                    if (setToFalse) s.parsing = false;
                    return s;
                });

            $scope.seedList = _.pairs($scope._seed);
            console.log('seedList', $scope.seedList);
            
            $timeout(function() {
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            }, 500)
        }

        var self_scope = $scope;

        $scope.editSeed = function(ev) {

            $mdDialog.show({
                locals: {
                    seedList: $scope.seedList,
                    seedStructure: $scope.seedStructure,
                    _seed: $scope._seed
                },
                templateUrl: '/static/AaaE/views/seed-editor-dialog.html',
                parent: angular.element(document.body),
                targetEvent: ev,
                controller: DialogController
            });

            function DialogController($scope, $mdDialog, seedList, seedStructure, _seed) {

                $scope.seedList = seedList;
                $scope.seedStructure = seedStructure;
                $scope._seed = _seed;
                $scope.selectedSeedCycle = null;
                $scope.varyMin = 0;
                $scope.varyMax = 0;
                $scope.seedTouched = false;

                $scope.closeDialog = function() {
                    $mdDialog.hide();
                };

                $scope.seedChange = function($event) {
                    $scope.seedTouched = true;
                    $scope.readyToSave = true;
                };

                $scope.initialize = function() {
                    console.log('ng-init');
                    $timeout(function() {
                        $scope.parseSeedList();
                    }, 500);
                }

                $scope.seedChangeAsync = function($event, seedkey) {
                    
                    $scope._seed[seedkey].parsing = true;

                    var val = $event.currentTarget.value;
                    $.post("/symbolic_math/latex/", {
                        expressionString: val
                    }, function(data) {
                        
                        $scope._seed[seedkey].string = val;
                        $scope._seed[seedkey].javascript = data.javascript;
                        $scope._seed[seedkey].latex = data.latex;
                        
                        $scope.parseSeedList();
                        $scope.$apply();

                        $timeout(function() {
                            $scope._seed[seedkey].parsing = false;
                            $timeout(function() {
                                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
                            }, 500)
                        }, 500)
                        
                    });
                   
                };

                $scope.parseSeedList = function(setToFalse) {
                    if (setToFalse === undefined) setToFalse = false;
                    $scope._seed = _.mapObject(
                        $scope._seed, function(s) {
                            if (s.parsing === undefined) s.parsing = false;
                            if (setToFalse) s.parsing = false;
                            return s;
                        });

                    $scope.seedList = _.pairs($scope._seed);
                    console.log('seedList', $scope.seedList);
                    
                    $timeout(function() {
                        MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
                    }, 500)
                }

                $scope.updateInstance = function() {
                    self_scope.updateInstance();
                    $mdDialog.hide();
                }

              }
        }

        $scope.execute = function() {
            if ($scope.instance.seed) {

                $scope.__seed = JSON.parse($scope.instance.seed);
                $scope._seed = _.mapObject(
                    $scope.__seed, function(s) {
                        s.parsing = false;
                        return s;
                    });

                // prepare code to eval
                // line-by-line for the system-generated part
                var seedcodelines = [];

                // full seed object
                seedcodelines.push( 'var seed = ' + $scope.instance.seed + ';' );

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
                    var k = $scope.seedStructure[attr].varname ? 
                                $scope.seedStructure[attr].varname : attr; 

                    switch ($scope._seed[attr].type) {
                        case 'string':
                        case 'color':
                            line = "var " + k + " = \""
                                + $scope._seed[attr].value.toString() + "\";"
                            break;
                        case 'math':
                            line = "var " + k + " = "
                                + JSON.stringify($scope._seed[attr]) + ";"
                            break;
                        case 'javascript':
                            line = "var " + k + " = "
                                + $scope._seed[attr].value + ";"
                            break;
                        case 'number':
                            line = "var " + k + " = "
                                + $scope._seed[attr].value.toString() + ";"
                            break;
                    }

                    seedcodelines.push(line);

                }

                // remove `var` seedcodelines if coffeescript
                var coffee = false;
                if ($scope.instance.game.scriptType.indexOf('coffeescript') > -1) {
                    coffee = true;
                }
                if (coffee) {
                    seedcodelines = _.map(seedcodelines, function(line) {
                        return line.split('var ').join('').split(';').join('');
                    });
                }

                $scope.parseSeedList();

                // get required-module code (if any)
                var required_codeblocks = '';
                if ($scope.instance.game.required_modules.length > 0) {
                    required_codeblocks = _.map(
                        $scope.instance.game.required_modules, function(mod) {
                            return mod.source;
                        }).join("\n\n");
                }

                var source = seedcodelines.join("\n") + "\n"
                    + required_codeblocks + "\n" 
                    + $scope.instance.sourcecode;

                var sourceWithoutSeedlines = required_codeblocks + "\n" 
                    + $scope.instance.sourcecode;

                //console.log(source)

                if (coffee) {
                    $scope.instance.sourcecode 
                        += "\ntry\n\twindow.start()\ncatch error\n\tconsole.log error"
                    source = CoffeeScript.compile($scope.instance.sourcecode);
                } else {
                    source += "\n try { window.start(); } catch(e) {}"
                }

                if (source.indexOf('window.renderingDone()') == -1) {
                    source += "\n\nwindow.renderingDone()";
                }

                function updateElapsedTime() {
                    $scope.timeElapsed = ((new Date()).getTime() - $scope.appstart.getTime()) / 1000;
                }

                $scope.appstart = new Date();
                timer = $interval(updateElapsedTime, 1000);

                $scope.source = source;

                // execute seed code and game script
                if ($scope.instance.game.scriptType == "text/paperscript") {

                    $scope.clearPaperCanvas();

                    //var comp = paper.PaperScript.parse($scope.instance.sourcecode);
                    //console.log(comp.toString())
                    //paper.PaperScript.execute(comp);
                    
                    eval( seedcodelines.join("\n") );
                    $scope.loading = false;
                    $scope.gameFunction = new Function('Canvas', 'canvas',
                        'paper', //source);
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
        }

        $scope.saveAsNewInstance = function() {
            return;
            $scope.updateSeed();
            
            var req = {
                method: 'POST',
                data: $scope._seed,
                url: '/game/app-instantiate/' + $scope.instance.game.id + '/',
                headers: {
                    'Content-Type': 'application/json'
                }
            }

            $http(req).then(function successCallback(response) {
                
                if (response.data.id) {
                    $scope.instance = InstanceService.get({id:response.data.id})
                    $scope.instance.$promise.then(function() {

                        $scope.clearCanvas();
                        $scope.clearPaperCanvas();
                        $scope.clearEvalScope();

                        $mdToast.showSimple("Saved as new instance.");
                        
                        $scope.loading = true;
                        $scope.timeElapsed = 0;
                        $scope.seedTouched = false;
                        $scope.readyToSave = false;

                        $scope.execute();
                    })

                   
                }
                
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
            try {
                window.appdestroy();
            } catch (e) { 
                console.log('no appdestroy()', e); 
            }
            if ($scope.gameFunction) {
                delete $scope.gameFunction;
                console.log('deleting gameFunction')
                
            }
        }

        $scope._destroy = function() {
            console.log('scope destroy instance.js')
            $scope.clearCanvas();
            $scope.clearPaperCanvas();
            $scope.clearEvalScope();
        }

        // $scope.$on("$destroy", function() {
        //     console.log('destroy1');
        //     $scope._destroy();
        //});

        // $scope.$destroy = function() {
        //     console.log('destroy2');
        //     if ($scope.gameFunction) {
        //         delete $scope.gameFunction;
        //         console.log('deleting gameFunction')
                
        //     }
        // }


        $scope.updateSeed = function() {
            _.each($scope.seedList, function(seed) {
                $scope._seed[seed[0]] = seed[1];
            })
            console.log('seed after update', $scope._seed)
        }

        $scope.updateInstance = function() {
            $scope.loading = true;
            $scope.updateSeed();
            $scope.instance.seed = JSON.stringify($scope._seed)

            if ($scope.userLoggedIn) {

                var req = {
                    method: 'POST',
                    data: $scope._seed,
                    url: '/game/app-instantiate/' + $scope.instance.game.id + '/',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }

                $http(req).then(function successCallback(response) {
                    
                    if (response.data.id) {
                        $scope.instance = InstanceService.get({id:response.data.id})
                        $scope.instance.$promise.then(function() {

                            $scope.clearCanvas();
                            $scope.clearPaperCanvas();
                            $scope.clearEvalScope();

                            $mdToast.showSimple("Saved as new instance.");
                            
                            $scope.loading = true;
                            $scope.timeElapsed = 0;
                            $scope.seedTouched = false;
                            $scope.readyToSave = false;

                            $scope.execute();
                        })

                       
                    }
                    
                }, function errorCallback(response) {
                    console.log('error', response)
                });

            } else {
                $scope.clearCanvas();
                $scope.clearPaperCanvas();
                $scope.clearEvalScope();

                $scope.loading = true;
                $scope.timeElapsed = 0;
                $scope.seedTouched = false;
                $scope.readyToSave = false;

                $scope.execute();
            }
           

            //$scope.seedTouched = false;
            //$timeout($scope.execute, 500)
            //$timeout($scope.snapshot, 2000)
        }

        // $scope.$on( "$routeChangeStart", function($event, next, current) {
        //   console.log("routechange", $event)
          
        // })

  }
])
