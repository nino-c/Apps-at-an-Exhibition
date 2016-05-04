angular
	.module('Exhibition')
	.controller('PaperscriptController', ['$rootScope', '$scope', '$route', '$timeout', '$document', 'InstanceService',
		function($rootScope, $scope, $route, $timeout, $document, InstanceService) {
		
		InstanceService.get({id:$route.current.params.id})
	        .$promise.then(function(inst) {

	            //console.log('instance seed', inst.seed, inst);

	            $scope.instance = inst;
	            $scope.seedStructure = JSON.parse(inst.game.seedStructure);
	            $scope.execute();
	        })
		
	    $scope.execute = function() {

	    	
            $scope.seed = JSON.parse($scope.instance.seed);
			


	    	var seedcodelines = [];
			seedcodelines.push( 'var seed = ' + $scope.instance.seed + ';' );
            //seedcodelines.push( 'var canvas = $("#bg-canvas");' )
            seedcodelines.push( 'var Canvas = document.getElementById("paperscript-canvas");' )

            // import seed attributes into local namespace
            for (attr in $scope.seed) {
                
                var line = '';
                var k = $scope.seedStructure[attr].varname ? $scope.seedStructure[attr].varname : attr; 

                switch ($scope.seed[attr].type) {
                    case 'string':
                    case 'color':
                        line = "var " + k + " = \""
                            + $scope.seed[attr].value.toString() + "\";"
                        break;
                    case 'math':
                        line = "var " + k + " = "
                            + JSON.stringify($scope.seed[attr]) + ";"
                        break;
                    case 'javascript':
                        line = "var " + k + " = "
                            + $scope.seed[attr].value + ";"
                        break;
                    case 'number':
                        line = "var " + k + " = "
                            + $scope.seed[attr].value.toString() + ";"
                        break;
                }

                seedcodelines.push(line);


            }

            var required_codeblocks = '';
            if ($scope.instance.game.required_modules.length > 0) {
                required_codeblocks = _.map(
                    $scope.instance.game.required_modules, function(mod) {
                        return mod.source;
                    }).join("\n\n");
            }

            $scope.source = seedcodelines.join("\n") + "\n"
                + required_codeblocks + "\n" 
                + $scope.instance.sourcecode;

            // $timeout(function() {
            //     var scriptElement = document.createElement('script');
            // scriptElement.type = "text/paperscript";
            // scriptElement.text = $scope.source;
            // scriptElement.id = "ppscript";
            
            // //console.log($(scriptElement));
            // scriptElement.attributes.canvas = 'paperscript-canvas';
            // document.body.appendChild(scriptElement);
            
            // //paper.setup('paperscript-canvas');
            // paper.PaperScript.load('ppscript');
    
            // }, 1000)
            

            // create a clean scope
            //var cleanscope = $rootScope.$new();
            //cleanscope.$eval($scope.source, [paper]);
            // $timeout(function() {
            //     eval($scope.source);
            // }, 500)
            
            //$scope.$eval($scope.source, [paper]);

	    };

		$scope.init = function() {
			console.log('scope init');
			$("#bg-iframe").remove();
		};

		

	}]);