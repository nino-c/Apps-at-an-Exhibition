/*

@author: Nino P. Cocchiarella
(c) 2016

General site-wide plerping-system
-startup routines

*/

function print(x) {
  console.log(x);
}

// site-wide startup routine
$(document).ready(function() {

  print("start main js app");
  var canvas_iframe = $("#big-canvas");
  canvas_iframe.width( $(window).width() );
  canvas_iframe.height( $(window).height() );

});