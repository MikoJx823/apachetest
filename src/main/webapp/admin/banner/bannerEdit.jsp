<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="org.apache.commons.lang.StringUtils"%>

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
	AdminService.performBlockAccess(request, response, AdminFunction.Banner, AdminFunction.Edit);

	int id = StringUtil.strToInt(request.getParameter("id"));
	BannerInfoBean bean = BannerService.getInstance().getBeanById(id);
	BannerInfoBean beanUpdate =(BannerInfoBean)request.getAttribute("bannerBean");
	if(beanUpdate !=null){
		if( beanUpdate.getId() == bean.getId()){
			bean = beanUpdate;
		}
	}
	
	String basePath = StringUtil.getHostAddress() + "admin/";
	//String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
<jsp:include page="../main/adminHeader.jsp"></jsp:include>

<body>

    <jsp:include page="../main/topNav.jsp"></jsp:include>
    <section class="container">    
    <!--main-row-->
    <div class="row">
      
		<jsp:include page="../main/leftMenu.jsp"><jsp:param value="settings" name="pageIdx"/> </jsp:include>
	
    <!--right main content started-->
    <div class="col-xs-19">
    	<form role="form" action="AdminBannerServlet" method="post" id="form" enctype="multipart/form-data" onsubmit="return checkForm()"> 
		<input type="hidden" name="id" value="<%=bean.getId()%>">
		<input type="hidden" name="actionType" value="update">	
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Edit Banner</big> </div>
<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
     
           <h5 class="text-primary">Banner Information</h5>
			
			<div class="row">
        	<div class="col-xs-8">
            	<div class="form-group">
                    <label>Name </label>
                    <input class="form-control" name="name" autocomplete="off" value="<%=StringUtil.filter(bean.getName())%>">
      		    </div><!--form-group-->
            </div><!--col-xs-8-->
            
            <div class="col-xs-8">
            	<div class="form-group">
                    <label>Position</label>
                    <select name="position" class="form-control">
                    <%=BannerPositionPulldown.select(bean.getPosition()) %>
                    </select>
      		    </div><!--form-group-->
            </div><!--col-xs-8-->  
            
            <div class="col-xs-8">
	        	<div class="form-group">
	            	<label>Sequence</label>
	            	<input class="form-control" name="seq" autocomplete="off" value="<%=bean.getSeq()%>">
	          	</div>
      		</div><!--col-xs-8-->
      		
        	</div>
			
			<div class="row">
        	 <div class="col-xs-24">
            	<div class="form-group">
                    <label>Link </label>
                    <input class="form-control" name="link" autocomplete="off" value="<%=StringUtil.filter(bean.getLink())%>">
      		    </div><!--form-group-->
            </div><!--col-xs-8-->

		</div><!--row-->
		
		<div class="row"> 
      		<div class="col-xs-8">
            	<div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
        		        <%=GenericStatusPulldown.getPulldown(bean.getStatus()) %>
      		        </select>
      		    </div><!--form-group-->
            </div><!--col-xs-8-->  
		</div><!--row-->
        
        <div class="row">
         	<div class="col-xs-6">
               <div class="form-group">
               	<label>Web Image </label>
               	<%if(!(StringUtil.filter(bean.getImage()).equals("")) ) {  %>
                	<img src="../../images/banner/<%=StringUtil.filter(bean.getImage())%>" width="100px" >
                <%} %>
               	<input  type="file"  class="form-control" id="image" name="image" autocomplete="off" >  
                <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          	   </div><!--form-group-->
            </div><!--col-xs-6-->
            
            <div class="col-xs-6">
                <div class="form-group">
                 <label>Mobile Image </label>
                 <%if(!(StringUtil.filter(bean.getAppimage()).equals("")) ) {  %>
                	<img src="../../images/banner/<%=StringUtil.filter(bean.getAppimage())%>" width="100px" >
                 <%} %>
                 <input  type="file"  class="form-control" id="appimage" name="appimage" autocomplete="off" >  
                 <label><small>File size <= 800KB<br/>Only support JPEG / PNG</small></label>                 
          		</div><!--form-group-->
            </div><!--col-xs-6-->

        </div>
			
			
         </div>
         	<div class="panel-footer text-right">
			   <button type="submit" class="btn btn-primary loginbtn hvr-float-shadow">Submit</button>
			   <button type="button" onclick="back()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
			</div><!--panel-footer-->
        </div>
<!--.panel group plan ended-->
		</form>
  </div><!--panel body ended-->

  
	</div> <!--panel default main panel-->
    
   
  
    </section><!-- /section.container --> 
<script type="text/javascript">	
	function isInt(value) {
		   if (isNaN(value)) {
		     return false;
		   }
		   var x = parseFloat(value);
		   return (x | 0) === x;
		}
	   
	function isNumeric(val) {
	    var validChars = '0123456789.';
	       for(var i = 0; i < val.length; i++) {
	           if(validChars.indexOf(val.charAt(i)) == -1)
	               return false;
	       }
	    return true;
	}

	function checkForm(){
		
	}
	
	function back() {
		window.location="../banner/AdminBannerServlet?actionType=search&from=menu";
	}
</script>
</body>

</html>
