angular
  .module('Exhibition')
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
