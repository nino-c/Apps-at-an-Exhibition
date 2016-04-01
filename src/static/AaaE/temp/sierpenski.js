

// var sierpenski_IFS = [
// 	[[0.5, 0, 1],
// 	 [0, 0.5, 1],
// 	 [0, 0, 0]],
// 	[[0.5, 0, 50],
// 	 [0, 0.5, 1],
// 	 [0, 0, 0]],
// 	[[0.5, 0, 25],
// 	 [0, 0.5, 50],
// 	 [0, 0, 0]],
// ];

var sierpenski_IFS = [
	[
		[[0.5, 0],
		 [0, 0.5]], [1,1]
	],
	
	[	
		[[0.5, 0],
	 	[0, 0.5]], [50,1]
	],
	[	
		[[0.5, 0],
	 	[0, 0.5]], [50,50]
	]
]

function getOrderedPairs(n, m) {
	var pairs = [];
	_.each(_.range(n), function(_n) { 
		_.each(_.range(m), function(_m) {
			pairs.push([_n,_m]);
		});
	});	
	return pairs;
}

var x = 0;
var y = 0;
var num_iterations = 1000;

_.each(_.range(num_iterations), function(i) {
	var k = _.sample([0,1,2]);
	var mat = sierpenski_IFS[k];
	var image_vector = numeric.dot(mat[0], [x,y]);
	image_vector[0] += mat[1][0];
	image_vector[1] += mat[1][1];
	x = image_vector[0];
	y = image_vector[1];
	if (i > 10) {
		var point = Path.Rectangle({
			point: [x,y],
			size: [1,1],
			fillColor: 'rgba(50,50,50,0.8)'
		});
	}
})




project.activeLayer.transform( new Matrix(5,0,0,-5,view.center.x, view.center.y) );