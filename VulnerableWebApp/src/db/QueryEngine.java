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
	
	public ResultSet queryDb(String query){
		
		Statement stmt;
		try {
			stmt = conn.createStatement();
			logger.logQuery(query);
			return stmt.executeQuery(query);
		} catch (SQLException s) {
			String msg = s.getMessage() 
					+ "\n\n SQLState: " 
					+ s.getSQLState()
					+ "\n\n ErrorCode: "
					+ s.getErrorCode();
			System.err.println(msg);
			logger.logError(msg);
		}
		
		return null;
	}
	
	public ResultSet select(String selection, String table, String condition){
		String query = "SELECT " + selection 
				+ " FROM " + table;
		if(condition != null && !condition.isEmpty()){
			query += " ";
			query += condition + ";";
		}
		
		return queryDb(query);
	}
	
	public void printResultSet(ResultSet rs){
		
		StringBuffer buf = new StringBuffer();
		try {
		while(rs.next()){
			for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
				buf.append("COLUMN " + i + " = " + rs.getObject(i) + "\n");
			}
		}
		}catch(SQLException s){
			String msg = s.getMessage() 
					+ "\n\n SQLState: " 
					+ s.getSQLState()
					+ "\n\n ErrorCode: "
					+ s.getErrorCode();
			System.err.println(msg);
			logger.logError(msg);
		}
		System.out.println(buf.toString());
	}
}
