<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.asiapay.clp.bean.*,com.asiapay.clp.service.*,com.asiapay.clp.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	//HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)request.getSession().getAttribute("cartMap");
	
	String errorMsg = StringUtil.filter((String) request.getSession().getAttribute(SessionName.errorMsg));
	String errorMsgC = StringUtil.filter((String) request.getSession().getAttribute(SessionName.errorMsgC));
	String loginFrom = StringUtil.filter((String)request.getSession().getAttribute(SessionName.loginFrom));
	String loginSource = StringUtil.filter((String)request.getSession().getAttribute(SessionName.loginSource)) ;
	String loginUType = StringUtil.filter((String)request.getSession().getAttribute(SessionName.loginUType));
	String loginTarget = StringUtil.filter((String)request.getSession().getAttribute(SessionName.loginTarget));
	
	String returnPage = StringUtil.filter((String) request.getSession().getAttribute(SessionName.returnPage));
	
	/*if(returnPage.contains("shopping/")) {
		returnPage = returnPage.replaceAll("shopping/", "");
		returnPage = "shopping/" + returnPage;
	}*/
	
	String navigatingPath = "";
	if(request.getRequestURI().contains("shopping")){
		navigatingPath = "checkout";
	}else{
		navigatingPath = "shopping/checkout";
	}
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
<form action="<%=basePath %>login" method="post" id="infoForm" name="infoForm"> 
	<input type="hidden" name="actionType" value="login">
	<input type="hidden" name="lang" value="<%=lang%>">
	<input type="hidden" name="from" value="<%=loginFrom %>">
	<!--  <input type="hidden" name="source" value="<%=loginSource%>"> -->
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
	<input type="hidden" name="utype" value="<%=loginUType%>">
	<input type="hidden" name="target" value="<%=loginTarget %>">
	<input type="hidden" name="returnPage" value="<%=returnPage%>" >
	<input type="hidden" name="isResponsive" value="y">
<div class="container">

<div class="row">
    <!-- <div class="col-xs-24 text-center pd-10"><img src="<%=basePath %>images/clp-logo-en.png" class="img-responsive center-block">
    </div> -->
</div><!--row-->

<div class="row">
    <div class="col-xs-24"> <div class="btn-group address wd-100" data-toggle="buttons">

  	<div class="group">      
      <input type="text" name="mLoginId" >
      <span class="highlight"></span>
      <span class="bar"></span>
      <label><fmt:message key="login.name"/></label>
    </div>
    
    <div class="group">      
      <input type="password" name="mPassword" >
      <span class="highlight"></span>
      <span class="bar"></span>
      <label><fmt:message key="login.password"/></label>
    </div>
 
</div>
    </div>
</div><!--row-->


<div class="row">
	<div class="col-xs-24 pt-10">
	
	<input type="submit" class="btn btn-success btn-lg btn-block" value="<%=I18nUtil.getString("login.member", lang)%>" 
     	onclick="return checkForm()">
	</div>
</div><!--row-->
<div class="row">
	<div class="col-xs-24 pt-10"><a class="btn btn-success btn-success-line btn-lg btn-block" 
	href="javascript:onGuestLogin();"><fmt:message key="login.guest"/></a></div>
</div><!--row--> <!-- href="checkout?actionType=checkout2" -->

<div class="row">
	<div class="col-xs-24 pt-10">
	<a href="https://services.clp.com.hk/<%=isEng == true?"en":"zh"%>/login/registration.aspx?_ga=2.173943075.1064939436.1508400737-771624725.1508400737"><u><fmt:message key="login.register.account"/></u></a><br>     
	<a href="https://www1.clpgroup.com/clponline/<%=isEng == true?"en":"tc"%>/forgotPassword/entry.do"><u><fmt:message key="login.forgot.pass"/></u></a>               
	</div>
</div>

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

		if($.trim($("[name='mLoginId']").val()) == '') {
			errorMsg +="<fmt:message key="error.checkout.form.loginid.required"/>" + "\n";
		}
		
		if($.trim($("[name='mPassword']").val()) == '') {
			errorMsg +="<fmt:message key="error.checkout.form.password.required"/>" + "\n";
		}
		
		if(errorMsg != ""){
			errorMsg ="<fmt:message key="error.fields.are.mandatory"/>" + "\n";
			alert(errorMsg);
			return false;
		}
		
		return true;
	}
	
	function onGuestLogin(){
		
		if('<%=returnPage%>' == ''){
			/*if('<%=loginFrom%>' == ''){
				window.location="<%=basePath%>checkout?actionType=checkout2";
			}else {*/
				window.location="index.jsp?type=web";
			//}
		}else {
			window.location='<%=returnPage%>&type=web';
			
		}
	}
</script>


</body>
<%
	request.getSession().removeAttribute(SessionName.errorMsg);
	request.getSession().removeAttribute(SessionName.errorMsgC);
	request.getSession().removeAttribute(SessionName.returnPage);
	request.getSession().removeAttribute(SessionName.loginFrom);
	request.getSession().removeAttribute(SessionName.loginSource) ;
	request.getSession().removeAttribute(SessionName.loginUType);
	request.getSession().removeAttribute(SessionName.loginTarget);
%>
</html>
