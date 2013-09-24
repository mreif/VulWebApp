package util;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class GenericLogger {

	private BufferedWriter bw = null;
	
	public GenericLogger(String logfile){
		try {
			bw = new BufferedWriter(new FileWriter(logfile, true));
		} catch (IOException e) {
			System.err.println("File " + logfile + " doesn't exist!");
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
}
