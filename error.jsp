<%@ page language="java" import="com.project.util.*,java.util.Calendar,com.project.bean.*,com.project.service.*,java.util.*,java.text.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost") ;
	
	String type = StringUtil.filter(request.getParameter("type"));
	
%>

<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>">
<head>
<jsp:include page="shoppings/meta.jsp" />

</head>
<body>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/> 

<jsp:include page="shoppings/header.jsp" />

<section>
<div class="categorypg container">
   <div class="row">
           
<div class="col-xs-24"> <h1 class="text-primary">Page Not Found</h1>
</div>

<div class="col-xs-24">
<h4>對不起，系統未能顯示你所需的網頁，請檢查輸入的URL是否正確後再試。<br>
你亦可 <a class=" dark-gray-link" href="https://store.clp.com.hk"><u>https://store.clp.com.hk</u></a> 瀏覽，或回上一頁。</h4>

<br><br>

<h4>Sorry, your requested page cannot be displayed, please check the URL and then try again. <br>You may also visit the CLP home page at <a class=" dark-gray-link" href="https://store.clp.com.hk"><u>https://store.clp.com.hk</u></a>, or back to previous page.</h4>

</div>
    </div>   
	</div><!--category pg ended-->   

</section>


<jsp:include page="shoppings/footer.jsp" />

</body>
</html>




