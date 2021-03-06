<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.PropertiesUtil" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	PropertiesUtil propUtil = new PropertiesUtil();
	String basePath = propUtil.getProperty("hostAddr") + propUtil.getProperty("virtualHost");
	//String basePath = "http://localhost:8080/navalli/";	
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
	<jsp:include page="meta.jsp" />

   	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/slick.css">
  	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/slick-theme.css">
   	
   	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
   	<script src="<%=basePath %>js/jssor.slider.min.js" type="text/javascript"></script>
   	<script src="<%=basePath %>js/slick.min.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
    
    
    //START SUB BANNER SLIDER FUNCTION 
    jssor_1_slider_init = function() {

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
              $Idle: 5000,
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
              $Idle: 5000,
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
       //END SUB BANNER SLIDER FUNCTION
       
       
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
            
            /*$('.slider-resp-prod').slick({
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
            	        infinite: true
            	      }
            	    },
            	    {
            	      breakpoint: 600,
            	      settings: {
            	        slidesToShow: 2,
            	        slidesToScroll: 1,
            	        infinite: true
            	      }
            	    },
            	    {
            	      breakpoint: 480,
            	      settings: {
            	        slidesToShow: 1,
            	        slidesToScroll: 1,
            	        infinite: true
            	      }
            	    }
            	    // You can unslick at a given breakpoint now by adding:
            	    // settings: "unslick"
            	    // instead of a settings object
            	  ]
            	});*/

            
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
        .jssorb052 .i .b {fill:#000;fill-opacity:0.3;}
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
	        width: 100%;
	        box-sizing: border-box;
	        -moz-box-sizing: border-box;
  			-webkit-box-sizing: border-box;
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
		.slick-slide {
	       position: relative;
		   width: 20%;
		   margin: 15px;
		   overflow: hidden;
	    }
	    
	    .slick-slide img {
	      /*max-width:200px;
	      max-height:200px;
	      margin-left: auto;
    	  margin-right: auto;;*/
		  /* max-width: 100%; 
    	  width:100%;
	      height:100%; */
	      max-width: 100%;
	      height:auto;
	      margin-left: auto;
    	  margin-right: auto;
    	  -moz-transition: all 0.3s;
  		  -webkit-transition: all 0.3s;
  		  transition: all 0.3s;
  		  opacity: .7;
	    }
	    
	    .slick-slide:hover img {
	      -moz-transform: scale(1.1);
		  -webkit-transform: scale(1.1);
		  transform: scale(1.1);
		  opacity:1;
		}


    </style>

</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="swiper-slider hidden-xs hidden-sm">
		<!-- Slider main container -->
		<div class="swiper-container fullscreen">
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <div class="swiper-slide" style="background-image: url(<%=basePath%>images/slides/Main-Banner-Cover-Up.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(<%=basePath%>images/slides/Main-Banner-Cover-Up-02.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(<%=basePath%>images/slides/Main-Banner-Cover-Up-03.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3">
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

	<div class="swiper-slider hidden-md hidden-lg" style="margin">
		<!-- Slider main container -->
		<div class="swiper-container fullscreen" style="min-height:100px;max-height:400px;!important"> <!--  -->
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <div class="swiper-slide" style="background-image: url(<%=basePath %>images/slides/03-m.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3">
		        		</div>
		        	</div>
		        </div>
		        
		        <!--  <img class="swiper-slide hidden-md hidden-lg" src="<%=basePath %>images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		        <img class="swiper-slide hidden-md hidden-lg" src="<%=basePath %>images/slides/Main-Banner-Cover-Up-Mobile.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		       	-->
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
				<div style="padding-left:5px;padding-right:5px;padding-bottom:10px;" class="col-xs-12 col-md-6 col-lg-6" > 
					<div class="clearfix">
					
					<div id="jssor_1" style="position:relative;margin: 0 auto;top:0px;left:0px;width:570px;height:410px;overflow:hidden;visibility:hidden;">
				     
				        <!-- Loading Screen -->
				        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
				            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
				        </div>
				        <div data-u="slides" style="cursor:default;padding:0;top:0px;left:0px;width:570px;height:410px;overflow:hidden;">
				            <div>
				                <img data-u="image" class="img-responsive" src="../images/01.jpg" />
				            </div>
				            <div data-p="170.00"><a href="#">
				                <img data-u="image" class="img-responsive" src="../images/01.jpg" />
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
				    <script type="text/javascript">jssor_1_slider_init();</script>
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
					                <img data-u="image" class="img-responsive" src="../images/02.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="../images/02.jpg"" />
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
						<div style="padding-left:5px;padding-right:5px;" class="col-xs-6 col-md-6 col-lg-6">
							<div class="clearfix">
							<div id="jssor_3" style="position:relative;margin:0 auto;top:0px;left:0px;width:570px;height:420px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding:0px 10px 0px 10px;top:0px;left:0px;width:570px;height:400px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="../images/03.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
					                <img data-u="image" class="img-responsive" src="../images/03.jpg" />
					            	</a>
					            </div>
					            <div data-b="0"> 
					                <img data-u="image" src="../img/gallery/980x380/008.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
					                <img data-u="image" class="img-responsive" src="../images/IMG_2470.JPG" />
					            	</a>
					            </div>
					             <div data-b="0"> 
					                <img data-u="image" src="../img/gallery/980x380/008.jpg" />
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
						<div style="padding-left:5px;padding-right:5px;" class="col-md-12 col-lg-12">
							<div class="clearfix">
							<div id="jssor_4" style="position:relative;padding-top:10px;margin:0 auto;top:0px;left:0px;width:1140px;height:405px;overflow:hidden;visibility:hidden;">
					        <!-- Loading Screen -->
					        <div data-u="loading" class="jssorl-009-spin" style="position:absolute;top:0px;left:0px;width:100%;height:100%;text-align:center;background-color:rgba(0,0,0,0.7);">
					            <img style="margin-top:-19px;position:relative;top:50%;width:38px;height:38px;" src="../svg/loading/static-svg/spin.svg" />
					        </div>
					        <div data-u="slides" style="cursor:default;padding: 0px 10px 0px 10px;top:0px;left:0px;width:1140px;height:405px;overflow:hidden;">
					            <div>
					                <img data-u="image" class="img-responsive" src="../images/4.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="../images/4.jpg" />
					            	</a>
					            </div>
					            <div data-b="0"> 
					                <img data-u="image" src="../img/gallery/980x380/008.jpg" />
					            </div>
					            <div data-p="170.00"><a href="#">
					                <img data-u="image" class="img-responsive" src="../images/IMG_2470.JPG" />
					            	</a>
					            </div>
					             <div data-b="0"> 
					                <img data-u="image" src="../img/gallery/980x380/008.jpg" />
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
	

	<section class="section products second-style" id="home-products">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 section-title text-center">
					<h3><i class="line"></i>Latest Products<i class="line"></i></h3>
					<p>Lorem Ipsum is simply dummy text.</p>
				</div>
				<div class="col-sm-12">
					<div class="masonry row">
						<div class="product col-md-3 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<span class="onsale">Sale!</span>
								<div class="product-thumbnail">
									<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Bag Dark Beige</a></h3>
							<div class="star-rating">
								<span style="width:90%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$66.50</span>
								</ins>
								<del>
									<span class="amount">$150.00</span>
								</del>
							</p>
						</div><!-- /.product -->

						<div class="product col-md-3 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<div class="product-thumbnail">
									<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Shoes Maroon</a></h3>
							<div class="star-rating">
								<span style="width:20%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$80.99</span>
								</ins>
							</p>
						</div><!-- /.product -->

						<div class="product col-md-3 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<span class="onsale new">New!</span>
								<div class="product-thumbnail">
									<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Unisex Cap</a></h3>
							<div class="star-rating">
								<span style="width:65%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$99.99</span>
								</ins>
							</p>
						</div><!-- /.product -->

						<div class="product col-md-3 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<div class="product-thumbnail">
									<img src="../images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Hands winter</a></h3>
							<div class="star-rating">
								<span style="width:50%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$15.00</span>
								</ins>
							</p>
						</div><!-- /.product -->

						<div class="product col-md-4 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<span class="onsale hot">Hot!</span>
								<div class="product-thumbnail">
									<img src="build/img/products/1.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Patterned Scarf</a></h3>
							<div class="star-rating">
								<span style="width:70%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$39.99</span>
								</ins>
							</p>
						</div><!-- /.product -->

						<div class="product col-md-4 col-sm-6 col-xs-12" data-product-id="1">
							<div class="inner-product">
								<div class="product-thumbnail">
									<img src="build/img/products/12.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div>
								</div>
							</div>
							<h3 class="product-title"><a href="#!">Twill Silk Scarf</a></h3>
							<div class="star-rating">
								<span style="width:90%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$49.99</span>
								</ins>
							</p>
						</div><!-- /.product -->
					</div><!-- /.masonry -->
				</div>
				<div class="col-sm-12 text-center">
					<a href="#!" class="btn btn-default">Show More</a>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.products -->
	
	<section class="section" style="background-color:#f8f8f8;"> <!-- psmall-padding-top addings:70px -->
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
								<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" />
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					    <div>
					      <a href="https://www.instagram.com/p/BDX1oYbxJCK" target="_blank">
								<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg"/>
							</a>
					    </div>
					</div>
				</div>
			</div>
			
		</div>
	</section><!-- /.instagram -->

	<section class="section promotions small-padding-top" id="promotions">
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<div class="promotion media">
						<div class="media-left media-middle">
							<i class="lil-local_atm"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Money Back</h3>
							<p>Lorem Ipsum is simply dummy text of the printing.</p>
						</div>
					</div>
				</div>

				<div class="col-sm-4">
					<div class="promotion media">
						<div class="media-left media-middle">
							<i class="lil-public"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">In Worldwide</h3>
							<p>Lorem Ipsum is simply dummy text of the printing.</p>
						</div>
					</div>
				</div>

				<div class="col-sm-4">
					<div class="promotion media">
						<div class="media-left media-middle">
							<i class="lil-local_shipping"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Free Shipping</h3>
							<p>Lorem Ipsum is simply dummy text of the printing.</p>
						</div>
					</div>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</section><!-- /.promotions -->
	
	<!--  <section class="section promotions small-padding-top" id="promotions">
		
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
    					<!--   style="float:left;width:20%;padding:30px" 
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
				
			</div><!-- /.row 
		</div><!-- /.container 
	</section> --><!-- /.promotions -->	

	<jsp:include page="footer.jsp" />

</body>
</html>