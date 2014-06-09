package kkweb.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class C_DBConnectionPaperschest extends C_DBConnectionAbs{
	// ローカル
	//private final static String DRIVER_URL = "jdbc:postgresql://localhost:5432/paperschest";
	// テストサーバ
	private final static String DRIVER_URL = "jdbc:postgresql://192.168.101.21:5432/paperschest";
	// 本番サーバ
	//private final static String DRIVER_URL = "jdbc:postgresql://192.168.101.26:5432/paperschest";
	private final static String DRIVER_NAME = "org.postgresql.Driver";
	private final static String USER_NAME = "postgres";
	private final static String PASSWORD = "admin";

	// コネクションの生成
	public Connection createConnection(){
		try{
			Class.forName(DRIVER_NAME);
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
