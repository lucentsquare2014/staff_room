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

import kkweb.beans.PayslipURL;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundNumberException;

import org.apache.commons.codec.digest.DigestUtils;

public class PayslipURLDAO {
	// 登録されているURLを全て取得
	public ArrayList<PayslipURL> getList(){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		// 指定された条件の在籍社員を探す
		String sql = "select * from payslip_url order by number";
		ArrayList<PayslipURL> al = new ArrayList<PayslipURL>();
		Statement stmt = null;
		ResultSet rs = null;
		int index = 0;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			while(rs.next()){ // カーソルを動かす
				PayslipURL tmp = new PayslipURL();
				tmp.setNumber(rs.getString("number"));
				tmp.setUrl(rs.getString("url"));
				tmp.setLimit(rs.getDate("limit"));
				tmp.setYearmonth(rs.getDate("yearmonth"));
				al.add(tmp);
			}
			// コネクションなどをクローズ
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

		// ヒットしたデータが無かった場合はエラーを投げる
		if (index == 0){
			try {
				throw new NotFoundNumberException();
			} catch (NotFoundNumberException e) {
				//e.printStackTrace();
			}
		}


		return al;
	}

	// 現在時刻から1ヶ月後の値にアップデートする
	// 更新した社員番号と支給年月のHashMapを返す
	public Map<String, Date> updateLimit(ArrayList<String> numberList){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Map<String, Date> map = new HashMap<String, Date>();
		Map<String, Date> updated = new HashMap<String, Date>();
		int num = 0;
		String sql1 = "select number , max(yearmonth) " +
				"from payslip group by number order by number";
		String sql2 = "update payslip_url " +
				"set \"limit\"=?, yearmonth=? , url=? " +
				"where number=?";
		try {
			stmt = conn.prepareStatement(sql1);
			try {
				rs = stmt.executeQuery();
				// 一番新しい給与明細の日付をmapに追加
				while(rs.next()){
					String number = rs.getString("number");
					Date d = rs.getDate(2);
					map.put(number, d);
				}
			} catch (SQLException e) {
				//System.out.println("");
				//e.printStackTrace();
			}
			stmt.close();
			rs.close();
			//for(String k : map.keySet()) System.out.println("key : " + k + " num : " + map.get(k));
			stmt = conn.prepareStatement(sql2);

			for(String number : numberList){
				if(map.containsKey(number)){
					// mapの2ヵ月後のDateを作成
					Calendar cal = Calendar.getInstance();
					cal.setTime(map.get(number));
					cal.add(Calendar.MONTH, 2); // 2ヵ月後に変更
					Date d = new Date(cal.getTime().getTime());

					stmt.setDate(1, d);
					stmt.setDate(2, map.get(number));
					stmt.setString(3, DigestUtils.shaHex(number+map.get(number).toString()));
					stmt.setString(4, number);
					//System.out.println(stmt.toString());
					try {
						num += stmt.executeUpdate();
						// 更新した社員番号と給与明細書の年月
						updated.put(number, map.get(number));
						//System.out.println("updated : " + number);
					} catch (SQLException e) {
						//System.out.println("社員番号 : " + number + " をアップデートできませんでした");
						//e.printStackTrace();
					}
					stmt.clearParameters(); // パラメータリセット
				}
			}

			stmt.close();
			dbconn.closeConection(conn);
		} catch (SQLException e1) {
			//e1.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);

			} catch (SQLException e) {
			}
		}
		return updated;
	}

	// 指定されたユーザの最新の給与明細書を用いて
	// URLを登録する
	// 登録した社員番号と支給年月のHashmapを返す
	public Map<String, Date> insert(ArrayList<String> numberList){
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = dbconn.createConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Map<String, Date> map = new HashMap<String, Date>();
		Map<String, Date> inserted = new HashMap<String, Date>();
		int num = 0;
		try {
			String sql1 = "select number , max(yearmonth) " +
					"from payslip group by number order by number";
			stmt = conn.prepareStatement(sql1);
			try {
				rs = stmt.executeQuery();
				// 一番新しい給与明細の日付をmapに追加
				while(rs.next()){
					String number = rs.getString("number");
					Date d = rs.getDate(2);
					map.put(number, d);
				}
			} catch (SQLException e) {
				//System.out.println("");
				//e.printStackTrace();
			}
			stmt.close();
			rs.close();

			String sql2 = "insert into payslip_url " +
					"(number, url, yearmonth, \"limit\") values ( ?, ?, ? ,? )";
			stmt = conn.prepareStatement(sql2);

			//Date yearmonth = new Date()
			for(String number : numberList){
				if(map.containsKey(number)){
					// 2ヵ月後のDateを作成
					Calendar cal = Calendar.getInstance();
					cal.setTime(map.get(number));
					cal.add(Calendar.MONTH, 2); // 2ヵ月後に変更
					Date limit = new Date(cal.getTime().getTime());
					// 社員番号をハッシュ化
					String url = DigestUtils.shaHex(number+map.get(number).toString());
					// パラメータをセット
					stmt.setString(1, number);
					stmt.setString(2, url);
					stmt.setDate(3, map.get(number));
					stmt.setDate(4, limit);
					//System.out.println(stmt.toString());
					try {
						num += stmt.executeUpdate();
						// 追加した社員番号と年月
						inserted.put(number, map.get(number));
						//System.out.println("inserted : " + number);
					} catch (SQLException e) {
						//System.out.println("社員番号 : " + number + " をインサートできませんでした");
						//e.printStackTrace();
					}
					stmt.clearParameters(); // パラメータリセット
				}
			}

			stmt.close();
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

		return inserted;
	}

	// payslip_urlを検索し期限が過ぎているかを調べる
	// 期限内なら true
	public boolean useThisCode(String number, String code){
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql =
				"select \"limit\", url from payslip_url where number = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int num = 0;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			rs = stmt.executeQuery();
			// 使用する給与明細書データ
			Date limit = null;
			String CODE = null;
			while(rs.next()){
				limit = rs.getDate(1);
				CODE = rs.getString("url");
				num++;
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
			// ヒットなし
			if(num == 0) return false;

			// 現在時刻のカレンダー
			Calendar cal = Calendar.getInstance();
			Calendar target = Calendar.getInstance();
			target.setTime(limit);
			/*//
			System.out.println("cal : " + cal.getTime().toString());
			System.out.println("target : " + target.getTime().toString() );
			System.out.println(CODE);
			System.out.println(code);
			//*/
			// 現在時刻よりlimitのほうが古い日付
			return (cal.before(target) && CODE.equals(code));

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
		return false;
	}

	public Date getYearmonth(String number) throws NotFoundNumberException{
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql =
				"select yearmonth from payslip_url where number = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int num = 0;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			rs = stmt.executeQuery();
			// 使用する給与明細書データ
			Date yearmonth = null;

			while(rs.next()){
				yearmonth = rs.getDate(1);
				num++;
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
			// ヒットなし
			if(num == 0) throw new NotFoundNumberException();
			return yearmonth;

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
		return null;
	}

}
