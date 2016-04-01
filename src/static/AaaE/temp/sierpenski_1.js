

var sierpenski_IFS = [
	new Matrix(0.5, 0, 0, 0.5, 1, 1),
	new Matrix(0.5, 0, 0, 0.5, 1, 50),
	new Matrix(0.5, 0, 0, 0.5, 50, 50)
]

var union = new Group();

var unit_square = new Path.Rectangle({
	from: [0,0],
	to: [1,1],
	fillColor: 'black'
})
union.addChild(unit_square)

var max_iterations = 25;
var num_iterations = 0;

function iterate() {
	var newChildren = [];
	_.each(sierpenski_IFS, function(T) {
		var currentSet = union.clone();
		//currentSet.position = union.position;
		currentSet.transform(T);
		newChildren.push(currentSet);
	});
	union.addChildren(newChildren)
	if (num_iterations <= max_iterations) {
		setTimeout(function() {
			num_iterations++;
			iterate();
		}, 1000);	
	}
}

iterate();

project.activeLayer.transform( new Matrix(10,0,0,-10,view.center.x, view.center.y) );