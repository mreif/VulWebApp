package db;

import java.sql.ResultSet;
import java.util.ArrayList;

public abstract class TableQuery<T> {

	private QueryEngine queryEngine = null;
	
	private final String[] metadata;
	private final String table;
	
	public TableQuery(String[] metadata, String table){
		this.metadata = metadata;
		this.table = table;
		this.queryEngine = new QueryEngine();
	}
	
	public String getTable(){ return this.table; }
	public String[] getMetadata(){ return this.metadata; }
	
	public String getInsertTuple(){
		
		String result = metadata[1];
		for(int i = 2; i < metadata.length; i++){
			result += ", " + metadata[i];
		}
		
		return result;
	}
	
	public ResultSet executeQuery(String query){
		return this.queryEngine.queryDb(query);
	}
	
	public abstract ArrayList<T> getAll();
	
	public abstract void save(T element);
	
	public abstract T getById(String id);
	
	public abstract void printTable(ArrayList<T> rs);
}
