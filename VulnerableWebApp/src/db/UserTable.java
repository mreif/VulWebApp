package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.User;

public class UserTable extends TableQuery<User> {
	
	public UserTable(){
		super(User.metadata, "user");
	}

	public ArrayList<User> getAll() {
		String query = String.format("SELECT * FROM %s;", this.getTable());
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		String username = null;
		String password = null;

		User user = null;
		ArrayList<User> users = new ArrayList<User>();
		
		try {
			while(rs.next()){
				
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 3: password = data; break;
						case 2: username = data; break;
						case 1: element_id = new Integer(data).intValue(); break;
						default: break;
					}
				}
				user = new User(element_id, username, password);
				users.add(user);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("user, getAll()");
		}
		
		return users;
	}

	public void save(User user) {
		String values = String.format("( '%s', '%s' );", user.getUsername(), user.getPassword());
		String query = String.format("INSERT INTO %s ( %s ) VALUES %s",
				this.getTable(), this.getInsertTuple(), values);
		
		this.executeUpdate(query);		
	}

	public User getById(String id) {
		String query = String.format("SELECT * FROM %s WHERE id=%s;", this.getTable(), id);
		ResultSet rs = this.executeQuery(query);
		
		int element_id = -1;
		String username = null;
		String password = null;

		User user = null;
		
		try {
			while(rs.next()){
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 3: password = data;
						case 2: username = data;
						case 1: element_id = new Integer(data).intValue();
					}
				}
				user = new User(element_id, username, password);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("user, getById()");
		}
		
		return user;
	}

	public void printTable(ArrayList<User> users) {
		
		StringBuffer buf = new StringBuffer();
		
		for(int i = 0; i < users.size(); i++){
			User cuser = users.get(i);
			buf.append(cuser.getId() + "   |   " + cuser.getUsername() + "    |    " + cuser.getPassword() + "\n");
		}
		System.out.println(buf.toString());
	}

}
