<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*, com.project.service.* ,com.project.util.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	//PropertiesUtil propUtil = new PropertiesUtil();
	//String basePath = propUtil.getProperty("hostAddr") + propUtil.getProperty("virtualHost");
	String basePath = StringUtil.getHostAddress();
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

	<script src="<%=basePath %>js/jssor.slider.min.js" type="text/javascript"></script>
   	<script src="<%=basePath %>js/slick.min.js" type="text/javascript"></script>
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
            
            $('.slider-resp-prod').slick({
                infinite: true,
            	  speed: 300,
            	  slidesToShow: 5,
            	  slidesToScroll: 1,
            	  responsive: [
            	    {
            	      breakpoint: 769,
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
            	    },
            	    {
              	      breakpoint: 400,
              	      settings: {
              	        slidesToShow: 1,
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
	        width: 100%;
	        box-sizing: border-box;
	        -moz-box-sizing: border-box;
  			-webkit-box-sizing: border-box;
	        /*margin: 100px auto;*/
	    }
	    .slider-insta .slick-prev,
		.slider-insta .slick-next
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
		.slider-insta .slick-slide {
	       position: relative;
		   width: 20%;
		   margin: 15px;
		   overflow: hidden;
	    }
	    
	    .slider-insta .slick-slide img {
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
	    
	    .slider-insta .slick-slide:hover img {
	      -moz-transform: scale(1.1);
		  -webkit-transform: scale(1.1);
		  transform: scale(1.1);
		  opacity:1;
		}
	    
	    .slider-prod {
	    	margin: 0;
	      	padding: 0;
	        width: 96%;
	        box-sizing: border-box;
	        -moz-box-sizing: border-box;
  			-webkit-box-sizing: border-box;
	        /*margin: 100px auto;*/
	    }
	    
		.slider-prod .slick-slide {
	       position: relative;
		   width: 20%;
		   margin: 15px;
		   overflow: hidden;
	    }
	    
	    .slider-prod .slick-slide img {
	      height:200px;
	      max-width: 100%;
	      margin-left: auto;
    	  margin-right: auto;
    	  -moz-transition: all 0.3s;
  		  -webkit-transition: all 0.3s;
  		  transition: all 0.3s;
  		  /*height:auto; 
  		   /* opacity: .7;*/
	    }
	    
	    .slider-prod .slick-prev:before,
    	.slider-prod .slick-next:before {
	      color: black;
	    }
	    
	    /*.slider-prod .slick-slide:hover img {
	      -moz-transform: scale(1.1);
		  -webkit-transform: scale(1.1);
		  transform: scale(1.1);
		  opacity:1;
		}*/
	    
    </style>

</head>
<body>

	<jsp:include page="header.jsp" />
	
	<div class="swiper-slider hidden-xs hidden-sm">
		<!-- Slider main container -->
		<div class="swiper-container " > <!-- style="min-height:100px;max-height:200px;!important" -->
		    <!-- Additional required wrapper -->
		    <div class="swiper-wrapper text-center">
		        <!-- Slides -->
		        <div class="swiper-slide" style="background-image: url(<%=basePath %>images/slides/Main-Banner-Cover-Up.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(<%=basePath %>images/slides/Main-Banner-Cover-Up-02.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <div class="swiper-slide" style="background-image: url(<%=basePath %>images/slides/Main-Banner-Cover-Up-03.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3" data-swiper-parallax="-100">
		        		</div>
		        	</div>
		        </div>
		        <!--  <div class="swiper-slide" style="background-image: url(images/slides/03.jpg);">
		        	<div class="valign-wrapper fullscreen">
		        		<div class="valign col-xs-offset-3">
		        		</div>
		        	</div>
		        </div>-->
		        
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
		        <img class="swiper-slide hidden-md hidden-lg" src="<%=basePath %>images/slides/03-m.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		        <img class="swiper-slide hidden-md hidden-lg" src="<%=basePath %>images/slides/Main-Banner-Cover-Up-Mobile.jpg" style="width: 100%;!important;height:auto;!important;margin-left: auto;margin-right: auto;"/>
		       
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
				                <img data-u="image" src="<%=basePath %>images/01.jpg" />
				            </div>
				            <div><a href="#">
				                <img data-u="image" src="<%=basePath %>images/01.jpg" />
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
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/02.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/02.jpg"" />
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
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/03.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/03.jpg" />
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
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/4.jpg" />
					            </div>
					            <div><a href="#">
					                <img data-u="image" class="img-responsive" src="<%=basePath %>images/4.jpg" />
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
	
	<section class="section" style="background-color:#e0e0e0;"> <!-- psmall-padding-top addings:70px -->
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<h4 class="index-insta-header"><strong><i class="index-insta-line"></i>Latest Products<i class="index-insta-line"></i></strong></h4> 
					<p style="padding-bottom:15px;font-size:10pt;"><i>Checkout The Latest And Hottest!</i></p>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					 <div class="section slider-resp-prod slider-prod slider">
						<div data-product-id="1" style="background-color:white;"> <!-- class="product col-md-3 col-sm-6 col-xs-12 -->
							<div> <!--class="inner-product"  -->
								<span style="width:30px;height:30px;line-height:30px;top:0px;right:0px;background-color:#e74c3c;backface-visibility:hidden;background-clip:padding-box;font-size:10px;color:#fff;text-align:center;display:block;overflow:hidden;z-index:1;position:absolute;color:white">NEW</span> <!--class="onsale"  -->
								<span style="width:30px;height:30px;line-height:30px;top:30px;right:0px;background-color:#a52923;backface-visibility:hidden;background-clip:padding-box;font-size:10px;color:#fff;text-align:center;display:block;overflow:hidden;z-index:1;position:absolute;color:white">HOT</span>
								<div class="product-thumbnail">
								<a href="#!">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</a>
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
							<!--  <div class="star-rating">
								<span style="width:90%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$75.99</span>
								</ins>
							</p>-->
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!-- <div class="product-btns">
										 <span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span> 
									</div>-->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
					</div> 
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 text-center" style="padding-top:25px;left:-10px">
					<button type="button" class="btn btn-default">Shop More</button>
				</div>
			</div>
		</div>
	</section><!-- /.instagram -->
	
	<section class="section" style="background-color:#e0e0e0;"> <!-- psmall-padding-top addings:70px -->
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<h4 class="index-insta-header"><strong><i class="index-insta-line"></i>Top Rated<i class="index-insta-line"></i></strong></h4> 
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12">
					 <div class="section slider-resp-prod slider-prod slider">
						<div data-product-id="1" style="background-color:white;"> <!-- class="product col-md-3 col-sm-6 col-xs-12 -->
							<div> <!--class="inner-product"  -->
								<span style="width:40px;height:40px;line-height:40px;top:0px;right:0px;background-color:#e74c3c;backface-visibility:hidden;background-clip:padding-box;font-size:14px;color:#fff;text-align:center;display:block;overflow:hidden;z-index:1;position:absolute;color:white">Sale</span> <!--class="onsale"  -->
								<div class="product-thumbnail">
								<a href="#!">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</a>
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
							<!--  <div class="star-rating">
								<span style="width:90%"></span>
							</div>
							<p class="product-price">
								<ins>
									<span class="amount">$75.99</span>
								</ins>
							</p>-->
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!-- <div class="product-btns">
										 <span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span> 
									</div>-->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--<div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
						
						<div data-product-id="1" style="background-color:white;">
							<div>
								<div class="product-thumbnail">
									<img src="<%=basePath %>images/Dry-winter-snow-natural-hd-wallpaper.jpg" class="img-responsive" alt="">
								</div>
								<div class="product-details text-center">
									<!--  <div class="product-btns">
										<span data-toggle="tooltip" data-placement="top" title="Add To Cart">
											<a href="#!" class="li-icon add-to-cart"><i class="lil-shopping_cart"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="Add to Favorites">
											<a href="#!" class="li-icon"><i class="lil-favorite"></i></a>
										</span>
										<span data-toggle="tooltip" data-placement="top" title="View">
											<a href="product.html" class="li-icon view-details"><i class="lil-search"></i></a>
										</span>
									</div> -->
								</div>
							</div>
							<h4 class="product-title" style="padding:0;margin:0;padding-left:15px;padding-top:5px;font-size:10pt;font-weight:900;"><strong><a href="#!">Bag Maroon</a></strong></h4>
							<p style="padding:0;margin:0;padding-left:15px;font-size:10pt;">45ml</p>
							<p style="padding:0;margin:0;padding-top:3px;padding-left:15px;font-weight:900;font-size:12pt;">RM 44.00 &nbsp;&nbsp;<span style="background-color:#e74c3c;color:white;padding-right:5px;padding-left:5px;font-size:11pt;"> 20% OFF </span> </p>
							<p style="padding:0;margin:0;padding-left:15px;padding-bottom:10px;font-size:8pt;"><del>RM60.00</del></p>
						</div><!-- /.product -->
					</div> 
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 text-center" style="padding-top:25px;left:-10px;">
					<button type="button" class="btn btn-default">Shop More</button>
				</div>
			</div>
		</div>
	</section><!-- /.instagram -->
	
	<section class="section" style="background-color:#e0e0e0;"> <!--#f8f8f8  psmall-padding-top addings:70px -->
		<div class="container">
			<div class="row">
				<div class="col-sm-12 text-center">
					<h4 style="padding:0px;margin:0px;"><strong>Playing Favorites</strong></h4>
					<p style="padding-bottom:15px;font-size:10pt;"><i>Share a selfie wearing your fave Navalli Hill products with #NHMAKEUPMY</i></p>
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
	
	<section class="section promotions" id="promotions">
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
	
	<jsp:include page="footer.jsp" />
	
  	<script src="<%=basePath %>js/slick.min.js" type="text/javascript" charset="utf-8"></script>
	
	<script>
	function onSubscripe(){
		
		
		//SubscribeServlet
		
	}
	
	
	</script>
	
</body>
</html>