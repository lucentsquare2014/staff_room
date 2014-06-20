package kkweb.common;

public class DB_Const {
	private DB_Const(){}
	
	// 接続するDBのホストアドレス
	
	// ローカルサーバー
	//private static final String DB_HOSTNAME = "//localhost:5432";

	// テストサーバー
	private static final String DB_HOSTNAME = "//192.168.101.21:5432";

	// 本番サーバー
	//private static final String DB_HOSTNAME = "//192.168.101.26:5432";

	// DBドライバー
	public static final String DRIVER_NAME = "org.postgresql.Driver";
	// 接続データベースのURL
	public static final String DRIVER_URL = "jdbc:postgresql:"+DB_HOSTNAME;
	
}
