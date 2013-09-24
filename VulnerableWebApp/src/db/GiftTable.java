package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.Gift;
import dao.Guestbookentry;

public class GiftTable extends TableQuery<Gift> {
	
	public GiftTable() {
		super(Gift.metadata, "gift");
	}

	@Override
	public ArrayList<Gift> getAll() {
		String query = String.format("SELECT * FROM %s;", this.getTable());
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		String name = null;
		String description = null;
		String picPath = null;

		Gift tmpGift= null;
		ArrayList<Gift> gifts = new ArrayList<Gift>();
		
		try {
			while(rs.next()){
				
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 4: picPath = data; break;
						case 3: description = data; break;
						case 2: name = data; break;
						case 1: element_id = new Integer(data).intValue(); break;
						default: break;
					}
				}
				tmpGift = new Gift(element_id, name, description, picPath);
				gifts.add(tmpGift);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("gift, getAll()");
		}
		
		return gifts;
	}

	@Override
	public void save(Gift gift) {
		String values = String.format("( '%s', '%s', '%s' );", gift.getName(), gift.getDescription(), gift.getPicturePath());
		String query = String.format("INSERT INTO %s ( %s ) VALUES %s",
				this.getTable(), this.getInsertTuple(), values);
		
		this.executeUpdate(query);	
		
	}

	@Override
	public Gift getById(String id) {
		String query = String.format("SELECT * FROM %s WHERE id=%s;", this.getTable(), id);
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		String name = null;
		String description = null;
		String picPath = null;

		Gift gift = null;
		
		try {
			while(rs.next()){
				
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 4: picPath = data; break;
						case 3: description = data; break;
						case 2: name = data; break;
						case 1: element_id = new Integer(data).intValue(); break;
						default: break;
					}
				}
				gift = new Gift(element_id, name, description, picPath);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("gift, getAll()");
		}
		
		return gift;
	}

	@Override
	public void printTable(ArrayList<Gift> entries) {
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < entries.size(); i++) {
			Gift gift = entries.get(i);
			buf.append(gift.getId() + "   |   " + gift.getName()
					+ "    |    " + gift.getDescription() + "    |    " + gift.getPicturePath() + "\n");
		}
		System.out.println(buf.toString());
		
	}

}
