// included by system, present only for testing
var Canvas = document.getElementById('big-canvas');




///////////////////////////////////////////////////////////


var analyser;
var viz;
var line;

// create circle elements
view.width = Canvas.width;
view.height = Canvas.height;


function init_path() {
	line = new Path({
		strokeWidth: 1,
		strokeColor: 'red'
	});
	var domain = numeric.linspace(0, view.width, bincount);
	var points = _.map(domain, function(x) {
		return [x,view.height/2];
	});
	_.each(points, function(point) {
		line.add(new Point(point));
	});
}


function onFrame() {
	
	analyser.getByteFrequencyData(fdata);

	_.each(_.range(bincount), function(i) {
		line.segments[i].point.y = fdata[i];
	})
	line.smooth();

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
	analyser.fftSize = 256;
	audioSrc.connect(analyser);
	analyser.connect(ctx.destination);

	bincount = analyser.frequencyBinCount; console.log('bincount', bincount)
	fdata = new Uint8Array(bincount);

	init_path();
}






// included by system, present only for testing
$(document).ready(function() {
	start();
})

