package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.GiftEntry;
import dao.Guestbookentry;

public class GiftEntryTable extends TableQuery<GiftEntry> {

	public GiftEntryTable() {
		super(GiftEntry.metadata, "giftentry");
	}

	@Override
	public ArrayList<GiftEntry> getAll() {
		String query = String.format("SELECT * FROM %s;", this.getTable());
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		int rating = 0;
		String commentary = null;
		int gift_id = -1;
		
		GiftEntry giftEntry = null;
		ArrayList<GiftEntry> giftEntrys = new ArrayList<GiftEntry>();
		
		try {
			while(rs.next()){
				
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 4: gift_id = new Integer(data).intValue(); break;
						case 3: commentary = data; break;
						case 2: rating = new Integer(data).intValue(); break;
						case 1: element_id = new Integer(data).intValue(); break;
						default: break;
					}
				}
				giftEntry = new GiftEntry(element_id, rating, commentary, gift_id);
				giftEntrys.add(giftEntry);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("giftentry, getAll()");
		}
		
		return giftEntrys;
	}

	@Override
	public void save(GiftEntry gentry) {
		String values = String.format("( '%s', '%s', '%s' );", gentry.getRating(), gentry.getCommentary(), gentry.getGiftId());
		String query = String.format("INSERT INTO %s ( %s ) VALUES %s",
				this.getTable(), this.getInsertTuple(), values);
		
		this.executeUpdate(query);	
		
	}

	@Override
	public GiftEntry getById(String id) {
		String query = String.format("SELECT * FROM %s;", this.getTable());
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		int rating = 0;
		String commentary = null;
		int gift_id = -1;
		
		GiftEntry giftEntry = null;
		
		try {
			while(rs.next()){
				
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 4: gift_id = new Integer(data).intValue(); break;
						case 3: commentary = data; break;
						case 2: rating = new Integer(data).intValue(); break;
						case 1: element_id = new Integer(data).intValue(); break;
						default: break;
					}
				}
				giftEntry = new GiftEntry(element_id, rating, commentary, gift_id);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("giftentry, getById()");
		}
		
		return giftEntry;
	}

	@Override
	public void printTable(ArrayList<GiftEntry> entries) {
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < entries.size(); i++) {
			GiftEntry giftEntry = entries.get(i);
			buf.append(giftEntry.getId() + "   |   " + giftEntry.getRating()
					+ "    |    " + giftEntry.getCommentary() + "     |     " + giftEntry.getGiftId() + "\n");
		}
		System.out.println(buf.toString());
		
	}

}
