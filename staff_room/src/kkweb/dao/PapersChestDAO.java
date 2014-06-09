package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundNumberException;

public class PapersChestDAO {
	// 書棚に指定された年月リストのの給与明細書を追加する
	public int insertPayslipByYearmonth(String number ,ArrayList<Date> yearmonth){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement stmt = null;
		int num = 0;
		try {
			String sql = "insert into paperschest " +
					"select number, '01', yearmonth, ?, ? from payslip " +
					"where yearmonth=? and number=?";
			// ? => update_stamp, comment
			stmt = conn.prepareStatement(sql);

			//Date yearmonth = new Date()
			for(Date ym : yearmonth){

				// 一ヵ月後のDateを作成
				Calendar cal = Calendar.getInstance(); // 現在日時
				stmt.setDate(1, new Date(cal.getTime().getTime())); // 更新日時セット

				stmt.setString(2,"公開"); // コメントセット
				stmt.setDate(3, ym); // 書類の年月セット
				stmt.setString(4, number);
				//System.out.println(stmt.toString());
				try {
					num += stmt.executeUpdate();
				} catch (SQLException e) {
					//System.out.println("社員番号 : " + number + " をインサートできませんでした");
					e.printStackTrace();
				}
				stmt.clearParameters(); // パラメータリセット

			}

			stmt.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}

		return num;
	}

	// 特定の一件を更新
	public int update(String number, Date yearmonth , String code, String comment){
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement stmt = null;
		int num = 0;
		try {
			String sql = "update paperschest " +
					"set update_stamp=? " +
					", comment=? where yearmonth=? and code=? and number=?";
			// ? => update_stamp, comment
			stmt = conn.prepareStatement(sql);

			// 一ヵ月後のDateを作成
			Calendar cal = Calendar.getInstance(); // 現在日時
			stmt.setDate(1, new Date(cal.getTime().getTime())); // 更新日時セット
			// 該当月の給与明細書と先月の給与明細書を比較して変わった部分を調べる

			stmt.setString(2, comment); // コメントセット
			stmt.setDate(3, yearmonth); // 書類の年月セット
			stmt.setString(4, code); // 書類コードをセット
			stmt.setString(5, number); // 社員番号をセット
			//System.out.println(stmt.toString());
			num += stmt.executeUpdate();

			stmt.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}

		return num;
	}

	// numberで指定された社員の最新給与明細書を追加する
	// 追加できなかった社員番号を返す
	public ArrayList<String> insertPayslipByNumber(ArrayList<String> number){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement stmt = null;
		ArrayList<String> uninserted_users = new ArrayList<String>();
		int num = 0;
		try {
			String sql = "insert into paperschest (number,code,yearmonth,update_stamp,comment) " +
					"select number, '01', yearmonth, ?, ? from payslip " +
					"where number=? " +
					"order by yearmonth desc offset 0 limit 1";

			stmt = conn.prepareStatement(sql);
			Calendar cal = Calendar.getInstance(); // 現在日時
			Date d = new Date(cal.getTime().getTime());
			for(String n : number){
				// 一ヵ月後のDateを作成
				stmt.setDate(1, d); // 更新日時セット
				stmt.setString(2,"公開"); // コメントセット
				stmt.setString(3, n);
				//System.out.println(stmt.toString());
				try {
					num += stmt.executeUpdate();
					//System.out.println("insert : " + n);
				} catch (SQLException e) {
					//System.out.println("社員番号 : " + number + " をインサートできませんでした");
					//e.printStackTrace();
					uninserted_users.add(n);
				}
				stmt.clearParameters(); // パラメータリセット
			}

			stmt.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(stmt != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}

		return uninserted_users;
	}

	// numberで指定された社員の書棚に登録されている給与明細書を更新する
	public ArrayList<String> updatePayslipByNumber(ArrayList<String> number){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement ppstmt = null;
		ResultSet rs = null;
		ArrayList<String> updated_users = new ArrayList<String>();
		int num = 0;
		try {
			for(String n : number){
				// あるユーザの最新給与支給月を取得
				String sql = "select yearmonth from payslip " +
						"where number=? " +
						"order by yearmonth desc " +
						"offset 0 limit 1";
				ppstmt = conn.prepareStatement(sql);
				ppstmt.setString(1, n);
				rs = ppstmt.executeQuery();
				Date ym = null;
				while(rs.next()){
					ym = rs.getDate("yearmonth");
				}
				ppstmt.close();
				rs.close();
				
				if(ym == null) throw new NotFoundNumberException();
				
				sql = "update paperschest " +
						"set update_stamp=? , comment=? " +
						"where yearmonth=? and code='01' and number=?";

				ppstmt = conn.prepareStatement(sql);
				Calendar cal = Calendar.getInstance(); // 現在日時
				Date d = new Date(cal.getTime().getTime());

				// 一ヵ月後のDateを作成
				ppstmt.setDate(1, d); // 更新日時セット
				ppstmt.setString(2,"更新"); // コメントセット
				ppstmt.setDate(3, ym); // 給与支給年月
				ppstmt.setString(4, n); // 社員番号
				//System.out.println(stmt.toString());
				try {
					num += ppstmt.executeUpdate();
					//System.out.println("update : " + n);
					updated_users.add(n);
				} catch (SQLException e) {
					//System.out.println("社員番号 : " + number + " をインサートできませんでした");
					//e.printStackTrace();
				}
				ppstmt.clearParameters(); // パラメータリセット
			}

			ppstmt.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		} catch (NotFoundNumberException e){
			
		}
		finally{
			try {
				if(ppstmt != null ? !ppstmt.isClosed() : false) ppstmt.close();
				if(ppstmt != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}

		return updated_users;
	}

}
