<%@ page language="java" import="com.project.pulldown.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils,java.util.*,java.text.*" contentType="text/html; charset=utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
%>
<%



%>

<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>">

<head>
<jsp:include page="meta.jsp" />

</head>
<body>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<jsp:include page="header.jsp" />

 
<section>
<div class="categorypg container">
 <h5 class="text-primary"><fmt:message key="checkout.survey"/></h5>

    <p><fmt:message key="checkout.survey.thanks2"/></p>
    
    <div class="col-xs-24 text-right mb-20">  
    	<a href="index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" class="btn btn-success"><fmt:message key="checkout.survey.contShop"/></a>
    </div>
</div>   

</section>


<jsp:include page="footer.jsp" />
<script>

	function checkForm(){
		if($.trim($("#rating").val()) == '0') {
			alert("Please select one of the rating");
			return false;
		}
		
		alert("Thank you for your feedback. ")
		return true;
	}
	
	$(function(){
		$('.surveybutton').hide();
		
		$("#rating").change(function(){
			$('.surveybutton').show();
		});
	});
</script>

</body>
</html>

