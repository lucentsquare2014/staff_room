package holiday;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import dao.AccessDB;

public class GetHoliday {

	public ArrayList<HashMap<String, String>> getHoliday(String this_year) {
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		Statement stmt;
		String sql = "SELECT DISTINCT * FROM holiday WHERE h_年月日 like '" 
				+ this_year + "%' order by h_年月日";
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			while (rs.next()) {
				HashMap<String, String> map = new HashMap<String, String>();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					String field = rsmd.getColumnName(i);
					String getdata = rs.getString(field);
					if (getdata == null) {
						getdata = "";
					}
					map.put(field, getdata);
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		return list;
	}
	
	public String getThisYear(){
		DateFormat dateFormat = new SimpleDateFormat("yyyy");
		Date date = new Date();
		return dateFormat.format(date);
	}
}
