

angular
  .module('app.exhibition')
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
  // .directive('pendingBar', ['$rootScope', function ($rootScope) {
  //   return {
  //     link: function (scope, element, attrs) {
  //         console.log('pendingBar')
  //         console.log(scope, element, attrs)
  //         element.addClass('hide')
  //         $rootScope.$on('$routeChangeStart', function () {
  //             element.removeClass('hide')
  //         })
  //         $rootScope.$on('$routeChangeSuccess', function () {
  //             element.addClass('hide')
  //         })
  //         $rootScope.$on('$routeChangeError', function () {
  //             element.removeClass('hide')
  //         })
  //       }
  //     }
  // }])
  // .directive('viewState', ['$rootScope', ($rootScope) => {
  //     return {
  //         link: function (scope, element, attrs) {
  //           console.log('viewState')
  //           console.log(scope, element, attrs)
  //           element.addClass('hide')
  //           $rootScope.$on('$routeChangeStart', function () {
  //             element.addClass('hide')
  //         })
  //           $rootScope.$on('$routeChangeSuccess', function () {
  //             element.removeClass('hide')
  //         })
  //           $rootScope.$on('$routeChangeError', function () {
  //             element.addClass('hide')
  //           })
  //       }
  //     }
  // }])
