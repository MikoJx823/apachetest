<%@page import="com.asiapay.clp.bean.*"%>
<%@page import="com.asiapay.clp.util.PropertiesUtil"%>
<%@page import="com.asiapay.clp.util.I18nUtil"%>
<%@page import="com.asiapay.secure.PaydollarSecureUtil"%>
<%@page import="com.asiapay.secure.PaydollarSecureException"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.asiapay.clp.util.StringUtil"%>
<%@page import="org.apache.log4j.Logger" %>
<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
	response.setContentType("text/html;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
	OrderBean orderBean = (OrderBean) request.getSession().getAttribute("orderBean");
	
	//From session
	double amount = orderBean.getTotalAmount();
	String orderRef = orderBean.getOrderRef();
	
	//From properties file
	PropertiesUtil propUtil = new PropertiesUtil();
	String merchantId = propUtil.getProperty("merchantId");
	String payType = propUtil.getProperty("payType");
	String currCode = propUtil.getProperty("currCode");
	String action = propUtil.getProperty("paymentUrl");
	
    String successUrl = propUtil.getProperty("hostAddr")+propUtil.getProperty("virtualHost")+"shopping/paySuccess.jsp" ;
   
    String failUrl = propUtil.getProperty("hostAddr")+propUtil.getProperty("virtualHost")+"shopping/payFail.jsp" ;
    String errorUrl = propUtil.getProperty("hostAddr")+propUtil.getProperty("virtualHost")+"shopping/payCancel.jsp" ;
   
    String lang = orderBean.getOrderLang();
	
	//String secureHash = StringUtil.blockXss((String) session.getAttribute("secureHash")); 
	String secureHash=null;

	if("true".equals(StringUtil.filter(PropertiesUtil.getProperty("secureHashFlag")))){
		// For secureHash generate
		try{		
			System.out.println("-- START generate secureHash --- ");
			NumberFormat formatter = new DecimalFormat("###.##"); //String.valueOf
			secureHash=PaydollarSecureUtil.generatePaymentSecureHash(merchantId,orderBean.getOrderRef(),currCode,String.valueOf(amount),payType);
			System.out.println("-- SecureHash:"+secureHash+"--- ");
			System.out.println("-- END generate secureHash --- ");
		}catch(PaydollarSecureException e){
			System.out.println("SecureHash generate failed - "+ e.getMessage());
			return;
		}
		//request.setAttribute("secureHash", secureHash);
	}
	// Print Log
	
	System.out.println("action:" + action);
	System.out.println("merchantId:" + merchantId);
	System.out.println("amount:" + amount);
	System.out.println("orderRef:" + orderRef);
	System.out.println("currCode:" + currCode);
	System.out.println("payType:" + payType);
	System.out.println("successUrl:" + successUrl);
	System.out.println("payType:" + payType);
	System.out.println("failUrl:" + failUrl);
	System.out.println("errorUrl:" + errorUrl);
	System.out.println("lang:" + lang);
	//System.out.println("secureHash:" + secureHash);
	
	



%>


<!DOCTYPE html>

<html lang="en">
<head>
  <META http-equiv=Content-Type content="text/html; charset=utf-8">

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- The above 2 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="description" content="">
	<meta name="author" content="">
	
	<!-- Note there is no responsive meta tag here -->
	
	
	<title></title>
		
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->
</head>

	<body onload="javascript:document.forms[0].submit();" >
		<form name="payFormCcard" method="post" action="<%=action%>">
			<input type="hidden" name="merchantId" value="<%=merchantId%>"> 
			<input type="hidden" name="amount" value="<%=amount%>" >
			<input type="hidden" name="orderRef" value="<%=orderRef%>">
			<input type="hidden" name="currCode" value="<%=currCode%>" >
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="successUrl" value="<%=successUrl%>">
			<input type="hidden" name="failUrl" value="<%=failUrl%>">
			<input type="hidden" name="cancelUrl" value="<%=errorUrl%>">
			<input type="hidden" name="lang" value="<%=lang%>">
			<%if("true".equals(StringUtil.filter(PropertiesUtil.getProperty("secureHashFlag")))){ %>
			<input type="hidden" name="secureHash" value="<%=secureHash%>">
			<%} %>
		</form>
	</body>
	
</html>
