package kkweb.common;



import java.sql.*;

public class C_DBConnection {

	// 接続データベース
	private final static String DRIVER_URL = DB_Const.DRIVER_URL+"/kintaikanri";

	private final static String USER_NAME = "postgres";
	private final static String PASSWORD = "admin";


	public Connection createConnection(){


		try{

			Class.forName(DB_Const.DRIVER_NAME);
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
