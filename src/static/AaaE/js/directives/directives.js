angular
  .module('Exhibition')
  .directive('artboard', ['$scope', ($scope) => {
    return {
      restrict: "AEC",
      scope: {
          script: function() {
              title: '='

          }
          script: '@',
          title: '@'
        },
        link: {
          (scope, elem, attrs) => {
              if (attrs.instance) {
                  eval(scope.instance.sourcecode)
              }
              if (attrs.title) {
                  var appinfo = () => {
                      return {
                          console.log(this);
                          return '---'
                      }
                  }
                  $scope.$watch(attrs.title, appinfo)
              }
          }
      }
    }
  }])
  .directive('timeAgo', ['$timeout', ($timeout) => {
      return {
        restrict: 'AEC',
        scope: {
            title: '@'
        },
        link: function (scope, elem, attrs) {
            var updateTime = () => {
              if (attrs.title) {
                console.log(attrs.title)
                elem.text(moment(attrs.title).fromNow())
                $timeout(updateTime, 15000)
              }
            }
            scope.$watch(attrs.title, updateTime)
        }
    }
  }])
