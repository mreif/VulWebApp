package db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.Security;
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
		String query = String.format("SELECT * FROM %s WHERE id='%s';", this.getTable(), id);
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
						case 3: password = data; break;
						case 2: username = data; break;
						case 1: element_id = new Integer(data).intValue(); break;
					}
				}
				user = new User(element_id, username, password);
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("user, getById()");
		}
		
		return user;
	}
	
	/**
	 * Validates user for login.
	 * @param user to validate
	 * @return 0 if exists
	 * 		   1 if username is incorrect
	 * 	  	   2 if password is incorrect
	 */
	public int validateUser(String name, String unhashedPassword){
		
		String query = String.format("SELECT * FROM %s WHERE username='%s' AND password=(MD5('%s'));",
				this.getTable(), name, unhashedPassword);
		int rows = -1;
		try {
			rows = super.getRowCount(query.replace("*", "COUNT(*)"));
		} catch (SQLException e1) {
			QueryLogger.getInstance().logError("user, validateUser()/rowCount()");
		}
		
		ResultSet rs = this.executeQuery(query);
		
		if(rows > 1) return 0;
		
		String username = null;
		String password = null;
		User user = null;
		int result = 1;

		query = String.format("SELECT * FROM %s WHERE username='%s';",
				this.getTable(), name);
		rs = this.executeQuery(query);
		
		try {
			while(rs != null && rs.next()){
				for(int i = 1 ; i <= rs.getMetaData().getColumnCount(); i++){
					String data = rs.getObject(i).toString();
					switch (i){
						case 3: password = data; break;
						case 2: username = data; break;
					}
				}
			}
		} catch (SQLException e) {
			QueryLogger.getInstance().logError("user, validateUser()");
		}
		
		if(username != null){
			user = new User(-1, username, password);
			String hash = Security.md5(unhashedPassword);
			
			result = 2;
		}
		
		return result;
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
