package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * DBとやりとりをするクラス
 */
public class NewsDAO {

	/*
	 * newsDBに接続するメソッド
	 * 
	 * @return データベースとやりとりするコネクションクラス
	 */
	private static Connection openNewsDB() {
		Connection con = null;
		try {
			// JDBCドライバの読み取り
			Class.forName("org.postgresql.Driver");
			// 各種設定
			String user = "lsc2014";
			String pass = "admin";

			// データベース接続
			con = DriverManager.getConnection(
					"jdbc:postgresql://localhost:5432/newsDB", user, pass);
			System.out.println("接続成功");
		} catch (Exception e) {
			System.out.println("例外発生：" + e);
		}
		return con;
	}

	/* newsDBへの接続を切断するメソッド */
	private static void closeNewsDB(Connection con) {
		try {
			// データベース切断
			con.close();
			System.out.println("切断成功");
		} catch (Exception e) {
			System.out.println("例外発生：" + e);
		}
	}
	/* post_idのシーケンスを最新のものに更新する*/
	public void setPostIdSequence(){
		String sql = "select setval('\"news_newsID_seq\"', (select max(news_id) from news));";
		Connection con = openNewsDB();
		Statement stmt;
		try{
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			closeNewsDB(con);
		}
	}
	/* newsDBに新規に書き込むメソッド */
	public void writeNews(HashMap<String, String> Newsdata) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		try {
			//stmt = con.createStatement();

			// SQL文を文字列としてsqlという変数に格納
			String sql = "INSERT INTO news (post_id, title, text, writer, filename, created, update) VALUES ("
					+ Newsdata.get("post_id")
					+ ", "
					+ "?"//Newsdata.get("title")
					+ ", "
					+ "?"//Newsdata.get("text")
					+ ", "
					+ "?"//Newsdata.get("writer")
					+ ", "
					+ "?"//Newsdata.get("filename")
					+ ", "
					+ "'"
					+ Newsdata.get("created")
					+ "'"
					+ ", "
					+ "'"					
					+ Newsdata.get("created") + "')";
			System.out.println(sql);
			// preparedStatementでエスケープ処理
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Newsdata.get("title"));
			pstmt.setString(2, Newsdata.get("text"));
			pstmt.setString(3, Newsdata.get("writer"));
			pstmt.setString(4, Newsdata.get("filename"));
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			int num = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e);
		} finally {
			closeNewsDB(con);
		}
	}
	
	/* newsDBにある記事を編集するメソッド */
	public void updateNews(HashMap<String, String> Newsdata) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		try {
			stmt = con.createStatement();

			// SQL文を文字列としてsqlという変数に格納
			String sql = "UPDATE news SET " 
					+ "post_id=" 
					+ Newsdata.get("post_id")
					+ ", " 
					+ "title=?" 
/*					+ "'"
					+ Newsdata.get("title")
					+ "'"
*/					+ ", "
					+ "text=?" 
/*					+ "'"
					+ Newsdata.get("text") 
					+ "'"
*/					+ ", " 
					+ "writer=?" 
/*					+ "'"
					+ Newsdata.get("writer")
					+ "'"					
*/					+ "," 
					+ "filename=?" 
/*					+ "'"
					+ Newsdata.get("filename") 
					+ "'"					
*/					+ ","
					+ "update=" 
					+ "'"
					+ Newsdata.get("update") 
					+ "'"					
					+ " WHERE news_id="
					+ Newsdata.get("news_id");
			System.out.println(sql);
			// preparedStatementでエスケープ処理
			PreparedStatement pstmt = con.prepareStatement(sql);
			// ここでsetした値がsql分の？と置き換わる
			pstmt.setString(1, Newsdata.get("title"));
			pstmt.setString(2, Newsdata.get("text"));
			pstmt.setString(3, Newsdata.get("writer"));
			pstmt.setString(4, Newsdata.get("filename"));
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			int num = pstmt.executeUpdate();
			closeNewsDB(con);
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

	/* 記事を削除するメソッド */
	public void deleteNews(String[] ids) {
		Connection con = openNewsDB();
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
			closeNewsDB(con);
		} catch (SQLException e) {
			System.out.println(e);
		}
	}

	// 例：getNews("select * from newsDB");
	/*
	 * テーブルのデータを参照し、listに格納して返すメソッド
	 * 
	 * @return ArrayList<HashMap<String,String>>型の検索結果を格納したリスト
	 */
	public ArrayList<HashMap<String, String>> getNews(String sql) {
		Connection con = openNewsDB();
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
			closeNewsDB(con);
		} catch (SQLException e) {
			System.out.println(e);
		}
		return list;
	}
}