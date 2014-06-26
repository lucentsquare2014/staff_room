package Mail;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import dao.AccessDB;

public class GetMail {
	
	public ArrayList<HashMap<String, String>> getShainMail(String sql) {
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		// ステートメントを作成　(ステートメント：制御や宣言などを行うために言語仕様にあらかじめ組み込まれている命令語、
		// および、それらを用いて記述された一つの命令文のこと)
		Statement stmt;
		// データ格納用のリスト
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		try {
			stmt = con.createStatement();
			// データ取得 　
			ResultSet rs = stmt.executeQuery(sql);
			// データのメタデータを取得  (メタデータ:データの作成日時や作成者、データ形式、タイトル、注釈など)
			ResultSetMetaData rsmd = rs.getMetaData();

			while (rs.next()) {
				// 1件分のデータ(連想配列)
			
				HashMap<String, String> map = new HashMap<String, String>();
		
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					// フィールド名を取得
					String field = rsmd.getColumnName(i);
					// フィールド名に対するデータ
					String getdata = rs.getString(field);
					if (getdata == null) {
						getdata = "";
					}
					// データ格納(フィールド名, データ)
					map.put(field, getdata);
				}
				// 1件分のデータを格納
				list.add(map);
			}
		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			access.closeDB(con);
		}
		return list;
	}

}
