<%@ page language="java" import="com.project.pulldown.*,java.sql.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.service.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
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
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
	String orderRef = request.getParameter("Ref")==null?"":StringUtil.blockXss(request.getParameter("Ref"));
	
	String isNeg = StringUtil.filter((String)request.getAttribute("isNegative")); 
	//OrderBean orderBean = OrderService.getInstance().getOrderByOrderRef(orderRef);
%>

<!DOCTYPE html>
<html lang="<%=I18nUtil.getLangHtml(request) %>"> 
<head>
<jsp:include page="meta.jsp" />

</head>
<body>

<jsp:include page="header.jsp" />
<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<section>
<div class="categorypg container">
    <h1 class="text-primary"><fmt:message key="checkout.title"/></h1>
    
    <b class="small mb-15"><fmt:message key="payfail.payment"/></b>
    <ul class=" step list-unstyled">
        <li><div></div></li>
        <li><div></div></li>
        <li><div></div></li>
        <li class="active"><div></div></li>
    </ul>
    <div class="clearfix"></div>
    
     <h1 class="text-primary text-center"> 
     <%if(isNeg.equals(StaticValueUtil.STATUS_YES)){ %>
     	<fmt:message key="payfail.title.negative"/>
     <%}else { %>
     	<fmt:message key="payfail.title"/>
     <%} %>
     </h1>
     <p class="text-center small">
     	<%if(isNeg.equals(StaticValueUtil.STATUS_YES)){ %>
     		<fmt:message key="payfail.negative.point.note"/>
     	<%}else { %>
     		<fmt:message key="payfail.note"/>
     	<%} %>
     </p>



 <div class="col-xs-24 text-right mb-20">  
    	<a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" class="btn btn-success"><fmt:message key="checkout.survey.contShop"/></a>
    </div>
	</div><!--category pg ended-->   
    
    
</section>

<jsp:include page="footer.jsp" />


<script type="text/javascript">
	dataLayer.push({
	      'event':'paymentStatus',
	      'eventCategory': 'Payment',
	  	  'eventAction': 'Failed',
		  'eventLabel': 'Payment Failed',
	});
	
</script>


</body>
</html>


