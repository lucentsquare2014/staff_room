package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * newsテーブルとやりとりをするクラス
 */
public class NewsDAO {
	
	private AccessDB access;
	// コンストラクタ
	public NewsDAO(){
		access = new AccessDB();
	}
	
	/* post_idのシーケンスを最新のものに更新する*/
	public void setPostIdSequence(){
		String sql = "select setval('\"news_newsID_seq\"', (select max(news_id) from news));";
		Connection con = access.openDB();
		Statement stmt;
		try{
			stmt = con.createStatement();
			stmt.executeQuery(sql);
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			access.closeDB(con);
		}
	}
	/* kintaikanriのnewsに新規に書き込むメソッド */
	public void writeNews(HashMap<String, String> Newsdata) {
		Connection con = access.openDB();
		try {

			// SQL文を文字列としてsqlという変数に格納
			String sql = "INSERT INTO news (post_id, title, text, writer, filename, primary_flag, created, update) VALUES ("
					+ Newsdata.get("post_id")
					+ ", ?, ?, ?, ?, ?, "
					+ "'"
					+ Newsdata.get("created")
					+ "'"
					+ ", "
					+ "'"
					+ Newsdata.get("created")
					+ "')";
			// プリペアードステートメントを作成
			// preparedStatementでエスケープ処理
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Newsdata.get("title"));
			pstmt.setString(2, Newsdata.get("text"));
			pstmt.setString(3, Newsdata.get("writer"));
			pstmt.setString(4, Newsdata.get("filename"));
			pstmt.setString(5, Newsdata.get("primary_flag"));
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		} finally {
			access.closeDB(con);
		}
	}

	/* kintaikanriのnewsにある記事を編集するメソッド */
	public void updateNews(HashMap<String, String> Newsdata) {
		Connection con = access.openDB();
		try {
			// SQL文を文字列としてsqlという変数に格納
			String sql = "UPDATE news SET "
					+ "post_id="
					+ Newsdata.get("post_id")
					+ ", "
					+ "title=?, text=?, writer=?, filename=?, primary_flag=?, "
					+ "update="
					+ "'"
					+ Newsdata.get("update")
					+ "'"
					+ " WHERE news_id="
					+ Newsdata.get("news_id");
			// プリペアードステートメントを作成
			// preparedStatementでエスケープ処理
			PreparedStatement pstmt = con.prepareStatement(sql);
			// ここでsetした値がsql分の？と置き換わる
			pstmt.setString(1, Newsdata.get("title"));
			pstmt.setString(2, Newsdata.get("text"));
			pstmt.setString(3, Newsdata.get("writer"));
			pstmt.setString(4, Newsdata.get("filename"));
			pstmt.setString(5, Newsdata.get("primary_flag"));
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			access.closeDB(con);
		}
	}

	/* 記事を削除するメソッド */
	public void deleteNews(String[] ids) {
		Connection con = access.openDB();
		// ステートメントを作成
		Statement stmt;
		try {
			stmt = con.createStatement();
			for (String id : ids) {
				// SQL文を文字列としてsqlという変数に格納
				String sql = "delete from news where news_id=" + id;
				// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
				stmt.executeUpdate(sql);
			}
		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			access.closeDB(con);
		}
	}

	// 例：getNews("select * from kintaikanri");
	/*
	 * テーブルのデータを参照し、listに格納して返すメソッド
	 *
	 * @return ArrayList<HashMap<String,String>>型の検索結果を格納したリスト
	 */
	public ArrayList<HashMap<String, String>> getNews(String sql) {
		Connection con = access.openDB();
		// ステートメントを作成
		Statement stmt;
		// データ格納用のリスト
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();

		try {
			stmt = con.createStatement();
			// データ取得
			ResultSet rs = stmt.executeQuery(sql);
			// データのメタデータを取得
			ResultSetMetaData rsmd = rs.getMetaData();

			while (rs.next()) {
				// 1件分のデータ(連想配列)
				HashMap<String, String> hdata = new HashMap<String, String>();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					// フィールド名を取得
					String field = rsmd.getColumnName(i);
					// フィールド名に対するデータ
					String getdata = rs.getString(field);
					if (getdata == null) {
						getdata = "";
					}
					// データ格納(フィールド名, データ)
					hdata.put(field, getdata);
				}
				// 1件分のデータを格納
				list.add(hdata);
			}
		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			access.closeDB(con);
		}
		return list;
	}

	/*
	 * 引数に渡された日付よりも新しい作成日付のnews_idを","で区切った文字列で返す
	 *
	 * @return String型の文字列
	 */
	public String getNewsFromLastLogin(String login_time){
		Connection con = access.openDB();
		// return用の変数
		String result = null;
		// 最後にログインした時間よりも日付が新しい記事を取ってくるsql文
		String sql = "select news_id from news where created > ?";
		try {

				// プリペアードステートメントを作成
				// preparedStatementでエスケープ処理
				PreparedStatement pstmt = con.prepareStatement(sql);

				// ここでsetした値がsql分の？と置き換わる
				pstmt.setTimestamp(1, java.sql.Timestamp.valueOf(login_time));
				// executeUpdateメソッドで実行。未読のnews_idを返す
				ResultSet rs = pstmt.executeQuery();
				StringBuilder builder = new StringBuilder();

				// 取得したデータを","で区切った文字列に変換
				while(rs.next()){
					builder.append(rs.getString("news_id")).append(",");
					// resultに","で連結させた文字列を格納
					result =  builder.toString();
				}
		} catch (SQLException e) {
			System.out.println(e);
		}finally{
			access.closeDB(con);
		}
		return result;
	}

}
