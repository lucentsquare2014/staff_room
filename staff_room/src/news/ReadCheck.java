package news;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dao.NewsDAO;
import dao.ShainDB;

public class ReadCheck {
	
	public String getUnread(String id){
		String[] kanri_info = getInfo(id);
		String last_access = kanri_info[1].substring(0, kanri_info[1].indexOf("."));
		NewsDAO news = new NewsDAO();
		String new_ids = news.getNewsFromLastLogin(last_access);
		if(new_ids != null){
			updateReadCheck(kanri_info[2], new_ids, kanri_info[0]);
			kanri_info[2] = kanri_info[2] + new_ids;
		}
		return  kanri_info[2];
	}
	
	//社員の管理情報を取得、今回のaccess_timeを更新
	private String[] getInfo(String id){
		String sql = "SELECT * FROM shainkanri WHERE shain_number = " +
				"(SELECT number FROM shainmst WHERE id = '" + id + "')";
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		Statement stmt;
		String[] data = new String[4];
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				data[0] = rs.getString("shain_number");
				data[1] = rs.getString("access_time");
				data[2] = rs.getString("read_check");
				data[3] = rs.getString("cookie");
			}
			String update_sql = "UPDATE shainkanri SET access_time = current_timestamp WHERE shain_number = '" + data[0] + "'";
			stmt.executeUpdate(update_sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		shain.closeShainDB(con);
		return data;
	}
	
	//未読記事を更新する
	private void updateReadCheck(String unread_ids,String new_ids,String number){
		String update_ids = "";
		String[] ids = (unread_ids + new_ids).split(",");
		ArrayList<String> unique = new ArrayList<String>();
		for(int i = 0; i < ids.length; i++){
			if(!unique.contains(ids[i])){
				unique.add(ids[i]);
				update_ids += unique.get(i) + ",";
			}
		}
		String sql = "UPDATE shainkanri SET read_check = '" + update_ids + 
				"' WHERE shain_number = '" + number + "'";
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		Statement stmt;
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		shain.closeShainDB(con);
	}
	
}
