package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class newsDao {
	public ArrayList<String> getdata(String sql){
		
		Connection conn = null;
		  String url = null, user = null, password = null;
			try {
			  conn = DriverManager.getConnection(url, user, password);
			  /*conn  = openNewsDB();*/

			  Statement stmt = conn.createStatement();
			  
			  ResultSet rs = stmt.executeQuery(sql);
			  ArrayList<String> getdata = new ArrayList<String>();
			 
			  while (rs.next()){
				  /*行からデータを取得*/
				  getdata.add(rs.getString("title"));
				  getdata.add (rs.getString("updata"));
				  getdata.add(rs.getString("postname"));				  }
			  
			  rs.close();
			  stmt.close();
	
			}catch (SQLException e){
			  e.getMessage();
			}
				
			return getdata(null);}
}
	