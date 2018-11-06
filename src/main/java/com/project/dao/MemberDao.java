package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.MemberInfoBean;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;
/*
 * Function 
 * Add
 * Edit
 * Delete
 * Get single record, list record by sql, list record by sql, page
 * Get total record no
 * */
public class MemberDao extends GenericDao{
	
	private static Logger log = Logger.getLogger(MemberDao.class);
	private static MemberDao instance = null;

	public static synchronized MemberDao getInstance()
	{
		if (instance == null)
			instance = new MemberDao();
		return instance;
	}
	
	public MemberInfoBean insert(MemberInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			bean.setCreatedDate(now);	

			conn = ConectionFactory.getConnection();
			sql = "insert into memberinfo("	+ 
					"title, firstname, lastname, email, phone, " + 
					"address1, address2, address3, postcode, state, " + 
					"country, password, " + 
					"status, createddate, createdby " +
					") values("+ 
					"?,?,?,?,?, ?,?,?,?,?, ?,?, ?,?,? " +
					")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;

			pstm.setString(count++, bean.getTitle()); 
			pstm.setString(count++, bean.getFirstname());
			pstm.setString(count++, bean.getLastname());
			pstm.setString(count++, bean.getEmail()); 
			pstm.setString(count++, bean.getPhone()); 
			
			pstm.setString(count++, bean.getAddress1()); 
			pstm.setString(count++, bean.getAddress2()); 
			pstm.setString(count++, bean.getAddress3());
			pstm.setString(count++, bean.getPostcode());
			pstm.setString(count++, bean.getState());
			
			pstm.setString(count++, bean.getCountry());
			pstm.setString(count++, bean.getPassword());
			
			pstm.setInt(count++, bean.getStatus());
			pstm.setTimestamp(count++, getTimestamp(bean.getCreatedDate())); 
			pstm.setString(count++, bean.getCreatedBy());
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());

			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				int id = rs.getInt(1);
				bean.setId(id);
			}
			
		}
		catch (Exception e)
		{
			bean = null;
			log.error(e);
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return bean;
	}
	
	public MemberInfoBean update(MemberInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			bean.setModifiedDate(now); 
			
			sql = "update memberinfo set "+ 
				  "title=?, firstname=?, lastname=?, email=?, phone=?, " + 
				  "address1=?, address2=?, address3=?, postcode=?, state=?, " + 
				  "country=?, password=?, " + 
				  "status=?, modifieddate=?, modifiedby=? " +
				  "where id = ?";
			
			
			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;
			
			pstm.setString(count++, bean.getTitle()); 
			pstm.setString(count++, bean.getFirstname());
			pstm.setString(count++, bean.getLastname());
			pstm.setString(count++, bean.getEmail()); 
			pstm.setString(count++, bean.getPhone()); 
			
			pstm.setString(count++, bean.getAddress1()); 
			pstm.setString(count++, bean.getAddress2()); 
			pstm.setString(count++, bean.getAddress3());
			pstm.setString(count++, bean.getPostcode());
			pstm.setString(count++, bean.getState());
			
			pstm.setString(count++, bean.getCountry());
			pstm.setString(count++, bean.getPassword());
			
			pstm.setInt(count++, bean.getStatus());
			pstm.setTimestamp(count++, getTimestamp(bean.getModifiedDate())); 
			pstm.setString(count++, bean.getModifiedBy());
			
			pstm.setInt(count++, bean.getId()); 
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();

		}
		catch (Exception e)
		{
			bean = null;
			log.error(sql, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return bean;
	}
	
	public boolean delete(MemberInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try{
			conn = ConectionFactory.getConnection();
			
			sql = "update memberinfo set "
				+ "status=?, modifieddate=?, modifiedby=? "
				+ "where id = ?";
			
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setInt(count, StaticValueUtil.Delete); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, bean.getModifiedBy()); count++;
			
			pstm.setInt(count, bean.getId());
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			if( pstm.executeUpdate()>0){
				result = true;
			}	
		}
		catch (Exception e)
		{
			result = false;
			log.error(e);
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return result;
	}
	
	public MemberInfoBean getBeanById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		MemberInfoBean result = null;
		List<MemberInfoBean> list = new ArrayList<MemberInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from memberinfo where id= "+ id + " and status != " + StaticValueUtil.Delete ;

			pstmt = new LoggableStatement(conn, sql);

			rs = pstmt.executeQuery();
			
			list = getFromResultSet(rs);
			
			if(list.size() > 0) {
				result = list.get(0);
				//log.info("getSortGroupInfo : id = " + result.getId());
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
	
	public MemberInfoBean getBeanByIdPassword(String loginid, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		MemberInfoBean result = null;
		List<MemberInfoBean> list = new ArrayList<MemberInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from memberinfo where email = '"+ loginid + "' and password ='"+ password + "'" ;

			pstmt = new LoggableStatement(conn, sql);

			rs = pstmt.executeQuery();
			
			list = getFromResultSet(rs);
			
			if(list.size() > 0) {
				result = list.get(0);
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
	
	public List<MemberInfoBean> getListBySqlwhere(String sqlWhere){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<MemberInfoBean> result = new ArrayList<MemberInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from memberinfo "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getFromResultSet(rs);

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

	public List<MemberInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<MemberInfoBean> result = new ArrayList<MemberInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from memberinfo "+sqlWhere+" limit ?,?";

			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());

			rs = pstmt.executeQuery();

			result = getFromResultSet(rs);

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
			
			sql = "select count(*) as count from memberinfo "+sqlWhere; 
			
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
			
			//log.info(pstmt);
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

	private List<MemberInfoBean> getFromResultSet(ResultSet rs) throws Exception{

		List<MemberInfoBean> result = new ArrayList<MemberInfoBean>();
		while (rs != null && rs.next()){
			MemberInfoBean bean = new MemberInfoBean();
			bean.setId(rs.getInt("id"));
			bean.setTitle(rs.getString("title"));
			bean.setFirstname(rs.getString("firstname"));
			bean.setLastname(rs.getString("lastname"));
			bean.setEmail(rs.getString("email"));
			
			bean.setPhone(rs.getString("phone"));
			bean.setAddress1(rs.getString("address1"));
			bean.setAddress2(rs.getString("address2"));
			bean.setAddress3(rs.getString("address3"));
			bean.setPostcode(rs.getString("postcode"));
			
			bean.setState(rs.getString("state"));
			bean.setCountry(rs.getString("country"));
			bean.setPassword(rs.getString("password"));
			
			bean.setStatus(rs.getInt("status"));
			bean.setCreatedDate(rs.getTimestamp("createddate"));
			bean.setCreatedBy(rs.getString("createdby"));
			bean.setModifiedBy(rs.getString("modifiedby"));
			bean.setModifiedDate(rs.getTimestamp("modifieddate"));
			
			result.add(bean);
		}
		return result;
	}
	
	
}
