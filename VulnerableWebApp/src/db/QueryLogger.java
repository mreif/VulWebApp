package db;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class QueryLogger{
	
	private static final String filename = "querylog.txt";
	private static QueryLogger logger = null;
	
	private BufferedWriter bw = null;
	
	private QueryLogger(){
		try {
			bw = new BufferedWriter(new FileWriter(filename, true));
		} catch (IOException e) {
			System.err.println("File " + filename + " doesn't exist!");
		}
	}
	
	public void logQuery(String query){
		try {
			bw.write("\nQUERY: " + query);
			bw.flush();
		} catch (IOException e) {
			System.err.println("unable write query to log");
			e.printStackTrace();
		}
	}
	
	public void logError(String msg){
		try {
			bw.write("\nERROR: " + msg);
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