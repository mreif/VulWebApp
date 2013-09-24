package dao;

public class GiftEntry {

	public static final String[] metadata = { "id", "rating", "commentary", "gift_id" };
	
	private int id;
	private int rating;
	private String commentary;
	private int gift_id;
	
	public GiftEntry(int id, int rating, String commentary, int gift_id){
		this.id = id;
		this.rating = rating;
		this.commentary = commentary;
		this.gift_id = gift_id;
	}
	
	public int getId() { return this.id; }
	public int getRating() { return this.rating; }
	public String getCommentary() { return this.commentary; }
	public int getGiftId() { return this.gift_id; }
}
