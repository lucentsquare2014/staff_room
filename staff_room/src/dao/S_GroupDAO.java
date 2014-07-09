package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class S_GroupDAO {
	public ArrayList<HashMap<String, String>> getGroup(){
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String sql = "SELECT * FROM schedule.gru ORDER BY g_gruno";
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			while(rs.next()){
				HashMap<String, String> hdata = new HashMap<String, String>();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					String field = rsmd.getColumnName(i);
					String getdata = rs.getString(field);
					hdata.put(field, getdata);
				}
				list.add(hdata);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		return list;
	}
}
