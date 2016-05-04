var Canvas = view._context.canvas;
view.viewSize = new Size(Canvas.width, Canvas.height);

function Vec2Point(vec) { console.log(vec.elements); return new Point(vec.elements[0], vec.elements[1]); }
function Point2Vec(point) { return $V([point._x, point._y]); }

DARK_GREY = new Color(0.6, 0.6, 0.6, 0.5);
LIGHT_GREY = new Color(0.7, 0.7, 0.7, 0.7);


// creation of matrices
// -- matrices are not used yet

var cartesian_matrix = new Matrix(1,0,0,-1, view.center.x, view.center.y);
cartesian_matrix.scale(5);

// var transformation = new Matrix(1, 0, 0, 1, 0.01, -0.1)
// transformation.rotate(0.1);
// transformation.scale(0.99)

var lines = [];

// creation of paths
// -- no transformation applied upon creation

var path1, path2;
_.each([path1, path2], function(path0, index) {
    _.each(_.range(-10,11), function(i) {

        var path1 = new Path({
            strokeWidth: 1,
            strokeColor: DARK_GREY
        });
        var points1 = _.map(_.range(-10,11), function(p) {
            return (index == 0 ? new Point(p*10,i*10) : new Point(i*10,p*10))
        })
        _.each(points1, function(p) { path1.add(p) })
        lines.push(path1)

    })
});


project.activeLayer.matrix = cartesian_matrix



var fixedpoint = (new Point(0,0)).transform(cartesian_matrix)
var r = 2

function applyTransform(seg,t) {
    var vec = fixedpoint - seg.point;
    if (vec.length != 0) {
        vec.angle += vec.length
        seg.point += vec.normalize()*Math.cos(t/10)
    }
    fixedpoint = (new Point(0,0) 
                    + new Point(r*Math.cos(t), r*Math.sin(t)))
                        .transform(cartesian_matrix)
    seg.path.smooth();
}

var encoder
var encoding_finished = false
view.onFrame = function(e) {
    // e {delta, time, count}

    // if (window.RECORD_GIF) {

    //     if (e.count == 0) {
    //         console.log($.post);
    //         console.log('paper-start');
    //         encoder = new GIFEncoder();
    //         encoder.setRepeat(0); //auto-loop
    //         encoder.setDelay(50);
    //         encoder.setSize(Canvas.width,Canvas.height);
    //         var s = encoder.start(); console.log(s);
    //     }

    //     if (e.time > 5) {
    //         encoder.addFrame(view._context);
    //         window.RECORD_GIF = false;
    //         encoding_finished = true;
    //     }
    // }

    // if (encoding_finished) {
    //     encoder.finish();
    //     var binary_gif = encoder.stream().getData(); 
    //     var data_url = 'data:image/gif;base64,'+encode64(binary_gif);
    //     console.log('save gif');
    //     $.post("/game/save_gif/", {
    //             image: data_url
    //         },
    //         function(data) {
    //             console.log(data);
    //         }
    //     );
    //     encoding_finished = false;
    // }

    _.each(lines, function(line) {
        _.each(line.segments, function(seg) {
            applyTransform(seg, e.time)
        });
    });

}






