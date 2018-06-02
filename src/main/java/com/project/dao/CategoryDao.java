package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.CategoryBean;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;

/*Function : 
 * Add
 * Edit
 * Get single by id 
 * Get List by sql, 
 * Get List by sql with page 
 * Get list by parent id
 * Get total page
 * 
 * */

public class CategoryDao extends GenericDao{
	
	private static Logger log = Logger.getLogger(CategoryDao.class);
	private static CategoryDao instance = null;

	public static synchronized CategoryDao getInstance(){
		if (instance == null)
			instance = new CategoryDao();
		return instance;
	}

	public CategoryBean insert(CategoryBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{
			
			conn = ConectionFactory.getConnection();
			sql = "insert into category("			
					+ "name, desc, parentid, image, seq, "
					+ "tag, "
					+ "status, createddate, createdby "
					+ ") values("
					+ "?,?,?,?,?, ?, ?,?,?"
					+")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setString(count,bean.getName()); count++;
			pstm.setString(count, bean.getDesc()); count++;
			pstm.setInt(count, bean.getParentId()); count++;
			pstm.setString(count, bean.getImage()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
			pstm.setInt(count, bean.getTag()); count++;
			
			pstm.setInt(count, bean.getStatus()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, bean.getCreatedBy()); count++;
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				int id = rs.getInt(1);
				bean.setId(id);
			}
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
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
	
	public CategoryBean update(CategoryBean bean){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			sql = "update category set "
				+ "name=?, desc=?, parentid=?, image=?, seq=?,"
				+ "tag=?, "
				+ "status=?, modifieddate=?, modifiedby=? "
				+ "where id = ? ";

			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setString(count, bean.getName()); count++;
			pstm.setString(count, bean.getDesc()); count++;
			pstm.setInt(count, bean.getParentId()); count++;
			pstm.setString(count, bean.getImage()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
			pstm.setInt(count, bean.getTag()); count++;
			
			pstm.setInt(count, bean.getStatus()); count++;
			pstm.setTimestamp(count, getTimestamp(new Date())); count++;
			pstm.setString(count, bean.getModifiedBy()); count++;
			
			pstm.setInt(count, bean.getId());
			
			log.info("Executing SQL: " + ((LoggableStatement) pstm).getQueryString());
				
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
	
	public CategoryBean getBeanById(int id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		CategoryBean result = null;
		List<CategoryBean> list = new ArrayList<CategoryBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from category where id=" + id + " and status != " + StaticValueUtil.Delete;

			pstmt = new LoggableStatement(conn, sql);

			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			list = getCategoryBeanFromResultSet(rs);
			
			if(list.size() > 0) {
				result = list.get(0);
			}			
		}
		catch (Exception e)
		{
			log.error(sql, e);
			result = null;
		}
		finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	public List<CategoryBean> getListBySqlwhere(String sqlWhere){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<CategoryBean> result = new ArrayList<CategoryBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from category "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getCategoryBeanFromResultSet(rs);
			
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
	
	public List<CategoryBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<CategoryBean> result = new ArrayList<CategoryBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			sql = "select * from category "+sqlWhere+" limit ?,?";

			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getCategoryBeanFromResultSet(rs);
			
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
	
	public List<CategoryBean> getFrontMenuBySqlwhere(String sqlWhere){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<CategoryBean> result = new ArrayList<CategoryBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select id, parentid, name, tag, seq, status from category "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			//result = getCategoryBeanFromResultSet(rs);
			
			while (rs != null && rs.next())
			{
				CategoryBean bean = new CategoryBean();
				bean.setId(rs.getInt("id"));
				bean.setParentId(rs.getInt("parentid"));
				bean.setName(rs.getString("name"));
				bean.setSeq(rs.getInt("seq"));
				bean.setTag(rs.getInt("tag"));
				
				bean.setStatus(rs.getInt("status"));
				
				result.add(bean);
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
	
	public int getTotalPages(int pageIdx,String sqlWhere)
	{
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
			
			sql = "select count(*) as count from category "+sqlWhere;
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
	
	public int getFrontCategoryBeanTotalPages(int pageIdx,String sqlWhere){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			//if(pageIdx == 1) pagingRows = 6;
			//else pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front"));
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front"));
			
			sql = "select count(*) as count from category "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("count");
				
				
				/*if (result % pagingRows == 0)
				{
					result = result / pagingRows;
				}
				else
				{
					result = result / pagingRows + 1;
				}*/
				
				if(result > pagingRows - 1) {
					result -= pagingRows - 1; // for first page
					
					if (result % pagingRows == 0){
						result = result / pagingRows;
					}else{
						result = result / pagingRows + 1;
					}
					
					result += 1;
				}else {
					result = 1;
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
	
	private List<CategoryBean> getCategoryBeanFromResultSet(ResultSet rs) throws Exception{

		List<CategoryBean> result = new ArrayList<CategoryBean>();
		while (rs != null && rs.next())
		{
			CategoryBean bean = new CategoryBean();
			bean.setId(rs.getInt("id"));
			bean.setParentId(rs.getInt("parentid"));
			bean.setName(rs.getString("name"));
			bean.setDesc(rs.getString("desc"));
			bean.setImage(rs.getString("image"));
			
			bean.setSeq(rs.getInt("seq"));
			bean.setTag(rs.getInt("tag"));
			
			bean.setStatus(rs.getInt("status"));
			bean.setCreatedDate(rs.getTimestamp("createddate"));
			bean.setCreatedBy(rs.getString("createdby"));
			bean.setModifiedDate(rs.getTimestamp("modifieddate"));
			bean.setModifiedBy(rs.getString("modifiedby"));
			
			result.add(bean);
		}
		return result;
	}
	
	

}
