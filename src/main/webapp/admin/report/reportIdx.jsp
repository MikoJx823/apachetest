<%@page import="com.project.bean.*"%>
<%@page import="com.project.pulldown.*" %>
<%@page import="com.project.service.*"%>
<%@page import="com.project.util.*"%>
<%@page import="java.io.PrintWriter" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%	
AdminInfoBean loginUser = (AdminInfoBean) request.getSession().getAttribute(SessionName.loginAdmin);
String url = request.getRequestURL().toString();

if (loginUser == null&& !url.contains("/LoginServlet") && !url.contains("login.jsp")&& !url.contains("/css/") && !url.contains("/images/") && !url.contains("/layer/")
		&& !url.contains("/js/") && !url.endsWith("/admin/"))
{
	
		PrintWriter pw = response.getWriter();
		pw.println("<script type='text/javascript'>alert('Your session has been timed out.')</script> <script type='text/javascript'>window.location.href='" + StringUtil.getHostAddress()// request.getContextPath()
				+ "admin/'</script> ");
		pw.flush();
		return;
}	
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Report, AdminFunction.ReportOrder);
	

	String orderId = StringUtil.filter((String)request.getSession().getAttribute("orderId"));
	String name = StringUtil.filter((String)request.getSession().getAttribute("name"));
	String phone = StringUtil.filter((String)request.getSession().getAttribute("phone"));
	String email = StringUtil.filter((String)request.getSession().getAttribute("email"));
	String status = StringUtil.filter((String)request.getSession().getAttribute("status"));
	String caNo = StringUtil.filter((String)request.getSession().getAttribute("caNo"));
	
	String yearFromStr = StringUtil.filter((String)request.getSession().getAttribute("yearFrom"));
	String monthFromStr = StringUtil.filter((String)request.getSession().getAttribute("monthFrom"));
	String dayFromStr = StringUtil.filter((String)request.getSession().getAttribute("dayFrom"));
	String yearToStr = StringUtil.filter((String)request.getSession().getAttribute("yearTo"));
	String monthToStr = StringUtil.filter((String)request.getSession().getAttribute("monthTo"));
	String dayToStr = StringUtil.filter((String)request.getSession().getAttribute("dayTo"));
	
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

	String basePath = StringUtil.getHostAddress() + "admin/";

%>
<!doctype html>
<html>

<jsp:include page="../main/adminHeader.jsp"></jsp:include>

<body>
	 <jsp:include page="../main/topNav.jsp"></jsp:include>
	 <section class="container">   
    <!--main-row-->
    <div class="row">

	<jsp:include page="../main/leftMenu.jsp"><jsp:param value="report" name="pageIdx"/> </jsp:include> 
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Report Management</big> </div>
<form role="form" action="AdminReportServlet" method="post">
<input type="hidden" name="actionType" value="orderReport">	  
  <div class="panel-body">
     
      <div class="uppertab">

	 <ul class="nav nav-tabs nav-tabs-main" role="tablist">
	     <li><a href="reportIdx.jsp">Report</a></li>
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
		        	<label>Order Status</label> 
			        <select class="form-control" name="status">
			 	       <%= OrderStatusPulldown.select(status,true) %>
			        </select>
		       	</div>
	       	</div><!--col-xs-8-->      
      </div><!--row end-->

        <div class="row">
              
	        <div class="col-xs-8"></div>
        	<div class="col-xs-8"></div>
        
	       	<div class="col-xs-8 text-right">    
	       		<button type="submit" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Download</button>
	       		<button type="button" onclick="back()" class="btn btn-cancel loginbtn hvr-float-shadow mt-25">Back</button>
	       	</div>
       
      </div><!--row end-->
   
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

  </div><!--panel body ended-->
 </form> 

	</div><!-- main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
  
<script type="text/javascript">
$(function () { $('.tooltip-show').tooltip('show');});
//$(function () { $("[data-toggle='tooltip']").tooltip(); });

function back(){
	window.location="reportIdx.jsp";
	
}
</script>
</body>
</html>
