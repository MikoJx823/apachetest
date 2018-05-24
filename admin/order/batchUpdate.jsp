
<%@page import="com.asiapay.clp.pulldown.*"%>
<%@page import="com.asiapay.clp.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.asiapay.clp.bean.*"%>
<%@page import="com.asiapay.clp.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	Date nowDate = new Date();
    System.out.println("--------------------------:"+nowDate.getDate());
    
    	
    AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
    
    List<OrderBean> orderList = (List<OrderBean>)request.getAttribute("orderList");
    
    int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	
	String orderId = StringUtil.trimToEmpty(request.getSession().getAttribute("orderId"));
	String name = StringUtil.trimToEmpty(request.getSession().getAttribute("name"));
	String phone = StringUtil.trimToEmpty(request.getSession().getAttribute("phone"));
	String email = StringUtil.trimToEmpty(request.getSession().getAttribute("email"));
	String status = StringUtil.trimToEmpty(request.getSession().getAttribute("status"));
	String caNo = StringUtil.trimToEmpty(request.getSession().getAttribute("caNo"));
	String itemType = StringUtil.trimToEmpty(request.getSession().getAttribute("itemType"));
	//String productStatusStr = StringUtil.trimToEmpty(request.getSession().getAttribute("productStatus"));
	//int productStatus = Integer.parseInt(productStatusStr);
	
	String yearFromStr = StringUtil.filter((String)request.getAttribute("byearFrom"));
	String monthFromStr = StringUtil.filter((String)request.getAttribute("bmonthFrom"));
	String dayFromStr = StringUtil.filter((String)request.getAttribute("bdayFrom"));
	String yearToStr = StringUtil.filter((String)request.getAttribute("byearTo"));
	String monthToStr = StringUtil.filter((String)request.getAttribute("bmonthTo"));
	String dayToStr = StringUtil.filter((String)request.getAttribute("bdayTo"));


	
	Calendar fromDate = Calendar.getInstance();
	fromDate.add(Calendar.DATE,  -2);
	if ("".equals(yearFromStr)){
		yearFromStr = String.valueOf(fromDate.get(Calendar.YEAR));
		monthFromStr = String.valueOf(fromDate.get(Calendar.MONTH)+1);
		dayFromStr = String.valueOf(fromDate.get(Calendar.DAY_OF_MONTH));

	}
	Calendar toDate = Calendar.getInstance();
	if ("".equals(yearToStr)){
		yearToStr = String.valueOf(toDate.get(Calendar.YEAR));
		monthToStr = String.valueOf(toDate.get(Calendar.MONTH)+1);
		dayToStr = String.valueOf(toDate.get(Calendar.DAY_OF_MONTH));
	}
    
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>
   
<body>
<jsp:include page="../main/topNav.jsp"></jsp:include>
	 <section class="container">   
    <!--main-row-->
    <div class="row">
      
	  <jsp:include page="../main/leftMenu.jsp"><jsp:param value="order" name="pageIdx"/> </jsp:include> 
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Order Management </big></div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
<form role="form" id="orderForm" action="AdminOrderServlet" method="post">
<input type="hidden" id="actionType" name="actionType" value="batchUpdate">	
<input type="hidden" id="from" name="from" value="search">
<input type="hidden" id="oId" name="oId" value="">
 
  <div class="panel-body">
      <div class="uppertab">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation" ><a href="../order/AdminOrderServlet?actionType=getSearchList&from=menu" >Search Order</a></li> 
    <li role="presentation" class="active"><a  aria-controls="home" role="tab" data-toggle="tab">Batch Eco Reward Update</a></li>       
  </ul>

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

<%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.UpdateStatus), AdminFunction.haveRight, adminGroupFunctions)) {%>
            

       <div class="row">

      <div class="col-xs-8">
         <div class="form-group">
         <label>Transaction Date</label>
         <div class="tbl full-width">
                        
         <!--year-->
         <div class="tbl-cell">
         <select class="form-control" name="yearFrom">
         <%=DatePulldown.getYYYYPulldown(Integer.parseInt(yearFromStr))%>
         </select></div>
                        
        <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
        <!--month-->
        <div class="tbl-cell">
         <select class="form-control" name="monthFrom">
         <%=DatePulldown.getMMPulldown(Integer.parseInt(monthFromStr)) %>
         </select>
       </div>
                        
      <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
      <!--date-->
         <div class="tbl-cell">
         <select class="form-control" name="dayFrom">
         <%=DatePulldown.getDDPulldown(Integer.parseInt(dayFromStr)) %>
         </select></div>
                    
         </div><!--tbl-row-->
         
        <div class="tbl full-width">
                        
         <!--year-->
         <div class="tbl-cell">
         <select class="form-control" name="yearTo">
         <%=DatePulldown.getYYYYPulldown(Integer.parseInt(yearToStr)) %>
         </select></div>
                        
        <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
        <!--month-->
        <div class="tbl-cell">
         <select class="form-control" name="monthTo">
         <%=DatePulldown.getMMPulldown(Integer.parseInt(monthToStr)) %>
         </select>
       </div>
                        
      <div class="tbl-cell tbl-center">&nbsp;/ &nbsp;</div>
                    
      <!--date-->
         <div class="tbl-cell">
         <select class="form-control" name="dayTo">
         <%=DatePulldown.getDDPulldown(Integer.parseInt(dayToStr)) %>
         </select></div>
                    
         </div><!--tbl-row-->
       </div><!--form-group-->
     </div><!--col-xs-8-->

      </div>

      
      <div class="row">
              
	        <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       		<button onclick="return getSearchList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Update</button>
	       	</div>
       
      </div><!--row end-->
<%} %> 
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<!--result-->
 
<!--result table-->

       </div><!--col-xs-24-->
      </div><!--row end-->


		
  </div><!--panel body ended-->
 </form> 

	</div><!-- main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
<script type="text/javascript">
$(function () { 
	
	$('.tooltip-show').tooltip('show');
	
	$('#checkAll').change(function() {
		   if($(this).is(":checked")) {
			   $('input:checkbox').not(this).prop('checked', this.checked);
		      return;
		   }
		   
		   $('input:checkbox').not(this).prop('checked', false); //'unchecked' event code
		   
		});
});
//$(function () { $("[data-toggle='tooltip']").tooltip(); });

function exportOrderList(){
	 $("#actionType").val("exportOrderList");
	 $("#orderForm").submit();
 }
function getSearchList(){
	 //$("#actionType").val("batchUpdate");
	
	var errorMsg = "";
	var startDate = "";
	var startDateErrMsg = "";
	var endDate = "";
	var endDateErrMsg = "";
	
	if($.trim($("[name='yearFrom']").val()) == '') {
		startDateErrMsg += " year,";
	}
	if($.trim($("[name='monthFrom']").val()) == '') {
		startDateErrMsg += " month,";
	}
	if($.trim($("[name='dayFrom']").val()) == '') {
		startDateErrMsg += " day,";
	}
	
	if(startDateErrMsg != "") {
		var temp = startDateErrMsg.substring(0, startDateErrMsg.length - 1);;
		startDateError = "Transaction Date Start" + temp + " is required \n";
		errorMsg += startDateError;
	}else{
		startDate = $.trim($("[name='dayFrom']").val()) + "/" + $.trim($("[name='monthFrom']").val()) + "/" + $.trim($("[name='yearFrom']").val());
	}
	
	if($.trim($("[name='yearTo']").val()) == '') {
		endDateErrMsg += " year,";
	}
	if($.trim($("[name='monthTo']").val()) == '') {
		endDateErrMsg += " month,";
	}
	if($.trim($("[name='dayTo']").val()) == '') {
		endDateErrMsg += " day,";
	}
		
	if(endDateErrMsg != "") {
		var temp = endDateErrMsg.substring(0, endDateErrMsg.length - 1);;
		endDateErrMsg = "Transaction Date End" + temp + " is required \n";
		errorMsg += endDateErrMsg;
	}else{
		endDate = $.trim($("[name='dayTo']").val()) + "/" + $.trim($("[name='monthTo']").val()) + "/" + $.trim($("[name='yearTo']").val());
	}
	
	if(errorMsg != ""){
		alert(errorMsg);
		return false;
	}
	
	var txt;
	var r = confirm("Confirm update eco reward delivery status between " + startDate + " - " + endDate + " ?" );
	if (r == true) {
		$("#orderForm").submit(); 
	}
	
	return false;
 }
 
function printOrder(){
	 var checkedSize = $("input[name='orderCheckIds']:checkbox:checked").size();
	 console.log(checkedSize);
	 if(checkedSize > 0) {
		 $("#actionType").val("printOrder");
		 $("#orderForm").submit();
	 }else {
		 alert("Please select at least one order to print.");
	 }
}
function resendEmail(oId) {
	console.log("oid " + oId);
	var r=confirm("Do you confirm to resend email for this customer ?");
    if (r==true){
    	$("#actionType").val("resendEmail");
    	$("#oId").val(oId);
    	$("#orderForm").submit();      
    }
    else{
      return;
    }
	
		

}


	 
 	
</script>

</body>
</html>
