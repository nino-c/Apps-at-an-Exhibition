var Canvas = document.getElementById('big-canvas');
Canvas.width = $(window).width();
Canvas.height = $(window).height();

view.size = new Size($(window).width(), $(window).height());
var cartesian = new Matrix(1,0,0,-1,view.center._x/2, view.center._y);
project.activeLayer.transform(cartesian);

//console.log(cartesian);


var COLOR1 = '#99cc66';

var AffineTransformation = function(matrix_2x2, offset_1x2, prob) {
    this.matrix = matrix_2x2;
    this.offset = offset_1x2;
    this.prob = prob;
}
AffineTransformation.prototype = {
    apply: function(vec) {
        return (this.matrix.multiply(vec)).add(this.offset);
    },
    applyToSet: function(set) {
        var self = this;
        return _.map(set, function(vertex) {
            return self.apply(vertex);
        });
    }
};

var transformations = _.map([
    [[0,0],[0,0.5],[0,0], 0.05],
    [[0.42,-0.42],[0.42,0.42],[0,0.2], 0.4],
    [[0.42,0.42],[-0.42,0.42],[0,0.2], 0.4],
    [[0.1,0],[0,0.1],[0,0.2], 0.15]
], function(list) {
    return new AffineTransformation(
        $M([list[0], list[1]]),
        $V(list[2]),
        list[3]
    );
});

//console.log(transformations);

function Point2Vec(point) {
    return $V([point._x, point._y]);
}

function Vec2Point(vec) {
    return new Point(vec.elements[0], vec.elements[1]);
}

function getVerticesFromRect(rect) {
    return [
        Point2Vec(rect.bounds.topLeft),
        Point2Vec(rect.bounds.topRight),
        Point2Vec(rect.bounds.bottomRight),
        Point2Vec(rect.bounds.bottomLeft)
    ]; 
}

var set = [];
var unit = 50;
var unit_square = new Path.Rectangle({
    fillColor: COLOR1,
    from: [unit, unit],
    to: [0,0],
    strokeColor: 'rgba(200,200,200,0.4)',
    strokeWidth: 1,
    opacity: 1
});
set.push(unit_square);


iteration_count = 0;
var ITERATION_LIMIT = 12;
var iteration_limit_reached = false;

var l = new Layer({
    //blendMode: 'multiply'
});
l.transform(cartesian);

function iterate() {

    _.each(set, function(member) {
        _.each(transformations, function(transform) {

            var rand = Math.random();
            if (rand > transform.prob) {
                return;
            }

            var vertices = transform.applyToSet(
                getVerticesFromRect(member)
            );
            var new_member = new Path({
                fillColor: COLOR1,
                strokeColor: 'rgba(200,200,200,0.4)',
                strokeWidth: 1,
                opacity: 1
            });
            
            new_member.addSegments(
                _.map(vertices, Vec2Point)
            )
            new_member.closed = true;
            l.addChild(new_member);
            
            set.push(new_member);
        });

        view.draw();

    });

    
    

    if (iteration_count < ITERATION_LIMIT) {
        iteration_count++;
        setTimeout(function() {
            iterate();
        }, 200);
    }

    
    // } else {
    //     iteration_limit_reached = true;
    // }
}
iterate();

// view.onFrame = function() {
//     if (!iteration_limit_reached) iterate();
// }



// enfore cartesian
//project.activeLayer.transform(cartesian);
