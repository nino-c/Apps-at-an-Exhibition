

window.drawAxes = function(project, view, xmax, ymax) {

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

    x_lines = [];
    _.each(_.range(-1*xmax,xmax), function(n) {
        line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(n, view.size.height/2) );
        line.add( new Point(n, -view.size.height/2) );
        x_lines.push( line );
    });

    y_lines = [];
    _.each(_.range(-1*ymax,ymax), function(n) {
        line = new Path({strokeColor: LIGHT_GREY });
        line.add( new Point(view.size.width/2, n) );
        line.add( new Point(-view.size.width/2, n) );
        y_lines.push( line );
    });

    project.activeLayer.transform( new Matrix((view.size.width / xmax),0,0,(view.size.height / -1*ymax), view.center.x, view.center.y) );

}