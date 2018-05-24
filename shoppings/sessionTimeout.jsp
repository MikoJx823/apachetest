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
  
	String lang = "C" ; 

	String orderRef = request.getParameter("Ref")==null?"":StringUtil.blockXss(request.getParameter("Ref"));
	
	//OrderBean orderBean = OrderService.getInstance().getOrderByOrderRef(orderRef);
	
	

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

<section class="gray-bg">
<div class="container">
  <div class="row  outer-wrap">
  <div class="col-xs-24 general-border">
<!--             
	content inside the box           
-->
    <div class="row">
   <div class="col-xs-24">

    <h3 class="title"><fmt:message key="error.sessionTimeout.title"/></h3>
    </div>
    

    <!--donation form-->
    <div class="col-xs-24">
   
       
    <div class="well well-sm">
    <div class="tbl-cell text-center iconarea">
    </div> <div class="tbl-cell"><h3 class="text-danger mt-10">    <small><fmt:message key="error.sessionTimeout.errorMsg"/><a href="../shopping/CategoryServlet" ><fmt:message key="error.clickHereToReturn"/></a>。</small><br></h3>
    <br>
    </div>
    </div>
    </div>
    
      
 <!--
	 content inside the box ended
  -->
        </div>
    </div>
  </div>
</div>
</section>

<jsp:include page="footer.jsp" />


</body>
</html>


