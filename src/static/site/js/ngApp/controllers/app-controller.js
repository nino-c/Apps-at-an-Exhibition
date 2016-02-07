var appController = Exhibition.controller('AppController', function ($scope, $rootScope, $location, GlobalService) {
    var failureCb = function (status) {
        console.log(status);
    };
    $scope.globals = GlobalService;

    $scope.initialize = function (is_authenticated) {
        console.log("app controller init, is auth: " + is_authenticated.toString());
        $scope.globals.is_authenticated = is_authenticated;
    };
})
