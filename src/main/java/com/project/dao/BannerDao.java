package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.BannerInfoBean;
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
public class BannerDao extends GenericDao{
	
	private static Logger log = Logger.getLogger(BannerDao.class);
	private static BannerDao instance = null;

	public static synchronized BannerDao getInstance()
	{
		if (instance == null)
			instance = new BannerDao();
		return instance;
	}
	
	public BannerInfoBean insert(BannerInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			bean.setCreatedDate(now);	

			conn = ConectionFactory.getConnection();
			sql = "insert into bannerinfo("			
					+ "name, link, position, image, seq,"
					+ "status, createddate, createdby "
					+ ") values("
					+ "?,?,?,?,?, ?,?,? "
					+")";
			
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;

			pstm.setString(count, bean.getName()); count++;
			pstm.setString(count, bean.getLink()); count++;
			pstm.setInt(count, bean.getPosition()); count++;
			pstm.setString(count, bean.getImage()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
			pstm.setInt(count, bean.getStatus()); count++;
			pstm.setTimestamp(count, getTimestamp(bean.getCreatedDate())); count++;
			pstm.setString(count, bean.getCreatedBy()); count++;
			
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
	
	public BannerInfoBean update(BannerInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			bean.setModifiedDate(now); 
			
			sql = "update bannerinfo set "
				+ "name=?, link=?, position=?, image=?, seq=?,"
				+ "status=?, modifieddate=?, modifiedby=? "
				+ "where id = ?";

			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;
			
			pstm.setString(count, bean.getName()); count++;
			pstm.setString(count, bean.getLink()); count++;
			pstm.setInt(count, bean.getPosition()); count++;
			pstm.setString(count, bean.getImage()); count++;
			pstm.setInt(count, bean.getSeq()); count++;
			
			pstm.setInt(count, bean.getStatus()); count++;
			pstm.setTimestamp(count, getTimestamp(bean.getModifiedDate())); count++;
			pstm.setString(count, bean.getModifiedBy()); count++;
			
			pstm.setInt(count, bean.getId()); 
			
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
	
	public boolean delete(BannerInfoBean bean){
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try{
			conn = ConectionFactory.getConnection();
			
			sql = "update bannerinfo set "
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
	
	public BannerInfoBean getBeanById(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		BannerInfoBean result = null;
		List<BannerInfoBean> list = new ArrayList<BannerInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from bannerinfo where id= "+ id + " and status != " + StaticValueUtil.Delete ;

			pstmt = new LoggableStatement(conn, sql);
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());

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
	
	public List<BannerInfoBean> getListBySqlwhere(String sqlWhere){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<BannerInfoBean> result = new ArrayList<BannerInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from bannerinfo "+sqlWhere;

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

	public List<BannerInfoBean> getListBySqlwhereWithPage(String sqlWhere,int pageIdx){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<BannerInfoBean> result = new ArrayList<BannerInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			sql = "select * from bannerinfo "+sqlWhere+" limit ?,?";

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

	public int getTotalItems(String sqlWhere, String type){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		try
		{
			conn = ConectionFactory.getConnection();
			pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows.front.web"));
			
			sql = "select count(*) as count from bannerinfo "+sqlWhere;
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
			
			sql = "select count(*) as count from bannerinfo "+sqlWhere; 
			
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

	private List<BannerInfoBean> getFromResultSet(ResultSet rs) throws Exception{

		List<BannerInfoBean> result = new ArrayList<BannerInfoBean>();
		while (rs != null && rs.next()){
			BannerInfoBean bean = new BannerInfoBean();
			bean.setId(rs.getInt("id"));
			bean.setName(rs.getString("name"));
			bean.setLink(rs.getString("link"));
			bean.setPosition(rs.getInt("position"));
			bean.setImage(rs.getString("image"));
			
			bean.setSeq(rs.getInt("seq"));

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
