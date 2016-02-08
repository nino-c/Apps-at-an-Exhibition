/*Exhibition.controller('FeedController', function ($scope, GlobalService, ExhibitionService, TagService, posts) {*/


Exhibition.controller('FeedController', function ($scope, GlobalService, ExhibitionService, apps) {
    $scope.apps = apps;
    $scope.globals = GlobalService;
    //options for modals
    $scope.opts = {
        backdropFade: true,
        dialogFade: true
    };

    // options for forms
    $scope.scriptTypes = [
      {value:'text/javascript', label: 'javascript'},
      {value:'text/coffeescript', label: 'coffeescript'},
      {value:'text/paperscript', label: 'paperscript'}
    ];

    //open modals
    $scope.open = function (action) {
        console.log("open", action)
        if (action === 'create'){
            $scope.appModalCreate = true;
            $scope.app = new Object();
            //$scope.app.tags = [];
            //$scope.app.tags_details = [];
        };
    };
    //close modals
    $scope.close = function (action) {
        if (action === 'create'){
            $scope.appModalCreate = false;
        };
    };
    //calling board service
    $scope.create = function () {
        console.log("create feed", $score.app);
        ExhibitionService.save($scope.app).then(function (data) {
            $scope.app = data;
            $scope.apps.push(data);
            $scope.appModalCreate = false;
        }, function(status){
            console.log(status);
        });
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
    //     $scope.post.tags.splice(index, 1);
    // };
});
