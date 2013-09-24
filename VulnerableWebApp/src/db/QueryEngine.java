package db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class QueryEngine {
	
	private QueryLogger logger = null;
	private Connection conn = null;
	
	public QueryEngine(){
		logger = QueryLogger.getInstance();
		conn = DBConn.getDbConnection();
	}
	
	public ResultSet queryDb(String query) throws SQLException{
		
		Statement stmt = conn.createStatement();
		logger.logQuery(query);
		return stmt.executeQuery(query);
	}
}
