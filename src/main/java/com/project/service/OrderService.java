package com.project.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.dao.OrderDao;
import com.project.pulldown.OrderStatusPulldown;

public class OrderService
{
	Logger log = Logger.getLogger(OrderService.class);

	private static OrderService instance = null;

	public static synchronized OrderService getInstance()
	{
		if (instance == null)
			instance = new OrderService();
		return instance;
	}

	private OrderDao orderDao;
	private OrderService()
	{
		orderDao = OrderDao.getInstance();
	}

	/*public void setResponseCar(JSONObject object,OrderBean orderBean)
	{
		List<OrderItemBean> orderItems = orderBean.getOrderItems();
		object.put("orderAmount", StringUtil.formatPrice(orderBean.getOrderAmount()));
		object.put("donatAmount", StringUtil.formatPrice(orderBean.getDonatAmount()));
		object.put("deliveryAmount", StringUtil.formatPrice(orderBean.getDeliveryAmount()));
		JSONArray itemsArray = JSONArray.fromObject(orderItems);
		object.put("items", itemsArray);
		object.put("respCode", StaticValueUtil.respCode_success);
	}*/
	
	//ORDER BEAN RELATED 
	
	public OrderBean getOrderBySqlwhere(String sqlWhere)
	{
		OrderBean orderMain = orderDao.getOrderMainBySqlwhere(sqlWhere);
		if (orderMain == null)
			return null;
		List<OrderItemBean> orderItems = orderDao.getOrderItemsByOrderId(orderMain.getoId());
		orderMain.setOrderItems(orderItems);
		return orderMain;
	}
	
	
	public OrderBean getOrderByRefNo(String ref){
		return orderDao.getOrderByRefNo(ref);
	}
	
	public OrderBean getSuccessOrderByRefNo(String ref){
		
		OrderBean order = orderDao.getOrderByRefNo(ref);
		if(order != null) {
			
			List<OrderItemBean> items = OrderService.getInstance().getOrderItemsByOrderId(order.getoId());
			order.setOrderItems(items);
		}
		
		return order;
	}
	
	public OrderBean getOrderMainBySqlwhere(String Sqlwhere){
		return orderDao.getOrderMainBySqlwhere(Sqlwhere);
	}
	
	public OrderBean insertOrder(OrderBean order){
		return orderDao.insertOrder(order);
	}
	
	public OrderBean updateOrder(OrderBean order){
		return orderDao.updateOrder(order);
	}
	
	public OrderBean updateOrderStatus(OrderBean order){
		return orderDao.updateOrderStatus(order);
	}
	
	public OrderBean updateOrderFromAdmin(OrderBean order){
		return orderDao.updateOrderFromAdmin(order);
	}
	
	public OrderBean getOrderById(String oId){
		List<OrderBean> orderList =  orderDao.getOrderMainListBySqlwhere(" where oId = '" + oId + "'" );
		if(orderList.size()==1)
			return orderList.get(0);
		return null;
	}
	
	public List<OrderBean> getListByStatusForReserveService(){ 
		String sqlWhere = " where orderstatus = '" + OrderStatusPulldown.PENDING + "'"; 
		return orderDao.getListByStatusForReserveService(sqlWhere);
	}
	
	public List<OrderBean> getOrderListBySqlwhere(String sqlWhere)
	{
		List<OrderBean> orderMainList = orderDao.getOrderMainListBySqlwhere(sqlWhere);
		for(OrderBean orderMain:orderMainList)
		{
			String sqlWhere2 = "where orderid = " + orderMain.getoId()  ;
			List<OrderItemBean> orderItems = orderDao.getOrderItemsBySqlWhere(sqlWhere2);
			
			orderMain.setOrderItems(orderItems);
		}
		return orderMainList;
	}
	
	public List<OrderBean> getOrderListBySqlwhere(String sqlWhere, int pageIdx){
		List<OrderBean> orderMainList = orderDao.getOrderMainListBySqlwhere(sqlWhere,pageIdx);
		for(OrderBean orderMain:orderMainList)
		{
			List<OrderItemBean> orderItems = orderDao.getOrderItemsByOrderId(orderMain.getoId());
			orderMain.setOrderItems(orderItems);
		}
		return orderMainList;
	}

	//ORDER ITEM BEAN RELATED 
	public OrderItemBean getOrderItemById(String id){
		List<OrderItemBean> orderItems =  orderDao.getOrderItemsBySqlWhere(" where id = '" + id + "'" );
		if(orderItems.size()==1)
			return orderItems.get(0);
		return null;
	}
	
	public List<OrderItemBean> getOrderItemListBySqlwhere(String sqlWhere){
		return orderDao.getOrderItemsBySqlWhere(sqlWhere);
	}
	
	public List<OrderItemBean> getOrderItemsByOrderId(int oId){
		String sqlWhere = " where orderid = " + oId;
		
		return orderDao.getOrderItemsBySqlWhere(sqlWhere);
	}
	
	public boolean updateOrderItem(int orderId, int status, String modifieidBy){
		return orderDao.updateOrderItem(orderId, status, modifieidBy);
	}
	
	//OTHERS 
	public int getTotalPages(int pageIdx,String sqlWhere){
		return orderDao.getTotalPages(pageIdx,sqlWhere);
	}
	
	public int getFrontTotalPages(int pageIdx,String sqlWhere, String type){
		return orderDao.getFrontTotalPages(pageIdx,sqlWhere, type);
	}
	
	public int getFrontItemTotalPages(int pageIdx,String sqlWhere){
		return orderDao.getFrontItemTotalPages(pageIdx,sqlWhere);
	}
	
	public int getFrontTotalItems(String sqlWhere){
		return orderDao.getFrontTotalItems(sqlWhere);
	}
	
	public void updateOrderStatusFromPayment(String orderref){
		OrderBean bean = getOrderByRefNo(orderref);
		
		if(bean != null){
			if(bean.getOrderStatus().equals(OrderStatusPulldown.PENDING)){
				bean.setOrderStatus(OrderStatusPulldown.REJECTED);
				updateOrderStatus(bean);
			}
		}
		
	}
	
	public  synchronized String generateOrderNo(HttpServletRequest req)
	{
        //String prefixNo = RefPrefix.shoppingCart + RefPrefix.Internet + RefPrefix.oneOff; // Shopping Cart
        
		int seqId =  SeqService.getInstance().getSeqid();
		
		String orderRef = String.format("%08d", seqId);//+prefixNo;
		log.info("generateOrderNo:"+orderRef);
		return orderRef;
	}
	
	public List<Integer> getPopularItem(String sqlWhere){
		return orderDao.queryForIntList(sqlWhere);
	}
}
