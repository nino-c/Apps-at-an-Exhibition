

var sierpenski_IFS = [
	[[0.5, 0, 1],
	 [0, 0.5, 1],
	 [0, 0, 0]],
	[[0.5, 0, 50],
	 [0, 0.5, 1],
	 [0, 0, 0]],
	[[0.5, 0, 25],
	 [0, 0.5, 50],
	 [0, 0, 0]],
]


// var unit_square = new Path.Rectangle({
// 	from: [0,0],
// 	to: [1,1],
// 	fillColor: 'black'
// })

function createUnivalentMatrix(n, val) {
	return _.map(_.range(N), function() { 
		return _.map(_.range(N), function() {
			return val;
		});
	});	
}

function getOrderedPairs(n, m) {
	var pairs = [];
	_.each(_.range(n), function(_n) { 
		_.each(_.range(m), function(_m) {
			pairs.push([_n,_m]);
		});
	});	
	return pairs;
}

var pixelobjects = [];

function renderPixels(pix) {
	pixelobjects = [];
	_.each(pix, function(p) {
		if (p[1]) {
			var point = Path.Circle({
				center: p[0].slice(0,2),
				radius: 0.5,
				fillColor: 'black'
			});
			pixelobjects.push(point);
		}
	})
}

function clearPixels(pix) {
	_.each(pixelobjects, function(p) {
		p.remove();
	});
}

var N = 100;
//var t = createUnivalentMatrix(N);
//var s = createUnivalentMatrix(N);

var t = _.map(getOrderedPairs(N,N), function(vec) { 
	var val = 0;
	if (vec[0][0] == 0 || vec[0][1] == 0 || vec[0][0] == 1 || vec[0][1] == 1) {
		val = 1;
	}
	return [vec, val]; 
});
var s = _.map(getOrderedPairs(N,N), function(vec) { return [vec, 0]; });;

var num_iterations = 0;
var max_iterations = 5;

function iterate() {

	_.each(sierpenski_IFS, function(T) {
		s = _.map(s, function(pix, i) {
			if (t[i][1] == 1) {
				return [numeric.dot(T, pix[0].concat(0)), 1];
			} else {
				return pix;
			}
		});
	})
	
	s = t;
	//clearPixels(s);
	t = _.map(getOrderedPairs(N,N), function(vec) { return [vec, 0]; });

	renderPixels(s);

	// setTimeout(function() {
	// 	iterate();
	// 	num_iterations++;
	// }, 1000)

}

iterate();

project.activeLayer.transform( new Matrix(5,0,0,-5,view.center.x, view.center.y) );