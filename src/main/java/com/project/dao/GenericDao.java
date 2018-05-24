package com.project.dao;

import java.lang.reflect.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

public class GenericDao
{

	private static Logger log = Logger.getLogger(GenericDao.class);

	public Timestamp getTimestamp(Date inputDate)
	{
		if (inputDate == null)
			return null;

		return new Timestamp(inputDate.getTime());
	}

	public String escapeInput(String in)
	{
		if (in == null)
			return null;

		String ans = "";
		String tmpS = "";
		String from = "'";
		String to = "''";
		StringTokenizer s = new StringTokenizer(in, from, true);
		while (s.hasMoreTokens())
		{
			tmpS = s.nextToken();
			if (tmpS.equals(from))
				ans += to;
			else
				ans += tmpS;
		}
		String out = ans.replaceAll("<", "&#60;");
		out = out.replaceAll(">", "&#62;");
		out = out.replaceAll("\"", " ");
		// out = out.replaceAll("&","&amp;");
		out = out.replaceAll("/", "&#x2F;");

		// ' --> &#x27; &apos; is not recommended
		return out;
	}

	public int queryForInt(String sqlcmd)
	{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int result = 0;
		try
		{

			//log.info("sqlcmd: " +sqlcmd);
			
			conn = ConectionFactory.getConnection();
			pstmt = conn.prepareStatement(sqlcmd);

			rs = pstmt.executeQuery();
			if (rs != null && rs.next())
			{
				result = rs.getInt(1);
			}

		}
		catch (Exception e)
		{
			log.error(sqlcmd, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}

		return result;

	}

	public List<String> queryForList(String sqlcmd)
	{

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<String> result = new ArrayList<String>();
		try
		{

			conn = ConectionFactory.getConnection();
			pstmt = conn.prepareStatement(sqlcmd);

			rs = pstmt.executeQuery();
			while (rs != null && rs.next())
			{
				result.add(rs.getString(1));
			}

		}
		catch (Exception e)
		{
			log.error(sqlcmd, e);
		}
		finally
		{
			DbClose.close(rs);
			DbClose.close(pstmt);
			DbClose.close(conn);
		}

		return result;

	}
	
	public List<Integer> queryForIntList(String sqlcmd){

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<Integer> result = new ArrayList<Integer>();
		try
		{

			conn = ConectionFactory.getConnection();
			pstmt = conn.prepareStatement(sqlcmd);

			rs = pstmt.executeQuery();
			while (rs != null && rs.next())
			{
				result.add(rs.getInt(1));
			}

		}
		catch (Exception e)
		{
			log.error(sqlcmd, e);
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
