angular
  .module('Exhibition')
  .controller('InstanceController', ['$rootScope', '$window', '$document', '$scope', 
    '$interval', '$location', '$route', '$resource', '$mdToast', 
    '$timeout', '$http', '$mdDialog', '$ngSilentLocation',
    'AppService',
    'InstanceService',
    function ($rootScope, $window, $document, $scope, $interval, $location, $route, 
        $resource, $mdToast, $timeout, $http, $mdDialog, $ngSilentLocation,
        AppService, InstanceService)  {

        //paper.setup('big-canvas');

        var timer;

        $scope.loading = true;
        $scope.timeElapsed = 0;
        $scope.seedTouched = false;
        $scope.readyToSave = false;
        $scope.autosnapshot = false;

        $scope.currentCycleValue = null;
        $scope.varyParam = null;
        $scope.varyMin = 0;
        $scope.varyMax = 0;

        $scope.featureDisplayContent = '';
        $scope.featureDisplayCSS = {};

        InstanceService.get({id:$route.current.params.instance_id})
            .$promise.then(function(inst) {

                console.log('instance seed', inst.seed, inst)

                $scope.instance = inst;
                $scope.seedStructure = JSON.parse(inst.game.seedStructure);
                $scope.execute();
            })

        $scope.initialize = function() {
            
            /*
                set up functions callable from userpap API
            */
            
            $window.renderingDone = function() {
                $timeout(function() {
                    $scope.renderingDone();
                }, 500)
            };

            $window.featureDisplay = function(content, css) {
                $scope.featureDisplay(content, css);
            }

            $window.snapshot = function() {
                $scope.shapshot();
            }
        }

        $scope.renderingDone = function() {
            
            if ($scope.autosnapshot) {
                $scope.snapshot();
                $scope.autosnapshot = false;
            }

            if ($scope.currentCycleValue != null) {
                $timeout(function() {
                    $scope.doCycle();
                }, 1500)
            }
        }

        $scope.cycleParam = function(param, min, max) {

            $scope.varyParam = param;
            $scope.currentCycleValue = min;
            $scope.varyMin = min;
            $scope.varyMax = max;

            console.log('cycle', $scope.varyParam, $scope.varyMin, $scope.varyMax);

            $scope.updateInstance(true);
        }

        $scope.doCycle = function() {

            $scope.currentCycleValue++;

            if ($scope.currentCycleValue > $scope.varyMax)  {
                $scope.currentCycleValue = null;
                return;
            }

            if (typeof $scope._seed[$scope.varyParam] == 'object' && $scope._seed[$scope.varyParam].value) {
                $scope._seed[$scope.varyParam].value = $scope.currentCycleValue;
            } else {
                $scope._seed[$scope.varyParam] = $scope.currentCycleValue;
            }

            $scope.updateSeed();
            $scope.parseSeedList();
            $scope.updateInstance(true);
        }

        
        $scope.featureDisplay = function(content, css) {

            if (!css)
                css = {};
            if (typeof content == 'string') 
                content = [content];

            $scope.featureDisplayContent = content;
            $scope.featureDisplayCSS = _.reduce(_.mapObject(css, function(val, key) {
                    return key+':'+val+';';
                }), function(a,b) { return a+b; }, '');

            $timeout(function() {
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            }, 500);
        }


        $scope.parseSeedList = function(setToFalse) {
            /*
                process _seed:Object
                create  seedList:Array
            */

            if (setToFalse === undefined) setToFalse = false;

            $scope._seed = _.mapObject(
                $scope._seed, function(s) {
                    if (s.parsing === undefined) s.parsing = false;
                    if (setToFalse) s.parsing = false;
                    return s;
                });
            
            $scope.seedList = _.pairs($scope._seed);
            
            $timeout(function() {
                MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
            }, 500);
        }

        $scope.updateSeed = function() {
            /*
                process seedList:Array
                create  _seed:Object
            */
            _.each($scope.seedList, function(seed) {
                $scope._seed[seed[0]] = seed[1];
            })
            $scope.instance.seed = JSON.stringify($scope._seed);

        }

        
        $scope.updateInstance = function(autosnapshot) {

            if (!autosnapshot) {
                $scope.autosnapshot = false;
            } else {
                $scope.autosnapshot = true;
            }

            $scope.loading = true;
            $scope.updateSeed();
            $scope.parseSeedList();
            
            if ($scope.userLoggedIn) {

                var req = {
                    method: 'POST',
                    data: $scope._seed,
                    url: '/game/app-instantiate/' + $scope.instance.game.id + '/',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }
                console.log(req)

                $http(req).then(function successCallback(response) {
                
                    if (response.data.id) {

                        $scope.instance.id = response.data.id;
                        $route.current.params.instance_id = response.data.id;
                        
                        $scope.clearCanvas();
                        $scope.clearPaperCanvas();
                        $scope.clearEvalScope();
                        $scope.loading = true;
                        $scope.timeElapsed = 0;
                        $scope.seedTouched = false;
                        $scope.readyToSave = false;

                        $rootScope.toast("Saved as new instance.");
                        $scope.execute();

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
           
        }

        var self_scope = $scope;

        $scope.viewSource = function(ev) {
            console.log('viewsource')
            $mdDialog.show({
                locals: {
                    app: $scope.instance.game,
                },
                templateUrl: '/static/AaaE/views/view-source-dialog.html',
                parent: angular.element(document.body),
                targetEvent: ev,
                controller: ViewSourceDialog
            });

            function ViewSourceDialog($scope, $mdDialog, app) {
                
                $scope.initialize = function() {

                    var lang = app.scriptType.split('text/').join('');
                    if (lang == 'paperscript') { lang = 'javascript'; }

                    $scope.cmOptions = {
                      lineWrapping: true,
                      lineNumbers: true,
                      indentWithTabs: true,
                      viewportMargin: Infinity,
                      mode: lang,
                      matchBrackets: true,
                      gutters: ['codemirror-gutters']
                    }

                    $scope.app = app;
                }

                $scope.closeDialog = function() {
                    $mdDialog.hide();
                };
            }
        }

        $scope.editSeed = function(ev) {

            console.log('editseed');

            $mdDialog.show({
                //bindToController: true,
                //require: ['^mdRadioGroup'],
                scope: $scope,
                templateUrl: '/static/AaaE/views/seed-editor-dialog.html',
                parent: angular.element(document.body),
                controller: DialogController,
                preserveScope: true
            });

            function DialogController($scope, $mdDialog) {
                
                $scope.initialize = function() {

                }

                $scope.closeDialog = function() {
                    $mdDialog.hide();
                };

                $scope.seedChange = function($event) {
                    console.log('seedChange', $event);
                    $scope.seedTouched = true;
                    $scope.readyToSave = true;
                    console.log($scope.seedList)
                };

                $scope.changeVaryParam = function() {
                    console.log('changeVaryParam')
                }

                $scope._updateInstance = function() {

                    $scope.updateSeed();
                    console.log('varyParam', $scope.varyParam);

                    if ($scope.varyParam != null) {
                        self_scope.cycleParam($scope.varyParam, $scope.varyMin, $scope.varyMax);
                    } else {
                        self_scope.updateInstance(true);    
                    }
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
                    eval( seedcodelines.join("\n") );
                    
                    $scope.gameFunction = new Function('Canvas', 'canvas',
                        'paper', //source);
                        'with (paper) { ' + source
                            + '}')

                    $scope.gameFunction(Canvas, canvas, paper)
                    $scope.loading = false;

                } else {

                    $scope.clearCanvas();

                    console.log(seedcodelines.join("\n"));
                    eval( seedcodelines.join("\n") );
                    
                    $scope.gameFunction = new Function('Canvas', 'canvas', source)
                    $scope.gameFunction(Canvas, canvas)
                    $scope.loading = false;

                }

            }
        }
    

    

        $scope.snapshot = function() {

            console.log('snapshot');

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
                    $rootScope.toast("Snapshot saved.")
                    console.log(data);
                }
            );
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

  }
])
