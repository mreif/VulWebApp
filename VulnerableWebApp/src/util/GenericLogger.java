package util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Timestamp;

public class GenericLogger {

	protected BufferedWriter bw = null;
	
	public GenericLogger(String logfile){
		try {
			bw = new BufferedWriter(new FileWriter(logfile, true));
		} catch (IOException e) {
			System.err.println(getTimestamp() + " | File " + logfile + " doesn't exist!");
		}
	}
	
	public void logError(String msg){
		try {
			bw.write("\n" + getTimestamp() + " | ERROR: " + msg);
		} catch (IOException e) {
			System.err.println("unable write query to log");
			e.printStackTrace();
		}
	}
	
	protected String getTimestamp(){
		return new Timestamp(System.currentTimeMillis()).toString();
	}
	
	public void closeLogger(){
		try {
			this.bw.close();
		} catch (IOException e) {
			System.err.println("unable to close logger");
			e.printStackTrace();
		}
	}
}
