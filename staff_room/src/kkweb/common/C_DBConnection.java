package kkweb.common;



import java.sql.*;

public class C_DBConnection {

 	//private final static String DRIVER_URL = "jdbc:postgresql://192.36.253.8:5432/kintaikanri";
	// ローカル
	//private final static String DRIVER_URL = "jdbc:postgresql://localhost:5432/kintaikanri";
	// テストサーバー
	private final static String DRIVER_URL = "jdbc:postgresql://192.168.101.21:5432/kintaikanri";
	// 本番
	//private final static String DRIVER_URL = "jdbc:postgresql://192.168.101.26:5432/kintaikanri";
	private final static String DRIVER_NAME = "org.postgresql.Driver";
	private final static String USER_NAME = "postgres";
	private final static String PASSWORD = "admin";


	public Connection createConnection(){


		try{

			Class.forName(DRIVER_NAME);
			Connection con = DriverManager.getConnection(DRIVER_URL,USER_NAME,PASSWORD);

			return con;

		}catch(SQLException e){

		}
		catch(ClassNotFoundException e){

		}

		return null;	//例外が発生した場合はnullを返します。

	}

	//切断メソッド
	public void closeConection(Connection con ){
		try{
			con.close();
		}catch(Exception ex){}

	}
}
