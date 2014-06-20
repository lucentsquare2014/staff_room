package kkweb.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class C_DBConnectionKintai extends C_DBConnectionAbs{


	// 接続データベース
	private final static String DRIVER_URL = DB_Const.DRIVER_URL+"/kintaikanri";
	// ユーザー名とパスワード
	private final static String USER_NAME = "postgres";
	private final static String PASSWORD = "admin";

	// コネクションの生成
	public Connection createConnection(){
		try{
			Class.forName(DB_Const.DRIVER_NAME);
			Connection con = DriverManager.getConnection(DRIVER_URL,USER_NAME,PASSWORD);

			return con;
		}catch(SQLException e){

		}
		catch(ClassNotFoundException e){

		}
		// 生成できなければnullを返す
		return null;

	}

}
