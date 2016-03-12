angular.module('Exhibition')
    .controller('CanvasController', ['$scope', 'instance', 
        function($scope, instance) {

        $scope.source = instance.game.source;
        $scope.seed = JSON.parse(instance.seed);

    }]);