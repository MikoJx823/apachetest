<%@page import="com.project.util.I18nUtil"%>
<%@page import="com.project.bean.MsgAlertBean"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.project.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	MsgAlertBean msgAlertBean = (MsgAlertBean)session.getAttribute("msgAlertBean");
	int type = 0;
	String msg = "";
	String focusId = "";
	if(msgAlertBean!=null)
	{
		type = msgAlertBean.getType();
		msg = msgAlertBean.getMsg();
		focusId = msgAlertBean.getFocusId();
		
		session.removeAttribute("msgAlertBean");
	}
%>

	 <% if(!"".equals(msg) && 1 ==type){%>
	 <div id="msgAlert" class="alert alert-warning" role="alert">
	 	<button type="button" class="close" data-dismiss="alert">
	 		<span aria-disable="true">&times;</span>
	 	</button>
	 	<%=msg%>
	 </div>
	 <%}%>

 
  <script src="../js/bootstrap.js"></script>
  <script type="text/javascript">
  <% if(!"".equals(msg) && 1 ==type){%>
  window.location.hash = "#<%=focusId%>";
  <%}%>
  
  <% if(!"".equals(msg) && 2 ==type){%>
  layer.alert('<%=msg%>', {
	  title: '提示信息',
      skin: 'layui-layer-molv',
      shift: 3 //动画类型0-6
  });
  <%}%> 
  </script>

