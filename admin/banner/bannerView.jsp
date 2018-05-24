<%@page import="com.asiapay.clp.pulldown.*"%>
<%@page import="com.asiapay.clp.service.*"%>
<%@page import="com.asiapay.clp.bean.*"%>
<%@page import="com.asiapay.clp.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> 
<%
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
                <td class="tbl-content"><%=StringUtil.filter(bean.getEname()) %></td>
                
                <td class="tbl-title">Platform</td>
                <td class="tbl-content"><%=DisplayPlatformPulldown.getText(bean.getPlatform()) %></td>
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
	                    <label>Web Image <small>(Eng)</small></label>
	                    <%if(!(StringUtil.filter(bean.getEwebimage()).equals("")) ) {  %>
	                    <img src="../../images_web/index_banner/<%=StringUtil.filter(bean.getEwebimage()) %>" width="100px">
	          			<%} %>
	          			</div><!--form-group-->
	                 </div><!--col-xs-6-->
	                 
	                 <div class="col-xs-6">
	                	<div class="form-group">
	                    <label>Web Image <small>(Chi)</small></label>
	                    <%if(!(StringUtil.filter(bean.getCwebimage()).equals("")) ) {  %>
	                    <img src="../../images_web/index_banner/<%=StringUtil.filter(bean.getCwebimage()) %>" width="100px">
	          			<%} %>
	          			</div><!--form-group-->
	                 </div><!--col-xs-6-->
	                 
	                 <div class="col-xs-6">
	                	<div class="form-group">
	                    <label>App Image <small>(Eng)</small></label>
	                    <%if(!(StringUtil.filter(bean.getEappimage()).equals("")) ) {  %>
	                    <img src="../../images/banner/<%=StringUtil.filter(bean.getEappimage()) %>" width="100px">
	          			<%} %>
	          			</div><!--form-group-->
	                 </div><!--col-xs-6-->
	                 
	                 <div class="col-xs-6">
	                	<div class="form-group">
	                    <label>App Image <small>(Chi)</small></label>
	                    <%if(!(StringUtil.filter(bean.getCappimage()).equals("")) ) {  %>
	                    <img src="../../images/banner/<%=StringUtil.filter(bean.getCappimage()) %>" width="100px">
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
		window.location="../banner/AdminBannerServlet?actionType=getSearchList&from=menu";
	}
</script>
</body>

</html>
