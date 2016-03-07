angular.module('Exhibition')
    // .directive('seedDisplay', function() {
    //     return {
    //         restrict: 'E',
    //         templateUrl: 'views/seedDisplay.html'
    //     }
    // })
    .component('seedDisplay', {
        bindings: {
            __seed: '='
        },
        controller: function() {
            
        },
        templateUrl: 'views/seedDisplay.html'
    })
    // .directive('gameTimer', function() {
    //     return function(scope, element, attrs) {
            
    //         restrict: 'E',
    //         scope: {},
    //         bindToController: {
    //             timeElapsed: '='
    //         },
    //         controller: function($scope) {
    //             this.startTime = new Date();
    //             this.timeElapsed = 0;
    //             $scope.$watch('timeElapsed', function() {
    //                 this.timeElapsed = ((new Date()).getTime() - this.startTime.getTime()) / 1000;
    //             }.bind(this)); 
    //         },
    //         controllerAs: 'ctrl',
    //         //bindToController: true,
    //         template: 'time: {{ timeElapsed }}'
    //     }
    // })