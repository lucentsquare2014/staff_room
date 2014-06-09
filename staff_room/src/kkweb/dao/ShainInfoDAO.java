package kkweb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kkweb.beans.ShainInfo;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionKintai;
import kkweb.error.NotFoundNumberException;



// 社員情報データベースにアクセスするクラス
public class ShainInfoDAO {
	// 参照する列名
	private String[] cols_name = {
			"id",
			"pw",
			"checked",
			"name",
			"number",
			"groupnumber",
			"mail",
			"zaiseki_flg",
			"syounin_junban",
			"checker"
	};

	// データベースにアクセスし社員情報を表すクラスを返す
	public ShainInfo shainInfo(String number){
		ShainInfo info = null;

		info = new ShainInfo();
		// kintaikanriデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionKintai();
		Connection conn = dbconn.createConnection();
		String sql = "select * from shainmst where number = ?";

		PreparedStatement stmt = null;
		ResultSet rs = null;
		int index = 0;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			rs = stmt.executeQuery();

			// 1行のみ選ばれるので以下が1回実行される
			while(rs.next()){ // カーソルを動かす
				info.setId(rs.getString(cols_name[index++]));
				info.setPw(rs.getString(cols_name[index++]));
				info.setChecked(rs.getString(cols_name[index++]));
				info.setName(rs.getString(cols_name[index++]));
				info.setNumber(rs.getString(cols_name[index++]));
				info.setGroupnumber(rs.getString(cols_name[index++]));
				info.setMail(rs.getString(cols_name[index++]));
				info.setZaiseki_flg(rs.getString(cols_name[index++]));
				info.setSyounin_junban(rs.getString(cols_name[index++]));
				//info.setChecker(rs.getString(cols_name[index++]));
			}

			// コネクションなどをクローズ
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);

			} catch (SQLException e) {
			}
		}
		// ヒットしたデータが無かった場合はエラーを投げる
		if (index == 0){
			try {
				throw new NotFoundNumberException();
			} catch (NotFoundNumberException e) {
				e.printStackTrace();
			}
		}
		return info;
	}
}
