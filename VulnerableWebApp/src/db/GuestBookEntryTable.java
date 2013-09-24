package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.Guestbookentry;

public class GuestBookEntryTable extends TableQuery<Guestbookentry> {

	public GuestBookEntryTable() {
		super(Guestbookentry.metadata, "guestbookentry");
	}

	@Override
	public ArrayList<Guestbookentry> getAll() {
		String query = String.format("SELECT * FROM %s;", this.getTable());
		ResultSet rs = this.executeQuery(query);

		int element_id = -1;
		String name = null;
		String entry = null;
		ArrayList<Guestbookentry> entries = new ArrayList<Guestbookentry>();

		try {
			while (rs.next()) {

				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					String data = rs.getObject(i).toString();
					switch (i) {
					case 3:
						entry = data;
						break;
					case 2:
						name = data;
						break;
					case 1:
						element_id = new Integer(data).intValue();
						break;
					default:
						break;
					}
				}
				Guestbookentry gentry = new Guestbookentry(element_id, name,
						entry);
				entries.add(gentry);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return entries;
	}

	@Override
	public void save(Guestbookentry element) {
		// TODO Auto-generated method stub

	}

	@Override
	public Guestbookentry getById(String id) {
		String query = String.format("SELECT * FROM %s WHERE id=%s;",
				this.getTable(), id);
		ResultSet rs = this.executeQuery(query);

		int element_id = -1;
		String name = null;
		String entry = null;
		Guestbookentry gentry = null;
		int metalen = this.getMetadata().length;

		try {
			while (rs.next()) {
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					int r = i % metalen;
					String data = rs.getObject(i).toString();
					switch (r) {
					case 0:
						entry = data;
					case 1:
						name = data;
					case 2:
						element_id = new Integer(data).intValue();
					}
				}
				gentry = new Guestbookentry(element_id, name, entry);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return gentry;
	}

	@Override
	public void printTable(ArrayList<Guestbookentry> entries) {
		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < entries.size(); i++) {
			Guestbookentry cuser = entries.get(i);
			buf.append(cuser.getId() + "   |   " + cuser.getName()
					+ "    |    " + cuser.getEntry() + "\n");
		}
		System.out.println(buf.toString());

	}

}
