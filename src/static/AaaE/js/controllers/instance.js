angular
  .module('Exhibition')
  .controller('InstanceController', ['$rootScope', '$window', '$document', '$scope', '$location', '$route', '$resource',
    'AppService',
    'InstanceService',
    ($rootScope, $window, $document, $scope, $location, $route, $resource, AppService, InstanceService) => {


        $scope.app = AppService.get({id:$route.current.params.app_id})
        $scope.instance = InstanceService.get({id:$route.current.params.instance_id})

        $scope.instance.$promise.then(function() {


            if ($scope.instance.seed) {

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
                seedcodelines.push( 'Canvas.height = $(window).height();' )
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
                    + "\n start();"

                console.log($scope.app)

                // execute seed code and game script
                if ($scope.instance.game.scriptType == "text/paperscript") {


                    eval( seedcodelines.join("\n") );
                    var game = new Function('Canvas', 'canvas', 'paper', 'with (paper) { ' + source + '}')
                    game(Canvas, canvas, paper)


                } else {

                    console.log(seedcodelines.join("\n"));
                    eval( seedcodelines.join("\n") );
                    var game = new Function('Canvas', 'canvas', source)
                    game(Canvas, canvas)

                }

            }
        })


  }
])
