package db;

import java.io.IOException;

public class QueryLogger extends util.GenericLogger{
	
	private static final String filename = "querylog.log";
	private static QueryLogger logger = null;
	
	private QueryLogger(){
		super(filename);
	}
	
	public void logQuery(String query){
		try {
			bw.write("\n" + getTimestamp() + " | QUERY: " + query);
			bw.flush();
		} catch (IOException e) {
			System.err.println("unable write query to log");
			e.printStackTrace();
		}
	}
	
	public void logError(String msg){
		try {
			bw.write("\n" + getTimestamp() + "ERROR: " + msg);
		} catch (IOException e) {
			System.err.println("unable write query to log");
			e.printStackTrace();
		}
	}
	
	public void closeLogger(){
		try {
			this.bw.close();
		} catch (IOException e) {
			System.err.println("unable to close logger");
			e.printStackTrace();
		}
	}
	
	public static QueryLogger getInstance(){
		
		if(logger == null){
			logger = new QueryLogger();
		}
		
		return logger;
	}
}