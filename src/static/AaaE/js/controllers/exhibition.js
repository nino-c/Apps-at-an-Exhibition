
  angular
    .module('Exhibition')
    .controller('ExhibitionController', ['$rootScope', '$scope', '$location', '$mdDialog',
      'AppService',
      'CategoryService',
      //'InstanceService',
      //'AppEditor',
      ($rootScope, $scope, $location, $mdDialog,
        AppService, CategoryService) => {

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

        
        


    }])
