angular.module('Exhibition')
    .filter('thumbnail', function() {
        return function(input, size) {
            if (!input) return '';
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
    .filter('rawText', function() {
        return function(text) {
          return  text ? String(text).replace(/<[^>]+>/gm, '') : '';
        };
    })
    .filter('limit', function() {
        return function(input, length) {
            if (input.length > length) {
                input = input.slice(0,length);
            }
            return input;
        }
    })
    .filter('reverse', function() {
        return function(input) {
            return input.reverse();
        }
    })
