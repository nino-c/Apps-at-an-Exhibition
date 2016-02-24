angular.module('Exhibition')
    .filter('thumbnail', function() {
        return function(input, size) {
            return input.replace(".png",
                "."+size.toString()+'x'+size.toString()+".png");
        }
    })
