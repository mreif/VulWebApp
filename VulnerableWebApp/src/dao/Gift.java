package dao;

public class Gift {
	
	public static final String[] metadata = { "id", "name", "description", "needed_time", "materials" , "instructions", "picture_path" };
	
	private int id;
	private String name;
	private String description;
	private String needed_time;
	private String materials;
	private String instructions;
	private String picturePath;
	
	public Gift(int id, String name,
			String description,
			String needed_time, String materials,
			String instructions, String picturePath){
		this.id = id;
		this.name = name;
		this.description = description;
		this.needed_time = needed_time;
		this.materials = materials;
		this.instructions = instructions;
		this.picturePath = picturePath;
	}
	
	public int getId(){ return this.id;}
	public String getName(){ return this.name;}
	public String getDescription(){ return this.description;}
	public String getTime(){ return this.needed_time;}
	public String getMaterials(){ return this.materials;}
	public String getInstructions(){ return this.instructions;}
	public String getPicturePath(){ return this.picturePath;}
}
