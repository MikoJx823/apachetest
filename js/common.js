//20160526 UAT Round1
// Scroll function handle links with @href started with '#' only
$(document).on('click', '.scrollbanner a[href^="#"]', function(e) {
    // target element id
    var id = $(this).attr('href');
    // target element
    var $id = $(id);
    if ($id.length === 0) {
        return;
    }
    // prevent standard hash navigation (avoid blinking in IE)
    e.preventDefault();
    // top position relative to the document
    var pos = $(id).offset().top - 109;
	
    // animated top scrolling
    $('body, html').animate({scrollTop: pos});
	
	$(id).addClass("border-primary").delay(1000).queue(function(next){
    $(this).removeClass("border-primary");
    next();
});
});

//*activate*/
$(function() {
//bx slider
$('.mainbanner').bxSlider({
	auto: true,
  minSlides: 1,
  maxSlides: 1,
  wrapperClass: 'bx-wrapper inner-pager',
   pager: false
}); //mainBanner

//scrollbanner
var numImgs = $('.scrollbanner li').length;
if(numImgs<5)
{
$('.product-scroll').addClass('hidden');
}

$('.scrollbanner').bxSlider({
	 wrapperClass: 'bx-wrapper product-link',
  minSlides: 2,
  maxSlides:5,
  moveSlides: 1,
  slideWidth: 200,
  slideMargin: 20,
  pager: false
}); 



//disable drop down
$('header .dropdown').on('click', function(event) {
    if ($(window).width() > 992) {
        event.stopPropagation();
    }
});

//add minus
$(".button_num").on("click", function() {
var $button = $(this);
var oldValue = $button.parent().find("input").val();
 if ($button.text() == "+") {
  	  var newVal = parseFloat(oldValue) + 1;
  	} else {
	   // Don't allow decrementing below zero
      if (oldValue > 0) {
        var newVal = parseFloat(oldValue) - 1;
	    } else {
        newVal = 0;
      }
	  }
$button.parent().find("input").val(newVal);
});
//*add minus ended*/

//cart function
  var submitIcon = $('.cart-open');
  var searchBox = $('.cartbox');
  var isOpen = false;
  submitIcon.click(function(){
   if(isOpen == false){searchBox.addClass('opened');isOpen = true;} 
   else {searchBox.removeClass('opened');
   isOpen = false;
   }
  }); 
   submitIcon.mouseup(function(){
    return false;
   });
   searchBox.mouseup(function(){
    return false;
   });
  $(document).mouseup(function(){
   if(isOpen == true){
    //$('.searchbox-icon').css('display','block');
    submitIcon.click();
  }
});
//*cartbox open*//
});

//menu
$(document).ready(function() {   
            var sideslider = $('[data-toggle=collapse-side]');
            var sel = sideslider.attr('data-target');
            var sel2 = sideslider.attr('data-target-2');
            sideslider.click(function(event){
                $(sel).toggleClass('in');
                $(sel2).toggleClass('out');
				 $('body').toggleClass('slide-active');

            });
});

 //product zoom function
  $(document).ready(function(){
  $("#productimage").elevateZoom({ gallery:'gal1', 
  cursor: 'pointer', 
  galleryActiveClass: 'active', 
  imageCrossfade: false, 
  //zoomType	: "lens", 
  lensShape : "square", 
  lensSize : 350
   });  
   //pass the images to Fancybox 
   $("#productimage").bind("click", function(e) { 
  
   var ez = $('#productimage').data('elevateZoom');	

   $.fancybox(ez.getGalleryList(),{
    	openEffect : 'none',
    	closeEffect	: 'none',
    	helpers : {
    		title : {
    			type : 'outside'
    		}
    	}
    }); 
   return false;
    });
});

//affix

$(function() {
	//hidden loader
	  $( ".zoomwrapper" ).append( $( '<div class="loader"><div class="loading-spinner"></div></div>' ) );
	  
	  
	//offset
	
			
	if ( $( ".product-scroll" ).length ) {
 		var pos2 = $( ".product-scroll" ).offset().top;
		$('.product-link2').affix({offset: {top: pos2} });
		$('.product-scroll').affix({offset: {top: pos2} });
		}
		
	
});

$( window ).load(function() {
  $(".loader").fadeOut();
});

$(document).ready(function(){
  
$(".fancybox").fancybox();
$("input[name='purpose']").click(function () {
    if (this.id == "Purposeother") {
        $("#OtherInput").show('slow');
    } else {
        $("#OtherInput").hide('slow');
    }
});
});