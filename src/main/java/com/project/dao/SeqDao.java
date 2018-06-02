package com.project.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;


public class SeqDao extends GenericDao
{
	private static Logger log = Logger.getLogger(SeqDao.class);
	private static SeqDao instance = null;

	public static synchronized SeqDao getInstance()
	{
		if (instance == null)
			instance = new SeqDao();
		return instance;
	}
	

	
	public int getSeqid()
	{
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String sql = "";
		
		int seqId = -1;
		
		try
		{
		
			conn = ConectionFactory.getConnection();
			sql = "insert into seqno values (null)";
					
			
			pstm = new LoggableStatement(conn, sql);

			
			log.info("Executing SQL:" + ((LoggableStatement) pstm).getQueryString());
			
			pstm.executeUpdate();
			rs = ((LoggableStatement) pstm).getGeneratedKeys();
			
			if (rs.next())
			{
				seqId= rs.getInt(1);
				
			}
			
		}
		catch (Exception e)
		{
			
			log.error(e);
		}
		finally
		{
			DbClose.closeAll(rs, pstm, conn);
		}
		return seqId;
	}
	



}
