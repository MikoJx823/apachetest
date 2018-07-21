package com.project.servlet.admin;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.project.bean.AdminInfoBean;
import com.project.bean.MsgAlertBean;
import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.pulldown.OrderStatusPulldown;
import com.project.service.AdminService;
import com.project.service.OrderService;
import com.project.util.MailUtil;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/**
 * Servlet implementation class AdminOrderServlet
 */
public class AdminOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(AdminOrderServlet.class);
	private static String SEARCH = "search";
	private static String EDIT = "edit";
	private static String RESEND_EMAIL = "resendEmail";
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		resp.setContentType("text/html");
		resp.setHeader("Cache-Control", "no-cache");
		req.getSession().removeAttribute("productBeanAdd");
		req.getSession().removeAttribute("productBeanUpdate");
		String actionType = req.getParameter("actionType");

		log.info("actionType:" + actionType);
		AdminService.getInstance().checkLogin(req, resp);
		
		if (SEARCH.equals(actionType)){
			search(req, resp);	
		}else if(EDIT.equals(actionType)){
			edit(req, resp);
		}else if(actionType.equals(RESEND_EMAIL)){
			resendEmail(req,resp);
		}
		
	}
	
	private void edit(HttpServletRequest req, HttpServletResponse resp) {
		
		String resultUrl = "orderEdit.jsp";
		String errorMsg = "";
		boolean isUpdate = false;
		AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
		
		try{
			
			String perviousStatus = "";
			String orderStatus = StringUtil.filter(req.getParameter("orderStatus"));
			String remark = new String(StringUtil.filter(req.getParameter("remark")).getBytes("ISO8859-1"), "utf-8");
			String email = StringUtil.filter(req.getParameter("email"));
			String contact = StringUtil.filter(req.getParameter("contact"));
			String trackno = StringUtil.filter(req.getParameter("trackno"));
			String address1 = new String(StringUtil.filter(req.getParameter("address1")).getBytes("ISO8859-1"), "utf-8");
			String address2 = new String(StringUtil.filter(req.getParameter("address2")).getBytes("ISO8859-1"), "utf-8");
			String addresstown = new String(StringUtil.filter(req.getParameter("addresstown")).getBytes("ISO8859-1"), "utf-8");
			String addressstate = new String(StringUtil.filter(req.getParameter("addressstate")).getBytes("ISO8859-1"), "utf-8");
			String addresscountry = new String(StringUtil.filter(req.getParameter("addresscountry")).getBytes("ISO8859-1"), "utf-8");
			String shipcompanyname = new String(StringUtil.filter(req.getParameter("shipcompanyname")).getBytes("ISO8859-1"), "utf-8");
			String shipaddress1 = new String(StringUtil.filter(req.getParameter("shipaddress1")).getBytes("ISO8859-1"), "utf-8");
			String shipaddress2 = new String(StringUtil.filter(req.getParameter("shipaddress2")).getBytes("ISO8859-1"), "utf-8");
			String shipaddresstown = new String(StringUtil.filter(req.getParameter("shipaddresstown")).getBytes("ISO8859-1"), "utf-8");
			String shipaddressstate = new String(StringUtil.filter(req.getParameter("shipaddressstate")).getBytes("ISO8859-1"), "utf-8");
			String shipaddresscountry = new String(StringUtil.filter(req.getParameter("shipaddresscountry")).getBytes("ISO8859-1"), "utf-8");
			
			String oId = StringUtil.filter(req.getParameter("id"));
			
			OrderBean order = OrderService.getInstance().getOrderById(oId);
			
			
			if(order == null) {
				errorMsg = "Update order fail - order not found ";
				log.info("Admin - Update Order Failed ");
				
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				resultUrl = "orderView.jsp?id="+order.getoId();
	            resp.sendRedirect(resultUrl);
	            return;
			}
			
			perviousStatus = order.getOrderStatus();
			
			if(!"".equals(orderStatus) && !order.getOrderStatus().equals(orderStatus)){
				order.setOrderStatus(orderStatus); 
				isUpdate = true;
			}
			
			if(!(remark.equals(order.getRemark())) || !(email.equals(order.getBuyeremail()))  || 
			   !(contact.equals(order.getBuyerphone())) || !(address1.equals(order.getBuyeraddress1())) || 
			   !(address2.equals(order.getBuyeraddress2())) || !(addresscountry.equals(order.getBuyercountry())) ||
			   !(addressstate.equals(order.getBuyerstate())) || !(addresstown.equals(order.getBuyertown()))  ||
			   !(trackno.equals(order.getTracknumber())) || !(shipcompanyname.equals(order.getShipcompanyname())) || 
			   !(shipaddress1.equals(order.getShipaddress1())) || !(shipaddress2.equals(order.getShipaddress2())) ||
			   !(shipaddresstown.equals(order.getShiptown())) || !(shipaddressstate.equals(order.getShipstate())) ||
			   !(shipaddresscountry.equals(order.getShipcountry())) 
			  ) {
				
				order.setBuyeraddress1(address1);
				order.setBuyeraddress2(address2);
				order.setBuyerstate(addressstate);
				order.setBuyertown(addresstown);
				order.setBuyerstate(addressstate);
				order.setBuyeremail(email);
				order.setBuyerphone(contact);
				order.setAdminremark(remark);
				//order.setRemark(remark);
				order.setTracknumber(trackno);
				
				order.setShipcompanyname(shipcompanyname);
				order.setShipaddress1(shipaddress1);
				order.setShipaddress2(shipaddress2);
				order.setShiptown(shipaddresstown);
				order.setShipstate(shipaddressstate);
				order.setShipcountry(shipaddresscountry);
				
				isUpdate = true;
			}
			
			if(isUpdate){
				
				order.setModifiedBy(loginUser.getLoginId());
				order = OrderService.getInstance().updateOrderFromAdmin(order);
				
				isUpdate = false;
			}
			
			List<OrderItemBean> orderItems = OrderService.getInstance().getOrderItemListBySqlwhere(" where orderId= " + order.getoId());
			
			if(orderItems == null) {
				errorMsg = "Update order fail - order not found ";
				log.info("Admin - Update Order Failed ");
				
				MsgAlertBean msgAlertBean = new MsgAlertBean();
				msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
				msgAlertBean.setMsg(errorMsg);
				msgAlertBean.setFocusId("msgAlert");
				req.getSession().setAttribute("msgAlertBean", msgAlertBean);
				resultUrl = "orderView.jsp?id="+order.getoId();
	            resp.sendRedirect(resultUrl);
	            return;
			}
			
			for(OrderItemBean orderItem: orderItems ){
				
				int cStatus = StringUtil.strToInt(req.getParameter("cStatus-" + orderItem.getId()));
				
				
					
			}
			
			
			if(order==null){
				
				errorMsg = "Update order fail.";
				log.info("Admin - Update Order Failed ");
			}else{
				errorMsg = "Update Order [ " + order.getOrderRef() + " ] success.";
				log.info("Admin - Update Success ");
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			resultUrl = "orderView.jsp?id="+order.getoId();
            resp.sendRedirect(resultUrl);
			
		}
		catch (Exception e)
		{
			log.error(e);
		}
		
	}

	private void search(HttpServletRequest req, HttpServletResponse resp){   		
		
		String resultUrl = "orderIdx.jsp";
		try
		{
			String from = StringUtil.filter(req.getParameter("from"));
			int pageIdx = StringUtil.trimToInt(req.getParameter("pageIdx"));
	
			Calendar toDate = Calendar.getInstance();
			String toYearDefault = String.valueOf(toDate.get(Calendar.YEAR));
			String toMonthDefault = String.valueOf(toDate.get(Calendar.MONTH)+1);
			String toDayDefault = String.valueOf(toDate.get(Calendar.DAY_OF_MONTH));
			Calendar fromDate = Calendar.getInstance();
			fromDate.add(Calendar.DATE,  -2);
			String fromYearDefault = String.valueOf(fromDate.get(Calendar.YEAR));
			String fromMonthDefault = String.valueOf(fromDate.get(Calendar.MONTH)+1);
			String fromDayDefault = String.valueOf(fromDate.get(Calendar.DAY_OF_MONTH));
			
			String dayFromStr = StringUtil.filter(req.getParameter("dayFrom"), fromDayDefault);
			String monthFromStr = StringUtil.filter(req.getParameter("monthFrom"), fromMonthDefault);
			String yearFromStr = StringUtil.filter(req.getParameter("yearFrom"), fromYearDefault);
			String dayToStr = StringUtil.filter(req.getParameter("dayTo"), toDayDefault);
			String monthToStr = StringUtil.filter(req.getParameter("monthTo"), toMonthDefault);
			String yearToStr = StringUtil.filter(req.getParameter("yearTo"), toYearDefault);
			
			String dateFromStr = yearFromStr + "-" + monthFromStr + "-" + dayFromStr + " 00:00:00";
			String dateToStr = yearToStr + "-" + monthToStr + "-" + dayToStr + " 23:59:59";
			
			String ref = StringUtil.filter(req.getParameter("ref"));
			String name = new String(StringUtil.filter(req.getParameter("name")).getBytes("ISO8859-1"), "utf-8");
			String phone = StringUtil.filter(req.getParameter("phone"));
			String email = StringUtil.filter(req.getParameter("email"));
			String status = StringUtil.filter(req.getParameter("status"));
			String productStatus = StringUtil.filter(req.getParameter("productStatus"));
			
			if ("menu".equals(from)){
				req.getSession().removeAttribute("dayFrom");
				req.getSession().removeAttribute("monthFrom");
				req.getSession().removeAttribute("yearFrom");
				req.getSession().removeAttribute("dayTo");
				req.getSession().removeAttribute("monthTo");
				req.getSession().removeAttribute("yearTo");
				
				req.getSession().removeAttribute("ref");
				req.getSession().removeAttribute("name");
				req.getSession().removeAttribute("phone");
				req.getSession().removeAttribute("email");
				req.getSession().removeAttribute("status");
				req.getSession().removeAttribute("itemType");
				req.getSession().removeAttribute("productStatus");
				
			}else if ("search".equals(from)){
				
				req.getSession().setAttribute("dayFrom", dayFromStr);
				req.getSession().setAttribute("monthFrom", monthFromStr);
				req.getSession().setAttribute("yearFrom", yearFromStr);
				req.getSession().setAttribute("dayTo", dayToStr);
				req.getSession().setAttribute("monthTo", monthToStr);
				req.getSession().setAttribute("yearTo", yearToStr);
				
				req.getSession().setAttribute("ref", ref);
				req.getSession().setAttribute("name", name);
				req.getSession().setAttribute("phone", phone);
				req.getSession().setAttribute("email", email);
				req.getSession().setAttribute("status", status);
				req.getSession().setAttribute("productStatus", productStatus);

				req.getSession().setAttribute("pageIdx", "0");
				
			}else{
				dayFromStr = StringUtil.filter((String)req.getSession().getAttribute("dayFrom")).equals("")? fromDayDefault : StringUtil.filter((String)req.getSession().getAttribute("dayFrom")) ;
				monthFromStr = StringUtil.filter((String)req.getSession().getAttribute("monthFrom")).equals("")? monthFromStr : StringUtil.filter((String)req.getSession().getAttribute("monthFrom"));
				yearFromStr = StringUtil.filter((String)req.getSession().getAttribute("yearFrom")).equals("") ? yearFromStr : StringUtil.filter((String)req.getSession().getAttribute("yearFrom"));
				dayToStr = StringUtil.filter((String)req.getSession().getAttribute("dayTo")).equals("") ? dayToStr : StringUtil.filter((String)req.getSession().getAttribute("dayTo"));
				monthToStr = StringUtil.filter((String)req.getSession().getAttribute("monthTo")).equals("") ? monthToStr : StringUtil.filter((String)req.getSession().getAttribute("monthTo"));
				yearToStr = StringUtil.filter((String)req.getSession().getAttribute("yearTo")).equals("") ? yearToStr : StringUtil.filter((String)req.getSession().getAttribute("yearTo"));

				dateFromStr = yearFromStr + "-" + monthFromStr + "-" + dayFromStr + " 00:00:00";
				dateToStr = yearToStr + "-" + monthToStr + "-" + dayToStr + " 23:59:59";
				
				ref = StringUtil.filter((String)req.getSession().getAttribute("ref"));
				name = new String(StringUtil.filter((String)req.getSession().getAttribute("name")).getBytes("ISO8859-1"), "utf-8");
				phone = StringUtil.filter((String)req.getSession().getAttribute("phone"));
				email = StringUtil.filter((String)req.getSession().getAttribute("email"));
				status = StringUtil.filter((String)req.getSession().getAttribute("status"));
				productStatus = StringUtil.filter((String)req.getSession().getAttribute("productStatus"));
				
				if (pageIdx == 0)
					pageIdx = StringUtil.strToInt((String) req.getSession().getAttribute("pageIdx"));

			}
			
			if (pageIdx == 0)
				pageIdx = 1;
	
			AdminInfoBean loginUser = (AdminInfoBean)req.getSession().getAttribute(SessionName.loginAdmin);
			
			String sqlWhere = "where 1=1 ";
			sqlWhere += "and transactiondate>='" + dateFromStr + "' and transactiondate<='" + dateToStr + "'";;
			if (!"".equals(ref)){	
				sqlWhere += " and orderref like '%" + ref + "%'";
			}
			
			if (!"".equals(name)){
				sqlWhere += " and (buyerfirstname like '%" + name + "%' or buyerlastname like '" + name + "' )";
			}
			if (!"".equals(phone))
			{
				sqlWhere += " and buyerphone like '%" + phone + "%'";
			}
			if (!"".equals(email))
			{
				sqlWhere += " and buyeremail like '%" + email + "%'";
			}
			
			if (!"".equals(status))
			{
				sqlWhere += " and orderstatus = '" + status + "'";
			}

			List<OrderBean> orderList = OrderService.getInstance().getOrderListBySqlwhere(sqlWhere,pageIdx);
			log.info("order list " + orderList.size());
			
			int totalPages = OrderService.getInstance().getTotalPages(pageIdx,sqlWhere);
			
			req.setAttribute(SessionName.beanList, orderList);
			req.setAttribute("pageIdx", pageIdx);
			req.setAttribute("totalPages", totalPages);
			
			req.getRequestDispatcher(resultUrl).forward(req, resp);
		}
		catch (Exception e)
		{
			log.error(e);
		}
	}
	
	private void resendEmail(HttpServletRequest req,HttpServletResponse resp) {
		
		String resultUrl = "resendEmailResult.jsp";
		String errorMsg = "";
		boolean result = false;
		String orderId = StringUtil.filter(req.getParameter("oId")).equals("") ? "0" : StringUtil.filter(req.getParameter("oId"));

		OrderBean order = OrderService.getInstance().getOrderById(orderId);
		try {
			
			if(order == null) {
				errorMsg = "Email Resend Failed";
			}else {
				if (order.getOrderStatus().equals(OrderStatusPulldown.ACCEPTED)){
					result = MailUtil.getInstance().sendOrderEmail(order);
				}
				
				if(!result) errorMsg = "Email resend failed [Order Ref : " + order.getOrderRef() + "]";
				else errorMsg ="Email resend success [Order Ref : " + order.getOrderRef() + "]";
			}
			
			MsgAlertBean msgAlertBean = new MsgAlertBean();
			msgAlertBean.setType(StaticValueUtil.MsgAlertType_Show);
			msgAlertBean.setMsg(errorMsg);
			msgAlertBean.setFocusId("msgAlert");
			req.getSession().setAttribute("msgAlertBean", msgAlertBean);
			
			resp.sendRedirect(resultUrl);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
