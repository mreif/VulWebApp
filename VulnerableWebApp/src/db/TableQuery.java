package db;

import java.util.ArrayList;

public interface TableQuery<T> {

	public ArrayList<T> getAll();
	
	public void save(T element);
	
	public T getById(String id);
}
