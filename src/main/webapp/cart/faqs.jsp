<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String basePath = StringUtil.getHostAddress();
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
						<li class="active">Faq's</li>
					</ol>
				</div>
			</div><!-- /.row -->
		</div><!-- /.container -->
	</div><!-- /.page-head -->

	<div class="page-wrapper">
		<section class="section" id="page-faqs">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h2 class="title">General Questions</h2>
						<div class="panel-group accordion" id="faqs" role="tablist" aria-multiselectable="true">
						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs" href="#faq-1" aria-expanded="true">
									        Is account registration required?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-1" class="panel-collapse collapse in">
						            <div class="panel-body">
						                Account registration at Sham is only required if you will be shopping. This ensures a valid communication channel for all parties involved in any transactions.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs" href="#faq-2" aria-expanded="true">
									        What is the currency used for all transactions?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-2" class="panel-collapse collapse">
						            <div class="panel-body">
						                All prices for products and other items, including each seller's or buyer's account balance are in USD.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs" href="#faq-3" aria-expanded="true">
									        What are the payment options?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-3" class="panel-collapse collapse">
						            <div class="panel-body">
						                The best way to transfer funds is via Paypal. This secure platform ensures timely payments and a secure environment.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs" href="#faq-4" aria-expanded="true">
									        Lorem Ipsum is simply dummy text
								        </a>
								    </h4>
						        </div>
						        <div id="faq-4" class="panel-collapse collapse">
						            <div class="panel-body">
						                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
						            </div>
						        </div>
						    </div>
						</div><!-- /.accordion -->
					</div>

					<div class="col-md-6">
						<h2 class="title">Users Questions</h2>
						<div class="panel-group accordion" id="faqs-2" role="tablist" aria-multiselectable="true">
						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs-2" href="#faq-2-1" aria-expanded="true">
									        Is account registration required?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-2-1" class="panel-collapse collapse in">
						            <div class="panel-body">
						                Account registration at Sham is only required if you will be shopping. This ensures a valid communication channel for all parties involved in any transactions.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs-2" href="#faq-2-2" aria-expanded="true">
									        What is the currency used for all transactions?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-2-2" class="panel-collapse collapse">
						            <div class="panel-body">
						                All prices for products and other items, including each seller's or buyer's account balance are in USD.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs-2" href="#faq-2-3" aria-expanded="true">
									        What are the payment options?
								        </a>
								    </h4>
						        </div>
						        <div id="faq-2-3" class="panel-collapse collapse">
						            <div class="panel-body">
						                The best way to transfer funds is via Paypal. This secure platform ensures timely payments and a secure environment.
						            </div>
						        </div>
						    </div>

						    <div class="panel panel-default">
						        <div class="panel-heading">
						            <h4 class="panel-title">
								        <a data-toggle="collapse" data-parent="#faqs-2" href="#faq-2-4" aria-expanded="true">
									        Lorem Ipsum is simply dummy text
								        </a>
								    </h4>
						        </div>
						        <div id="faq-2-4" class="panel-collapse collapse">
						            <div class="panel-body">
						                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the standard dummy text. Lorem Ipsum is simply dummy text of the printing and typesetting industry.
						            </div>
						        </div>
						    </div>
						</div><!-- /.accordion -->
					</div>
				</div><!-- /.row -->
			</div><!-- /.container -->
		</section><!-- #page-faqs -->
	</div><!-- /.page-wrapper -->

	<jsp:include page="footer.jsp" />

</body>
</html>