var N = 32; // should at least divide 1024
var analyser;
var viz;


// create circle elements
view.width = Canvas.width;
view.height = Canvas.height;

var r = _.min([view.width, view.height]) / 2; console.log('r', r)
var elem = [];

_.each(_.range(N), function(n) {
	
	var rfac = ((N-n)/N); 
	
	var col = new Color();
	col.hue = (360)*(n/N);
	col.saturation = 0.5;
	col.brightness = 1;
	
	var el = new Path.Circle({
		radius: r*rfac,
		center: view.center,
		fillColor: col,
		blendMode: 'multiply',
		opacity: 0.5 + ((n/N)/2)
	});
	
	elem.push(el)	
})


view.onFrame = function() {
	
	analyser.getByteFrequencyData(fdata);
	console.log('onFrame');
  
	_.each(elem, function(el, i){
		
		var sum = 0;
		_.each(_.range( ((bincount/N)*i), ((bincount/N)*(i+1)) ), 
			function(i) { sum += fdata[i]; });
		
		var fac = ((sum/(bincount/N))/255);

		el.fillColor.saturation = fac;
		el.fillColor.hue += 3*fac;


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
	audio.stop();
	delete audio;
}