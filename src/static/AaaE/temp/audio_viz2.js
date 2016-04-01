// included by system, present only for testing
var Canvas = document.getElementById('big-canvas');

var N = 4; // should at least divide 1024
var analyser;
var viz;


// create circle elements
view.width = Canvas.width;
view.height = Canvas.height;

var r0 = _.min([view.width, view.height]) / 2;
var elem = [];

var iteration_vector = new Point(-r0, -r0)
var startpoint = view.center;

_.each(_.range(N), function(n) {
	
	layer = new Layer({
		blendMode: 'multiply'
	})

	var col = new Color();
	col.hue = (360)*(n/N);
	col.saturation = 1;
	col.brightness = 0.5;

	var n2 = Math.pow(2, n);
	var n4 = Math.pow(4, n);
	var r = r0 * (1/n2);
	
	var _elem = [];

	_.each(_.range(n2), function(i) {
		_.each(_.range(n2), function(j) {
			var center = startpoint + new Point(r*2*i, r*2*j);
			var el = new Path.Circle({
				radius: r,
				center: center,
				fillColor: col,
				//strokeColor: 'black',
				//blendMode: 'multiply',
				opacity: 0.5 + ((n/N)/2)
			});

			layer.addChild(el);
			_elem.push(el);

		});
	});

	elem.push(_elem);
	startpoint -= new Point(r/2, r/2)
		
});

console.log(elem)

view.onFrame = function() {
	
	analyser.getByteFrequencyData(fdata);
	//console.log('onFrame');
	//console.log(fdata)
  
	_.each(elem, function(el, i){
		
		var sum = 0;
		console.log( ((bincount/N)*i), ((bincount/N)*(i+1)) )
		_.each(_.range( ((bincount/N)*i), ((bincount/N)*(i+1)) ), 
			function(i) { sum += fdata[i]; }
		);
		
		var val = ((sum/(bincount/N)));
		
		_.each(el, function(_el) {
			_el.fillColor.saturation = val;
			_el.fillColor.hue += val;
		})
	
	});

}


var audio;
var bincount;
var fdata;

window.start = function() {
	
	audio = new Audio();
	audio.src = '/static/audio/floyd.mp3';
	audio.play();

	var ctx = new AudioContext();
	var audioSrc = ctx.createMediaElementSource(audio);
	analyser = ctx.createAnalyser();
	audioSrc.connect(analyser);
	analyser.connect(ctx.destination);

	bincount = analyser.frequencyBinCount;
	fdata = new Uint8Array(bincount);
}

window.appdestroy = function() {
	console.log('app destroy');
	audio.pause();
	audio.src = '';
    console.log(audio);
	delete audio;
	window.start = null;
	view.onFrame = null;
}



/////////////////

// included by system, present only for testing
$(document).ready(function() {
	start();
})

