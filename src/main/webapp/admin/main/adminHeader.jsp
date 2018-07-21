<%@page import="com.project.util.*"%>
<%
//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin"); 
String basePath = StringUtil.getHostAddress() + "admin/"; 
%>

<head>
    <meta charset="utf-8">
    <title>Admin</title>
    <meta name="description" content="CLP ">
    <meta name="viewport" content="width=device-width">
    <head>
    <meta charset="utf-8">

    <!--  <link rel="stylesheet" href="<%=basePath %>css/bootstrap.css"> -->
    <link rel="stylesheet" href="<%=basePath %>css/style.css">
 	
    <script src="<%=basePath %>js/jquery-1.12.min.js"></script>
    <script src="<%=basePath %>ckeditor/ckeditor.js"></script>
	<script src="<%=basePath %>js/bootstrap.min.js"></script>
    <script src="<%=basePath %>js/modernizr.custom.65704.js"></script>
     <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>


