<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Category, AdminFunction.View);

    String id = request.getParameter("id");
    
    CategoryBean category = CategoryService.getInstance().getCategoryBeanListBySqlwhere(" where id="+id).get(0);
    
    String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost.admin");
%>

<!DOCTYPE html>
<html>
  <jsp:include page="../main/adminHeader.jsp"></jsp:include>
  
  <body>
  
 <jsp:include page="../main/topNav.jsp"></jsp:include>
 
<!-- header menu ended-->

    <section class="container">
    
    <!--main-row-->
    <div class="row">
    
    <!--left Menu area-->
    <jsp:include page="../main/leftMenu.jsp"><jsp:param value="category" name="pageIdx"/> </jsp:include> 
    <!--Left ended col-xs-5-->
    
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
  <div class="panel-heading"><big>View Category</big></div>
  	<jsp:include page="../main/msgAlert.jsp"></jsp:include>
  <div class="panel-body">
     
            <h5 class="text-primary">Category Information</h5>
            <table class="table table-hover table-condensed">
            <tbody>
             <tr>
            	<td class="tbl-title">Category Id</td>
                <td class="tbl-content">
                <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE){ %>
                	<%=category.getParentidentifier() %>
                <%}else { %>
                	<%=category.getId() %>
                <%} %>
                </td>
                
                <td class="tbl-title">isParent</td>
                <td class="tbl-content"><%=category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE ? "Yes" : "No" %></td>
            </tr>

             <tr>
            	<td class="tbl-title">Name <small>(Eng)</small></td>
                <td class="tbl-content"><%=category.geteName()==null?"":category.geteName() %></td>
                
                <td class="tbl-title">Name <small>(Chi)</small></td>
                <td class="tbl-content"><%=category.getcName()==null?"":category.getcName() %></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Sequence <small>(Web)</small></td>
                <td class="tbl-content"><%=category.getSeq()%></td>
                
                <td class="tbl-title">Sequence <small>(App)</small></td>
                <td class="tbl-content"><%=category.getSeqapp() %></td>
            </tr>
            
             <tr>
            	<td class="tbl-title">Description <small>(Eng)</small></td>
                <td class="tbl-content"><%=category.geteDesc()==null?"":category.geteDesc() %></td>
                
                <td class="tbl-title">Description <small>(Chi)</small></td>
                <td class="tbl-content"><%=category.getcDesc()==null?"":category.getcDesc() %></td>
            </tr>
			
			 <tr>
                <td class="tbl-title">Status</td>
                <td class="tbl-content"><%=GenericStatusPulldown.getText(category.getStatus()) %></td>
                
                <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE){ %>
                <td class="tbl-title"></td>
                <td class="tbl-content"></td>
                <%}else { %>
                <td class="tbl-title">Parent Category</td>
                <td class="tbl-content"><%=CategoryService.getInstance().getParentCatStr(category.getParentId()) %></td>
                <%} %>
            </tr>
			
            <tr>
                <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE){ %>
                	<!--<td class="tbl-title">  Deeplink keyword </td>
                	<td class="tbl-content"><%//StringUtil.filter(category.getDeeplinkkey()) %></td> -->
                	
                <%}else { %>
                	<!--  <td class="tbl-title">Parent Category</td>
                	<td class="tbl-content"><%=CategoryService.getInstance().getParentCatStr(category.getParentId()) %></td>
                	<td class="tbl-title"></td>
                	<td class="tbl-content"></td> -->
                <%} %>
            </tr>
            
            <%if(category.getIsparent() == StaticValueUtil.PRODUCT_ENABLE){ %>
            <!--  <tr>
            	<td class="tbl-title">Link Path (web)</td>
                <td class="tbl-content" colspan="3"><%=StringUtil.filter(category.getDeeplinkpathweb())%></td>
            </tr>
            
            <tr>
            	<td class="tbl-title">Link Path (app)</td>
                <td class="tbl-content" colspan="3"><%=StringUtil.filter(category.getDeeplinkpathapp())%></td>
            </tr>  -->
            	
            <%} %>
			
			  <tr>
            	<td colspan="4">
            	<div class="row">
                 <div class="col-xs-8">
                	<div class="form-group">
                    <label>Image <small>1</small></label>
                    <%if(!(StringUtils.trimToEmpty(category.getImage1()).equals("")) ) {  %>
          				<img src="../../GetImageFileServlet?&name=<%=StringUtil.filter(category.getImage1()) %>" width="100px">
          			<%} %>                
          			</div><!--form-group-->
                 </div><!--col-xs-8-->
                 </div><!--row-->
                </td>
            </tr>
			
            </tbody>
            
            </table>
  

<!--.panel group plan ended-->

			
  </div><!--panel body ended-->
  
  <div class="panel-footer text-right">
	
	
	
	 
   <a href="./AdminCategoryServlet?actionType=getSearchList" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a>
  	
  	<!-- javascript:history.go(-1)
  	 <a href="javascript:back()" class="btn btn-cancel loginbtn hvr-float-shadow">Back</a> -->

  </div><!--panel-footer-->
	</div> <!--panel default main panel-->
    
    </div><!--right main content col-xs-19 ended-->
    
    </div>
  
    </section><!-- /section.container -->
    
    <script>
	function back() {
		window.location="./AdminCategoryServlet?actionType=getSearchList";
	}

</script>
  </body>
</html>


