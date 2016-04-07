var Canvas = document.getElementById('big-canvas');


var seed = {
	"integer": {"type":"number", "default":60, "min":2, "max":99999999999}
}

view.viewSize = new Size(Canvas.width, Canvas.height);

function isPrime(n) {
	var div = [];
	if (n==1) return false;
	_.each(_.range(2,n+1), function(i) {
		if (n%i == 0) return false;
	});
	return true;
}
