<%@ page language="java" import="com.project.util.PropertiesUtil" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>

<%
String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
%>	
	
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Sham - Creative Shopping Theme</title>

	<!-- Load Fonts -->
	<link rel="stylesheet" type="text/css" media="all" href="http://fonts.googleapis.com/css?family=Inconsolata:300,400,500,700|Unica+One:300,400,500,700">
	<!-- All theme style -->
	<link rel="stylesheet" type="text/css" media="all" href="<%=basePath %>css/min.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/custom.css">
	
	<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
	
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->
