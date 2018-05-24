<%@ page language="java" import="java.text.*,java.util.Calendar,java.util.*,com.project.bean.*,com.project.pulldown.*,com.project.service.*,com.project.util.*,org.apache.commons.lang.StringUtils" contentType="text/html; charset=utf-8"%>
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
	boolean isEng = I18nUtil.isEng(request);
	String lang = I18nUtil.getLangHtml(request).equals("en")?"E":"C";  
	String basePath = PropertiesUtil.getProperty("hostAddr")+PropertiesUtil.getProperty("virtualHost");
	
	int totalPages = StringUtil.trimToInt(request.getAttribute(SessionName.totalPages));
	int pageIdx = StringUtil.trimToInt(request.getAttribute(SessionName.pageIdx));
	String parentId = StringUtil.filter((String)request.getAttribute("parentId"));
	
   	List<CategoryBean> categories = (List<CategoryBean>)request.getAttribute(SessionName.categories);
   	CategoryBean parentCat = CategoryService.getInstance().getParentCat(StringUtil.strToInt(parentId));
	if(parentCat == null) parentCat = new CategoryBean();
	
	String parentCatName = StringUtil.filter(!isEng? parentCat.getcName() : parentCat.geteName());
   	
	
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

<script type="text/javascript">

(function() {
	//var cat = "<%=ParentCategoryPulldown.getTextByLanguage(StringUtil.strToInt(parentId), I18nUtil.Lang_EN)%>";
	document.title = "Smart Shopping - <%=parentCatName%>" ;
	
	//For Webtrends 
	 document.querySelector('meta[name="WT.cg_s"]').setAttribute("content", "<%=StringUtil.filter(parentCat.geteName()) %>");
 })();

 </script>

<section>
<div class="categorypg container">
    <h1 class="text-primary"><%=parentCatName%><%//ParentCategoryPulldown.getTextByLanguage(Integer.parseInt(parentId), lang) %></h1>
 
        <div class="list-group productCat">
        <%if(pageIdx == 1) { 
        	String path = StringUtil.filter(parentCat.getDeeplinkpathweb());
        	if(!"".equals(path)) path = basePath + path + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
        	
        	/*String allpath = StringUtil.filter(parentCat.getDeeplinkpathweb());
			
        	
        	if(StringUtil.strToInt(parentId) == StaticValueUtil.CAT_ECO ) {
        		path = "ecorewardList?actionType=search&parentId=" + parentId + "&from=menu&pageIdx=0&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;
				allpath = basePath + "images_web/cat_eco_all.jpg";
        	}else {
        		path = "productList?actionType=search&parentId=" + parentId + "&from=menu&pageIdx=0&type=" + StaticValueUtil.LOGIN_SOURCE_WEB;

			if(StringUtil.strToInt(parentId) == StaticValueUtil.CAT_ELECTRICAL ){
        			allpath = basePath + "images/cat_electrical_all.jpg";
        		}else if(StringUtil.strToInt(parentId) == StaticValueUtil.CAT_SMART ){
        			allpath = basePath + "images/cat_smart_all.jpg";
        		}
        	}*/
        %>
            <a href="<%=path%>" class="list-group-item">
	          <div class="media">
	            <div class="media-left"> <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="<%=basePath %>product_img/<%=StringUtil.filter(parentCat.getImage1()) %>" class="media-object"> </div>
	            <div class="media-body">
	              <p><b><fmt:message key="category.all"/></b></p>
	            </div>
	            <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
	          </div>
          </a>
          <%} %>
          
          <% for(CategoryBean category: categories){ 
          		String categoryName = category.getcName();
          		String path2 = "";
          		
	          	if(I18nUtil.getLangHtml(request).equals("en")){
	          		categoryName = category.geteName();
	          	}
          		
	          	if(StringUtil.strToInt(parentId) == StaticValueUtil.CAT_ECO ) {
	        		path2 = "ecorewardList?actionType=search&categoryId=" + category.getId() + "&from=menu&pageIdx=0&type=" +  StaticValueUtil.LOGIN_SOURCE_WEB;
	        	}else {
	        		path2 = "productList?actionType=search&categoryId=" + category.getId() + "&from=menu&pageIdx=0&type=" +  StaticValueUtil.LOGIN_SOURCE_WEB;
	        	}
	          	
          %>
          
            <a href="<%=path2 %>" class="list-group-item">
          <div class="media">
            <div class="media-left"> 
            <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="<%=basePath %>product_img/<%=StringUtil.filter(category.getImage1()) %>" class="media-object" width="80px">
          	</div>
            <div class="media-body">
              <p><b><%=StringUtil.filter(categoryName) %>  </b></p>
            </div>
            <div class="media-right media-middle"><em class="fa fa-chevron-right text-primary"></em></div>
          </div>
          </a>
          
          <%} %>
      </div><!--list-group productCat-->
      
      <div class="row text-center">
      	<% 
      	String navPath = "category?parentId=" + parentId + "&type=" + StaticValueUtil.LOGIN_SOURCE_WEB + "&pageIdx=" ; 
      	%>
		<%//StringUtil.getCategoryPagingString(5, pageIdx, totalPages, "AdminCategoryServlet?actionType=getCategoryList&pageIdx=") %>
		<%=StringUtil.getFrontPagingString(5, pageIdx, totalPages, navPath) %>
 	 </div>
 	 
	</div><!--category pg ended-->
</section>



 <jsp:include page="footer.jsp" />


</body>
</html>

