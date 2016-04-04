angular.module('Exhibition')
    .filter('thumbnail', function() {
        return function(input, size) {
            return input.split(".png")
                .join("."+size.toString()+'x'+size.toString()+".png");
        }
    })
    .filter('round', function() {
        return function(input) {
            return Math.round(input);
        }
    })
    .filter('numberType', function() {
        return function(input) {
            return _.filter(input, function(item) {
                return item[1].type == 'number';
            })
        }
    })
