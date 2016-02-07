Exhibition.controller('ExhibitionController', function ($scope, $routeParams, $location, ExhibitionService, GlobalService, app) {
    $scope.app = app;
    $scope.globals = GlobalService;
    var failureCb = function (status) {
        console.log(status);
    }
    //options for modals
    $scope.opts = {
        backdropFade: true,
        dialogFade: true
    };
    //open modals
    $scope.open = function (action) {
        if (action === 'edit'){
            $scope.appModalEdit = true;
        };
    };
    //close modals
    $scope.close = function (action) {
        if (action === 'edit'){
            $scope.appModalEdit = false;
        };
    };
    //calling board service
    $scope.update = function () {
        ExhibitionService.update($scope.app).then(function (data) {
            $scope.app = data;
            $scope.appModalEdit = false;
        }, failureCb);
    };
    // $scope.getTag = function (text) {
    //     return TagService.query(text).then(function (data) {
    //         return data;
    //     }, function (status) {
    //         console.log(status);
    //     });
    // };
    // $scope.selectTag = function () {
    //     if (typeof $scope.selectedTag === 'object') {
    //         $scope.app.tags.push($scope.selectedTag.url);
    //         $scope.app.tags_details.push($scope.selectedTag);
    //         $scope.selectedTag = null;
    //     }
    // };
    // $scope.removeTag = function (category) {
    //     var index = $scope.app.tags_details.indexOf(category);
    //     $scope.app.tags_details.splice(index, 1);
    //     var index = $scope.app.tags.indexOf(category.url);
    //     $scope.app.tags.splice(index, 1);
    // };
});
