<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	boolean isEng = I18nUtil.isEng(request);
	//String lang = I18nUtil.getLang(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
	
	//HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute("cartMap");
	
	String errorMsg = StringUtil.filter(String.valueOf((String) request.getSession().getAttribute(SessionName.errorMsg)));
	String errorMsgC = StringUtil.filter(String.valueOf((String) request.getSession().getAttribute(SessionName.errorMsgC)));
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	//String loginFrom = StringUtil.filter(String.valueOf((String) request.getSession().getAttribute(SessionName.loginFrom)));
	//String loginSource = StringUtil.filter(String.valueOf((String) request.getSession().getAttribute(SessionName.loginSource)));
	
	/*String navigatingPath = "";
	if(request.getRequestURI().contains("shopping")){
		navigatingPath = "checkout";
	}else{
		navigatingPath = "shopping/checkout";
	}*/
	
	
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
<!--category pg ended-->
<form action="<%=basePath %>checkout" method="post" id="infoForm" name="infoForm"> 
	<input type="hidden" name="actionType" value="checkLogin2">
	<input type="hidden" name="lang" value="<%=lang%>">
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
	
	<!--  <input type="hidden" name="from" value="<%//loginFrom %>">
	<input type="hidden" name="source" value="<%//loginSource%>"> -->
<div class="container">

 <div class="row"><div class="col-xs-24"></div></div>

<div class="row">
    <div class="col-md-12"> <h3 class="text-primary"><b><fmt:message key="checkout.login"/></b></h3> 


<div class="btn-group address wd-100" data-toggle="buttons">

  <div class="group">      
      <input type="text" name="loginId" id="loginId" autocomplete="new-password">
      <span class="highlight"></span>
      <span class="bar"></span>
      <label><fmt:message key="login.name"/></label>
    </div>
    
    <div class="group">      
      <input type="password" name="password" id="password" autocomplete="new-password">
      <span class="highlight"></span>
      <span class="bar"></span>
      <label><fmt:message key="login.password"/></label>
    </div>
  
  
 
</div>
   

	<div class="wd-100 pt-10">
	
	<input type="submit" class="btn btn-success btn-lg btn-block" value="<%=I18nUtil.getString("checkout.login", lang)%>" 
     	onclick="return checkForm()">
     	
     	<a href="https://services.clp.com.hk/<%=isEng == true?"en":"zh"%>/login/registration.aspx?_ga=2.173943075.1064939436.1508400737-771624725.1508400737"><u><fmt:message key="login.register.account"/></u></a><br> 
	    <a href="https://www1.clpgroup.com/clponline/<%=isEng == true?"en":"tc"%>/forgotPassword/entry.do"><u><fmt:message key="login.forgot.pass"/></u></a>                             
	</div>

 </div>

	<div class="col-md-12 pt-10">
<h3 class="text-primary"><b><fmt:message key="checkout.login.guest"/></b></h3> 
<a class="btn btn-success btn-success-line btn-lg btn-block" 
	href="javascript:onGuestLogin();"><fmt:message key="checkout.login.btn.guest"/></a></div>
</div><!--row--> <!-- href="checkout?actionType=checkout2" -->

</div>
</form>
</section>

<jsp:include page="footer.jsp" />

<script type="text/javascript">

$( document ).ready(function() {
	
	if('<%=errorMsg %>' != '') {
		if(<%=isEng%>){
			alert('<%=errorMsg%>');
		}
	}
	
	if('<%=errorMsgC%>' != '') {
		if(!<%=isEng%>){
			alert('<%=errorMsgC%>');
		}
	}
	
	});
	
	function checkForm(){
		var errorMsg = "";
		
		if($.trim($("#loginId").val()) == '') {
			errorMsg += '<fmt:message key="error.checkout.loginid.required"/>' + '\n';
		}
		
		if($.trim($("#password").val()) == '') {
			errorMsg += '<fmt:message key="error.checkout.password.required"/>' + '\n';
		}
		
		if(errorMsg != ""){
			errorMsg = "<fmt:message key="error.fields.are.mandatory"/>" + "\n" + errorMsg;
			
			alert(errorMsg)
			return false;
		}
		
		dataLayer.push({
			'event': 'checkout',
				'ecommerce': {
			      'checkout': {
			        'actionField': {'step': '3'}
			     }
			   },
				'eventCallback': function() {}
		});
		
		return true;
	}
	
	function onGuestLogin(){
		
		dataLayer.push({
			'event': 'checkout',
				'ecommerce': {
			      'checkout': {
			        'actionField': {'step': '3'}
			     }
			   },
				'eventCallback': function() {
					window.location="<%=basePath%>checkout?actionType=checkout2&type=web";
			   }
		});
		
	}

</script>


</body>
<%
	request.getSession().removeAttribute(SessionName.errorMsg);
	request.getSession().removeAttribute(SessionName.errorMsgC);
%>
</html>
