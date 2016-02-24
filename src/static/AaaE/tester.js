/*
    *
    *   @author: nino p cocchiarella
    *   (c) 2016
    *
*/

view.viewSize = new Size(Canvas.width, Canvas.height);

// define formal mathematical function in 1 var
MFunction = function(func, extrema) {
   
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
    this.compute();
}

MFunction.prototype = {
    
    compute: function(delta) {
        if (!delta) { delta = 100; }

        eval("_func = function(x) { return "+this.func+"; };");

        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);
        this.codomain.elements = _.map(this.domain.elements, _func);
        this.codomain.min = _.min(this.codomain.elements);
        this.codomain.max = _.max(this.codomain.elements);
        this.mapping = _.zip(this.domain.elements, this.codomain.elements);
    },

    draw: function(path, matrix_premult) {
        if (this.mapping == null) { this.compute(); }
        
        _w = Math.abs(this.domain.max - this.domain.min);
        _h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );
    

        points = this.mapping;

        if (matrix_premult) {
            points = _.map(points, function(p) {
                return numeric.dot(matrix_premult, p);
            })
        }

        _.each(points, function(p) {
            path.add(new Point(p));
        });
        
        T = new Matrix(
            (view.size.width / _w), 0,
            0, (view.size.height / (-1*_h)), 
            view.center.x, view.center.y);

        project.activeLayer.transform(T); 
    }
}


func = new MFunction(funct, [xMin,xMax]);

// draw Cartesian axes
drawAxes = function(xmax, ymax) {

    if (xmax == undefined) xmax = 10;
    if (ymax == undefined) ymax = 10;

    DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
    LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);

    x_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    x_axis.add(new Point(-view.size.width/2, 0));
    x_axis.add(new Point(view.size.width/2, 0));

    y_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });
    y_axis.add(new Point(0, -view.size.height/2));
    y_axis.add(new Point(0, view.size.height/2));

    _.each(_.range(-1*xmax,xmax), function(n) {
        var line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(n, view.size.height/2) );
        line.add( new Point(n, -view.size.height/2) );
        line.closed = true;
    });


    _.each(_.range(-1*ymax,ymax), function(n) {
        var line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(view.size.width/2, n) );
        line.add( new Point(-view.size.width/2, n) );
        line.closed = true;
    });


    project.activeLayer.transform( new Matrix((view.size.width / xmax),0,0,(view.size.height / (-1*ymax)), view.center.x, view.center.y) );

}
//executeRemotePaperscript("/static/site/js/app/graph-util.js");
drawAxes();

////////////////////////

INITCOLOR = _.map(_.range(3), Math.random)
N = 15;

with (paper) {

graphs = [];

_.map(_.range(N), function(n) {

    layer = new Layer({
        backgroundColor: new Color(1,1,1,0)
    });

    thickness = (n == 0 ? 3 : 1)
    alpha = 0.5 - (n/(N*2))

    var graph = new Path({
        strokeColor: new Color(  INITCOLOR.concat([alpha]) ),
        strokeWidth: thickness
    });

    matrix = [[1,0],[0,(1-(n/N))]]
    func.draw(graph, matrix);
    graph.smooth();
    graphs.push(graph);

 });




////////////


function onResize(event) {

}

view.onFrame = function(event) {
    scale = 1 + (Math.sin(event.time)/ breathDelta)
    _.each(graphs, function(g) {
        g.scale(1, scale);
    });
}

}