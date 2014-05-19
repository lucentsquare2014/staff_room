package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class newsDAO {

	// newsDBに接続するメソッド
	public static Connection openNewsDB() {
		Connection con = null;
		try {
			// JDBCドライバの読み取り
			Class.forName("org.postgresql.Driver");
			// 各種設定
			String user = "postgres";
			String pass = "jhyw79pg";

			// データベース接続
			con = DriverManager.getConnection(
					"jdbc:postgresql://localhost:5432/NEO-NEO", user, pass);
			System.out.println("接続成功");
		} catch (Exception e) {
			System.out.println("例外発生：" + e);
		}
		return con;
	}

	// newsDBへの接続を切断するメソッド
	public static void closeNewsDB(Connection con) {
		try {
			// データベース切断
			con.close();
			System.out.println("切断成功");
		} catch (Exception e) {
			System.out.println("例外発生：" + e);
		}
	}

	// newsDBに新規に書き込むメソッド
	public void writeNews(HashMap<String, String> Newsdata) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		try {
			stmt = con.createStatement();

			// SQL文を文字列としてsqlという変数に格納
			String sql = "INSERT INTO news (postID, title, text, writer, filename, created, update) VALUES "
					+ Newsdata.get("postID")
					+ ", "
					+ Newsdata.get("title")
					+ ", "
					+ Newsdata.get("text")
					+ ", "
					+ Newsdata.get("writer")
					+ ", "
					+ Newsdata.get("filename")
					+ ", "
					+ Newsdata.get("created")
					+ ", "
					+ Newsdata.get("update");
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			int num = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}

	// newsDBにある記事を編集するメソッド
	public void updateNews(HashMap<String, String> Newsdata) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		try {
			stmt = con.createStatement();

			// SQL文を文字列としてsqlという変数に格納
			String sql = "UPDATE news SET postID=" + Newsdata.get("postID")
					+ ", " + Newsdata.get("title") + ", "
					+ Newsdata.get("text") + ", " + Newsdata.get("writer")
					+ "," + Newsdata.get("filename") + ","
					+ Newsdata.get("update") + "WHERE newsID="
					+ Newsdata.get("newsID");
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			int num = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}

	// 記事を削除するメソッド
	public void deleteNews(String id) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		try {
			stmt = con.createStatement();
			// SQL文を文字列としてsqlという変数に格納
			String sql = "DELETE news WHERE newsID=" + id;
			// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			int num = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}

	// 例：getNews("select * from newsDB");
	// テーブルのデータを参照し、listに格納して返すメソッド
	public ArrayList<HashMap<String, String>> getNews(String sql) {
		Connection con = openNewsDB();
		// ステートメントを作成
		Statement stmt;
		// データ格納
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
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		return list;
	}
}