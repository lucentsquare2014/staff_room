package kkweb.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kkweb.beans.CreatePaperSelecter;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;

public class CreatePaperSelecterDAO {
	private final String[] cols_name = {
			"code", "paper_type"
	};

	// 書類コードマスタから書類IDと書類名を取得する
	public CreatePaperSelecter createSelecter(){
		CreatePaperSelecter selecter = new CreatePaperSelecter();

		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql = "select * from paperstype";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql);
			// 使用する給与明細書データ
			while(rs.next()){
				int index = 0;
				selecter.addCode(rs.getString(cols_name[index++]));
				selecter.addType(rs.getString(cols_name[index++]));
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);

			} catch (SQLException e) {
			}
		}

		return selecter;
	}
}
