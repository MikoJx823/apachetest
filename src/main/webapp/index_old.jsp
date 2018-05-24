<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	
	//List<BannerInfoBean> bannerMain = BannerService.getInstance().getFrontListByPosition(StaticValueUtil.BANNER_INDEX_MAIN);
	//List<BannerInfoBean> bannerSubLeft = BannerService.getInstance().getFrontListByPosition(StaticValueUtil.BANNER_INDEX_SUB_L);
	//List<BannerInfoBean> bannerSubRightTop = BannerService.getInstance().getFrontListByPosition(StaticValueUtil.BANNER_INDEX_SUB_R_T);
	//List<BannerInfoBean> bannerSubRightBottom1 = BannerService.getInstance().getFrontListByPosition(StaticValueUtil.BANNER_INDEX_SUB_R_B_1);
	//List<BannerInfoBean> bannerSubRightBottom2 = BannerService.getInstance().getFrontListByPosition(StaticValueUtil.BANNER_INDEX_SUB_R_B_2);

%>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie ie6 ie-lt10 ie-lt9 ie-lt8 ie-lt7 no-js" lang="en-US"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie ie7 ie-lt10 ie-lt9 ie-lt8 no-js" lang="en-US"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie ie8 ie-lt10 ie-lt9 no-js" lang="en-US"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie ie9 ie-lt10 no-js" lang="en-US"> <![endif]-->
<!--[if gt IE 9]><!--><html class="no-js" lang="en-US"><!--<![endif]-->
<!-- the "no-js" class is for Modernizr. -->
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Sham - Creative Shopping Theme</title>

	<!-- Load Fonts -->
	<link rel="stylesheet" type="text/css" media="all" href="http://fonts.googleapis.com/css?family=Inconsolata:300,400,500,700|Unica+One:300,400,500,700">
	<!-- All theme style -->
	<link rel="stylesheet" type="text/css" media="all" href="css/min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
   	<link rel="stylesheet" type="text/css" href="css/slick.css">
  	<link rel="stylesheet" type="text/css" href="css/slick-theme.css">

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	
	
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	
	
	<script src="js/jssor.slider.min.js" type="text/javascript"></script>
   	<script src="js/slick.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        jssor_1_slider_init = function() {
			
        	//LEFT SUB BANNER 
            var jssor_1_options = {
              $AutoPlay: 1,
              $Idle: 5000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };
            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);
			
            //RIGHT TOP FIRST SUB BANNER
            var jssor_2_options = {
            	$AutoPlay: 1,
            	$Idle: 5000,
            	$ArrowNavigatorOptions: {
            		$Class: $JssorArrowNavigator$
                },
                $BulletNavigatorOptions: {
                    $Class: $JssorBulletNavigator$
                }
            };
            var jssor_2_slider = new $JssorSlider$("jssor_2", jssor_2_options);
            
            //RIGHT TOP SECOND SUB BANNER
            var jssor_3_options = {
            	$AutoPlay: 1,
                $Idle: 5000,
                $ArrowNavigatorOptions: {
                	$Class: $JssorArrowNavigator$
                },
                $BulletNavigatorOptions: {
                    $Class: $JssorBulletNavigator$
                }
            };
			var jssor_3_slider = new $JssorSlider$("jssor_3", jssor_3_options);
            
			var jssor_4_options = {
		    	$AutoPlay: 1,
		    	$Idle: 5000,
		    	$ArrowNavigatorOptions: {
		        	$Class: $JssorArrowNavigator$
		    	},
		   		$BulletNavigatorOptions: {
		        	$Class: $JssorBulletNavigator$
		   		}
		    };
		    var jssor_4_slider = new $JssorSlider$("jssor_4", jssor_4_options);
			
            /*#region responsive code begin*/
            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_1_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;
                var containerElement2 = jssor_2_slider.$Elmt.parentNode;
                var containerWidth2 = containerElement2.clientWidth;
                var containerElement3 = jssor_3_slider.$Elmt.parentNode;
                var containerWidth3 = containerElement3.clientWidth;
                var containerElement4 = jssor_4_slider.$Elmt.parentNode;
                var containerWidth4 = containerElement4.clientWidth;
                
                if (containerWidth && containerWidth2 && containerWidth3 && containerWidth4) {
                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);
                    var expectedWidth2 = Math.min(MAX_WIDTH || containerWidth2, containerWidth2);
                    var expectedWidth3 = Math.min(MAX_WIDTH || containerWidth3, containerWidth3);
                    var expectedWidth4 = Math.min(MAX_WIDTH || containerWidth4, containerWidth4);
                    
                    jssor_1_slider.$ScaleWidth(expectedWidth);
                    jssor_2_slider.$ScaleWidth(expectedWidth2);
                    jssor_3_slider.$ScaleWidth(expectedWidth3);
                    jssor_4_slider.$ScaleWidth(expectedWidth4);
                }else {
                    window.setTimeout(ScaleSlider, 0);
                }
            }
            
            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            
            
            /*#endregion responsive code end*/
        };
        
        
        $(document).on('ready', function() {
            $('.slider-resp-insta').slick({
              infinite: true,
          	  speed: 300,
          	  slidesToShow: 5,
          	  slidesToScroll: 1,
          	  responsive: [
          	    {
          	      breakpoint: 768,
          	      settings: {
          	        slidesToShow: 3,
          	        slidesToScroll: 1,
          	        infinite: true,
          	      	dots:true
          	      }
          	    },
          	    {
          	      breakpoint: 600,
          	      settings: {
          	        slidesToShow: 2,
          	        slidesToScroll: 1,
          	        infinite: true,
          	      	dots:true
          	      }
          	    }
          	    // You can unslick at a given breakpoint now by adding:
          	    // settings: "unslick"
          	    // instead of a settings object
          	  ]
          	});
          });
    </script>
    <style>
        /* jssor slider loading skin spin css */
        .jssorl-009-spin img {
            animation-name: jssorl-009-spin;
            animation-duration: 1.6s;
            animation-iteration-count: infinite;
            animation-timing-function: linear;
        }

        @keyframes jssorl-009-spin {
            from {
                transform: rotate(0deg);
            }

            to {
                transform: rotate(360deg);
            }
        }


        .jssorb052 .i {position:absolute;cursor:pointer;}
        .jssorb052 .i .b {fill:#E64D3C;fill-opacity:0.3;}
        .jssorb052 .i:hover .b {fill-opacity:.7;}
        .jssorb052 .iav .b {fill-opacity: 1;}
        .jssorb052 .i.idn {opacity:.3;}

        .jssora053 {display:block;position:absolute;cursor:pointer;}
        .jssora053 .a {fill:none;stroke:#fff;stroke-width:640;stroke-miterlimit:10;}
        .jssora053:hover {opacity:.8;}
        .jssora053.jssora053dn {opacity:.5;}
        .jssora053.jssora053ds {opacity:.3;pointer-events:none;}
        
        .slider-insta {
	    	margin: 0;
	      	padding: 0;
	      	box-sizing: border-box;
	        width: 100%;
	        
	        /*margin: 100px auto;*/
	    }
	    .slick-prev,
		.slick-next
		{
			opacity:0;
			width:0px;
			height:0px;
			left:0;
			right:0;
		}
	
	    /*.slick-slide {
	      margin: 0px 10px;
	    }*/
	
	    .slick-slide img {
	      /*max-width:200px;
	      max-height:200px;
	      margin-left: auto;
    	  margin-right: auto;;*/
	      width: 90%;
	      height:auto;
	      margin-left: auto;
    	  margin-right: auto;
	    }
	    
	    
    </style>

</head>
<body>

	<div class="nav-container navbar-fixed-top nav-sticky" >
		<!-- <nav class="sub-navbar">
			 <div class="list-select">
				<div class="inner-select">
					<div class="selected">EN</div>
					<ul>
						<li><a href="#!">EN</a></li>
						<li><a href="#!">AR</a></li>
						<li><a href="#!">TR</a></li>
					</ul>
				</div>
			</div>
			<div class="list-select">
				<div class="inner-select">
					<div class="selected"><i class="lil-dollar"></i></div>
					<ul>
						<li><a href="#!"><i class="lil-dollar"></i></a></li>
						<li><a href="#!"><i class="lil-gbp"></i></a></li>
						<li><a href="#!"><i class="lil-try"></i></a></li>
					</ul>
				</div>
			</div>

			<ul class="pull-right list-inline">
				<li><a href="#!">My account</a></li>
				<li><a href="wishlist.html">My Wishlist</a></li>
			</ul>
			<div class="clearfix"></div> 
		</nav><!-- /.sub-navbar -->
	    <nav class="navbar navbar-default" style="background-color:#000000">
	      	<div class="container">
	        	<div class="navbar-header">
			        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			        </button>
			        <a class="header-logo navbar-brand " href="index.html" style="position:absolute;width:150px;">
			          	<img src="images/logo2.png" alt="Navalli">
			        </a>
	        	</div>
	        	
			    <ul class="navbar-nav navbar-icons">
			    	<li style="padding-right:10px;margin:0px;" class="header-social-icon hidden-sm hidden-xs"><a href="https://www.facebook.com/" target="_blank"><img data-u="image" src="images/icon/fb.png" height="33px"/></a></li>
					<li style="padding:0px;margin:0px;" class="header-social-icon hidden-sm hidden-xs"><a href="http://instagram.com/" target="_blank"><img data-u="image" src="images/icon/ig.png" height="33px"/></a></li>
			    	<li class="shopping-cart">
			            <a href="#!" class="li-icon hidden" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">
			                <i class="lil-shopping_cart"></i><span class="badge">4</span>
			            </a>
			            <ul class="dropdown-menu">
			                <div class="dropdown-wrap" slim-scroll="√">
			                    <li>
			                        <a href="product.html"><img src="build/img/products/2.jpg" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="product.html">Bag Dark Beige</a></p>
			                            <p class="product-price clearfix">
											<ins>
												<span class="amount">$66.50</span>
											</ins>
										</p>
			                        </div>
			                    </li>
			                    <li>
			                        <a href="product.html"><img src="build/img/products/24.jpg" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="product.html">Shoes Maroon</a></p>
			                            <div class="product-price clearfix">$80.99</div>
			                        </div>
			                    </li>
			                    <li>
			                        <a href="product.html"><img src="build/img/products/3.jpg" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="product.html">Unisex Cap</a></p>
			                            <div class="product-price clearfix">$99.99</div>
			                        </div>
			                    </li>
			                    <li>
			                        <a href="product.html"><img src="build/img/products/12.jpg" class="img-responsive product-img" alt=""></a>
			                        <div class="product-details">
			                            <p class="product-title clearfix"><a href="product.html">Twill Silk Scarf</a></p>
			                            <div class="product-price clearfix">$49.99</div>
			                        </div>
			                    </li>
			                </div>
			                <li class="dropdown-footer">
				                <a href="cart.html">View Cart</a>
			                </li>
			            </ul>
			        </li>
			        <li><a href="#!" class="li-icon hidden" id="trigger-overlay"><i class="lil-search"></i></a></li>
			    </ul>
	        	<div id="navbar" class="navbar-collapse collapse">
				    <ul class="nav navbar-nav navbar-left hidden">
				         <li>
				            <a href="about.html">New <!--  <i class="caret"></i>--></a>
				        </li>
				        
				        <li class="active">
				            <a href="index.html" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Makeup </a>
				           	<div class="mega-dropdown1 dropdown-menu">
				           		<ul class="mega-subcontent">
				           		<li style="display:block;padding:3px 20px;"><p><b>Hi</b></p></li>
				           		<!-- <li style="display:block;padding:0px 20px;"><h4>Test</h4></li> class="mega-tag" -->
				                <li class="active"><a href="index.html">Home Default</a></li>
				                <li><a href="index-2.html">Home Default Slider</a></li>
				                <li><a href="index-3.html">Home Overlay Products</a></li>
				                <li><a href="index-4.html#instagram">Home instagram section</a></li>
				            	</ul>
				            
					            <ul class="mega-subcontent" >
					            	<li style="display:block;padding:3px 20px;"><p><b>Hi</b></p></li>
					                <li><a href="index.html">Home Default</a></li>
					                <li><a href="index-2.html">Home Default Slider</a></li>
					                <li><a href="index-3.html">Home Overlay Products</a></li>
					                <li><a href="index-4.html#instagram">Home instagram section</a></li>
					            </ul>
					            <ul class="mega-subcontent" >
					            	<li style="display:block;padding:3px 20px;"><p><b>Hi</b></p></li>
					                <li><a href="index.html">Home Default</a></li>
					                <li><a href="index-2.html">Home Default Slider</a></li>
					                <li><a href="index-3.html">Home Overlay Products</a></li>
					                <li><a href="index-4.html#instagram">Home instagram section</a></li>
					            </ul>
					            <ul class="mega-subcontent" >
					            	<li style="display:block;padding:3px 20px;"><p><b>Hi</b></p></li>
					                <li><a href="index.html">Home Default</a></li>
					                <li><a href="index-2.html">Home Default Slider</a></li>
					                <li><a href="index-3.html">Home Overlay Products</a></li>
					                <li><a href="index-4.html#instagram">Home instagram section</a></li>
					            </ul>
				           	</div>
				        </li>
				        <li>
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Skin </a>
				            <ul class="dropdown-menu">
				                <li><a href="products.html">Full Width Shop</a></li>
				                <li><a href="products-with-filter.html">Shop With Filter</a></li>
				                <li><a href="products-sidebar-left.html">Sidebar Left</a></li>
				                <li><a href="products-sidebar-right.html">Sidebar Right</a></li>
				                <li><a href="product.html">Simple Product</a></li>
				            </ul>
				        </li>
				       
				        <li>
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Bestseller</a>
				            <ul class="dropdown-menu">
				                <li><a href="page.html">Page Default</a></li>
				                <li><a href="login-register.html">Login / Register</a></li>
				                <li><a href="404.html">Not Found (404)</a></li>
				                <li><a href="faqs.html">FAQ'S</a></li>
				            </ul>
				        </li>
				        <li><a href="about.html">How To</a></li>
				        <li><a href="contact.html">FAQ</a></li>
				    </ul>
			    </div><!--/.nav-collapse -->
	      	</div><!--/.container -->
	    </nav>
	</div><!-- /.nav-container -->
	
	<div class="swiper-slider hidden-xs hidden-sm">
		<!-- Slider main container -->
		<div class="swiper-container " > <!-- style="min-height:100px;max-height:200px;!important" -->
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <div class="swiper-slide" style="background-image: url(images/slides/03.jpg);  ">
		        	<div class="valign-wrapper ">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(images/slides/02.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-8" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(images/slides/03.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-5">
		        		</div>
		        	</div>
		        </div>
		    </div>
		    <!-- If we need pagination -->
		    <div class="swiper-pagination"></div>
		    <!-- If we need navigation buttons -->
		    <div class="swiper-button-prev"><i class="lil-chevron_left"></i> </div>
		    <div class="swiper-button-next"><i class="lil-chevron_right"></i> </div>
		</div>
	</div><!-- /.swiper-slider -->
	
	<div class="swiper-slider hidden-md hidden-lg" style="margin">
		<!-- Slider main container -->
		<div class="swiper-container fullscreen" style="min-height:100px;max-height:400px;!important"> <!--  -->
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <img class="swiper-slide hidden-md hidden-lg" src="images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		        <img class="swiper-slide hidden-md hidden-lg" src="images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		        <img class="swiper-slide hidden-md hidden-lg" src="images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		        <img class="swiper-slide hidden-md hidden-lg" src="images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		    </div>
		    <!-- If we need pagination -->
		    <div class="swiper-pagination"></div>
		    <!-- If we need navigation buttons -->
		   <!--  <div class="swiper-button-prev"> <i class="lil-chevron_left"></i> </div>
		    <div class="swiper-button-next">i class="lil-chevron_right"></i></div> -->
		</div>
	</div><!-- /.swiper-slider -->
	
	

	<section class="section collections index-resp-container" id="home-collections" >
		<div class="container">
			<div class="row">
				<!--  <div class="col-md-1 col-sm-1 col-lg-1"></div>
				<div class="col-md-10 col-sm-10 col-lg-10">
					<div class="row"> -->
					
					
					<div style="padding-left:5px;padding-right:5px;padding-bottom:10px;" class="col-xs-12 col-md-6 col-lg-6" > 
					<div class="clearfix">
					
					<div id="jssor_1" style="position:relative;margin: 0 auto;top:0px;left:0px;width:570px;height:410px;overflow:hidden;visibility:hidden;">
				     
				        <!-- Loading Screen -->
				        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
				            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
				        </div>
				        <div data-u="slides" style="cursor:default;padding:0;top:0px;left:0px;width:570px;height:410px;overflow:hidden;">
				            <div>
				                <img data-u="image" src="images/01.jpg" />
				            </div>
				            <div><a href="#">
				                <img data-u="image" src="images/01.jpg" />
				            	</a>
				            </div>
				        </div>
				        <!-- Bullet Navigator -->
				        <div data-u="navigator" class="jssorb052" style="position:absolute;bottom:12px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
				            <div data-u="prototype" class="i" style="width:12px;height:12px;">
				                <svg viewBox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
				                    <circle class="b" cx="8000" cy="8000" r="5800"></circle>
				                </svg>
				            </div>
				        </div>
				    </div>
				    
					</div>
					
					<!--  <a href="#!">
						<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
					</a> -->
				</div><!-- /.collection -->
					
					<div class="col-xs-12 col-md-6 col-lg-6">
					
					<div class="row">
						<div style="padding-left:5px;padding-right:5px;" class="col-xs-6 col-md-6 col-lg-6" >
							<div class="clearfix">
							<div id="jssor_2" style="position:relative;margin:0 auto;top:0px;left:0px;width:570px;height:420px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding:0px 10px 10px 10px;top:0px;left:0px;width:570px;height:400px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/02.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="images/02.jpg"" />
					            	</a>
					            </div>
					        </div>
					        <!-- Bullet Navigator -->
					        <div data-u="navigator" class="jssorb052" style="position:absolute;bottom:30px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
					            <div data-u="prototype" class="i" style="width:16px;height:16px;">
					                <svg viewBox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
					                    <circle class="b" cx="8000" cy="8000" r="5800"></circle>
					                </svg>
					            </div>
					        </div>
				    	</div>
				    	<!--  <script type="text/javascript">jssor_2_slider_init();</script> -->
				    	</div>
							<!--  <a href="#!">
								<img src="build/img/collections/02.jpg" class="img-responsive" alt="">
							</a>-->
						</div><!-- /.collection -->
						<div style="padding-left:5px;padding-right:5px;" class="col-xs-6 col-md-6 col-lg-6">
							<div class="clearfix">
							<div id="jssor_3" style="position:relative;margin:0 auto;top:0px;left:0px;width:570px;height:420px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding:0px 10px 0px 10px;top:0px;left:0px;width:570px;height:400px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/03.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="images/03.jpg" />
					            	</a>
					            </div>
					        </div>
					        <!-- Bullet Navigator -->
					        <div data-u="navigator" class="jssorb052" style="position:absolute;bottom:30px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
					            <div data-u="prototype" class="i" style="width:16px;height:16px;">
					                <svg viewBox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
					                    <circle class="b" cx="8000" cy="8000" r="5800"></circle>
					                </svg>
					            </div>
					        </div>
				    	</div>
				    	<!--  <script type="text/javascript">jssor_3_slider_init();</script> -->
							</div>
							<!--  <a href="#!">
								<img src="build/img/collections/03.jpg" class="img-responsive" alt="">
							</a> -->
						</div><!-- /.collection -->
						<div style="padding-left:5px;padding-right:5px;" class="col-md-12 col-lg-12">
							<div class="clearfix">
							<div id="jssor_4" style="position:relative;padding-top:10px;margin:0 auto;top:0px;left:0px;width:1140px;height:405px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding: 0px 10px 0px 10px;top:0px;left:0px;width:1140px;height:405px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/4.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="images/4.jpg" />
					            	</a>
					            </div>
					        </div>
					        <!-- Bullet Navigator -->
					        <div data-u="navigator" class="jssorb052" style="position:absolute;bottom:12px;right:12px;" data-autocenter="1" data-scale="0.5" data-scale-bottom="0.75">
					            <div data-u="prototype" class="i" style="width:16px;height:16px;">
					                <svg viewBox="0 0 16000 16000" style="position:absolute;top:0;left:0;width:100%;height:100%;">
					                    <circle class="b" cx="8000" cy="8000" r="5800"></circle>
					                </svg>
					            </div>
					        </div>
				    	</div>
				    	<!--  <script type="text/javascript">jssor_4_slider_init();</script> -->
							</div>
							<!--  <a href="#!">
								<img src="build/img/collections/04.jpg" class="img-responsive" alt="">
							</a> -->
						</div><!-- /.collection -->
					</div>
				</div>
				
				<!--</div>
				
				 </div>
				<div class="col-md-1 col-sm-1 col-lg-1"></div> -->
				<script type="text/javascript">jssor_1_slider_init();</script>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.collections -->
	
	<section class="section small-padding-top" style="background-color:#f8f8f8;"> <!-- paddings:70px -->
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<h3 style="padding:0px;margin:0px;"><strong>Playing Favorites</strong></h3>
					<p style="padding-bottom:15px;"><i>Share a selfie wearing your fave Navalli Hill products with #NHMAKEUPMY</i></p>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 ">
					 <div class="section slider-resp-insta slider-insta slider">
						<div > 
							<a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" />
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					</div>
				</div>
			</div>
			
		</div>
	</section><!-- /.instagram -->

	<section class="section small-padding-top">	
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center"> <!-- section-title -->
					<h3 class="index-insta-header"><strong><i class="index-insta-line"></i>Find Us At<i class="index-insta-line"></i></strong></h3> 
					<p style="padding:0px;;color:#000000;font-weight:400"><i>Checkout the Latest and Hottest!</i></p>
				</div>
				<div class="row">
					
					<div class="col-xs-12 col-md-4" style="text-align:center;">
						<a href="https://shopee.com.my/" target="_blank">
								    <img data-u="image" src="images/brands/shopee.png" height="120px"/>
							    </a>
					</div>
						<div class="col-xs-12 col-md-4" style="text-align:center;">
						<a href="http://www.11street.my/" target="_blank">
								    <img data-u="image" src="images/brands/11street.png" height="120px"/>
							    </a>
						</div>
						<div class="col-xs-12 col-md-4" style="text-align:center;">
						<a href="https://www.lazada.com.my/" target="_blank">
								    <img data-u="image" src="images/brands/lazada.png" height="120px"/>
							    </a>
						</div>
				
			</div>
			
		</div>
	</section><!-- /.instagram -->
	
	<footer class="footer">
		<div class="container">
			<div class="widgets">
				<div class="row">
						<div class="hidden-md hidden-lg"><div class="col-xs-1"></div> </div>
						<div class="col-xs-11 col-md-6 widget widget-about">
							
							<h3 style="color:white;margin-top:0px;"><strong>NEED HELP ?</strong> </h3>
							<p style="color:white;font-weight:400;font-size:10pt;padding:0px;margin:0px;"><i>admin@nhmakeup.com.my</i></p>
							<br>
							<p style="display:inline-block;background-color:#d9d7d4;height:1px;width:60%;"></p>
							
							<p style="color:white;font-size:10pt;padding-top:5px;">OPERATION HOURS</p>
							<p style="color:white;font-weight:400;font-size:10pt;">Mon - Fri (except public holiday) <br>9.00AM - 6.00PM</p>
							
						</div><!-- ./widget -->
						
						<div class="hidden-md hidden-lg"><div class="col-xs-1"></div> </div>
						<div class="col-xs-11 col-md-6 widget widget-newsletter">
							<h3 class="widget-title" style="color:white" ><strong>Join our Newsletter</strong></h3>
							<form action="#!" method="POST" class="inputs-border clearfix">
								<div class="form-group">
									<input type="email" name="email" placeholder="admin@nhmakeup.com.my" class="form-control" autocomplete="off">
									<button type="submit" class="btn btn-primary"><i class="lil-long-arrow-right"></i></button>
								</div>
							</form>
							<ul class="social">
								<li><a href="https://www.facebook.com/" target="_blank"><img data-u="image" src="images/icon/fb.png" height="39px"/></a></li>
								<li><a href="https://www.instagram.com/" target="_blank"><img data-u="image" src="images/icon/ig.png" height="39px"/></a></li>
							</ul>
						</div><!-- ./widget -->
					
					
				
			</div><!-- /.widgets -->
		</div><!-- /.container -->
		<div class="copy-right text-center" style="backgroud-color:#000000">
			<p style="color:white;font-weight:400;font-size:9pt;">Copyright © NAVALLI HILL MALAYSIA. All rights reserved. </p>
		</div>
	</footer><!-- /.footer -->
	
	<!-- open/close -->
	<div class="overlay overlay-simplegenie">
		<i class="overlay-close lil-close"></i>
		<div class="container">
			<div class="row text-center pos-r">
				<div class="col-md-7 col-xs-11 col-center col-height-center search-form">
					<form action="#!" method="POST" class="inputs-bg" id="searchform">
						<strong>Type a sentence or word you want to search for, And press Enter.</strong>
						<input type="text" name="q" class="form-control" placeholder="Search..">
					</form>
				</div>
			</div>
		</div>
	</div><!-- /.overlay -->

	<!-- Go to top -->
	<a href="#top" class="go-to-top">
		<i class="lil-angle-double-down"></i>
	</a>

	<!-- All Theme Scripts -->
	<script type="text/javascript" src="js/min.js"></script>
  	<script src="js/slick.min.js" type="text/javascript" charset="utf-8"></script>

</body>
</html>