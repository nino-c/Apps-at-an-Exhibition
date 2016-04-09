
function drawAxes(_layer) {

    DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
    LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);

    view.viewSize = new Size(Canvas.width, Canvas.height);

    x_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    x_axis.add(new Point(-view.size.width/2, 0));
    x_axis.add(new Point(view.size.width/2, 0));
    //x_axis.closed = true;
    //project.activeLayer.insertChild(0,x_axis)

    y_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    y_axis.add(new Point(0, -view.size.height/2));
    y_axis.add(new Point(0, view.size.height/2));

    x_lines = [];
    _.each(_.range(-10,10), function(n) {
        line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(n, view.size.height/2) );
        line.add( new Point(n, -view.size.height/2) );
        //line.closed = true;
        //project.activeLayer.insertChild(0, line);
        x_lines.push( line );
    });

    y_lines = [];
    _.each(_.range(-10,10), function(n) {
        line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(view.size.width/2, n) );
        line.add( new Point(-view.size.width/2, n) );
        //line.closed = true;
        //project.activeLayer.insertChild(0, line);
        y_lines.push( line );
    });


    _layer.transform( new Matrix((view.size.width / 10),0,0,
        (view.size.height / -10), view.center.x, view.center.y) 
    );

}

drawAxes(project.activeLayer);

MFunction = function(func, extrema) {
    //console.log(func.length);
    this.func = func;
    if (!extrema) { extrema = [-5,5]; }

    this.domain = {
        elements: [],
        min: (extrema[0] || -5),
        max: (extrema[1] || 5)
    };

    this.codomain = {
        elements: [],
        min: null,
        max: null
    };

    this.mapping = null;
}

MFunction.prototype = {
    
    compute: function(delta) {
        if (!delta) { delta = 50; }
        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);
        this.codomain.elements = _.map(this.domain.elements, this.func);
        this.codomain.min = _.min(this.codomain.elements);
        this.codomain.max = _.max(this.codomain.elements);
        this.mapping = _.zip(this.domain.elements, this.codomain.elements);

        this._w = Math.abs(this.domain.max - this.domain.min);
        this._h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );

        this.transformation_matrix = new Matrix(
            (view.size.width / this._w), 0,
            0, (view.size.height / (-1*this._h)), 
            view.center.x, view.center.y);

        this.computed = true;
        console.log("computed.  transform-matrix: ", this.transformation_matrix)
    },

    // "flattens" mapping
    // i.e. [[1,2],3] -> [1,2,3]
    getPoints: function() {
        if (!this.computed) { this.compute(); }
        this.points = _.map(this.mapping, function(pair) {
            return _.flatten(pair);
        });
        return this.points;
    },


    draw: function(path, matrix_premult, map3d, tmatrix) {

        if (!this.computed) { this.compute(); }

        if (map3d) {
            this.points = this.points3d;
        } else {
            this.points = this.getPoints();
        }

        if (matrix_premult) {
            this.points = _.map(this.points, function(p) {
                return numeric.dot(matrix_premult, p);
            })
        }

        _.each(this.points, function(p) {
            path.add(new Point(p));
        })

        path.add(new Point(this.domain.max*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));
        path.add(new Point(this.domain.min*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));
        //path.closed = true;

        //path.transform(this.transformation_matrix);

        //path.smooth();
        
        if (tmatrix) {
            path.transform(tmatrix);
        } else {
            path.transform(this.transformation_matrix);
        } 
    }
}

// add function wrapper around js expression from math object
var mkfunc = "var _func1 = function(x) { return " + func1.javascript + "; }";
console.log(mkfunc);
eval(mkfunc);
var F0 = new MFunction(_func1, [x_min, x_max]);

path1 = new Path({
    strokeColor: new Color(0.7, 0.3, 0.3, 0.8),
    strokeWidth: 3,
    closed: false,
    //fillColor: new Color(Math.random(),1,Math.random(),0.2),
});
F0.compute();

transformation = [
  [1, 0, 0], //5*Math.cos(Math.PI/-4)],
  [0, 1, 0] //5*Math.sin(Math.PI/-4)],
];
//F0.draw(path1);
path1.smooth();


// T = new Matrix(
//         (view.size.width / _w), 0,
//         0, (view.size.height / (-1.2*_h)), 
//         view.center.x, view.center.y);
// console.log(T);
//project.activeLayer.transform(F0.transformation_matrix);