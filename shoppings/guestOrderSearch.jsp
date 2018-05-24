<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	
	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	String key = StringUtil.filter((String) request.getAttribute(SessionName.orderRef)); 
	System.out.println("--------Key="+key);
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	/*
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
    boolean isMember = false;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
		}	
	}
	
	if(!isMember){
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
		requestDispatcher.forward(request, response);
		return;
	}
	*/
	List<OrderBean> histories = (List<OrderBean>) request.getAttribute(SessionName.histories) == null ? new ArrayList<OrderBean>() : (List<OrderBean>) request.getAttribute(SessionName.histories);
	List<OrderBean> orderSearch = (List<OrderBean>) request.getAttribute(SessionName.orderSearch) == null ? new ArrayList<OrderBean>() : (List<OrderBean>) request.getAttribute(SessionName.orderSearch);
	
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
	<ol class="breadcrumb">
		<li><a href="<%=basePath %>index.jsp?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>"><fmt:message key="breadcrumb.home" /></a></li>				
		<li class="active"><fmt:message key="header.history.title"/></li>
	</ol>
    <h1 class="text-primary"><fmt:message key="history.title"/></h1>
    
   <fmt:message key="history.ref"/>
   <!--price selection-->
        <!--for search--> 
         <form action="<%=basePath %>guestOrderSearch?type=<%=StaticValueUtil.LOGIN_SOURCE_WEB%>" name="addCartForm" method="post">   
    <input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">  
      <h5 class="text-primary mt-30"><fmt:message key="history.guest.searchOrderHistory"/></h5>
    <div class="row mt-10">
 
    <div class="col-sm-8">
    	
          <div class="group">      
      <input name="key" type="tel" required>
      <span class="highlight"></span>
      <span class="bar"></span>
      <label><fmt:message key="history.guest.orderRef"/></label>
    </div> <!--group-->
        
    
    </div>
    
    </div>
    
     <div class="row mb-30">
    <div class="col-xs-24">
    
    <input class="btn btn-primary" type="submit" value="<fmt:message key="history.guest.submit"/>"/>
    </div>
    </div>
    </form>
    <div class="row mt-10">
        
        <div class="col-xs-24">
        
        	<%if(orderSearch.size() != 0 ){ %>
        	<table class="table verticalMid_tbl">
            	
                <thead class="small">
                	<tr>
                		<th><fmt:message key="history.ref"/></th>
                		<th><fmt:message key="history.date"/></th>
                		<th><fmt:message key="history.status"/></th>
                		<th></th>
                	</tr>
                </thead>
                <tbody class="small">
                
                <%for(OrderBean history : orderSearch) {  %>
                <tr>
                <td><%=StringUtil.filter(history.getOrderRef()) %></td>
                <td><%=DateUtil.formatDate(history.getTransactiondate()) %></td>
                <td><%=OrderStatusPulldown.getNameByLanguage(history.getOrderStatus() ,lang) %><td>
                <th><a href="shoppings/guestOrderResult.jsp?oid=<%=history.getoId() %>&type=<%=StaticValueUtil.LOGIN_SOURCE_WEB %>" 
                class="btn btn-sm btn-primary"><fmt:message key="history.view"/></a></th></tr>
                <%} %>
                <!--  <tr><td>800220</td><td>12/12/2017</td><th><a href="order_detail.html" class="btn btn-sm btn-primary">View</a></th></tr>
                <tr><td>800220</td><td>12/12/2017</td><th><a href="order_detail.html" class="btn btn-sm btn-primary">View</a></th></tr>
                -->
                </tbody>
                
            </table>
        
        	<%}else {
        		if (key== ""||key==null){
        	}else{%>
        		<fmt:message key="history.no.record"/>	
        	
        	<%}} %>
    
        </div>
          <!--col-xs-24-->
        
     
            
          </div><!--row-->
    
       <%--if(histories.size() > 0){ 
		String navPath = "history?type=" + StaticValueUtil.LOGIN_SOURCE_WEB + "&pageIdx=";
		
		--%>
	  <div class="row text-center">
		<%--=StringUtil.getFrontPagingString(5, pageIdx, totalPages, navPath) --%>
 	 </div>
	<%--} --%>
      
      
      
	</div><!--category pg ended-->
</section>

<jsp:include page="footer.jsp" />


</body>
</html>
