function getRadius(path) {
	return path.bounds.width / 2 + path.strokeWidth / 2;
}

function setRadius(path, radius) {
	var newRadiusWithoutStroke = radius - path.strokeWidth / 2;
	var oldRadiusWithoutStroke = path.bounds.width / 2;
	path.scale(newRadiusWithoutStroke / oldRadiusWithoutStroke);
}


Path.Circle.prototype.getRadius = function() {
	return this.path.bounds.width / 2 + this.path.strokeWidth / 2;
}

var Canvas = document.getElementById('bg-canvas');
view.viewSize = new Size(Canvas.width, Canvas.height);

var primes = [2,3,5,7,11,13,17,19,23];

DARK_GREY = new Color(0.6, 0.6, 0.6, 0.5);
LIGHT_GREY = new Color(0.7, 0.7, 0.7, 0.7);

var cartesian_matrix = new Matrix(1,0,0,-1, view.center._x, view.center._y);
cartesian_matrix.scale(3);

function Vec2Point(vec) { console.log(vec.elements); return new Point(vec.elements[0], vec.elements[1]); }
function Point2Vec(point) { return $V([point._x, point._y]); }

with (Math) {

	var grid = new Group();
	var lines = [];
	var range = _.range(-10,11); //numeric.linspace(-10, 10, 50);
	var magnification = 10;

	var cx = 1;
	var cy = 1;

	

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

	grid.addChildren(lines);

	// var cir = new Path.Circle({
	// 	fillColor: 'green',
	// 	center: [0,0],
	// 	radius: 1
	// });
	// var cir2 = new Path.Circle({
	// 	fillColor: 'red',
	// 	center: [20,20],
	// 	radius: 1
	// });
	// grid.addChildren([cir, cir2]);	


	//////////////////

	var PIX_PER_ITERATION = 1;
	var timecount = 0;
	var drops = [];

	var PROJECTION_MATRIX = $M([
		[1,0,sqrt(2)/2],
		[0,1,sqrt(2)/2]
	]);


	var Drop = function(center, wavelength, frequency, amplitude) {
		
		this.t = 0;
		this.center = center;
		this.radius = 1;
		this.wavelength = (wavelength || 30);
		this.frequency 	= (frequency || 2);
		this.amplitude 	= (amplitude || 10);
		this.starttime 	= (new Date()).getTime();
		this.iteration_started = false;

		this.peakCircle = new Path.Circle({
			radius: this.radius,
			strokeWidth: 1,
			strokeColor: '#777777'
		});
		grid.addChild(this.peakCircle);

		this.radiiset = [];

		//drop adds itself to collection upon creation
		drops.push(this);
		
	};

	Drop.prototype = {

		evaluate_z_at_vector: function(vector3) {
			return Math.cos(
				((PI*2)/this.wavelength)*vector3.elements[0] 
				+ ((PI*2)/this.wavelength)*vector3.elements[1] 
				- this.frequency*vector3.elements[2]
			);
		},

		start_iteration: function() {
			this.iterate(1); 
		},

		iterate: function(n) {
			var self = this;
			this.iteration_started = true;
			this.radius = n; //* PIX_PER_ITERATION;
			setRadius(this.peakCircle, this.radius);

			var vec3 = $V([this.radius, this.radius, n])
			var z = self.evaluate_z_at_vector(vec3);

			this.radiiset.push({radius: this.radius, value: z});
			
			_.each(lines, function(line) {
				_.each(line.segments, function(seg) {
					// get distance from current largest radius
					var d = floor(Point2Vec(seg.point).length() - self.radius);
					//console.log('d', d);
					if (d <= self.radius) {
						if (self.radiiset[self.radius-1]) {
							var z = self.radiiset[self.radius-1].value;
							//console.log(seg.point);
							var localpoint = seg.point; //.transform(cartesian_matrix.inverted());
							//console.log('lp', seg.point);
							var vec3 = $V([localpoint._x, localpoint._y].concat(z));
							//console.log('v3', PROJECTION_MATRIX, vec3);

							// project R3 -> R2
							var vec2 = PROJECTION_MATRIX.multiply(vec3);
							//console.log('v2', vec2);
							seg.point = new Point(vec2.elements[0], vec2.elements[1]);
							seg.path.smooth();
						}
					}
				});
			});
		},

		computeTime: function() {
			this.t = ((new Date()).getTime() - this.starttime) / 1000;
		}
	};

	var points = [];
	_.each(lines, function(line) {
		_.each(line.segments, function(seg) {
			points.push($V([seg.point._x, seg.point._y]));	
		});
	});

	// function applyTransform(point, timecount) {
	// 	var vec = $V([point._x, point._y]);
	// 	var t = timecount / 1000;
	// 	var x = point._x;
	// 	var y = point._y;
	// 	return Math.sin(t*x) + Math.cos(t*y);
	// }

	// var radius = 2;
	// function apply() {
	// 	var oldradius = getCircleRadius(circle0);
	// 	if (oldradius) {
	// 		radius = Math.log(timecount * 10);
	// 		circle0.scale(radius/oldradius);
	// 	}
	// }
	

	////////////////////

	onFrame = function(e) {
		// e {delta, timecount, count}
		//console.log('e', e);
		timecount = e.count;
		_.each(drops, function(drop) {
			if (drop.iteration_started)
				drop.iterate(e.count);
		});
		// if (e.count == 0) {
		// 	setInterval(apply, 200);
		// }
		//circle0.radius = Math.log(timecount * 10);
		//console.log(circle0.radius);
		//view.draw();
		
	}

	// var iteration = 1;
	// var iteration_limit = 5000;
	// function iterate() {
	// 	_.each(drops, function(drop) {
	// 		if (drop.iteration_started)
	// 			drop.iterate(iteration);
	// 	});
	// 	iteration++;
	// 	if (iteration < iteration_limit) {
	// 		setTimeout(function() {
	// 			iterate();
	// 		}, 500);
	// 	}
	// }

	var drop1 = new Drop($V([0,0]), 30, 2, 10);
	drop1.start_iteration();
	drops.push(drop1);
	//iterate(1);
	//setInterval(iterate, 300);
	//console.log('drops', drops);


	project.activeLayer.transform(cartesian_matrix);

}