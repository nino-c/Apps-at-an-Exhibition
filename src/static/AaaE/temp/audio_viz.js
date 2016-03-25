var analyser;
var viz;
var N;

function init_audioviz() {

	var ctx = new AudioContext();
	var audioSrc = ctx.createMediaElementSource(audio);
	analyser = ctx.createAnalyser();
	audioSrc.connect(analyser);
	analyser.connect(ctx.destination);
	
	viz = $("#audioviz");
	var bincount = analyser.frequencyBinCount;
	var fdata = new Uint8Array(bincount);
	N = 32; // should at least divide 1024
	
	var elements = _.map(_.range(N), function(n) {
		return $('<div class="n_viz_bar" id="vizbar'+n+'"></div>');
	});
	_.each(elements, function(el){viz.append(el);})
	
	

	function renderFrame() {
		requestAnimationFrame(renderFrame);
		analyser.getByteFrequencyData(fdata);

		_.each(elements, function(el, i){
			
			var sum = 0;
			_.each(_.range( ((bincount/N)*i), ((bincount/N)*(i+1)) ), 
				function(r) { sum += fdata[r]; });
			
			el.css({'margin-top':(120-( 120 * ((sum/(bincount/N))/255) ))+'px'});

		});

	}

	renderFrame(); 


}

var audio;

$(document).ready(function() {
	var viz = document.createElement('div');
	viz.id = 'audioviz';
	viz.class = 'n_viz';
	document.body.appendChild(viz);

	audio = new Audio();
	audio.src = '/static/audio/floyd.mp3';
	init_audioviz();
	audio.play();
})




