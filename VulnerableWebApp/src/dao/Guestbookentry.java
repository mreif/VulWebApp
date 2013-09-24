package dao;

public class Guestbookentry {

	public static final String[] metadata = { "id", "name", "entry" };
	
	private int id;
	private String name;
	private String entry;
	
	public Guestbookentry(int id, String name, String entry){
		this.id = id;
		this.name = name;
		this.entry = entry;
	}
	
	public int getId(){ return this.id; }
	public String getName(){ return this.name; }
	public String getEntry(){ return this.entry; }
	
}
