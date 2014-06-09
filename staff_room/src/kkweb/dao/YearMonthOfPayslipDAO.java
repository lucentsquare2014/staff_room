package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kkweb.beans.*;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;

public class YearMonthOfPayslipDAO {
	private final String[] cols_name = {
			"yearmonth", "sikyuukubun"
	};

	//private final String URL = "SalaryPage?paper_id=";

	public ArrayList<YearMonthOfPayslip> getYearMonth(String number){
		ArrayList<YearMonthOfPayslip> list = new ArrayList<YearMonthOfPayslip>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql =
				"select yearmonth, sikyuukubun from payslip inner join paytype on " +
				"payslip.sikyuukubun = paytype.code where number = ? " +
				"order by yearmonth desc";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			rs = stmt.executeQuery();
			// 使用する給与明細書データ

			while(rs.next()){
				int index = 0;
				YearMonthOfPayslip ym = new YearMonthOfPayslip();
				Date d = rs.getDate(cols_name[index++]);
				String[] ymd = d.toString().split("-");
				ym.setYear(ymd[0]);
				ym.setMonth(ymd[1]);
				ym.setYearmonth(d);
				ym.setSikyuukubun(rs.getString(cols_name[index]));
				list.add(ym);
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

		return list;
	}

	public ArrayList<Date> getUniqYearMonth(String number){
		ArrayList<Date> list = new ArrayList<Date>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql =
				"select distinct yearmonth from payslip where number = ? " +
				"order by yearmonth desc";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			rs = stmt.executeQuery();
			// 使用する給与明細書データ

			while(rs.next()){
				Date d = rs.getDate("yearmonth");
				list.add(d);
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

		return list;
	}
}
