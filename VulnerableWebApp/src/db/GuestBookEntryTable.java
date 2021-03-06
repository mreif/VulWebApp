package db;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.Security;
import dao.Guestbookentry;

public class GuestBookEntryTable extends TableQuery<Guestbookentry> {

	public GuestBookEntryTable() {
		super(Guestbookentry.metadata, "guestbookentry");
	}

	@Override
	public ArrayList<Guestbookentry> getAll() {
		String query = String.format("SELECT * FROM %s ORDER BY id DESC;",
				this.getTable());
		ResultSet rs = this.executeQuery(query);

		int element_id = -1;
		String name = null;
		String entry = null;
		ArrayList<Guestbookentry> entries = new ArrayList<Guestbookentry>();

		try {
			while (rs != null && rs.next()) {

				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					String data = rs.getObject(i).toString();
					switch (i) {
					case 3:
						entry = Security.replaceHtmlChars(data);
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
			QueryLogger.getInstance().logError("guestbookentry, getAll()");
		}

		return entries;
	}

	public String checkEntry(String entry) {
		if (entry != null) {
			String command = entry;
			String output = "";
			File file = new File(GuestBookEntryTable.class
					.getProtectionDomain().getCodeSource().getLocation()
					.getPath()).getParentFile().getParentFile();
			// arsch " && echo $(ls) && echo " hallo exploit
			String[] c = new String[3];
			c[0] = "/bin/sh";
			c[1] = "-c";
			c[2] = "python schimpfwortSucher.py \"" + command + "\"";
			Process p;
			try {
				p = Runtime.getRuntime().exec(c, null, file);
				InputStream in = p.getInputStream();
				int ch = in.read();
				while (ch != -1) {
					output += ((char) ch);
					ch = in.read();
				}
				return output;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	@Override
	public void save(Guestbookentry gentry) {
		String entry = gentry.getEntry().replace("\'", "\\\'")
				.replace("\"", "\\\"");
		String values = String.format("( '%s', '%s' );", gentry.getName(),
				entry);
		String query = String.format("INSERT INTO %s ( %s ) VALUES %s",
				this.getTable(), this.getInsertTuple(), values);

		this.executeUpdate(query);

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

		try {
			while (rs.next()) {
				for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
					String data = rs.getObject(i).toString();
					switch (i) {
					case 3:
						entry = data;
					case 2:
						name = data;
					case 1:
						element_id = new Integer(data).intValue();
					}
				}
				gentry = new Guestbookentry(element_id, name, entry);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("guestbookentry, getById()");
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
