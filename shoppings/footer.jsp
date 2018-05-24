<%@ page language="java" import="com.project.util.*,java.sql.*,java.util.Calendar,com.project.bean.*,java.util.*" contentType="text/html; charset=utf-8"%>
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
    int year = Calendar.getInstance().get(Calendar.YEAR);
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
	String loginMethod = "mCommerce";
	if(member != null){
		if(!"".equals(StringUtil.filter(member.getLoginFrom()))){
			loginMethod = StringUtil.filter(member.getLoginFrom());
		}
	}
	
	String servletUrl = StringUtil.filter((String) request.getAttribute(SessionName.servletUrl),"index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_WEB);
	
	String gaCookie = StringUtil.trimToEmpty(request.getSession().getAttribute(SessionName.cookieLoginGA));
%>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/> 

<footer class="footer">
<a href="#top" class="backtop text-center  scroll"><span class="fa fa-chevron-up"></span><em class="sr-only">Back To Top 返回頁頂 </em></a>

<div class="container">

      <div class="row">
      <div class="col-xs-24 mt-15">
         
            <ul class=" list-inline pull-right tcLink">
          
          <li title="Privacy Policy"><a title="" href="https://www.clp.com.hk/<fmt:message key="header.ln"/>/privacy-policy"><span><fmt:message key="footer.privacy"/></span></a> </li>
          
          <li title="Copyright"><a title="" href="https://www.clp.com.hk/<fmt:message key="header.ln"/>/copyright"><span><fmt:message key="footer.copyright"/></span></a> </li>
          
          <li title="Disclaimer"><a title="" href="https://www.clp.com.hk/<fmt:message key="header.ln"/>/disclaimer"><span><fmt:message key="footer.disclaimer"/></span></a> </li>
          
          <li title="Personal Information Collection Statement"><a title="" href="https://www.clp.com.hk/<fmt:message key="header.ln"/>/personal-information-collection-statement"><span><fmt:message key="footer.personal.information"/></span></a> </li>
          
          <li> © <%=year %> CLP Power Hong Kong Limited.中華電力有限公司 All Rights Reserved.</li>
          
        </ul>
      
        </div>
        </div>
      
</div>
</footer>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="<%=basePath %>js/jquery.min.js"></script>




<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="<%=basePath %>js/bootstrap.js"></script>
<script src="<%=basePath %>js/function_web.js"></script>
<script>

	
	$(document).ready(function(){
    $("#mainMenu .dropdown").hover(
	function(){
        $("img").unveil();
        }
		);
});
    </script> 
<!--for lazy load rreduce loading-->
<script src="<%=basePath %>layer-v3.0.3/layer/layer.js"></script>


<!-- Google Tag Manager -->
 <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-KTZQ427');</script> 
<!-- End Google Tag Manager -->


<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KTZQ427"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript> 
<!-- End Google Tag Manager (noscript) -->


<!-- Google Tag Manager -->
<!--<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5KH7SFT');</script>
<!-- End Google Tag Manager -->

<!-- Google Tag Manager (noscript) -->
<!--<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5KH7SFT"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<!-- webTrend -->
<script src="<%=basePath %>js/webtrends.js" type="text/javascript"></script>
<script type="text/javascript">
    //<![CDATA[
    var _tag = new WebTrends();
    _tag.dcsGetId();
    //]]>
    </script>
    <script type="text/javascript">
        //<![CDATA[
        _tag.dcsCustom = function ()
        {
            // Add custom parameters here.
            //_tag.DCSext.param_name=param_value;
        }
        _tag.dcsCollect();
        //]]>
</script>


<script type="text/javascript">

$( document ).ready(function() {
	
	if("<%=gaCookie%>" == "<%=StaticValueUtil.STATUS_YES%>"){
		dataLayer.push({
		    'event':'loginMethod',
		    'method': '<%=loginMethod%>'
		})
		
		console.log("LOGIN GA POST");
	}
	
	});

</script>

<%
request.getSession().removeAttribute(SessionName.cookieLoginGA);
%>
