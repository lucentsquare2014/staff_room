package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class AccessDB {

	public Connection openDB(){
		Connection con = null;
		try{
	    //　JDBCドライバの読み取り
	    Class.forName("org.postgresql.Driver");
	    //　各種設定
	    String user = "lsc2014";
	    String pass = "admin";

	    //　データベース接続
	    //ローカルのデータベースにアクセス
//	    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/kintaikanri",user,pass);
	    //テストサーバのデータベースにアクセス
	    con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/kintaikanri",user,pass);
		}catch (Exception e) {
		    e.printStackTrace();
	    }
		return con;
	}

	public void closeDB(Connection con){
		try{
	        //　データベース切断
	        con.close();
		}catch (Exception e){
			e.printStackTrace();
	    }
	}

}

