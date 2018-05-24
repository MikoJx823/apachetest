///2017/CLP-ep360Cart/html/js/function.js
//lazyLoadAdded
//input materialize update 0323



//addfocus
//addfocus

function addFocus(){$(".group").children("input").each(function(){var t=$(this).val();0!=t.length?($(this).parent().addClass("pfocus"),$(this).addClass("focus")):($(this).parent().removeClass("pfocus"),$(this).removeClass("focus"))})}function checkFocus(){var t=1;$(".group").children("input").on("focusout",function(){t++;var i=$(this).val();return 0!=i.length?($(this).parent().addClass("pfocus"),$(this).addClass("focus"),!1):($(this).parent().removeClass("pfocus"),void $(this).removeClass("focus"))})}
/**
 * jQuery Unveil
 * A very lightweight jQuery plugin to lazy load images
 * http://luis-almeida.github.com/unveil
 *
 * Licensed under the MIT license.
 * Copyright 2013 Luís Almeida
 * https://github.com/luis-almeida
 */

!function(t){t.fn.unveil=function(i,s){function n(){var i=c.filter(function(){var i=t(this);if(!i.is(":hidden")){var s=o.scrollTop(),n=s+o.height(),e=i.offset().top,u=e+i.height();return u>=s-r&&n+r>=e}});e=i.trigger("unveil"),c=c.not(e)}var e,o=t(window),r=i||0,u=window.devicePixelRatio>1,a=u?"data-src-retina":"data-src",c=this;return this.one("unveil",function(){var t=this.getAttribute(a);t=t||this.getAttribute("data-src"),t&&(this.setAttribute("src",t),"function"==typeof s&&s.call(this))}),o.on("scroll.unveil resize.unveil lookup.unveil",n),n(),this}}(window.jQuery||window.Zepto);


$(function() {
        $(".thumbnail .img-responsive").unveil(5);
		$(".media-left .media-object").unveil(5);
    });
//CheckFocus Endedadd focus ended

//activae add focus and check focus;
$(function() {
	addFocus();
	checkFocus();
	
});

$( window ).on('load', function() {
	addFocus();
  setTimeout( function(){ 
    // Do something after 1 second 
	//console.log( '500ms');
	addFocus();
  }  , 1000 );
});

$(function() {
$('.group').children('input').bind('blur', function(){
   // $(this).removeClass('focus');
	
		checkFocus();
});

$('.group').children('input').bind('focus', function(){
	$(this).parent().addClass('pfocus');
    $(this).addClass('focus');
	
		checkFocus();
});
});

//materize form

$(function() {
	
//bx slider	
$('.bxslider').bxSlider({
	 auto: true,
  //mode: 'slide',
  speed: '500',
  captions: false
});

//#rating change

$( "#rating" ).change(function() {
	var stars = $( "#rating" ).val();
	//console.log('changed');
	//console.log(stars);
	
	  switch (stars) {
		case '0':
		//$('.ratingOptions').hide();
		$('.ratingOptions').css("display","none"); 
			//$('.rating0').show();
			$('.rating0').css("display","block"); 
			
			//console.log('case0');
			break;
			
		case '1':

		
			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating1').show();
			$('.rating1').css("display","block"); 
			//console.log('case01');
			break;
		case '2':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating2').show();
			$('.rating2').css("display","block"); 
			//console.log('case2');
			break;
		case '3':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating3').show();
			$('.rating3').css("display","block"); 
			//console.log('case3');
			break;
		case '4':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
		//	$('.rating4').show();
			$('.rating4').css("display","block"); 
			//console.log('case4');
			break;
		case '5':

			$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating5').show();
			$('.rating5').css("display","block"); 
			//console.log('case5');
			
	}
});










//prevent click close dropdown
$('.stopProp .dropdown-menu').click(function(e) {
       e.stopPropagation();
    });
	

	$('.dropdown .btn-group-vertical div').on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		
		$( this ).toggleClass( 'active' );
		var checkbox = $( this ).children().is( ":checked" );
		
		 if (checkbox) {
        $( this ).children().prop( "checked", false );
    } else {
       $( this ).children().prop( "checked", true );
    } 
		
    });
	
//$('.dropdown-accordion').on('show.bs.dropdown', function (event) {
 // var accordion = $(this).find($(this).data('accordion'));
  //accordion.find('.panel-collapse.in').collapse('hide');
//});


	$('#restButton').click(function(e) {
       e.stopPropagation();
    });
	

// Prevent dropdown to be closed when we click on an accordion link
$('.dropdown-accordion').on('click', 'a[data-toggle="collapse"]', function (event) {
  event.preventDefault();
  event.stopPropagation();
  $($(this).data('parent')).find('.panel-collapse.in').collapse('hide');
  $($(this).attr('href')).collapse('show');
});	
	
	
$('.selectpicker').selectpicker({
  style: 'btn-sm btn-link',
  size: 8,
  iconBase: 'fa',
  tickIcon: 'fa-check'
});



});

//20160718
// Scroll function handle links with @href started with '#' only
$(document).on('click', 'a.scroll[href^="#"]', function(e) {
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
    //var pos = $(id).offset().top;
    // animated top scrolling
    $('body, html').animate({scrollTop: 0});
	
	$(id).addClass("focus").delay(1000).queue(function(next){
    $(this).removeClass("focus");
    next();
});
	
	
});


$(function() {
//cart function
  var submitIcon = $('.cart-open');
  var searchBox = $('.cartbox');
  var isOpen = false;
  submitIcon.click(
  function(){
   if(isOpen == false){
	   searchBox.addClass('opened');
	   isOpen = true;
	   } 
   else {searchBox.removeClass('opened');
   isOpen = false;
   }
  }); 
   submitIcon.mouseup(function(){
    return false;
	 alert("false");
   });
   searchBox.mouseup(function(){
    return false;
   });
  $(document).mouseup(function(){
   if(isOpen == true){
	searchBox.removeClass('opened');
	isOpen = false;
  }
});
//*cartbox open*//

//.affix
$('.backtop').affix(
	{offset: {top: 200} }
  );
  

  


//form click 
$( ".otherInput" ).click(function() {
  $( this ).prev().click();
});


 $(".donationSelect a").click(function(){
        $( this ).prev('input').click();
		
    });
	
	$("input:radio:checked").parent().addClass("active");
	
	
	
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

//end
});

//material design



