package news;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dao.AccessDB;
import dao.NewsDAO;

public class ReadCheck {
	
	public String getUnread(String id){
		String[] kanri_info = getInfo(id);
		String last_access = "";
		if(kanri_info[1].indexOf(".") != -1){
			last_access = kanri_info[1].substring(0, kanri_info[1].indexOf("."));
		}else{
			last_access = kanri_info[1].substring(0, kanri_info[1].indexOf("+"));
		}
		NewsDAO news = new NewsDAO();
		String new_ids = news.getNewsFromLastLogin(last_access);
		if(new_ids != null){
			kanri_info[2] = updateReadCheck(kanri_info[2], new_ids, kanri_info[0]);
		}
		return  kanri_info[2];
	}
	
	//社員の管理情報を取得、今回のaccess_timeを更新
	private String[] getInfo(String id){
		String sql = "SELECT * FROM shainkanri WHERE shain_number = " +
				"(SELECT number FROM shainmst WHERE id = '" + id + "')";
		AccessDB shain = new AccessDB();
		Connection con = shain.openDB();
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
				if(rs.getString("read_check") == null){
					data[2] = "";
				}
			}
			String update_sql = "UPDATE shainkanri SET access_time = current_timestamp WHERE shain_number = '" + data[0] + "'";
			stmt.executeUpdate(update_sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		shain.closeDB(con);
		return data;
	}
	
	//未読記事を更新する
	private String updateReadCheck(String unread_ids,String new_ids,String number){
		String update_ids = "";
		if(unread_ids.equals(",")){
			unread_ids = "";
		}
		String[] ids = (unread_ids + new_ids).split(",");
		ArrayList<String> unique = new ArrayList<String>();
		for(int i = 0; i < ids.length; i++){
			if(!unique.contains(ids[i])){
				unique.add(ids[i]);
//				update_ids += unique.get(i) + ",";
				// unique.get(i)でIndexOutOfBounds...のエラーが起こっているので
				// get（）を使わないように修正
				update_ids += ids[i] + ",";
			}
		}
		String sql = "UPDATE shainkanri SET read_check = '" + update_ids + 
				"' WHERE shain_number = '" + number + "'";
		AccessDB shain = new AccessDB();
		Connection con = shain.openDB();
		Statement stmt;
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		shain.closeDB(con);
		return update_ids;
	}
	
}
