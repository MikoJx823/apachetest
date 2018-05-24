<%@ page language="java" import="com.project.util.*" contentType="text/html; charset=utf-8"%>

<%
String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");

String currentPage = request.getRequestURI();
String title = "Smart Shopping";
String titleWebtrend =  ""; 

if(currentPage.contains("index.jsp")){
	title += " - Homepage";
	titleWebtrend += "Homepage";

}else if(currentPage.contains("login.jsp")){
	title += " - Login";
	titleWebtrend += "Login";

}else if(currentPage.contains("hotitem.jsp")){
	title += " - What’s Hot";
	titleWebtrend += "What’s Hot";

}else if(currentPage.contains("ecoreward.jsp")){ //Smart Appliance & Electrical Appliace configure on that page
	title += " - Eco Rewards";
	titleWebtrend += "Eco Rewards";

}else if(currentPage.contains("searchResult.jsp")){
		title += " - Search";
	titleWebtrend += "Search";

}else if(currentPage.contains("guestOrderSearch.jsp")){
	title += " - Guest Order Search";
	titleWebtrend += "Guest Order Search";

}else if(currentPage.contains("guestOrderResult.jsp")){
	title += " - Guest Order Details";
	titleWebtrend += "Guest Order Details";

}else if(currentPage.contains("orderHistory.jsp")){
	title += " - Order History";
	titleWebtrend += "Order History";

}else if(currentPage.contains("orderHistoryDetail.jsp")){
	title += " - Order History Details";
	titleWebtrend += "Order History Details";

}else if(currentPage.contains("redeem.jsp")){
	title += " - E-Redeem";
	titleWebtrend += "E-Redeem";

}else if(currentPage.contains("redeem2.jsp")){
	title += " - E-Redeem Details";
	titleWebtrend += "E-Redeem Details";

}else if(currentPage.contains("redeem3.jsp")){
	title += " - E-Redeem Confirm";
	titleWebtrend += "E-Redeem Confirm";

}else if(currentPage.contains("redeemSuccess.jsp")){
	title += " - E-Redeem Success";
	titleWebtrend += "E-Redeem Success";

}else if(currentPage.contains("redeemed.jsp")){
	title += " - E-Redeemed";
	titleWebtrend += "E-Redeemed";

}else if(currentPage.contains("checkout.jsp")){
	title += " - My Cart";
	titleWebtrend += "My Cart";

}else if(currentPage.contains("checkoutLogin.jsp")){
	title += " - My Cart Login";
	titleWebtrend += "My Cart Login";

}else if(currentPage.contains("checkout2.jsp")){
	title += " - My Cart Form";
	titleWebtrend += "My Cart Form";

}else if(currentPage.contains("checkout3.jsp")){
	title += " - My Cart Confirm";
	titleWebtrend += "My Cart Confirm";

}else if(currentPage.contains("surveySubmitted.jsp")){
	title += " - My Cart Survey";
	titleWebtrend += "My Cart Survey";

}else if(currentPage.contains("paySuccess.jsp")){
	title += " - Payment Successed";
	titleWebtrend += "Payment Successed";

}else if(currentPage.contains("payCancel.jsp")){
	title += " - Payment Cancelled";
	titleWebtrend += "Payment Cancelled";

}else if(currentPage.contains("payFail.jsp")){
	title += " - Payment Failed";
	titleWebtrend += "Payment Failed";

}else if(currentPage.contains("error.jsp")){
	title += " - Page Not Found (Error)";
	titleWebtrend += "Page Not Found (Error)";

}

if(titleWebtrend.equals(""))
	titleWebtrend =  request.getServerName() +  request.getRequestURI() +  (request.getQueryString() == null ? "" : ("?" +  request.getQueryString())) ;


%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"  />
<meta content="web" itemprop="platform" name="platform">

<!--webtrend-->
<meta name="WT.cg_n" content="web">
<meta name="WT.cg_s" content="<%=titleWebtrend %>">

<script>
console.log("pervious <%=request.getHeader("Referer")%>");
console.log("pervious <%=request.getAttribute("javax.servlet.forward.request_uri")  %>");
</script>

<!--facebook Meta-->
<title><%=title%></title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
<link href="<%=basePath %>css/style_web.css" rel="stylesheet" type="text/css">
<script src="<%=basePath %>js/webtrends.js" type="text/javascript"></script>
