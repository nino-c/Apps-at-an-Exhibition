/*

@author: Nino P. Cocchiarella
(c) 2016

General site-wide plerping-system
-startup routines

*/

requirejs(['jQuery2.1.1', 'numeric-1.2.6', 'underscore', 'backbone'], function() {
	

	$(document).ready(function() {

	  print("start main js app");
	  print(Backbone)
	  var canvas_iframe = $("#big-canvas");
	  canvas_iframe.width( $(window).width() );
	  canvas_iframe.height( $(window).height() );

	});
});



// // site-wide startup routine
// $(document).ready(function() {

//   print("start main js app");
//   var canvas_iframe = $("#big-canvas");
//   canvas_iframe.width( $(window).width() );
//   canvas_iframe.height( $(window).height() );

// });