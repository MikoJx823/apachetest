package com.project.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.dao.LoggableStatement;
import com.project.pulldown.OrderStatusPulldown;
import com.project.service.ProductService;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

public class OrderDao extends GenericDao
{
	private static Logger log = Logger.getLogger(OrderDao.class);

	private OrderDao(){
	}

	private static OrderDao instance = null;

	public static synchronized OrderDao getInstance()
	{
		if (instance == null)
			instance = new OrderDao();
		return instance;
	}
	public OrderBean insertOrder(OrderBean order){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";

		try
		{
			conn = ConectionFactory.getConnection();
			conn.setAutoCommit(false);
			
			sql = "insert into orderinfo("+
				  "orderref, memberid, totalamount, orderamount, deliveryamount, " +
				  "discountamount, couponamount, remainamount, transactiondate, paymentref, " +
				  "buyertitle, buyerfirstname, buyerlastname, buyercompanyname, buyerphone, " +
				  "buyeremail,  buyeraddress1, buyeraddress2, buyerpostcode, buyertown,  " +
				  "buyerstate, buyercountry, shipfirstname, shiplastname, shipcompanyname,  " +
				  "shipaddress1, shipaddress2, shippostcode, shiptown, shipstate,  " +
				  "shipcountry, tracknumber, buyerremark, adminremark, remark, " +
				  "paymethod, approvalcode, maskedcardno, holdername, src, " +
				  "currency, eci, sourceip, ipcountry," + 
				  "orderstatus, createddate, createdby "+
				  ") values( " +
				  "?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, " +
				  "?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?, ?,?,?" +
				  ")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
		
			pstm.setString(count, order.getOrderRef()); count++;
			pstm.setInt(count, order.getMemberid()); count++;
			pstm.setDouble(count, order.getTotalAmount()); count++;
			pstm.setDouble(count, order.getOrderAmount()); count++;
			pstm.setDouble(count, order.getDeliveryAmount()); count++;
			
			pstm.setDouble(count, order.getDiscountAmount()); count++;
			pstm.setDouble(count, order.getCouponamount()); count++;
			pstm.setDouble(count, order.getRemainAmount()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, order.getPaymentRef()); count++;
			
			pstm.setString(count, order.getBuyertitle()); count++;
			pstm.setString(count, order.getBuyerfirstname()); count++;
			pstm.setString(count, order.getBuyerlastname()); count++;
			pstm.setString(count, order.getBuyercompanyname()); count++;
			pstm.setString(count, order.getBuyerphone()); count++;
			
			pstm.setString(count, order.getBuyeremail()); count++;
			pstm.setString(count, order.getBuyeraddress1()); count++;
			pstm.setString(count, order.getBuyeraddress2()); count++;
			pstm.setString(count, order.getBuyerpostcode()); count++;
			pstm.setString(count, order.getBuyertown()); count++;
			
			pstm.setString(count, order.getBuyerstate()); count++;
			pstm.setString(count, order.getBuyercountry()); count++;
			pstm.setString(count, order.getShipfirstname()); count++;
			pstm.setString(count, order.getShiplastname()); count++;
			pstm.setString(count, order.getShipcompanyname()); count++;
			
			pstm.setString(count, order.getShipaddress1()); count++;
			pstm.setString(count, order.getShipaddress2()); count++;
			pstm.setString(count, order.getShippostcode()); count++;
			pstm.setString(count, order.getShiptown()); count++;
			pstm.setString(count, order.getShipstate()); count++;
			
			pstm.setString(count, order.getShipcountry()); count++;
			pstm.setString(count, order.getTracknumber()); count++;
			pstm.setString(count, order.getBuyerremark()); count++;
			pstm.setString(count, order.getAdminremark()); count++;
			pstm.setString(count, order.getRemark()); count++;
			
			pstm.setString(count, order.getPayMethod()); count++;
			pstm.setString(count, order.getApprovalCode()); count++;
			pstm.setString(count, order.getMaskedCardNo()); count++;
			pstm.setString(count, order.getHolderName()); count++;
			pstm.setString(count, order.getSrc()); count++;
			
			pstm.setString(count, order.getCurrency()); count++;
			pstm.setString(count, order.getEci()); count++;
			pstm.setString(count, order.getSourceip()); count++;
			pstm.setString(count, order.getIpcountry()); count++;

			pstm.setString(count, order.getOrderStatus()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, order.getCreatedBy()); count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			if (rs.next())
			{
				int oid = rs.getInt(1);
				order.setoId(oid);
			} 
			log.info("OrderDao order.getoId():" + order.getoId());
			List<OrderItemBean> orderItems = order.getOrderItems();
			for(OrderItemBean orderItem : orderItems){
			
				sql = "insert into orderitem(" +
					  "orderid, pid, pvid, price, discount, " +
					  "quantity, productname, productimage, productcode, variantname, "+ 
					  "categoryid, " + 
					  "status, createddate, createdby " + 
					  ") values (" + 
					  "?,?,?,?,?, ?,?,?,?,?, ?, ?,?,? " + 
					  ")";

				pstm = new LoggableStatement(conn, sql);
				count = 1;
				pstm.setInt(count, order.getoId()); count++ ;
				pstm.setInt(count, orderItem.getPid()); count++;
				pstm.setInt(count, orderItem.getPvid()); count++;
				pstm.setDouble(count, orderItem.getPrice()); count++;
				pstm.setDouble(count, orderItem.getDiscount()); count++;
				
				pstm.setInt(count, orderItem.getQuantity()); count++;
				pstm.setString(count, orderItem.getProductname()); count++;
				pstm.setString(count, orderItem.getProductimage()); count++;
				pstm.setString(count, orderItem.getProductcode()); count++;
				pstm.setString(count, orderItem.getVariantname()); count++;
				
				pstm.setInt(count, orderItem.getCategoryid()); count++;
				
				pstm.setInt(count, orderItem.getStatus()); count++;
				pstm.setTimestamp(count, getTimestamp(new Date())); count++;
				pstm.setString(count, orderItem.getCreatedBy()); count++;
				
				//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
				log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
				
				pstm.executeUpdate();
				rs = ((LoggableStatement) pstm).getGeneratedKeys();
				if (rs.next()){
					int id = rs.getInt(1);
					orderItem.setId(id);
					orderItem.setOrderId(order.getoId());
				}
			}
			
			order.setOrderItems(orderItems);
			conn.commit();
			         
		}
		catch (Exception e)
		{
			order = null;
			log.error(e);
			try
			{
				conn.rollback();
			}
			catch (Exception e2)
			{
			}
			
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		log.info("insert order id:"+order.getoId());
		for(OrderItemBean orderItem : order.getOrderItems())
		{
			log.info("insert orderItem id:"+orderItem.getId());
		}
		
		return order;
	}

	public OrderBean updateOrder(OrderBean order){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try {
			Date now = new Date();
			order.setModifiedDate(now);
			sql = "update orderinfo set "+
				  "orderref=?, memberid=?, totalamount=?, orderamount=?, deliveryamount=?, " +
				  "discountamount=?, couponamount=?, remainamount=?, transactiondate=?, paymentref=?," +
				  "buyertitle=?, buyerfirstname=?, buyerlastname=?, buyercompanyname=?, buyerphone=?,  " +
				  "buyeremail=?, buyeraddress1=?, buyeraddress2=?, buyerpostcode=?, buyertown=?, " +
				  "buyerstate=?, buyercountry=?, shipfirstname=?, shiplastname=?, shipcompanyname=?,  " +
				  "shipaddress1=?, shipaddress2=?, shippostcode=?, shiptown=?, shipstate=?,  " +
				  "shipcountry=?, tracknumber=?, buyerremark=?, adminremark=?, remark=?, " +
				  "paymethod=?, approvalcode=?, maskedcardno=?, holdername=?, src=?, " +
				  "currency=?, eci=?, sourceip=?, ipcountry=?," + 
 				  "orderstatus=?, modifieddate=?, modifiedby=? "+
		          "where oid = ?";

			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setString(count, order.getOrderRef()); count++;
			pstm.setInt(count, order.getMemberid()); count++;
			pstm.setDouble(count, order.getTotalAmount()); count++;
			pstm.setDouble(count, order.getOrderAmount()); count++;
			pstm.setDouble(count, order.getDeliveryAmount()); count++;
			
			pstm.setDouble(count, order.getDiscountAmount()); count++;
			pstm.setDouble(count, order.getCouponamount()); count++;
			pstm.setDouble(count, order.getRemainAmount()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, order.getPaymentRef()); count++;
			
			pstm.setString(count, order.getBuyertitle()); count++;
			pstm.setString(count, order.getBuyerfirstname()); count++;
			pstm.setString(count, order.getBuyerlastname()); count++;
			pstm.setString(count, order.getBuyercompanyname()); count++;
			pstm.setString(count, order.getBuyerphone()); count++;
			
			pstm.setString(count, order.getBuyeremail()); count++;
			pstm.setString(count, order.getBuyeraddress1()); count++;
			pstm.setString(count, order.getBuyeraddress2()); count++;
			pstm.setString(count, order.getBuyerpostcode()); count++;
			pstm.setString(count, order.getBuyertown()); count++;
			
			pstm.setString(count, order.getBuyerstate()); count++;
			pstm.setString(count, order.getBuyercountry()); count++;
			pstm.setString(count, order.getShipfirstname()); count++;
			pstm.setString(count, order.getShiplastname()); count++;
			pstm.setString(count, order.getShipcompanyname()); count++;
			
			pstm.setString(count, order.getShipaddress1()); count++;
			pstm.setString(count, order.getShipaddress2()); count++;
			pstm.setString(count, order.getShippostcode()); count++;
			pstm.setString(count, order.getShiptown()); count++;
			pstm.setString(count, order.getShipstate()); count++;
			
			pstm.setString(count, order.getShipcountry()); count++;
			pstm.setString(count, order.getTracknumber()); count++;
			pstm.setString(count, order.getBuyerremark()); count++;
			pstm.setString(count, order.getAdminremark()); count++;
			pstm.setString(count, order.getRemark()); count++;
			
			pstm.setString(count, order.getPayMethod()); count++;
			pstm.setString(count, order.getApprovalCode()); count++;
			pstm.setString(count, order.getMaskedCardNo()); count++;
			pstm.setString(count, order.getHolderName()); count++;
			pstm.setString(count, order.getSrc()); count++;
			
			pstm.setString(count, order.getCurrency()); count++;
			pstm.setString(count, order.getEci()); count++;
			pstm.setString(count, order.getSourceip()); count++;
			pstm.setString(count, order.getIpcountry()); count++;
			
			pstm.setString(count, order.getOrderStatus()); count++; 
			pstm.setTimestamp(count, new Timestamp(order.getModifiedDate().getTime()));count++;
			pstm.setString(count, order.getModifiedBy());count++;
		
			pstm.setInt(count, order.getoId());
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			
		} catch (Exception e) {
			order = null;
			log.error(sql,e);
		} finally {
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return order;
	}
	
	public OrderBean updateOrderFromAdmin(OrderBean order){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try {
			Date now = new Date();
			order.setModifiedDate(now);
			sql = "update orderinfo set "+
				  "buyertitle=?, buyerfirstname=?, buyerlastname=?, buyercompanyname=?, buyerphone=?, " +
				  "buyeremail=?, buyeraddress1=?, buyeraddress2=?, buyerpostcode=?, buyertown=?, " +
				  "buyerstate=?, buyercountry=?, shipfirstname=?, shiplastname=?, shipcompanyname=?, " +
				  "shipaddress1=?, shipaddress2=?, shippostcode=?, shiptown=?, shipstate=?, " +
				  "shipcountry=?, tracknumber=?, adminremark=?, " +
				  "orderstatus=?, modifieddate=?, modifiedby=? "+
		          "where oid = ?";
			
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setString(count, order.getBuyertitle()); count++;
			pstm.setString(count, order.getBuyerfirstname()); count++;
			pstm.setString(count, order.getBuyerlastname()); count++;
			pstm.setString(count, order.getBuyercompanyname()); count++;
			pstm.setString(count, order.getBuyerphone()); count++;
			
			pstm.setString(count, order.getBuyeremail()); count++;
			pstm.setString(count, order.getBuyeraddress1()); count++;
			pstm.setString(count, order.getBuyeraddress2()); count++;
			pstm.setString(count, order.getBuyerpostcode()); count++;
			pstm.setString(count, order.getBuyertown()); count++;
			
			pstm.setString(count, order.getBuyerstate()); count++;
			pstm.setString(count, order.getBuyercountry()); count++;
			pstm.setString(count, order.getShipfirstname()); count++;
			pstm.setString(count, order.getShiplastname()); count++;
			pstm.setString(count, order.getShipcompanyname()); count++;
			
			pstm.setString(count, order.getShipaddress1()); count++;
			pstm.setString(count, order.getShipaddress2()); count++;
			pstm.setString(count, order.getShippostcode()); count++;
			pstm.setString(count, order.getShiptown()); count++;
			pstm.setString(count, order.getShipstate()); count++;
			
			pstm.setString(count, order.getShipcountry()); count++;
			pstm.setString(count, order.getTracknumber()); count++;
			pstm.setString(count, order.getAdminremark()); count++;
		
			pstm.setString(count, order.getOrderStatus()); count++; 
			pstm.setTimestamp(count, getTimestamp(new Date()));count++;
			pstm.setString(count, order.getModifiedBy());count++;

			pstm.setInt(count, order.getoId());
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			
		} catch (Exception e) {
			order = null;
			log.error(sql,e);
		} finally {
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return order;
	}
	
	public OrderBean updateOrderStatus(OrderBean order){
		
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try {
			Date now = new Date();
			order.setModifiedDate(now);
			sql = "update orderinfo set "+
		          "orderstatus=?, modifieddate=?, modifiedby=? "+
		          "where oid = ?";
			
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setString(count, order.getOrderStatus());count++;
			pstm.setTimestamp(count, new Timestamp(order.getModifiedDate().getTime()));count++;
			pstm.setString(count, order.getModifiedBy());count++;

			pstm.setInt(count, order.getoId());
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());

			pstm.executeUpdate();
			
		} catch (Exception e) {
			order = null;
			log.error(sql,e);
		} finally {
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return order;
		
	}
	
	public OrderBean getOrderByRefNo(String ref){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		OrderBean result = null;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from orderinfo where orderref = ?";
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setString(1, ref);
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			List<OrderBean> resultList = getOrderFromResultSet(rs);
			if(resultList.size()==1)
			{
				result = resultList.get(0);
			}

		
		}
		catch (Exception e)
		{
			log.error(sql, e);
		}
		finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public OrderBean getOrderMainBySqlwhere(String Sqlwhere){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		OrderBean result = null;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from orderinfo "+Sqlwhere;
			
			pstmt = new LoggableStatement(conn, sql);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			List<OrderBean> resultList = getOrderFromResultSet(rs);
			if(resultList.size()==1)
			{
				result = resultList.get(0);
			}

			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<Integer> getPopularItem(String sqlWhere){
		
		return queryForIntList(sqlWhere);
	}
	
	public List<OrderBean> getOrderMainListBySqlwhere(String sqlWhere){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<OrderBean> result = new ArrayList<OrderBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from orderinfo "+sqlWhere;
			
			pstmt = new LoggableStatement(conn, sql);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			result = getOrderFromResultSet(rs);

			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<OrderBean> getOrderMainListBySqlwhere(String sqlWhere,int pageIdx){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<OrderBean> result = new ArrayList<OrderBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			sql = "select * from orderinfo "+sqlWhere+" order by oid DESC limit ?,?";
			
			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			result = getOrderFromResultSet(rs);

			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<OrderBean> getListByStatusForReserveService(String sqlWhere){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<OrderBean> result = new ArrayList<OrderBean>();
		try{
			conn = ConectionFactory.getConnection();
			sql = "select oid, orderstatus, transactiondate, createddate from orderinfo "+sqlWhere ;
			
			pstmt = new LoggableStatement(conn, sql);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			while (rs != null && rs.next()){
				OrderBean order = new OrderBean();
				order.setoId(rs.getInt("oid"));
				order.setOrderStatus(rs.getString("orderStatus"));
				order.setTransactiondate(rs.getTimestamp("transactiondate"));
				order.setCreatedDate(rs.getTimestamp("createdDate"));

				result.add(order);
			}
			
			
		} catch (Exception e){
			log.error(sql, e);
		} finally{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}

	public List<OrderItemBean> getOrderItemsByOrderId(int oId){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<OrderItemBean> result = new ArrayList<OrderItemBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from orderitem where orderid = ?";
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setInt(1, oId);
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			result = getOrderItemFromResultSet(rs);

		}
		catch (Exception e)
		{
			log.error(sql, e);
		}
		finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
    public List<OrderItemBean> getOrderItemsBySqlWhere(String sqlWhere){
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        List<OrderItemBean> result = new ArrayList<OrderItemBean>();
 
        try
        {
            conn = ConectionFactory.getConnection();
            sql = "select * from orderitem "+ sqlWhere;
            pstmt = new LoggableStatement(conn, sql);
            log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
            
            rs = pstmt.executeQuery();
            result = getOrderItemFromResultSet(rs);
 
        }
        catch(Exception e)
        {
            log.error(sql, e);
        } finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
    }

    public boolean updateOrderItem(int orderId, int status, String modifieidBy){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try {
			Date now = new Date();
			
			sql = "update orderitem set "+
		          "status=?, modifieddate = ?, modifiedby = ? " +
		          "where orderid = ?";
			
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;
			
			pstm.setInt(count, status); count++;
			pstm.setTimestamp(count, new Timestamp(now.getTime())); count++;
			pstm.setString(count, modifieidBy);count++;
			pstm.setInt(count, orderId);

			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			
			result = true;
			
		} catch (Exception e) {
			
			log.error(sql,e);
		} finally {
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return result;
	}
	
	public int getHoldingProductQty(int pvid){
		String sqlcmd = "SELECT SUM(oi.quantity) as quantity FROM orderitem oi inner join orderinfo o on o.oid=oi.orderid WHERE (o.orderstatus in('"+OrderStatusPulldown.PENDING+"','"+OrderStatusPulldown.ACCEPTED+"')) and oi.pvid="+pvid;
		return queryForInt(sqlcmd);
	}
	
	public int getSoldOutProductQty(int pvid)
	{
		String sqlcmd = "SELECT SUM(oi.quantity) as quantity FROM orderitem oi inner join orderinfo o on o.oid=oi.orderid WHERE ( o.orderstatus='"+OrderStatusPulldown.ACCEPTED+"')and oi.pvid="+pvid;
		return queryForInt(sqlcmd);
	}
    
	public int getTotalPages(int pageIdx,String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			
			sql = "select count(*) as count from orderinfo "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}
			}

		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getFrontTotalPages(int pageIdx,String sqlWhere, String type){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			
			if(StaticValueUtil.LOGIN_SOURCE_MOBILE.equals(type)){
				pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front"));
			}else {
				pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front.web"));
			}
			
			sql = "select count(*) as count from orderinfo "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}
			}

		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getFrontItemTotalPages(int pageIdx,String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front"));
			
			sql = "select count(*) as count from orderitem "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}
			}
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	public int getFrontTotalItems(String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front"));
			
			sql = "select count(*) as count from orderitem "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next()){
				result = rs.getInt("count");
			}

		}
		catch (Exception e)
		{
			log.error(pstmt, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}
		return result;
	}
	
	private List<OrderBean> getOrderFromResultSet(ResultSet rs) throws Exception{

		List<OrderBean> result = new ArrayList<OrderBean>();
		while (rs != null && rs.next())
		{
			OrderBean order = new OrderBean();
			order.setoId(rs.getInt("oid"));
			order.setOrderRef(rs.getString("orderref"));
			order.setMemberid(rs.getInt("memberid"));
			order.setTotalAmount(rs.getDouble("totalamount"));
			order.setOrderAmount(rs.getDouble("orderamount"));
			
			order.setDeliveryAmount(rs.getDouble("deliveryamount"));
			order.setDiscountAmount(rs.getDouble("discountamount"));
			order.setCouponamount(rs.getDouble("couponamount"));
			order.setRemainAmount(rs.getDouble("remainamount"));
			order.setTransactiondate(rs.getTimestamp("transactiondate"));
			
			order.setPaymentRef(rs.getString("paymentref"));
			order.setBuyertitle(rs.getString("buyertitle"));
			order.setBuyerfirstname(rs.getString("buyerfirstname"));
			order.setBuyerlastname(rs.getString("buyerlastname"));
			order.setBuyercompanyname(rs.getString("buyercompanyname"));
			
			order.setBuyerphone(rs.getString("buyerphone"));
			order.setBuyeremail(rs.getString("buyeremail"));
			order.setBuyeraddress1(rs.getString("buyeraddress1"));
			order.setBuyeraddress2(rs.getString("buyeraddress2"));
			order.setBuyerpostcode(rs.getString("buyerpostcode"));
			
			order.setBuyertown(rs.getString("buyertown"));
			order.setBuyerstate(rs.getString("buyerstate"));
			order.setBuyercountry(rs.getString("buyercountry"));
			order.setShipfirstname(rs.getString("shipfirstname"));
			order.setShiplastname(rs.getString("shiplastname"));
			
			order.setShipcompanyname(rs.getString("shipcompanyname"));
			order.setShipaddress1(rs.getString("shipaddress1"));
			order.setShipaddress2(rs.getString("shipaddress2"));
			order.setShippostcode(rs.getString("shippostcode"));
			order.setShiptown(rs.getString("shiptown"));
		
			order.setShipstate(rs.getString("shipstate"));
			order.setShipcountry(rs.getString("shipcountry"));
			order.setTracknumber(rs.getString("tracknumber"));
			order.setBuyerremark(rs.getString("buyerremark"));
			order.setAdminremark(rs.getString("adminremark"));
			order.setRemark(rs.getString("remark"));
			
			order.setPayMethod(rs.getString("paymethod"));
			order.setApprovalCode(rs.getString("approvalcode"));
			order.setMaskedCardNo(rs.getString("maskedcardno"));
			order.setHolderName(rs.getString("holdername"));
			order.setSrc(rs.getString("src"));
			
			order.setCurrency(rs.getString("currency"));
			order.setEci(rs.getString("eci"));
			order.setSourceip(rs.getString("sourceip"));
			order.setIpcountry(rs.getString("ipcountry"));

			order.setOrderStatus(rs.getString("orderstatus"));
			order.setCreatedDate(rs.getTimestamp("createddate"));
			order.setCreatedBy(rs.getString("createdby"));
			order.setModifiedDate(rs.getTimestamp("modifieddate"));
			order.setModifiedBy(rs.getString("modifiedby"));
			
			order.setOrderItems(getOrderItemsByOrderId(order.getoId()));
			result.add(order);
		}
		return result;

	}
	
	private List<OrderItemBean> getOrderItemFromResultSet(ResultSet rs) throws Exception{
		
		List<OrderItemBean> result = new ArrayList<OrderItemBean>();
		while (rs != null && rs.next())
		{
			OrderItemBean orderItem = new OrderItemBean();
			orderItem.setId(rs.getInt("id"));
			orderItem.setOrderId(rs.getInt("orderid"));
			orderItem.setPid(rs.getInt("pid"));
			orderItem.setPvid(rs.getInt("pvid"));
			orderItem.setPrice(rs.getDouble("price"));
			
			orderItem.setDiscount(rs.getDouble("discount"));
			orderItem.setQuantity(rs.getInt("quantity"));
			orderItem.setProductname(rs.getString("productname"));
			orderItem.setProductimage(rs.getString("productimage"));
			orderItem.setProductcode(rs.getString("productcode"));
			
			orderItem.setVariantname(rs.getString("variantname"));
			orderItem.setCategoryid(rs.getInt("categoryid"));
			
			orderItem.setStatus(rs.getInt("status"));
			orderItem.setCreatedDate(rs.getTimestamp("createddate"));
			orderItem.setCreatedBy(rs.getString("createdby"));
			orderItem.setModifiedDate(rs.getTimestamp("modifieddate")); 
			orderItem.setModifiedBy(rs.getString("modifiedby"));

			result.add(orderItem);
		}
		return result;
		
	}
	
	
}
