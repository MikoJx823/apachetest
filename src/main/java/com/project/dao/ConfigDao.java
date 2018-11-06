package com.project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.ConfigBean;
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

public class ConfigDao extends GenericDao{
	
	private static Logger log = Logger.getLogger(ConfigDao.class);
	private static ConfigDao instance = null;

	public static synchronized ConfigDao getInstance(){
		if (instance == null)
			instance = new ConfigDao();
		return instance;
	}

	public ConfigBean getBeanById(int id){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ConfigBean result = null;
		List<ConfigBean> list = new ArrayList<ConfigBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from config where id=" + id ;

			pstmt = new LoggableStatement(conn, sql);

			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			list = getConfigBeanFromResultSet(rs);
			
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
	
	public ConfigBean getBeanByName(String name){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ConfigBean result = null;
		List<ConfigBean> list = new ArrayList<ConfigBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from config where name ='" + name + "'";

			pstmt = new LoggableStatement(conn, sql);

			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			list = getConfigBeanFromResultSet(rs);
			
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
	
	public List<ConfigBean> getListBySqlwhere(String sqlWhere){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ConfigBean> result = new ArrayList<ConfigBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from config "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getConfigBeanFromResultSet(rs);
			
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
	
	private List<ConfigBean> getConfigBeanFromResultSet(ResultSet rs) throws Exception{

		List<ConfigBean> result = new ArrayList<ConfigBean>();
		while (rs != null && rs.next())
		{
			ConfigBean bean = new ConfigBean();
			bean.setId(rs.getInt("id"));
			bean.setName(rs.getString("name"));
			bean.setValue(rs.getString("value"));
			
			result.add(bean);
		}
		return result;
	}

}
