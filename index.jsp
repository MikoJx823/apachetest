<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	Date now = new Date();
	
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

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
	

	
	<script src="js/jssor.slider.min.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        jssor_1_slider_init = function() {

            var jssor_1_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_1_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_1_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_2_slider_init = function() {

            var jssor_2_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_2_slider = new $JssorSlider$("jssor_2", jssor_2_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_2_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_2_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_3_slider_init = function() {

            var jssor_3_options = {
              $AutoPlay: 1,
              $Idle: 2000,
              $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$
              },
              $BulletNavigatorOptions: {
                $Class: $JssorBulletNavigator$
              }
            };

            var jssor_3_slider = new $JssorSlider$("jssor_3", jssor_3_options);

            /*#region responsive code begin*/

            var MAX_WIDTH = 980;

            function ScaleSlider() {
                var containerElement = jssor_3_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_3_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
        
        jssor_4_slider_init = function() {

            var jssor_4_options = {
              $AutoPlay: 1,
              $Idle: 2000,
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
                var containerElement = jssor_4_slider.$Elmt.parentNode;
                var containerWidth = containerElement.clientWidth;

                if (containerWidth) {

                    var expectedWidth = Math.min(MAX_WIDTH || containerWidth, containerWidth);

                    jssor_4_slider.$ScaleWidth(expectedWidth);
                }
                else {
                    window.setTimeout(ScaleSlider, 30);
                }
            }

            ScaleSlider();

            $Jssor$.$AddEvent(window, "load", ScaleSlider);
            $Jssor$.$AddEvent(window, "resize", ScaleSlider);
            $Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
            /*#endregion responsive code end*/
        };
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
        .jssorb052 .i .b {fill:#000;fill-opacity:0.3;}
        .jssorb052 .i:hover .b {fill-opacity:.7;}
        .jssorb052 .iav .b {fill-opacity: 1;}
        .jssorb052 .i.idn {opacity:.3;}

        .jssora053 {display:block;position:absolute;cursor:pointer;}
        .jssora053 .a {fill:none;stroke:#fff;stroke-width:640;stroke-miterlimit:10;}
        .jssora053:hover {opacity:.8;}
        .jssora053.jssora053dn {opacity:.5;}
        .jssora053.jssora053ds {opacity:.3;pointer-events:none;}
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
			        <a class="navbar-brand" href="index.html">
			          	<img src="images/logo2.png" alt="Navalli" witdh="100px">
			        </a>
	        	</div>
	        	<div id="navbar" class="navbar-collapse collapse">
			    	<li class="shopping-cart hidden">
			            <a href="#!" class="li-icon" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">
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
				                <a href="<%=basePath%>cartsummary">View Cart</a>
			                </li>
			            </ul>
			        </li>
			        <li><a href="#!" class="li-icon hidden" id="trigger-overlay"><i class="lil-search"></i></a></li>
			    </ul>
	        	<div id="navbar" class="navbar-collapse collapse">
				    <!--  <ul class="nav navbar-nav navbar-left">
				        <li class="active">
				            <a href="index.html" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Home <i class="caret"></i></a>
				            <ul class="dropdown-menu">
				                <li class="active"><a href="index.html">Home Default</a></li>
				                <li><a href="index-2.html">Home Default Slider</a></li>
				                <li><a href="index-3.html">Home Overlay Products</a></li>
				                <li><a href="index-4.html#instagram">Home instagram section</a></li>
				            </ul>
				        </li>
				        <li>
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Shop <i class="caret"></i></a>
				            <ul class="dropdown-menu">
				                <li><a href="products.html">Full Width Shop</a></li>
				                <li><a href="products-with-filter.html">Shop With Filter</a></li>
				                <li><a href="products-sidebar-left.html">Sidebar Left</a></li>
				                <li><a href="products-sidebar-right.html">Sidebar Right</a></li>
				                <li><a href="product.html">Simple Product</a></li>
				            </ul>
				        </li>
				        <li>
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">eCommerce Pages <i class="caret"></i></a>
				            <ul class="dropdown-menu">
				                <li><a href="wishlist.html">Wishlist</a></li>
				                <li><a href="cart.html">Cart</a></li>
				                <li><a href="checkout.html">Checkout</a></li>
				                <li><a href="order-received.html">Order Received</a></li>
				                <li><a href="order-tracking.html">Order Tracking</a></li>
				            </ul>
				        </li>
				        <li>
				            <a href="#!" data-toggle="dropdown" aria-haspopup="false" aria-expanded="false">Pages <i class="caret"></i></a>
				            <ul class="dropdown-menu">
				                <li><a href="page.html">Page Default</a></li>
				                <li><a href="login-register.html">Login / Register</a></li>
				                <li><a href="404.html">Not Found (404)</a></li>
				                <li><a href="faqs.html">FAQ'S</a></li>
				            </ul>
				        </li>
				        <li><a href="about.html">About</a></li>
				        <li><a href="contact.html">Contact</a></li>
				    </ul>-->
			    </div> <!--/.nav-collapse -->
	      	</div><!--/.container -->
	    </nav>
	</div><!-- /.nav-container -->

	<div class="swiper-slider">
		<!-- Slider main container -->
		<div class="swiper-container fullscreen">
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <div class="swiper-slide" style="background-image: url(images/slides/01.jpg);">
		        	<div class="valign-wrapper fullscreen">
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
		    <div class="swiper-button-prev"><i class="lil-chevron_left"></i></div>
		    <div class="swiper-button-next"><i class="lil-chevron_right"></i></div>
		</div>
	</div><!-- /.swiper-slider -->

	<section class="section collections" id="home-collections">
		<div class="container">
			<div class="row">
				
				<div style="padding-left:5px;padding-right:5px;padding-bottom:20px;" class="col-sm-6 " > 
					<div class="clearfix">
					
					<div id="jssor_1" style="position:relative;margin: 0 auto;top:0px;left:0px;width:750px;height:500px;overflow:hidden;visibility:hidden;">
				     
				        <!-- Loading Screen -->
				        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
				            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
				        </div>
				        <div data-u="slides" style="cursor:default;padding:10px;top:0px;left:0px;width:750px;height:500px;overflow:hidden;">
				            <div>
				                <img data-u="image" class="img-responsive" src="images/01.jpg" />
				            </div>
				            <div data-p="170.00"><a href="#">
				                <img data-u="image" class="img-responsive" src="images/01.jpg" />
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
				    <script type="text/javascript">jssor_1_slider_init();</script>
					</div>
					
					<!--  <a href="#!">
						<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
					</a> -->
				</div><!-- /.collection -->
				<div class="col-sm-6"> 
					<div class="row">
						<div style="padding-left:5px;padding-right:5px;" class="col-sm-6 " >
							<div class="clearfix">
							<div id="jssor_2" style="position:relative;margin:0 auto;top:0px;left:0px;width:350px;height:230px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;top:0px;left:0px;width:350px;height:220px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/02.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
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
				    	<script type="text/javascript">jssor_2_slider_init();</script>
				    	</div>
							<!--  <a href="#!">
								<img src="build/img/collections/02.jpg" class="img-responsive" alt="">
							</a>-->
						</div><!-- /.collection -->
						<div style="padding-left:5px;padding-right:5px;" class="col-sm-6">
							<div class="clearfix">
							<div id="jssor_3" style="position:relative;margin:0 auto;top:0px;left:0px;width:700px;height:460px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding:0px 10px 0px 10px;top:0px;left:0px;width:700px;height:440px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/03.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
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
				    	<script type="text/javascript">jssor_3_slider_init();</script>
							</div>
							<!--  <a href="#!">
								<img src="build/img/collections/03.jpg" class="img-responsive" alt="">
							</a> -->
						</div><!-- /.collection -->
						<div style="padding-left:5px;padding-right:5px;" class="col-sm-12 ">
							<div class="clearfix">
							<div id="jssor_4" style="position:relative;padding-top:10px;margin:0 auto;top:0px;left:0px;width:700px;height:240px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding: 0px 10px 10px 10px;top:0px;left:0px;width:740px;height:250px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="images/4.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
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
				    	<script type="text/javascript">jssor_4_slider_init();</script>
							</div>
							<!--  <a href="#!">
								<img src="build/img/collections/04.jpg" class="img-responsive" alt="">
							</a> -->
						</div><!-- /.collection -->
					</div>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.collections -->

	
	
	
	

	<section class="section small-padding-top" style="background-color:#f8f8f8; padding:70px">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center" >
					<h3>Playing Favorites</h3>
					<p>Share a selfie wearing your face Navalli Hill products with MAKEUPMY</p>
				</div>
			</div>
			<div class="row">
				<div class="pos-r clearfix">
					<ul style="text-align:center;">
					    <li style="display:inline-block;*display:inline;padding:5px;">
    					<!--   style="float:left;width:20%;padding:30px" -->
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" width="120px" height="120px"/>
					    </a>
					    </li>
					    <li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" width="120px" height="120px"/>
					    </a>
					    </li>
 						<li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" width="120px" height="120px"/>
					    </a>
					    </li>
					    <li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" width="120px" height="120px"/>
					    </a>
					    </li>
					    <li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/Dry-winter-snow-natural-hd-wallpaper.jpg" width="120px" height="120px"/>
					    </a>
					    </li>
					</ul>
					
					
					
					    
					    
					   
					    
					    
					    
					   
					
					
				</div>
			</div>
		</div>
	</section><!-- /.instagram -->


	
	<section class="section promotions small-padding-top" id="promotions">
		
		<div class="container">
			<div class="row">
				<div class="col-sm-12 section-title text-center">
					<h3><i class="line"></i>Find Us At<i class="line"></i></h3>
					<p>Checkout the Latest and Hottest!</p>
				</div>
				<div class="row">
				<div class="pos-r clearfix">
					<ul style="text-align:center;">
					    <li style="display:inline-block;*display:inline;padding:5px;">
    					<!--   style="float:left;width:20%;padding:30px" -->
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/brands/Shopee.png" height="120px"/>
					    </a>
					    </li>
					    <li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/brands/11street.png" height="120px"/>
					    </a>
					    </li>
 						<li style="display:inline-block;*display:inline;padding:5px">
					    <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
						    <img data-u="image" src="images/brands/lazada.png" height="120px"/>
					    </a>
					    </li>
					</ul>
				</div>
			</div>
				
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.promotions -->	
	<footer class="footer">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="col-sm-6 widget widget-about">
						<h3 class="widget-title" style="color:white">NEED HELP ? </h3>
						<p style="color:white">admin@nhmakeup.com.my</p>
						<br>
						<h4 style="color:white">OPERATION HOURS</h4>
						<p style="color:white">Mon - Fri (except Public Holiday) <br>9.00am - 6.00pm</p>
						
					</div><!-- ./widget -->
					<div class="col-sm-6 widget widget-newsletter">
						<h3 class="widget-title" style="color:white" >Join our Newsletter</h3>
						<form action="#!" method="POST" class="inputs-border clearfix">
							<div class="form-group">
								<input type="email" name="email" placeholder="Your Email" class="form-control" autocomplete="off">
								<button type="submit" class="btn btn-primary"><i class="lil-long-arrow-right"></i></button>
							</div>
						</form>
						<ul class="social">
							<li><a href="#!" target="_blank"><img data-u="image" src="images/icon/fb.png" height="30px"/></a></li>
							<li><a href="#!" target="_blank"><img data-u="image" src="images/icon/ig.png" height="30px"/></a></li>
						</ul>
					</div><!-- ./widget -->
				</div><!-- /.row -->
			</div><!-- /.widgets -->
		</div><!-- /.container -->
		<div class="copy-right text-center" style="backgroud-color:#000000">
			<p>© Copyright 2018. All Rights Reserved. Created by </p>
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

</body>
</html>