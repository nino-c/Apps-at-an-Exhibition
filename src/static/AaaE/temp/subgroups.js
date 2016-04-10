var Canvas = document.getElementById('bg-canvas');
var seed = {
	"integer_group": {"type":"number", "default":60, "min":2, "max":99999999999}
}
var integer_group = 2520;


view.viewSize = new Size(Canvas.width, Canvas.height);

function get_divisors(n) {
	return _.filter(_.range(1,n+1), function(i) {
		return n%i==0;
	})
}

function isPrime(n) {
	if (n==1) 
		return false;
	for (var i=2; i<n; i++) {
		if (n%i == 0) 
			return false;
	}
	return true;
}

function is_member(x, rows) {
	return _.includes(_.flatten(rows), x);
}

function subgroups(n) {

	var rows = [[1]].concat([
		_.filter( _.range(1, Math.floor(n/2)), function(i) {
			return n%i == 0 && isPrime(i);
		})
	]);

	while (1) {

		var newrow = [];
		_.each(rows[rows.length-1], function(element) {
			_.each(_.range(1, rows.length), function(prev_index) {

				var prevrow = rows[prev_index];
				_.each(prevrow, function(e2) {
					var m = element * e2;
					if (newrow.length > 0 && m == n) 
						return;
					if (n%m==0 && !is_member(m,rows) && !_.includes(newrow, m)) {
						_.each(newrow, function(ne) {
							if (ne > m && ne % m == 0) 
								return;
						})
						newrow.push(m);
					}
				});
			});
		});
		
		if (newrow.length == 0)
			break;

		var newrow_relprime = newrow.sort(function(a,b) { return a - b; });
		rows.push(newrow_relprime);

	}

	return rows.reverse();
}


var color1 = new Color({
	hue: 350,
	saturation: 0.1,
	brightness: 0.9
});


if (isPrime(integer_group)) {

	var circ = new Path.Circle({
		center: view.center,
		radius: 100,
		fillColor: color1
	});

	var text = new PointText({
	    point: view.center,
	    justification: 'center',
	    content: integer_group.toString(),
	    fillColor: 'black',
	    fontFamily: 'Courier New',
	    fontWeight: 'bold',
	    fontSize: 32
	});

	var text = new PointText({
	    point: new Point(view.center.x, view.center.y + 25),
	    justification: 'center',
	    content: 'prime',
	    fillColor: 'black',
	    fontFamily: 'Courier New',
	    fontSize: 14
	});

} else {

	S = subgroups(integer_group);
	var positions = {};

	var rowheight = view.viewSize._height / S.length;
	_.each(S, function(row, i) {

		var centerY = (rowheight*i) + (rowheight/2);
		var colwidth = view.viewSize._width / row.length;

		_.each(row, function(num, j) {

			var centerX = (colwidth*j) + (colwidth/2);
			var center1 = new Point(centerX, centerY);
			var center2 = new Point(centerX, (centerY+4));

			positions[num.toString()] = [centerX, centerY];

			var circ = new Path.Circle({
				center: center1,
				radius: 20,
				fillColor: color1
			});

			var text = new PointText({
			    point: center2,
			    justification: 'center',
			    content: num.toString(),
			    fillColor: 'black',
			    fontFamily: 'Courier New',
			    fontWeight: 'bold',
			    fontSize: 16
			});
		})
		
	});

	var divisors = get_divisors(integer_group);
	var _S = S.reverse();

	_.each(divisors, function(div) {
		_.each(_S, function(row, i) {
			_.each(row, function(num) {
				if (div == num) {
					if (_S.length > i+1) {
						var nextrow = _S[i+1];
						var factors = [];
						_.each(nextrow, function(j) {
							if (j%div==0) {
								factors.push(j);
								var line = new Path.Line({
						            strokeColor: new Color(0.4,0.4,0.4,0.75),
						            strokeWidth: 1,
						            from: positions[num.toString()],
						            to: positions[j.toString()]
						        });
						        project.activeLayer.insertChild(0,line);
							}
						});
					}
				}
			});
		});
	});

}

var renderDone = false;
view.onFrame = function(e) {
	if (!renderDone && view.isVisible() && view.isInserted()) {
	  	renderDone = true;
	 	window.renderingDone(); 
	}
}

try {
    window.featureDisplay("$\\{H\: H \\leqslant (\\mathbb{Z}/" + 
    	integer_group + "\\space \\mathbb{Z})\\}$", {"font-size":"18px"});
} catch (e) {}