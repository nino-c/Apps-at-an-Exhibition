var Canvas = document.getElementById('bg-canvas');
view.viewSize = new Size(Canvas.width, Canvas.height);

var primes = [2,3,5,7,11,13,17,19,23];

DARK_GREY = new Color(0.6, 0.6, 0.6, 0.5);
LIGHT_GREY = new Color(0.7, 0.7, 0.7, 0.7);

var cartesian_matrix = new Matrix(1,0,0,-1,view.center._x, view.center._y);
cartesian_matrix.scale(3);




var grid = new Group();
var lines = [];
var range = _.range(-10,11); //numeric.linspace(-10, 10, 50);
var magnification = 10;

_.each(range, function(i) {

	var path1 = new Path({
		strokeWidth: 1,
		strokeColor: DARK_GREY
	});
	var points1 = _.map(range, function(p) {
		return new Point(p*magnification,i*magnification);
	});
	_.each(points1, function(p) {
		path1.add(p);
	})
	lines.push(path1);

});

_.each(range, function(i) {

	var path2 = new Path({
		strokeWidth: 1,
		strokeColor: DARK_GREY
	});
	var points2 = _.map(range, function(p) {
		return new Point(i*magnification,p*magnification);
	});
	_.each(points2, function(p) {
		path2.add(p);
	})
	lines.push(path2);

});

var cir = new Path.Circle({
	fillColor: 'green',
	center: [0,0],
	radius: 1
});
var cir2 = new Path.Circle({
	fillColor: 'red',
	center: [20,20],
	radius: 1
});

grid.addChildren(lines);
grid.addChildren([cir, cir2]);

//////////////////

var PIX_PER_SECOND = 100;
var time = 0;
var drops = [];

var Drop = function(center, frequency, init_amplitude) {
	this.t = 0;
	this.radius = 0;
	this.starttime = (new Date()).getTime();
};

Drop.prototype = {
	iterate: function() {
		this.radius = this.time() * PIX_PER_SECOND;		
		_.each(lines, function(line) {
			_.each(line.segments, function(seg) {
				
			});
		});
	},
	time: function() {
		return ((new Date()).getTime() - this.starttime);
	},
};

var points = [];
_.each(lines, function(line) {
	_.each(line.segments, function(seg) {
		points.push($V([seg.point._x, seg.point._y]));	
	});
});

function applyTransform(point, time) {
	var vec = $V([point._x, point._y]);
	var t = time / 1000;
	var x = point._x;
	var y = point._y;
	return Math.sin(t*x) + Math.cos(t*y);
}

///////////////////

var cx = 1;
var cy = 1;

view.onFrame = function(e) {
	// e {delta, time, count}
	time = e.time;
	_.each(lines, function(line) {
		_.each(line.segments, function(seg) {
			var z = applyTransform(seg.point, time);
			seg.point += (new Point(z*cx, z*cy));	
			seg.path.smooth();
		});
	});
}

project.activeLayer.transform(cartesian_matrix);