
<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
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
	
	String yearFromStr = StringUtil.trimToEmpty(request.getSession().getAttribute("yearFrom"));
	String monthFromStr = StringUtil.trimToEmpty(request.getSession().getAttribute("monthFrom"));
	String dayFromStr = StringUtil.trimToEmpty(request.getSession().getAttribute("dayFrom"));
	String yearToStr = StringUtil.trimToEmpty(request.getSession().getAttribute("yearTo"));
	String monthToStr = StringUtil.trimToEmpty(request.getSession().getAttribute("monthTo"));
	String dayToStr = StringUtil.trimToEmpty(request.getSession().getAttribute("dayTo"));
	
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
<input type="hidden" id="actionType" name="actionType" value="getSearchList">	
<input type="hidden" id="from" name="from" value="search">
<input type="hidden" id="oId" name="oId" value="">
 
  <div class="panel-body">
      <div class="uppertab">

  <!-- Nav tabs -->
  <ul class="nav nav-tabs nav-tabs-main" role="tablist">
    <li role="presentation" class="active"><a aria-controls="home" role="tab" data-toggle="tab">Search Order</a></li> 
    <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.UpdateStatus), AdminFunction.haveRight, adminGroupFunctions)) {%>
    <li role="presentation" ><a href="../order/batchUpdate.jsp">Batch Eco Reward Update</a></li>     
    <%} %>
  </ul>

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

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
      
	      <div class="col-xs-8">
	      <div class="form-group">
	        <label>Order ID</label>
	            <input class="form-control" name="orderId" autocomplete="off" value="<%=orderId %>">
	      </div>
	       </div><!--col-xs-8-->   
       
	      <div class="col-xs-8">
	      <div class="form-group">
	        <label>CA No</label>
	            <input class="form-control" name="caNo" autocomplete="off" value="<%=caNo%>">
	      </div>
	       </div><!--col-xs-8-->           
                
      </div><!--row end-->
      
      <div class="row">
      	<div class="col-xs-8">
       <div class="form-group">
        <label>Buyer Name</label> 
	         <input class="form-control" name="name" autocomplete="off" value="<%=name %>">
       </div>
       </div><!--col-xs-8-->     
      
       <div class="col-xs-8">
       <div class="form-group">
        <label>Buyer Email</label>
            <input class="form-control" name="email" autocomplete="off" value="<%=email %>">
       </div>
       </div><!--col-xs-8--> 
       
        <div class="col-xs-8">
       <div class="form-group">
        <label>Buyer Phone</label> 
            <input class="form-control" name="phone" autocomplete="off" value="<%=phone %>">
       </div>
       </div><!--col-xs-8-->
      </div><!--row end-->
      
       <div class="row">
	       <div class="col-xs-8">
		       	<div class="form-group">
		        	<label>Order Status</label> 
			        <select class="form-control" name="status">
			 	       <%= OrderStatusPulldown.select(status,true) %>
			        </select>
		       	</div>
	       	</div><!--col-xs-8-->    
	       	
	       	<div class="col-xs-8">
		       	<div class="form-group">
		        	<label>Item Type</label> 
		        	<select class="form-control" name="itemType">
		        	<option value="" ><%=StaticValueUtil.DEFAULT_ALL %></option>
		        	<option value="<%=StaticValueUtil.DEFAULT_VALUE%>" <%=itemType.equals(String.valueOf(StaticValueUtil.DEFAULT_VALUE))?"selected":"" %>>Product</option>
		        	<option value="<%=StaticValueUtil.ECOREWARD_ECOUPON%>" <%=itemType.equals(String.valueOf(StaticValueUtil.ECOREWARD_ECOUPON))?"selected":"" %>>E-Coupon</option>
		        	<option value="<%=StaticValueUtil.ECOREWARD_COUPON%>" <%=itemType.equals(String.valueOf(StaticValueUtil.ECOREWARD_COUPON))?"selected":"" %>>Coupon</option>
		        	</select>
		       	</div>
	       	</div><!--col-xs-8-->      
      </div><!--row end-->
      
      
      
       <div class="row">
	       <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       <button onclick="getSearchList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Search</button>
	       <%if(orderList !=null && orderList.size()>0){ %>
	        <!-- <button onclick="exportOrderList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Export</button> -->
	       <!--  <button onclick="printOrder()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Print Order</button> -->
	       <%} %>
	       </div>
       
      </div><!--row end-->
    
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<hr>
<!--result-->
 
<!--result table-->

<%if(orderList !=null && orderList.size()>0){ %>
<h4 class="text-primary">Order List</h4>
           <!--upper tab ended-->
        <div class="row">
        
        <div class="col-xs-24">
         <!--result-->
<table class="table table-condensed table-striped table-hover">
<thead class="bg-black"><tr>
	<!--  <th width="3%"> <input type="checkbox" name="checkAll" id="checkAll"></th> -->
	<th width="14%">Transaction Date</th> 
    <th width="13%">Order ID</th>
    <th width="13%">CA No </th>
    <th width="12%">Buyer Name</th>
    <th width="15%">Total Amount</th>
    <th width="10%">Order Status</th>
    <th class="tbl-center" width="20%">Action</th>
    </tr>
</thead>
<tbody>

 <%
	    for(OrderBean bean:orderList){     
	    	String priceStr = "";
	    	
	    	if(bean.getTotalAmount() > 0) {
	    		priceStr = StringUtil.formatCurrencyPrice(bean.getTotalAmount()) ;
	    	}
	    	
	    	if(!"".equals(priceStr) && bean.getEcoPoint() > 0 ){
	    		priceStr += " + " ;
	    	}
	    	
	    	if(bean.getEcoPoint() > 0){
	    		priceStr += StringUtil.formatIndexPrice(bean.getEcoPoint()) + " Eco Points";
	    	}
%>  
    <tr>
    	<!--  <td class="tbl-center"><input type="checkbox" name="orderCheckIds" value="<%=bean.getoId()%>"></td> -->
    	<td class="tbl-center"><%=DateUtil.dateFormatterSql_ss.format(bean.getTransactiondate()) %></td>
        <td class="tbl-center"><%=StringUtils.trimToEmpty(bean.getOrderRef()) %></td>
        <td class="tbl-center"><%=StringUtils.trimToEmpty(bean.getMemberid()) %></td>
        <td class="tbl-center"><%=bean.getBuyerEname()==null? bean.getBuyerCname(): bean.getBuyerEname()%></td>
        <td class="tbl-center"><%=priceStr %>
        
        </td>         
         <td class="tbl-center"><%=OrderStatusPulldown.getName(bean.getOrderStatus()) %></td>     
              
        <td class="tbl-center">   
         <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>     
           <a href="orderView.jsp?id=<%=bean.getoId() %>" class="btn btn-xs btn-cancel">View</a>
           <%} %>
            <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>
          <a href="orderUpdate.jsp?id=<%=bean.getoId() %>" class="btn btn-xs btn-primary">Edit</a>     
          <%} %>  
          <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Order, AdminFunction.ResendEmail), AdminFunction.haveRight, adminGroupFunctions) 
        		&& ( bean.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED) || bean.getOrderStatus().equals(OrderStatusPulldown.INSTALL_PENDING))) {%>
         	 <a href="javascript:resendEmail('<%=bean.getoId() %>')" class="btn btn-xs btn-warning">Resend Email</a>     
          <%} %> 
        </td>
    </tr>
<%} %>
    
</tbody>
</table>
<!--result table-->
<div class="row text-center">
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "AdminOrderServlet?actionType=getSearchList&pageIdx=") %>

  </div>
<%} else{%>
   No records found !
<%} %> 

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
	 $("#actionType").val("getSearchList");
	 $("#orderForm").submit(); 
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
