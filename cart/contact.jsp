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
						<li class="active">Contact Us</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section no-padding-bottom" id="contact-map">
			<div class="container">
				<div class="row">
					<div class="map-wrapper col-sm-12">
						<div id="map" data-lat="40.9803480" data-long="28.7270580" data-title="Liliom Lab" data-subtitle="Istanbul, Turkey"></div>
					</div><!-- /.map-wrapper -->
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section>

		<section class="section" id="contact-info">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<h3 class="no-margin-top">Why not say <span class="autotype">Hello</span><span class="typed-cursor">?</span></h3>
						<p class="description">
							Speak to our team if you have any questions, need advice or if you're curious to hear more about what we have to offer. Give us a call or send us an email.
						</p>

						<div>
							<p><strong>Phone:</strong> +90 555 888 111</p>
							<p><strong>Email:</strong> info@domain.com</p>
							<p><strong>Address:</strong> Avcılar NO:9 DAİRE :2, Istanbul, Turkey</p>
						</div>
					</div>
					<div class="col-md-8">
						<form action="#!" method="POST" class="inputs-border">
							<div class="form-group">
								<input class="form-control" type="text" placeholder="Name" name="name">
							</div>
							<div class="form-group">
								<input class="form-control" type="text" placeholder="Email Address" name="email">
							</div>
							<div class="form-group">
								<textarea class="form-control" name="message" placeholder="Message"></textarea>
							</div>
							<div class="form-group text-right">
								<button type="button" class="btn btn-default">Send Message</button>
							</div>
						</form>
					</div>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section>
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

</body>
</html>