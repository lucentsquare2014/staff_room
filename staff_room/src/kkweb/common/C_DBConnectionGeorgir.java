package kkweb.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class C_DBConnectionGeorgir extends C_DBConnectionAbs {

	// 接続データベース
	private final static String DRIVER_URL = DB_Const.DRIVER_URL+"/georgir";

	private final static String USER_NAME = "georgir";
	private final static String PASSWORD = "georgir";


	@Override
	// コネクションの生成
	public Connection createConnection() {
		try {
			Class.forName(DB_Const.DRIVER_NAME);
			Connection con = DriverManager.getConnection(DRIVER_URL, USER_NAME,PASSWORD);

			return con;
		} catch (SQLException e) {

		} catch (ClassNotFoundException e) {

		}
		// 生成できなければnullを返す
		return null;
	}

}
