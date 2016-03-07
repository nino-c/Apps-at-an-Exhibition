angular
  .module('Exhibition')
  .controller('InstanceController', ['$rootScope', '$window', '$document', '$scope', 
    '$interval', '$location', '$route', '$resource', '$mdToast',
    'AppService',
    'InstanceService',
    ($rootScope, $window, $document, $scope, $interval, $location, $route, 
        $resource, $mdToast,
        AppService, InstanceService) => {

        $scope.loading = true;

        $scope.app = AppService.get({id:$route.current.params.app_id})
        $scope.instance = InstanceService.get({id:$route.current.params.instance_id})

        var timer;
        $scope.timeElapsed = 0;

        $scope.instance.$promise.then(function() {


            if ($scope.instance.seed) {

                $scope._seed = JSON.parse($scope.instance.seed)
                console.log("_seed", $scope._seed)

                // $scope.$watch('_seed', function() {
                //     console.log($scope._seed)
                // })

                var seedComponents = [];
                for (var key in $scope._seed) {
                    seedComponents.push({property: key, value: $scope._seed[key]})
                }
                $scope.seedComponents = seedComponents;

                

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

                console.log($scope.app)
                
                $scope.appstart = new Date();
                timer = $interval(updateElapsedTime, 1000);

                // execute seed code and game script
                if ($scope.instance.game.scriptType == "text/paperscript") {

                    
                    eval( seedcodelines.join("\n") );
                    $scope.loading = false;
                    var game = new Function('Canvas', 'canvas', 'paper', 
                        'with (paper) { ' + source + '}')
                    game(Canvas, canvas, paper)
                    

                } else {

                    console.log(seedcodelines.join("\n"));
                    eval( seedcodelines.join("\n") );
                    $scope.loading = false;
                    var game = new Function('Canvas', 'canvas', source)
                    game(Canvas, canvas)

                }

            }



        })

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

    $scope.$on("$destroy", function() {
        console.log('destroy instance -- clear canvas')
        try {
            var _canvas = document.getElementById('big-canvas');
            if (_canvas) {
                var context = _canvas.getContext('2d')
                if (context) {
                    //context.fillStyle = '#ffffff';
                    context.clearRect(0,0,_canvas.width, _canvas.height);
                    console.log('clear canvas')
                }    
            }
        } catch (e) {
            console.log(e);
        }
    })

    $scope.updateInstance = function() {
        $scope.seedComponents.forEach(function(comp) {
            $scope._seed[comp.property] = comp.value;
        })
        console.log($scope._seed)
   }

    // $scope.$on( "$routeChangeStart", function($event, next, current) {
    //   console.log("routechange", $event)
      
    // })


  }
])
