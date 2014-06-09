package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kkweb.beans.Oshirase;
import kkweb.beans.Payslip;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundIDException;

// 給与明細書に必要なデータにアクセスするクラス
public class OshiraseDAO {
	// 年月, 社員番号
	public ArrayList<Oshirase> Oshirase(Date yearmonth, String number){
		ArrayList<Oshirase> list = new ArrayList<Oshirase>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql = "select * from oshirase " +
				"where number=? " +
				"and yearmonth=? order by linenumber asc";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			stmt.setDate(2, yearmonth);

			rs = stmt.executeQuery();

			while(rs.next()){
				Oshirase oshi = new Oshirase();
				String[] ymd = rs.getDate("yearmonth").toString().split("-");
				oshi.setYear(ymd[0]);
				oshi.setMonth(ymd[1]);
				oshi.setNumber(rs.getString("number"));
				oshi.setKoumoku(rs.getString("koumoku"));
				oshi.setLinenumber(rs.getInt("linenumber"));

				list.add(oshi);
			}
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
		// ヒットしたデータが無かった場合エラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				e.printStackTrace();
			}
		}
		return list;
	}


	// 検索区間の開始年月, 終了年月, 社員番号
	public ArrayList<Oshirase> oshirase(Date start, Date end , String number){
		ArrayList<Oshirase> list = new ArrayList<Oshirase>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行してお知らせデータを取得
		String sql = "select * from oshirase " +
				"where number=? " +
				"and yearmonth >=? " + 
				"and yearmonth <=? order by linenumber asc";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			stmt.setDate(2, start);
			stmt.setDate(3, end);

			rs = stmt.executeQuery();
			// 使用するお知らせデータ

			while(rs.next()){
				Oshirase oshi = new Oshirase();

				String[] ymd = rs.getDate("yearmonth").toString().split("-");
				oshi.setYear(ymd[0]);
				oshi.setMonth(ymd[1]);
				oshi.setNumber(rs.getString("number"));
				oshi.setYearmonth(rs.getDate("yearmonth"));
				oshi.setKoumoku(rs.getString("koumoku"));
				oshi.setLinenumber(rs.getInt("linenumber"));

				list.add(oshi);
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
		// ヒットしたデータが無かった場合エラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				//e.printStackTrace();
			}
		}
		return list;
	}

	public ArrayList<Date> payslipYearmonth(Date start, Date end , String number){
		ArrayList<Date> list = new ArrayList<Date>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行してお知らせデータを取得
		String sql = "select * from payslip " +
				"where number=? " +
				"and yearmonth >=? " + 
				"and yearmonth <=? order by yearmonth desc";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, number);
			stmt.setDate(2, start);
			stmt.setDate(3, end);

			rs = stmt.executeQuery();
			// 使用するお知らせデータ

			while(rs.next()){
				list.add(rs.getDate("yearmonth"));
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
		// ヒットしたデータが無かった場合エラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				//e.printStackTrace();
			}
		}

		return list;
	}


}
