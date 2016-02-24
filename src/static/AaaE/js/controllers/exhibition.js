
  angular
    .module('Exhibition')
    .controller('ExhibitionController', ['$scope', '$location', '$mdDialog',
      'AppService',
      'CategoryService',
      'InstanceService',
      //'AppEditor',
      ($scope, $location, $mdDialog,
        AppService, CategoryService, InstanceService) => {

        $scope.apps = AppService.query()
        $scope.categories = CategoryService.query()

        // options for forms
        $scope.scriptTypes = [
          {name:'text/javascript', label: 'javascript'},
          {name:'text/coffeescript', label: 'coffeescript'},
          {name:'text/paperscript', label: 'paperscript'}
        ]

        $scope.selectApp = (chosenApp) => {
          $scope.selectedApp = chosenApp
          $location.path('/apps/'+chosenApp.id)
        }

        $scope.createApp = (event) => {

          // create new app
          var newApp = {
            title:'New App',
            description:'',
            scriptType: "text/javascript",
            source:"function startApp() {\n\n}",
            seedStructure:'{"property": {"default":""}}',
            extraIncludes: []
          }

          //$location.path('/apps/new')

          $mdDialog.show({
              controller: 'AppEditor',
              parent: angular.element(document.body),
              targetEvent: event,
              templateUrl: '/static/site/js/plsysApp/components/app-editor.html',
              clickOutsideToClose:true,
              fullscreen: false
          })
        }

        ///////////////////

        $scope.instantiate = (event, _app) => {
            // console.log("create instance", $score.app);
            // InstanceService.save($scope.app).then(function (data) {
            //     $scope.app = data;
            //     $scope.apps.push(data);
            //     $scope.appModalCreate = false;
            // }, function(status){
            //     console.log(status);
            // });

            event.preventDefault();
            event.stopPropagation();

            var seedStructure = JSON.parse( _app.seedStructure )
            var seed = _.mapObject(seedStructure, (v,k) => {
              return v.default;
            })

            var instance = new InstanceService({})
            instance.app = _app
            instance.instantiator = _app.owner
            instance.seed = seed

            instance.$save();

        };


    }])
