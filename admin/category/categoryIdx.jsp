<%@page import="com.project.pulldown.*"%>
<%@page import="com.project.util.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.service.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	//BLOCK UNAUTHERIZE ACCESS 
	AdminService.performBlockAccess(request, response, AdminFunction.Category, AdminFunction.View);
        
    AdminInfoBean loginUser = (AdminInfoBean)session.getAttribute("loginUser");
	
	List<AdminGroupFunction> adminGroupFunctions = loginUser.getAdminGroupFunction();
	
    List<CategoryBean> categoryList = (List<CategoryBean>)request.getAttribute(SessionName.beanList);
     
    int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));

	String eName = StringUtil.trimToEmpty(request.getSession().getAttribute(SessionName.searchName));
	String status = StringUtil.trimToEmpty(request.getSession().getAttribute(SessionName.searchStatus));
	String parent = StringUtil.trimToEmpty(request.getSession().getAttribute(SessionName.searchParent));
	
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

	  <jsp:include page="../main/leftMenu.jsp"><jsp:param value="category" name="pageIdx"/> </jsp:include> 
    <!--right main content started-->
    <div class="col-xs-19">
    
    <div class="panel panel-default">
  
<div class="panel-heading"><big>Category Management</big></div>
<form role="form" id="categoryForm" action="AdminCategoryServlet" method="post">
<% session.setAttribute(SessionName.token,StringUtil.randomString(16)); %>
	<input type="hidden" name="<%=SessionName.token %>" value="<%= session.getAttribute(SessionName.token) %>" />
<input type="hidden" id="actionType" name="actionType" value="getSearchList">	
<input type="hidden" id="from" name="from" value="search">  
  <div class="panel-body">
      <jsp:include page="../main/msgAlert.jsp"></jsp:include>
      <div class="uppertab">
	
	<jsp:include page="../menu/categoryMenu.jsp"><jsp:param value="searchMenu" name="target"/> </jsp:include> 
	
  <!-- Nav tabs
   <ul class="nav nav-tabs nav-tabs-main" role="tablist">
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>
     	<li role="presentation" class="active"><a href="../category/AdminCategoryServlet?actionType=getSearchList&from=menu" >Category Search</a></li>
  	<%} %>
     <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.Add), AdminFunction.haveRight, adminGroupFunctions)) {%>
    	<li role="presentation"><a href="categoryAdd.jsp">Add Category</a></li>
   	<%} %>
   	 
  </ul>

  <!-- Tab panes -->
<div class="bg-light-primary pd-15">

       <div class="row">

      <div class="col-xs-8">
      <div class="form-group">
        <label>Name</label>
            <input class="form-control" name="<%=SessionName.searchName %>" autocomplete="off" value="<%=eName %>">
      </div>
       </div><!--col-xs-8-->   
       
      <div class="col-xs-8">
	      <div class="form-group">
	      	
	        <label>Parent Category</label>
	        <select class="form-control" name="<%=SessionName.searchParent%>">
	        	<%=CategoryService.getInstance().getParentSearchPulldown(parent) %>
	        	<%//ParentCategoryPulldown.searchPulldown(parent) %>
	        </select>
	      </div>
      </div><!--col-xs-8-->   

        <div class="col-xs-8">
             <div class="form-group">
                    <label>Status</label>
                     <select class="form-control" name="<%=SessionName.searchStatus%>">
                     	 <%=GenericStatusPulldown.getPulldownForSearch(status) %>
		          	 </select>   
       		</div><!--form-group-->
       	</div>
                
      </div><!--row end-->
 
       <div class="row">  
        <div class="col-xs-8"></div>
        <div class="col-xs-8"></div>
       <div class="col-xs-8 text-right">    
       <button  onclick="getCategoryInfoList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Search</button>
       <!--  
       <button  onclick="exportSpecialDonationList()" class="btn btn-primary loginbtn hvr-float-shadow mt-25">Export</button>
       -->
       </div>
       
      </div><!--row end-->
    
</div><!--.bg-light-primary-->

</div><!--.uppertab-->

<hr>
<!--result-->
 
<!--result table-->

<%if(categoryList !=null && categoryList.size()>0){ %>
<h4 class="text-primary">Category List</h4>
           <!--upper tab ended-->
        <div class="row">
        
        <div class="col-xs-24">
         <!--result-->
<table class="table table-condensed table-striped table-hover">
<thead class="bg-black"><tr>
	<th width="42%">Name</th> 
    <th width="20%">Parent</th>
    <th width="7%">Seq(Web)</th>
    <th width="7%">Seq(App)</th>
    <th width="7%">isParent</th>
    <th width="7%">Status</th>
    <th class="tbl-center" width="10%">Action</th>
    </tr>
</thead>
<tbody>

<%
	for(CategoryBean bean:categoryList){        
%>  
    <tr>
    	<td class="tbl-center"><%=bean.geteName()==null?"":bean.geteName() %></td>
        <td class="tbl-center"><%=CategoryService.getInstance().getParentCatStr(bean.getParentId()) %>
        <%//StringUtil.filter(ParentCategoryPulldown.getText(bean.getParentId())) %></td>
        <td class="tbl-center"><%=bean.getSeq() %></td>
        <td class="tbl-center"><%=bean.getSeqapp() %></td>
        <td class="tbl-center"><%=bean.getIsparent() == StaticValueUtil.PRODUCT_ENABLE ? "Yes" : "No" %></td>
        <td class="tbl-center"><%=GenericStatusPulldown.getText(bean.getStatus()) %></td>
        <td class="tbl-center">        
         <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.View), AdminFunction.haveRight, adminGroupFunctions)) {%>  
           <a href="categoryView.jsp?id=<%=bean.getId() %>" class="btn btn-xs btn-cancel">View</a>
           <%} %>
            <%if(AdminService.hasAccessRights(AdminFunction.getFunctionId(AdminFunction.Category, AdminFunction.Edit), AdminFunction.haveRight, adminGroupFunctions)) {%>  
          <a href="categoryUpdate.jsp?id=<%=bean.getId() %>" class="btn btn-xs btn-primary">Edit</a>   
          <%} %>     
        </td>
    </tr>
<%} %>
    
</tbody>
</table>

<div class="row text-center">
<%=StringUtil.getPagingString(5, pageIdx, totalPages, "AdminCategoryServlet?actionType=getSearchList&pageIdx=") %>

  </div>
<!--result table-->
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

  function getCategoryInfoList()
 {
	 $("#actionType").val("getSearchList");
 //    alert($("#actionType").val());
		 $("#categoryForm").submit();
	 
 }
 
  
  
</script>
</body>
</html>
