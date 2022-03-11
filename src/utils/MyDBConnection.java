package utils;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MyDBConnection {
//	static final Logger logger = LogManager.getLogger();

	
	public final static  Connection getConnection()  {
		return getConnection("jdbc/db");
	}
	
	public final static  Connection getConnection(String dbConStr)  {
		Context     ctx  = null;
		DataSource  ds   = null;
		Connection  conn = null;
		
		try
		{
			ctx = new InitialContext();
			
			/*
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			Connection conn = ds.getConnection();
			*/
			
			ds = (DataSource) ctx.lookup("java:comp/env/" + dbConStr);
			if(ds == null) {
				System.out.println("MyDBConnection - DataSource is null");
				return null;
			} 
		
			conn = ds.getConnection();
			if( conn == null ) {
				System.out.println("MyDBConnection - connection is null");
				return null;
			}
			
		} catch(Exception e) {
			System.out.println("MyDBConnection - " + e.getMessage());
			try {  if(conn != null ) { conn.close(); } conn = null;   } catch(Exception en) {}
			
		} finally {
			
			try {  if(ds   != null ) {               } ds   = null;   } catch(Exception en) {}
			try {  if(ctx  != null ) { ctx.close();  } ctx  = null;   } catch(Exception en) {}

		}
		return conn;
	}
}
