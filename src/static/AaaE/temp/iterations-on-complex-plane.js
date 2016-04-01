var Canvas = document.getElementById('big-canvas');
view.viewSize = new Size(Canvas.width, Canvas.height);


DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);
LIGHT_GREY = new Color(0.7, 0.7, 0.7, 0.4);

var cartesian_matrix = new Matrix(1,0,0,-1, view.center.x, view.center.y);


var grid = new Group();

_.each(_.range(-10,11), function(i) {
	_.each(_.range(-10,11), function(j) {
		var p = new Path.Rectangle({
			size: new Point(10,10),
			position:  (new Point(10*i,10*j)),
			strokeWidth: 1,
			strokeColor: LIGHT_GREY
		});
		grid.addChild(p);
	});
})

var raster = grid.rasterize(300);
//raster.position = grid.position + new Point(205,205)
grid.visible = false;

var map = {
	string: '(x^2-i)(x+2)',
	func: function(x) {
		var _x = math.complex(x[0], x[1]);
		return (_x.multiply(_x) - math.complex(0,1)) * (_x.add(math.complex(2,0)))
	}
}


function applyTransformation() {
	var tl = new Point(raster.bounds.left, raster.bounds.top);
	console.log(raster.width);
	var pixmap1 = [];
	for (var i=0; i<raster.width; i++) {
		pixmap1.push( [] );
		for (var j=0; j<raster.height; j++) {
			var cp = tl + new Point(i,j);
			pixmap1[i].push( raster.getPixel(cp) );
		}
	} 
	setInterval(function() {
		applyTransformation();
	}, 200);
}

project.activeLayer.transform(cartesian_matrix);
applyTransformation();