package com.project.dao;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

public class ConectionFactory
{
	private static Logger log = Logger.getLogger(ConectionFactory.class);

	private static DataSource ds = null;
	private static Context initCtx = null;
	private static Context ctx = null;

	public static Connection getConnection() throws ClassNotFoundException, SQLException
	{
		Connection conn = null;
		try
		{
			if (ds == null)
			{
				initCtx = new InitialContext();
				ctx = (Context) initCtx.lookup("java:comp/env");
				if (ctx == null)
				{
					log.info("Cann't lookup 'java:comp/env'");
					return null;
				}
				ds = (DataSource) ctx.lookup("jdbc/root");
			}
			if (ds == null)
			{
				log.info("Cann't lookup 'jdbc/root'");

			}
			conn = ds.getConnection();
		} catch (NamingException e)
		{
			log.info(e);
		} catch (SQLException e)
		{
			log.info(e);
		}
		return conn;
	}

}
