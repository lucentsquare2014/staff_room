package kkweb.common;

import java.sql.Connection;

public abstract class C_DBConnectionAbs {
	// コネクションの生成
	public abstract Connection createConnection();

	// コネクションのクローズ
	public void closeConection(Connection con ){
		try{
			con.close();
		}catch(Exception ex){}
	}

}
