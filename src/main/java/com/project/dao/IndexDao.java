package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.IndexInfoBean;
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

public class IndexDao extends GenericDao{
	
	private static Logger log = Logger.getLogger(IndexDao.class);
	private static IndexDao instance = null;

	public static synchronized IndexDao getInstance(){
		if (instance == null)
			instance = new IndexDao();
		return instance;
	}

	public IndexInfoBean insert(IndexInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try{
			
			conn = ConectionFactory.getConnection();
			sql = "insert into indexinfo(" + 
				  "pid, type, seq, " +
				  "status, createddate, createdby " + 
				  ") values(" + 
				  "?,?,?, ?,?,?" +
				  ")";
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setInt(count,bean.getPid()); count++;
			pstm.setInt(count, bean.getType()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
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
	
	public IndexInfoBean update(IndexInfoBean bean){

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			sql = "update indexinfo set " + 
				  "pid=?, type=?, seq=?, " +
				  "status=?, modifieddate=?, modifiedby=? " + 
				  "where id = ? ";

			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setInt(count, bean.getPid()); count++;
			pstm.setInt(count, bean.getType()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
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
	
	public IndexInfoBean getBeanById(int id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		IndexInfoBean result = null;
		List<IndexInfoBean> list = new ArrayList<IndexInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from indexinfo where id=" + id + " and status != " + StaticValueUtil.Delete;

			pstmt = new LoggableStatement(conn, sql);

			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			list = getIndexInfoBeanFromResultSet(rs);
			
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
	
	public List<IndexInfoBean> getListBySqlwhere(String sqlWhere){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<IndexInfoBean> result = new ArrayList<IndexInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from indexinfo "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getIndexInfoBeanFromResultSet(rs);
			
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
	
	public List<IndexInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<IndexInfoBean> result = new ArrayList<IndexInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			sql = "select * from indexinfo "+sqlWhere+" limit ?,?";

			pstmt = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getIndexInfoBeanFromResultSet(rs);
			
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
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			
			sql = "select count(*) as count from indexinfo "+sqlWhere;
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
	
	private List<IndexInfoBean> getIndexInfoBeanFromResultSet(ResultSet rs) throws Exception{

		List<IndexInfoBean> result = new ArrayList<IndexInfoBean>();
		while (rs != null && rs.next())
		{
			IndexInfoBean bean = new IndexInfoBean();
			bean.setId(rs.getInt("id"));
			bean.setPid(rs.getInt("pid"));
			bean.setType(rs.getInt("type"));
			bean.setSeq(rs.getInt("seq"));
			
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
