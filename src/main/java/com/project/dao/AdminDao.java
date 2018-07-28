package com.project.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.project.bean.AdminGroupFunction;
import com.project.bean.AdminInfoBean;
import com.project.bean.GroupInfoBean;
import com.project.bean.RightsInfoBean;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;
import com.project.util.StringUtil;


public class AdminDao extends GenericDao
{
	private static Logger log = Logger.getLogger(AdminDao.class);
	private static AdminDao instance = null;

	public static synchronized AdminDao getInstance()
	{
		if (instance == null)
			instance = new AdminDao();
		return instance;
	}
	public int getAdminQtyByGid( int gid)
	{
		String sqlcmd = "select count(aid) as qty from admininfo where gid="+gid;
		return queryForInt(sqlcmd);
	}
	public boolean delGroupInfoByGid(int gid)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "Delete from admingroupinfo where gid= ?";
			pstm = new LoggableStatement(conn, sql);
			pstm.setInt(1, gid);
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			if( pstm.executeUpdate()>0)
				result = true;
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
	public boolean delAdminInfoByAid(int aid)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "Delete from admininfo where aid= ?";
			pstm = new LoggableStatement(conn, sql);
			pstm.setInt(1, aid);
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			if( pstm.executeUpdate()>0)
				result = true;
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
	
	public boolean delAdminInfoByGid(int gid)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "Delete from admininfo where gId= ?";
			pstm = new LoggableStatement(conn, sql);
			pstm.setInt(1, gid);
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			if( pstm.executeUpdate()>0)
				result = true;
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
	public boolean delBranceByBid(int bid)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		boolean result = false;
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "Update brance set status="+StaticValueUtil.Delete+" where bid= ?";
			pstm = new LoggableStatement(conn, sql);
			pstm.setInt(1, bid);
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			if( pstm.executeUpdate()>0)
				result = true;
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
	public AdminInfoBean insertAdminInfoBean(AdminInfoBean bean)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			bean.setCreatedDate(now);
			bean.setUpdatedDate(now);
			conn = ConectionFactory.getConnection();
			sql = "insert into admininfo("
					+ "gId,"
					+ "bid,"
					+ "loginId,"
					+ "password,"
					+ "status,"
					+ "name,"
					+ "email,"
					+ "createdBy,"
					+ "createdDate,"
					+ "updatedBy,"
					+ "updatedDate"
					+ ")"
					+ " values("
					+ "?,?,?,?,?,?,?,?,?,?,?"
					+")";
			
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setInt(count, bean.getGid());
			count++;
			pstm.setInt(count, bean.getBid());
			count++;
			pstm.setString(count, bean.getLoginId());
			count++;
			pstm.setString(count, bean.getPassword());
			count++;
			pstm.setString(count, bean.getStatus());
			count++;
			pstm.setString(count, bean.getName());
			count++;
			pstm.setString(count, bean.getEmail());
			count++;
			pstm.setString(count, bean.getCreatedBy());
			count++;
			pstm.setTimestamp(count, new Timestamp(bean.getCreatedDate().getTime()));
			count++;
			pstm.setString(count, bean.getUpdatedBy());
			count++;
			pstm.setTimestamp(count, new Timestamp(bean.getUpdatedDate().getTime()));
			count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				int aid = rs.getInt(1);
				bean.setAid(aid);
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
	
	public static AdminGroupFunction addAdminGroupFunction(AdminGroupFunction adminGroupFunction,Connection conn)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			sql = "insert into adminrightsinfo (gid,fid,accessright,createddate,createdby) values(?,?,?,?,?)";
			pstmt = new LoggableStatement(conn, sql);

			pstmt.setInt(1, adminGroupFunction.getGid());
			pstmt.setInt(2, adminGroupFunction.getFid());
			pstmt.setString(3, adminGroupFunction.getAccessRight());
			pstmt.setTimestamp(4, new Timestamp(adminGroupFunction.getCreatedDate().getTime()));
			pstmt.setString(5, adminGroupFunction.getCreatedBy());

			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			int rows = pstmt.executeUpdate();
			if(rows<1)
			{
				return null;
			}
			log.info(pstmt);
		}
		catch (Exception e)
		{
			log.error(pstmt, e);
			return null;
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
		}
		return adminGroupFunction;
	}
	
	public GroupInfoBean addAdminGroup(GroupInfoBean adminGroup, List<AdminGroupFunction> adminFunctionList)
	{
		Connection conn = null;
		try
		{
			conn = ConectionFactory.getConnection();
			log.info("conn.setAutoCommit(false)");
			conn.setAutoCommit(false);
			boolean isSuccess = true;
			adminGroup = AdminDao.addAdminGroup(adminGroup);
			if(adminGroup.getGid()>0)
			{
				for(AdminGroupFunction function: adminFunctionList)
				{
					function.setGid(adminGroup.getGid());
					function = AdminDao.addAdminGroupFunction(function, conn);
					if(function == null)
					{
						isSuccess =false;
						break;
					}
				}
			}
			else
			{
				isSuccess =false;
			}
			if(isSuccess)
			{
				log.info("commit");
				conn.commit();
			}
			else
			{
				log.error("rollback");
				conn.rollback();
			}
		}
		catch (Exception e)
		{
			log.error(e);
		}
		finally
		{
			DbClose.close(conn);
		}
		return adminGroup;
		
	}
	
	public List<AdminGroupFunction> listAdminGroupFunctionByAGID(int agid){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		List<AdminGroupFunction> result = new ArrayList<AdminGroupFunction>();

		try{
			conn = ConectionFactory.getConnection();
			sql="select * from adminrightsinfo where gid=?";
			pstmt = new LoggableStatement(conn, sql);
			pstmt.setInt(1, agid);
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			rs=pstmt.executeQuery();
			
			result = getAdminGroupFunctionFromResultSet(rs);
			//log.info(pstmt);
		}catch(Exception e){
			log.error(pstmt,e);
		}finally{
			  DbClose.close(rs);
			  DbClose.close(pstmt);  
			  DbClose.close(conn);
		}
		return result;
	}
	
	private List<AdminGroupFunction> getAdminGroupFunctionFromResultSet(ResultSet rs) throws Exception{

		List<AdminGroupFunction> result = new ArrayList<AdminGroupFunction>();
		while (rs!=null && rs.next()){
			AdminGroupFunction bean = new AdminGroupFunction();
			bean.setGid(rs.getInt("gid"));
			bean.setFid(rs.getInt("fid"));
			bean.setAccessRight(rs.getString("accessright"));
			bean.setCreatedDate(rs.getTimestamp("createddate"));
			bean.setCreatedBy(rs.getString("createdby"));
			bean.setModifiedDate(rs.getTimestamp("modifieddate"));
			bean.setModifiedBy(rs.getString("modifiedby"));
			
			result.add(bean);
		}
		return result;
	
	}
	public static GroupInfoBean addAdminGroup(GroupInfoBean adminGroup)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";

		try
		{
			conn = ConectionFactory.getConnection();
			conn.setAutoCommit(false);

			sql = "insert into admingroupinfo("
				+ "groupName,"
				+ "description,"
				+ "status,"
				+ "createddate,"
				+ "createdby"							
				+ ")"
				+ " values("
				+ "?,?,?,?,?"
				+")";
			
            pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstm.setString(count, adminGroup.getGroupName());
			count++;
			pstm.setString(count, adminGroup.getDescription());
			count++;
			pstm.setInt(count, StaticValueUtil.Active);
			count++;
			pstm.setTimestamp(count, new Timestamp(adminGroup.getCreatedDate().getTime()));
			count++;
			pstm.setString(count, adminGroup.getCreatedBy());
			count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
		
			if (rs != null && rs.next())
			{
				adminGroup.setGid(rs.getInt(1));
			}
			log.info(pstm);
			conn.commit();
		}
		
		catch (Exception e)
		{
			log.error(pstm, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstm);
		}
		return adminGroup;
	}

	
/*	
	public GroupInfoBean insertGroupInfoBean(GroupInfoBean groupBean,List<RightsInfoBean> rightsList)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";

		try
		{
			conn = ConectionFactory.getConnection();
			conn.setAutoCommit(false);

			
			sql = "insert into admingroupinfo("
					+ "groupName,"
					+ "description"
					+ ")"
					+ " values("
					+ "?,?,?"
					+")";
			
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			pstm.setString(count, groupBean.getGroupName());
			count++;
			pstm.setString(count, groupBean.getDescription());
			count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			int gid = -1;
			if (rs.next())
			{
				gid = rs.getInt(1);
			}
			for(RightsInfoBean rightsBean : rightsList)
			{
				sql = "insert into grouprightsinfo("
						+ "gId,"
						+ "rId"
						+ ")"
						+ " values("
						+ "?,?"
						+")";
				pstm = new LoggableStatement(conn, sql);
				count = 1;
				pstm.setInt(count, gid );
				count++;
				pstm.setInt(count, rightsBean.getRid());
				count++;
				
				
				log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
				
				pstm.executeUpdate();
				rs = ((LoggableStatement) pstm).getGeneratedKeys();
				if (rs.next())
				{
					int oiid = rs.getInt(1);
					log.info("insert group rights oiid:"+oiid);
				}
			}
			
			conn.commit();
			         
		}
		catch (Exception e)
		{
			groupBean = null;
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
		
		return groupBean;
	}
	
	*/
	/*
	public GroupInfoBean updateGroupInfoBean(GroupInfoBean groupBean,List<RightsInfoBean> rightsList)
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		
		try
		{
			conn = ConectionFactory.getConnection();
			conn.setAutoCommit(false);
			
			
			sql = "update admingroupinfo set "
					+ "groupName=?, "
					+ "description=? "
					+ " where "
					+ " gid=?";
			
			
			pstm = new LoggableStatement(conn, sql);
			
			int count = 1;
			
			pstm.setString(count, groupBean.getGroupName());
			count++;
			pstm.setString(count, groupBean.getDescription());
			count++;
			pstm.setInt(count, groupBean.getGid());
			count++;
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			
			sql = "Delete from grouprightsinfo where gid=?";
			pstm = new LoggableStatement(conn, sql);
			count = 1;
			pstm.setInt(count, groupBean.getGid() );
			
			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			for(RightsInfoBean rightsBean : rightsList)
			{
				
				
				sql = "insert into grouprightsinfo("
						+ "gId,"
						+ "rId"
						+ ")"
						+ " values("
						+ "?,?"
						+")";
				pstm = new LoggableStatement(conn, sql);
				count = 1;
				pstm.setInt(count, groupBean.getGid() );
				count++;
				pstm.setInt(count, rightsBean.getRid());
				count++;
				
				log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
				
				pstm.executeUpdate();
				rs = ((LoggableStatement) pstm).getGeneratedKeys();
				if (rs.next())
				{
					int oiid = rs.getInt(1);
					log.info("insert group rights oiid:"+oiid);
				}
			}
			
			conn.commit();
			
		}
		catch (Exception e)
		{
			groupBean = null;
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
		
		return groupBean;
	}
	
	*/
	public AdminInfoBean updateAdminInfoBean(AdminInfoBean admin)
	{

		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			Date now = new Date();
			admin.setUpdatedDate(now);
			sql = "update admininfo set " + " gid=?,"+ " bid=?," + " loginId=?," + " password=?," + " status=?," + " name=?," + " email=?," + " createdBy=?," + " createdDate=?," + " updatedBy=?,"
					+ " updatedDate=?," + " lastLoginDate=? " + " where aid = ?";

			conn = ConectionFactory.getConnection();
			pstm = new LoggableStatement(conn, sql);
			int count = 1;

			pstm.setInt(count, admin.getGid());
			count++;
			pstm.setInt(count, admin.getBid());
			count++;
			pstm.setString(count, admin.getLoginId());
			count++;
			pstm.setString(count, admin.getPassword());
			count++;
			pstm.setString(count, admin.getStatus());
			count++;
			pstm.setString(count, admin.getName());
			count++;
			pstm.setString(count, admin.getEmail());
			count++;
			pstm.setString(count, admin.getCreatedBy());
			count++;
			pstm.setTimestamp(count, new Timestamp(admin.getCreatedDate().getTime()));
			count++;
			pstm.setString(count, admin.getUpdatedBy());
			count++;
			pstm.setTimestamp(count, new Timestamp(admin.getUpdatedDate().getTime()));
			count++;
			pstm.setTimestamp(count, admin.getLastLoginDate()==null?null:new Timestamp(admin.getLastLoginDate().getTime()));
			count++;
			pstm.setInt(count, admin.getAid());

			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());

			pstm.executeUpdate();

		}
		catch (Exception e)
		{
			admin = null;
			log.error(sql, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstm);
			DbClose.close(conn);

		}
		return admin;
	}

	public List<AdminInfoBean> getAdminInfoBeanListBySqlwhere(String sqlWhere)
	{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<AdminInfoBean> result = new ArrayList<AdminInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from admininfo "+sqlWhere;

			pstmt = new LoggableStatement(conn, sql);
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());

			rs = pstmt.executeQuery();

			result = getAdminInfoBeanFromResultSet(rs);
			
			log.info("getAdminInfoBeanList size:" + result.size());

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
	
	public List<AdminInfoBean> getListBySqlwhereWithPage(String sqlWhere, int pageIdx)
	{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int pagingRows = 10;
		List<AdminInfoBean> result = new ArrayList<AdminInfoBean>();
		try
		{	
			//pagingRows = StringUtil.strToInt(PropertiesUtil.getProperty("pagingRows"));
			
			conn = ConectionFactory.getConnection();
			sql = "select * from admininfo "+sqlWhere + " order by aid desc limit ?,?";
			
			pstmt = new LoggableStatement(conn, sql);
			int count = 1;
			pstmt.setInt(count, pagingRows * (pageIdx-1));
			count ++;
			pstmt.setInt(count, pagingRows);
			
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());

			rs = pstmt.executeQuery();

			result = getAdminInfoBeanFromResultSet(rs);
			
			log.info("getAdminInfoBeanList size:" + result.size());

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

	/*
	public List<String> getGroupRightsList(int gid)
	{
		String sql = "select r.rightsCode from grouprightsinfo gr inner join adminrightsinfo r on gr.rid=r.rid where gr.gid="+gid;
		return queryForList(sql);
	}
	*/
	public List<GroupInfoBean> getGroupListBySqlwhere(String sqlWhere)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<GroupInfoBean> result = new ArrayList<GroupInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from admingroupinfo "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);
			
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();

			result = getGroupInfoBeanFromResultSet(rs);
			log.info("getGroupList size:"+result.size());

		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	

	
	public List<RightsInfoBean> getRightsListBySqlwhere(String sqlWhere)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<RightsInfoBean> result = new ArrayList<RightsInfoBean>();
		try
		{
			conn = ConectionFactory.getConnection();
			sql = "select * from adminrightsinfo "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);
			
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			
			rs = pstmt.executeQuery();
			
			result = getRightsInfoBeanFromResultSet(rs);
			log.info("getGroupList size:"+result.size());
			
		} catch (Exception e)
		{
			log.error(sql, e);
		} finally
		{
			DbClose.closeAll(rs, pstmt, conn);
		}
		return result;
	}
	
	private List<AdminInfoBean> getAdminInfoBeanFromResultSet(ResultSet rs) throws Exception
	{

		List<AdminInfoBean> result = new ArrayList<AdminInfoBean>();
		while (rs != null && rs.next())
		{
			AdminInfoBean bean = new AdminInfoBean();
			bean.setAid(rs.getInt("aid"));
			bean.setGid(rs.getInt("gid"));
			bean.setBid(rs.getInt("bid"));
			bean.setLoginId(rs.getString("loginId"));
			bean.setPassword(rs.getString("password"));
			bean.setName(rs.getString("name"));
			bean.setStatus(rs.getString("status"));
			bean.setEmail(rs.getString("email"));
			bean.setCreatedBy(rs.getString("createdBy"));
			bean.setCreatedDate(rs.getTimestamp("createdDate"));
			bean.setUpdatedBy(rs.getString("updatedBy"));
			bean.setUpdatedDate(rs.getTimestamp("updatedDate"));
			bean.setLastLoginDate(rs.getTimestamp("lastLoginDate"));

			result.add(bean);
		}
		return result;
	}
	private List<GroupInfoBean> getGroupInfoBeanFromResultSet(ResultSet rs) throws Exception
	{

		List<GroupInfoBean> result = new ArrayList<GroupInfoBean>();
		while (rs != null && rs.next())
		{
			GroupInfoBean bean = new GroupInfoBean();
			bean.setGid(rs.getInt("gid"));
			bean.setGroupName(rs.getString("groupName"));
			bean.setDescription(rs.getString("description"));

			result.add(bean);
		}
		return result;
	}
	private List<RightsInfoBean> getRightsInfoBeanFromResultSet(ResultSet rs) throws Exception
	{
		
		List<RightsInfoBean> result = new ArrayList<RightsInfoBean>();
		while (rs != null && rs.next())
		{
			RightsInfoBean bean = new RightsInfoBean();
			bean.setRid(rs.getInt("rid"));
			bean.setRightsCode(rs.getString("rightsCode"));
			bean.setRightsDesc(rs.getString("rightsDesc"));
			
			result.add(bean);
		}
		return result;
	}
	
	public GroupInfoBean updateAdminGroup(GroupInfoBean adminGroup, List<AdminGroupFunction> adminFunctionList)
	{
		Connection conn = null;
		try
		{
			conn = ConectionFactory.getConnection();
			log.info("conn.setAutoCommit(false)");
			conn.setAutoCommit(false);
			boolean isSuccess = true;
			adminGroup = AdminDao.updateAdminGroup(adminGroup,conn);
			if(adminGroup!=null)
			{
				 if (AdminDao.deleteAdminGroupFunctionByAgid(adminGroup.getGid(),conn)<0)
				 {
					 isSuccess =false;
				 }
				 else
				 {
					 for(AdminGroupFunction function: adminFunctionList)
						{
							function.setGid(adminGroup.getGid());
							function = AdminDao.addAdminGroupFunction(function, conn);
							if(function == null)
							{
								isSuccess =false;
								break;
							}
						}
				 }
				
			}
			else
			{
				isSuccess =false;
			}
			if(isSuccess)
			{
				log.info("commit");
				conn.commit();
			}
			else
			{
				log.error("rollback");
				conn.rollback();
				adminGroup = null;
			}
		}
		catch (Exception e)
		{
			log.error(e);
			adminGroup = null;
		}
		finally
		{
			DbClose.close(conn);
		}
		return adminGroup;
		
	}
	
	public static GroupInfoBean updateAdminGroup(GroupInfoBean adminGroup,Connection conn)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try
		{
			sql = "update admingroupinfo set `groupName`=?,`description`=?,modifieddate=?,modifiedby=? where gid=? ";

			pstmt = new LoggableStatement(conn, sql);

			pstmt.setString(1, adminGroup.getGroupName());
			pstmt.setString(2, adminGroup.getDescription());
			pstmt.setTimestamp(3, new Timestamp(adminGroup.getModifiedDate().getTime()));
			pstmt.setString(4, adminGroup.getModifiedBy());
			pstmt.setInt(5, adminGroup.getGid());
			
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			pstmt.executeUpdate();

		}
		catch (Exception e)
		{
			log.error(pstmt, e);
			return null;
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
		}
		return adminGroup;
	}
	
	public static int deleteAdminGroupFunctionByAgid(int gid,Connection conn)
	{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int result = 0;
		try
		{
			sql = "delete from adminrightsinfo where gid=? ";

			pstmt = new LoggableStatement(conn, sql);

			pstmt.setInt(1, gid);
			
			log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			result = pstmt.executeUpdate();

		}
		catch (Exception e)
		{
			log.error(pstmt, e);
			result =  -1;
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
		}
		return result;
	}
	
	public int getUserTotalPages(int pageIdx,String sqlWhere){
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
			
			sql = "select count(*) as count from admininfo "+sqlWhere;
			pstmt = new LoggableStatement(conn, sql);	
			
			//log.info("Executing SQL:" + ((LoggableStatement) pstmt).getQueryString());
			//log.info("Executing SQL:" + sql);
			
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
			
			//log.info(" getTotalpage : " + result) ;
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
	
}
