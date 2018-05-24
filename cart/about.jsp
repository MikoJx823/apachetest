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
</head>
<body>

	<jsp:include page="header.jsp" />

	<div class="page-head content-top-margin">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-7">
					<ol class="breadcrumb">
						<li><a href="index.html">Home</a></li>
						<li class="active">About</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section" id="page-about">
			<div class="container">
				<div class="row">
					<div class="block clearfix">
						<div class="col-sm-4">
							<h2 class="title">We create products by today's standards.</h2>
							<p class="subtitle description">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
							</p>
							<p class="subtitle description">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
							</p>
						</div>
						<div class="col-sm-8">
							<div class="image">
								<img src="build/img/about-1.jpg" class="img-responsive">
								<div class="caption">
									<span>Our</span>
									<span>Office</span>
								</div>
							</div>
						</div>
					</div><!-- /.block -->

					<div class="block clearfix">
						<div class="col-sm-8">
							<div class="image">
								<img src="build/img/about-2.jpg" class="img-responsive">
								<div class="caption">
									<span>Mission</span>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<h2 class="title">Make it blend in or stand out.</h2>
							<p class="subtitle description">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
							</p>
							<p class="subtitle description">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
							</p>
						</div>
					</div><!-- /.block -->
				</div><!-- /.row -->

				<div class="block clearfix">
					<div class="col-sm-12 section-title text-center">
						<h3><i class="line"></i>Meet our Team<i class="line"></i></h3>
					</div>

					<div id="our-team">
						<div class="row">
							<div class="col-sm-3">
								<div class="author">
									<img src="build/img/users/8.jpg">
									<h3>Hussam</h3>
									<p>Web Developer</p>
									<ul class="social">
										<li><a href="https://twitter.com/Hussam3bd" target="_blank"><i class="lil-twitter"></i></a></li>
										<li><a href="https://instagram.com/Hussam3bd" target="_blank"><i class="lil-instagram"></i></a></li>
									</ul>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="author">
									<img src="build/img/users/7.jpg">
									<h3>Toyler</h3>
									<p>Product Designer</p>
									<ul class="social">
										<li><a href="#!" target="_blank"><i class="lil-twitter"></i></a></li>
										<li><a href="#!" target="_blank"><i class="lil-instagram"></i></a></li>
									</ul>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="author">
									<img src="build/img/users/5.jpg">
									<h3>Kevin</h3>
									<p>Creative Director</p>
									<ul class="social">
										<li><a href="#!" target="_blank"><i class="lil-twitter"></i></a></li>
										<li><a href="#!" target="_blank"><i class="lil-instagram"></i></a></li>
									</ul>
								</div>
							</div>

							<div class="col-sm-3">
								<div class="author">
									<img src="build/img/users/6.jpg">
									<h3>Alex</h3>
									<p>Web Designer</p>
									<ul class="social">
										<li><a href="#!" target="_blank"><i class="lil-twitter"></i></a></li>
										<li><a href="#!" target="_blank"><i class="lil-instagram"></i></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div><!-- /#our-team -->
				</div><!-- /.block -->
			</div><!-- /.container -->
		</section><!-- #page-about -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

</body>
</html>