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
	request.getSession().removeAttribute("orderBean");
	request.getSession().removeAttribute("cartMap");

	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	String orderRef = request.getParameter("Ref")==null?"":StringUtil.blockXss(request.getParameter("Ref"));
	
	OrderBean orderBean = OrderService.getInstance().getFrontBeanSuccessByRef(orderRef);
	
	if(orderBean == null){
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp?type=" + StaticValueUtil.LOGIN_SOURCE_MOBILE);
		requestDispatcher.forward(request, response);
		return;
	}
	
	MemberBean member = (MemberBean)request.getSession().getAttribute(SessionName.loginMember);
	
	boolean isMember = false;
	boolean isInstall = false;
	if(member != null){
		if(member.getUserType() == StaticValueUtil.USER_MEMBER){
			isMember = true;
		}	
	}
	
	//START FOR GA EE 
	String gaEECartList = "";
	for(OrderItemBean orderItem : orderBean.getOrderItems()){
		gaEECartList += StringUtil.getGAEECheckoutDetail(orderItem);
	}
	
	if(gaEECartList.endsWith(",")) gaEECartList = gaEECartList.substring(0, gaEECartList.length() - 1);
 	gaEECartList = "'actionField': {'id': '" + orderRef + "','affiliation': 'Online Store','revenue': " + orderBean.getTotalAmount() + "}," + 
 				   "'products': [" + gaEECartList + "]";
 	//END FOR GA EE 
 	
	if(orderBean.getEcoPoint() > 0 && orderBean.getEcoPayStatus().equals(OrderStatusPulldown.ACCEPTED ) && isMember){
		boolean isEco = MemberService.getInstance().performGetEcoPoint(request, member);
	}
	
	if(orderBean.getInstallAmount() > 0 && orderBean.getType() == StaticValueUtil.ORDERTYPE_INSTALL) {
		isInstall = true;	
	}
	
	boolean isEng = I18nUtil.isEng(request);
	String lang = orderBean.getOrderLang();
	
	String url = request.getHeader("referer");
	
	//FOR GA PAYMENT METHOD 
	String gaPayMethod = "";
	if(orderBean.getTotalAmount() > 0) {
		/*if(orderBean.getOfflineAmount() > 0) {
			gaPayMethod = "Offline Payment ";
		}else {*/
			gaPayMethod = "$";
		//}
	}
	
	if(orderBean.getEcoPoint() > 0 ) {
		if("".equals(gaPayMethod)){
			gaPayMethod = "Eco Points";
		}else {
			gaPayMethod += " and Eco Points";
		}
	}
	
	List<SurveyRatingBean> rating = SurveyRatingService.getInstance().getListBySqlwhere(" where status = " + StaticValueUtil.Active + " order by rating, seq DESC" );
	
	//String sqlWhere = "A inner join (Select quizid, id as sid FROM surveyinfo) B On (A.surveyid=B.sid) where status = " + StaticValueUtil.Active + " order by rating, seq DESC, quizid";
	//List<SurveyRatingBean> rating = SurveyRatingService.getInstance().getFrontListBySqlwhere(sqlWhere);
	
	
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

<form action="<%=basePath %>survey" method="post" id="infoForm" name="surveyForm">
	<input type="hidden" name="actionType" value="survey">
	<input type="hidden" name="lang" value="<%=lang%>">
	<input type="hidden" name="type" value="<%=StaticValueUtil.LOGIN_SOURCE_WEB%>">
	<input type="hidden" name="oid" value="<%=orderBean.getoId()%>">
	<input type="hidden" name="captureLog" value="<%=StringUtil.filter(url)%>">
	
<section>
<div class="categorypg container">
	
   
    
    <div class="row">
            <div class="col-xs-24 visible-xs visible-sm  mt-15">
<p class="text-center mb-15 text-primary"><b><fmt:message key="checkout.payment.success"/>   </b></p>
<ul class=" step list-unstyled">
        <li><div></div></li>
        <li><div></div></li>
        <li><div></div></li>
        <li class="active"><div></div></li>
    </ul>
</div> 
<div class="col-xs-24"> <h1 class="text-primary"><fmt:message key="checkout.title"/></h1></div>
      <div class="col-xs-24 hidden-xs hidden-sm">
        <div class="wizard bg-white">
          <a class="finish"><span class="badge">1</span><b><fmt:message key="checkout.cart.summary"/></b></a>
          <a class="finish"><span class="badge">2</span><b><fmt:message key="checkout.delivery.information"/>            </b></a>
          <a class="finish"><span class="badge">3</span><b><fmt:message key="checkout.progress.confirmation"/> </b></a>
          <a class="finish current"><span class="badge">4</span><b><fmt:message key="checkout.payment.success"/></b></a> 
 
          </div>
      </div>
    </div>    <div class="clearfix"></div>
     <%if(isInstall){ %>
      	<h1 class="text-primary"><fmt:message key="checkout.order.submitted"/></h1>
     <%}else { %>
    	<h1 class="text-primary "><fmt:message key="checkout.payment.success"/></h1>
     <%} %>
     
     <p class="small"><b><fmt:message key="checkout.order.ref"/> </b> <%=orderRef %></p>
     <%if(isMember) { %>
     <!--  <p class="small"><b><fmt:message key="checkout.order.remaining.balance"/> </b> <%=member.getEcoCredit().getEP_Balance() %></p> -->
     <%} %>
     
     <hr>
     
       <h5 class="text-primary"><fmt:message key="checkout.survey"/></h5>
       <p class="mb-10"><fmt:message key="checkout.survey.greet"/></p>
       
     
        <div class="form-group">
     	    
                <!-- the rating value is stored inside the input.rating-->
               <input class="rating" value="0" type="hidden" name="rating" id="rating"/> 
        </div>

		 <%for(Integer rate : SurveyRatingPulldown.value) { %>
	       <article class="ratingOptions rating<%=rate%>">
	         <p class="mb-10"><b><fmt:message key="checkout.survey.select"/></b></p>
				
				 <%for(SurveyRatingBean bean : rating){ 
         	 		 
        			 if(bean.getRating() == rate ){
        				SurveyBean survey = SurveyService.getInstance().getFrontBeanById(bean.getSurveyid());
		         	 
			        	 if(bean != null) {
			        		 String quizName = StringUtil.filter(survey.getEname());
			        		 if(!isEng) quizName = StringUtil.filter(survey.getCname());
			        		 
			        		 if(survey.getStatus() == StaticValueUtil.Active) {
		         %>
				
			       <div class="btn-group address wd-100 mt-10 mb-15" data-toggle="buttons">
			        <label class="btn btn-block">
			              <div>
			                <input type="checkbox" name="group<%=rate %>" id="group<%=rate %>-<%=bean.getId()%>" value="<%=survey.getId()%>" autocomplete="off">
			                <p class="label singleLabel"><%=quizName %></p>
			               </div>
			  		</label>
					</div>
	        	
	    <%					}
        	  			}
        	 		}
        		  } 
        %>
	  
	        </article>
		 <%} %>
		
       
        
       
        <p><fmt:message key="checkout.survey.contact"/><a href="mailto:CSD@clp.com.hk">CSD@clp.com.hk</a></p>
    
     <div class="col-xs-24 surveybutton mb-15">
     <input type="submit" class="btn btn-success btn-block" value="<fmt:message key="checkout.survey.submit"/>" onclick="return checkForm()">
     </div>
</section>
</form>

<jsp:include page="footer.jsp" />
<script>
	
	dataLayer.push({
	    'event':'paymentMethod',
	    'eventLabel': '<%=StringUtil.filter(gaPayMethod)%>'
	});
	
	<%=StringUtil.getGAEEFullConfig(gaEECartList, StaticValueUtil.GAEE_PURCHASE, "")%>	
	
	/*dataLayer.push({
		'ecommerce': {
		    'purchase': {
		      'actionField': {
		        'id': '<%=orderRef%>',
		        'affiliation': 'Online Store',
		        'revenue': '35.43',
				'ecopoint': '0'
		      },
		      'products': [{ 
		        'name': 'Triblend Android T-Shirt', 
		        'id': '12345',
		        'price': '15.25',
		        'brand': 'Google',
		        'category': 'Apparel',
		        'quantity': 1,
		       }]
		   }
		}
	});*/
	
	
	function checkForm(){
		var rate = $.trim($("#rating").val());
		if( !(rate > 0 && rate < 6 )) {
			alert("<fmt:message key="error.checkout.survey.incorrect.rate"/>");
			return false;
		}
		
		if( $( 'input[name="group'+ rate +'"]:checked' ).length < 1){
			alert("<fmt:message key="error.checkout.survey.answer.required"/>");
			return false;
		}
		
		return true;
	}
	
	$(function(){
		$('.surveybutton').hide();
		
		$("#rating").change(function(){
			$('.surveybutton').show();
		});

$( "#rating" ).change(function() {
	var stars = $( "#rating" ).val();
	console.log('changed');
	console.log(stars);
	
	  switch (stars) {
		case '0':
		//$('.ratingOptions').hide();
		$('.ratingOptions').css("display","none"); 
			//$('.rating0').show();
			$('.rating0').css("display","block"); 
			
			//console.log('case0');
			break;
			
		case '1':

		
			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating1').show();
			$('.rating1').css("display","block"); 
			console.log('case01');
			break;
		case '2':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating2').show();
			$('.rating2').css("display","block"); 
			//console.log('case2');
			break;
		case '3':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating3').show();
			$('.rating3').css("display","block"); 
			//console.log('case3');
			break;
		case '4':

			//$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
		//	$('.rating4').show();
			$('.rating4').css("display","block"); 
			//console.log('case4');
			break;
		case '5':

			$('.ratingOptions').hide();
			$('.ratingOptions').css("display","none"); 
			
			//$('.rating5').show();
			$('.rating5').css("display","block"); 
			//console.log('case5');
			
	}
});



	});
</script>

</body>
</html>

