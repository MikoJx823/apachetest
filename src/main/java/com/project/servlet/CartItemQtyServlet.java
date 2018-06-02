package com.project.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.project.bean.OrderItemBean;
import com.project.service.ReservationService;
import com.project.util.SessionName;
import com.project.util.StaticValueUtil;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class CartItemQtyServlet
 */
public class CartItemQtyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Logger log = Logger.getLogger(CartItemQtyServlet.class);

	private static final String removeCart = "removeCart";
	private static final String changeQty = "changeQty";
	
	@Override
	protected void service(HttpServletRequest request,  HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");

		String actionType = request.getParameter("actionType");
		log.info("actionType:" + actionType);

		
		if(removeCart.equals(actionType)){
			removeCart(request, response);
		} else if(changeQty.equals(actionType)){
			changeQty(request, response);
		}
		
		return ;
	}
	
	private void removeCart(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
	    response.setCharacterEncoding("utf-8");
	    response.setContentType("application/json");
	    response.setHeader("Cache-Control", "no-cache");
		
		/*if (!request.getSession().getAttribute(SessionName.token).equals(request.getParameter(SessionName.token)))
		return ;*/
		
		String successCode = StaticValueUtil.STATUS_NO;
		String errorMsg = "";
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		
		HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)session.getAttribute(SessionName.orderCartItemMap);
		String cartId = request.getParameter("cartId");

 		try {
 			//request.getSession().removeAttribute(SessionName.errorMsg);
 			//request.getSession().removeAttribute(SessionName.errorMsgC);

 			if(cartMap != null) {
 				if (cartMap.containsKey(cartId)) {
 					cartMap.remove(cartId);
 					successCode = StaticValueUtil.STATUS_YES;
 					
 					log.info("REMOVE CART SUCCESS *************************");
 					log.info("sessionId :" + sessionId);
 					log.info("cartId : " + cartId);
 				}
 			}
 		

 			JSONObject jsonObject = new JSONObject();
 			jsonObject.put(SessionName.successCode, successCode);
 			jsonObject.put(SessionName.errorMsg, errorMsg);
 			PrintWriter out = response.getWriter();
 			//log.info(jsonObject);
 			out.print(jsonObject);
 		} catch (Exception e) {
 			// TODO: handle exception
 			log.info("Remove ");
 		}

   		return;
	}

	private void changeQty(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
	    response.setCharacterEncoding("utf-8");
	    response.setContentType("application/json");
	    response.setHeader("Cache-Control", "no-cache");
	    
  		try {
 			
 			//request.getSession().removeAttribute(SessionName.errorMsg);
 			//request.getSession().removeAttribute(SessionName.errorMsgC);
 			
 			String errorMsg = "";
 			
 			String successCode = StaticValueUtil.STATUS_NO;
 			HttpSession session = request.getSession();
 			String sessionId = session.getId();
 			int oldQty = 0;
 			
 			HashMap<String, OrderItemBean> cartMap = (HashMap<String, OrderItemBean>)session.getAttribute(SessionName.orderCartItemMap);
 			
 			String cartId = request.getParameter("cartId");
 			String qty = request.getParameter("qty"+cartId);
 			log.info("qty" + qty);
 			if(cartMap!= null) {
 				OrderItemBean tempOrderItem = cartMap.get(cartId);
 				oldQty = tempOrderItem.getQuantity();

 				//START QTY CONTROL CALCULATION 
 				tempOrderItem.setQuantity(Integer.parseInt(qty));
 				
 				boolean holdFlag = false;
 				
 				holdFlag = ReservationService.getInstance().holdItem(sessionId, tempOrderItem, true);
 				
 				log.info("holdFlag: " + holdFlag);
 				if (!holdFlag){
 					log.info("oldQty: " + oldQty);
 					log.info("getQuantity: " + tempOrderItem.getQuantity());
 					
 					//tempOrderItem.setQuantity(oldQty);
 					//cartMap.put(cartId, tempOrderItem);
 					errorMsg = "Insufficient stock "+ tempOrderItem.getProductname() + "\\n";

 	 			} else {
 	 				OrderItemBean orderItem = cartMap.get(cartId);
 	 				orderItem.setQuantity(Integer.parseInt(qty));
 	 				
 					cartMap.put(cartId, orderItem);
 					successCode = StaticValueUtil.STATUS_YES;
 					log.info(orderItem.getQuantity());
 					session.setAttribute(SessionName.orderCartItemMap, cartMap);
 					log.info("Success Add item");
 				}
 				
 			} else {
 				log.info("cartMap is null");
 			}

 			JSONObject jsonObject = new JSONObject();
 			jsonObject.put(SessionName.successCode, successCode);
 			jsonObject.put(SessionName.errorMsg, errorMsg);
 			PrintWriter out = response.getWriter();
 			//log.info(jsonObject);
 			out.print(jsonObject);
 		} catch (Exception e) {
 			
 		}

  		return;

	}
}