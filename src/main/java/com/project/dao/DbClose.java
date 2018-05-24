package com.project.dao;

import java.sql.*;

import org.apache.log4j.Logger;

public class DbClose {
	private static Logger log = Logger.getLogger(DbClose.class);
	
	public static void close(ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				log.error("",e);
			}
		}
	}

	public static void close(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				log.error("",e);
			}
		}
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				log.error("",e);
			}
		}
	}
	public static void closeAll(ResultSet rs,PreparedStatement pstmt,Connection conn)
	{
		close(rs);
		close(pstmt);
		close(conn);
	}
	public static void rollback(Connection conn)
	{
		if (conn != null)
		{
			try
			{
				conn.rollback();
			}
			catch (Exception e)
			{
				log.error("", e);
			}
		}
	}
}
