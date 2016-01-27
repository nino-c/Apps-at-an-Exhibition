//require(['jquery', "underscore", "app/util"], function() {
  
  //print("Inside requirejs block wrapped around 'site.js', the scroller-controller.")

  (function(){
    $(window).scroll(function () {
        var top = $(document).scrollTop();
        $('.corporate-jumbo').css({
          'background-position': '0px -'+(top/3).toFixed(2)+'px'
        });
        if(top > 50) {
          $("#shield").css({"display":"none"});
          $('.navbar').removeClass('navbar-transparent');
        } else {
          $('.navbar').addClass('navbar-transparent');
          $("#shield").css({"display":"block"});
        }
    }).trigger('scroll');
  })();

//})

