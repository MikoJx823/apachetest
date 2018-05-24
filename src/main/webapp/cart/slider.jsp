<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="../css/slick.css">
<link rel="stylesheet" type="text/css" href="../css/slick-theme.css">
  <style type="text/css">
  
    .slider {
    	margin: 0;
        padding: 0;
        box-sizing: border-box;
        width: 80%;
        margin: 100px auto;
    }

    .slick-slide {
      margin: 0px 20px;
    }

    .slick-slide img {
      width: 100%;
    }

    .slick-prev:before,
    .slick-next:before {
      color: black;
    }


    .slick-slide {
      transition: all ease-in-out .3s;
      opacity: .2;
    }

    .slick-active {
      opacity: .5;
    }

    .slick-current {
      opacity: 1;
    }
  </style>
  
  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="../js/slick.min.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
    $(document).on('ready', function() {
     
      $(".slider-responsive").slick({
    	  dots: false,
    	  infinite: true,
    	  speed: 300,
    	  slidesToShow: 5,
    	  slidesToScroll: 1,
    	  responsive: [
    	    {
    	      breakpoint: 1024,
    	      settings: {
    	        slidesToShow: 3,
    	        slidesToScroll: 1,
    	        infinite: true,
    	        dots: false
    	      }
    	    },
    	    {
    	      breakpoint: 600,
    	      settings: {
    	        slidesToShow: 2,
    	        slidesToScroll: 1,
    	        infinite: true,
    	        dots: false
    	      }
    	    },
    	    {
    	      breakpoint: 480,
    	      settings: {
    	        slidesToShow: 1,
    	        slidesToScroll: 1,
    	        infinite: true,
    	        dots: false
    	      }
    	    }
    	    // You can unslick at a given breakpoint now by adding:
    	    // settings: "unslick"
    	    // instead of a settings object
    	  ]
    	});
      
     
      $(".lazy").slick({
        lazyLoad: 'ondemand', // ondemand progressive anticipated
        infinite: true
      });
    });
</script>
</head>
<body>


 <section class="slider-responsive slider">
    <div>
      <img src="http://placehold.it/350x300?text=1">
      <h1>Test 1</h1>
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=2">
       <h1>Test 2</h1>
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=3">
       <h1>Test 3</h1>
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=4">
       <h1>Test 4</h1>
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=5">
       <h1>Test 5</h1>
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=6">
       <h1>Test 6</h1>
    </div>
  </section>


</body>
</html>