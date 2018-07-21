<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.service.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.util.*"%>
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
	//AdminService.performBlockAccess(request, response, AdminFunction.Banner, AdminFunction.View);

	int id = StringUtil.strToInt(StringUtil.filter(request.getParameter("id")));
	
	BannerInfoBean bean = BannerService.getInstance().getBeanById(id);
	if (bean==null){
		return;	
	}
	
	AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
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
		<jsp:include page="../main/leftMenu.jsp"><jsp:param value="settings" name="pageIdx"/> </jsp:include>
	
    <!--right main content started-->
    <div class="col-xs-19">
    <div class="panel panel-default">
  			
	<div class="panel-heading"><big>View Banner</big> </div>
		<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  		<div class="panel-body">
     		
            <h5 class="text-primary">Banner Information </h5>
          
            <table class="table table-hover table-condensed">
            <tbody>
            <tr>
            	<td class="tbl-title">Name</td>
                <td class="tbl-content"><%=StringUtil.filter(bean.getName()) %></td>
                
                <td class="tbl-title">Position</td>
                <td class="tbl-content"><%=BannerPositionPulldown.getText(bean.getPosition()) %></td>
            </tr>
            
             <tr>
             	<td class="tbl-title">Sequence Number</td>
                <td class="tbl-content"><%=bean.getSeq()%></td>
                
				<td class="tbl-title">Status </td>
                <td class="tbl-content"><%=GenericStatusPulldown.getText(bean.getStatus()) %></td>
            </tr> 
            
            <tr>
             	<td class="tbl-title">Link</td>
                <td class="tbl-content" colspan="3"><%=StringUtil.filter(bean.getLink())%></td>
			</tr> 
            
            <tr>
	            <td class="tbl-title" colspan="4">	
	            	<div class="col-xs-6">
	                	<div class="form-group">
	                    <label>Web Image </label>
	                    <%if(!(StringUtil.filter(bean.getImage()).equals("")) ) {  %>
	                    <img src="../../images/banner/<%=StringUtil.filter(bean.getImage()) %>" width="100px">
	          			<%} %>
	          			</div><!--form-group-->
	                 </div><!--col-xs-6-->
	                 
	                 <div class="col-xs-6">
	                	<div class="form-group">
	                    <label>Mobile Image </label>
	                    <%if(!(StringUtil.filter(bean.getAppimage()).equals("")) ) {  %>
	                    <img src="../../images/banner/<%=StringUtil.filter(bean.getAppimage()) %>" width="100px">
	          			<%} %>
	          			</div><!--form-group-->
	                 </div><!--col-xs-6-->
	            </td>
            </tr>
            </tbody>
            </table>
         </div>
         
         	<div class="panel-footer text-right">
			   	<button type="button" onclick="back()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</button>
			</div><!--panel-footer-->
        </div>
<!--.panel group plan ended-->	
  </div><!--panel body ended-->

	  	
	</div> <!--panel default main panel-->
  
    </section><!-- /section.container -->
  
<script type="text/javascript">
	function back() {
		window.location="../banner/AdminBannerServlet?actionType=search&from=menu";
	}
</script>
</body>

</html>
