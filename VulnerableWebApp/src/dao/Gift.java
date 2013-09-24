package dao;

public class Gift {
	
	public static final String[] metadata = { "id", "name", "description", "picture_path" };
	public static final String table = "gift";
	
	private int id;
	private String name;
	private String description;
	private String picturePath;
	
	public Gift(int id, String name,
			String description, String picturePath){
		this.id = id;
		this.name = name;
		this.description = description;
		this.picturePath = picturePath;
	}
	
	public int getId(){ return this.id;}
	public String getName(){ return this.name;}
	public String getDescription(){ return this.description;}
	public String getPicturePath(){ return this.picturePath;}
}
