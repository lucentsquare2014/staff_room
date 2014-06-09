package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import kkweb.beans.*;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionKintai;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundNumberException;

public class SendListDAO {
	
	// 在籍するユーザの情報リストを返す
	public SendList sendList(){
		SendList info = null;

		info = new SendList();
		// kintaikanriデータベースにアクセス
		C_DBConnectionAbs dbconn = new C_DBConnectionKintai();
		Connection conn = dbconn.createConnection();
		// 指定された条件の在籍社員を探す
		String sql = "select * from shainmst where zaiseki_flg = ? order by number";
		ArrayList<ShainInfo> list = new ArrayList<ShainInfo>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, "1");
			rs = stmt.executeQuery();

			// 1行のみ選ばれるので以下が1回実行される
			while(rs.next()){ // カーソルを動かす
				ShainInfo s = new ShainInfo();
				s.setId(rs.getString("id"));
				s.setPw(rs.getString("pw"));
				s.setChecked(rs.getString("checked"));
				s.setName(rs.getString("name"));
				s.setNumber(rs.getString("number"));
				s.setGroupnumber(rs.getString("groupnumber"));
				s.setMail(rs.getString("mail"));
				s.setZaiseki_flg(rs.getString("zaiseki_flg"));
				//s.setChecker("checker");
				// 社員情報をリストに追加
				list.add(s);
			}
			info.setUsers(list);
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
		if (list.size() == 0){
			try {
				throw new NotFoundNumberException();
			} catch (NotFoundNumberException e) {
				e.printStackTrace();
			}
		}
		return info;
	}

	// 給与明細書が登録されているユーザの社員情報リストを返す
	public SendList payslipSendList(){
		SendList info = null;

		info = new SendList();
		// paperschestデータベースにアクセス
		C_DBConnectionAbs dbconnPS = new C_DBConnectionPaperschest();
		C_DBConnectionAbs dbconnKK = new C_DBConnectionKintai();
		Connection connPS = dbconnPS.createConnection();
		Connection connKK = dbconnKK.createConnection();

		// 給与明細書が登録されているユーザ
		String sql = "select distinct number from payslip order by number";
		ArrayList<ShainInfo> list = new ArrayList<ShainInfo>();
		ArrayList<String> numbers = new ArrayList<String>();
		ArrayList<Date> yearmonth = new ArrayList<Date>();
		ArrayList<String> array_sendlog = new ArrayList<String>();
		HashMap<String, Boolean> sendlog = new HashMap<String, Boolean>();
		PreparedStatement stmt = null;
		Statement _stmt = null;
		ResultSet rs = null;
		try {
			
			/// 給与明細書が登録されている社員番号リストを作成 : numbers
			_stmt = connPS.createStatement();
			rs = _stmt.executeQuery(sql);
			while(rs.next()){
				numbers.add(rs.getString("number"));
			}
			//for(String s : numbers) System.out.println(s);
			// close
			_stmt.close();
			rs.close();
			
			sql = "select yearmonth from payslip_url where number=? and " +
					"yearmonth=(select yearmonth from payslip "+
					"where number=? order by yearmonth desc offset 0 limit 1)";
			
			stmt = connPS.prepareStatement(sql);
			/// 
			for(String n : numbers){
				stmt.setString(1, n);
				stmt.setString(2, n);
				
				try {
					int index = 0;
					rs = stmt.executeQuery();
					while(rs.next()){
						index++;
						rs.getDate("yearmonth");
					}
					if(index > 0){
						sendlog.put(n,true);
						array_sendlog.add("送信済");
					}
					else{
						sendlog.put(n,false);
						array_sendlog.add("未送信");
					}
				} catch (Exception e) {
					//e.printStackTrace();
					// 空の場合
					sendlog.put(n,false);
					array_sendlog.add("未送信");
				}
				stmt.clearParameters();
				rs.close();
			}
			stmt.close();
			
			// kintaikanri に接続
			sql = "select * from shainmst where zaiseki_flg = ? order by number";
			stmt = connKK.prepareStatement(sql);
			stmt.setString(1, "1");
			rs = stmt.executeQuery();

			// 在籍している方の中から登録されている方を探す
			while(rs.next()){ // カーソルを動かす
				if(numbers.contains(rs.getString("number"))){
					ShainInfo s = new ShainInfo();
					s.setId(rs.getString("id"));
					s.setPw(rs.getString("pw"));
					s.setChecked(rs.getString("checked"));
					s.setName(rs.getString("name"));
					s.setNumber(rs.getString("number"));
					s.setGroupnumber(rs.getString("groupnumber"));
					s.setMail(rs.getString("mail"));
					s.setZaiseki_flg(rs.getString("zaiseki_flg"));
					//s.setChecker("checker");
					// 社員情報をリストに追加
					list.add(s);
				}
			}
			stmt.close();
			rs.close();
			
			
			
			sql = "select yearmonth from payslip "+
					"where number=? order by yearmonth desc offset 0 limit 1";
			stmt = connPS.prepareStatement(sql);
			
			for(ShainInfo s : list){
				stmt.setString(1, s.getNumber());
				rs = stmt.executeQuery();
				
				while(rs.next()){
					
					yearmonth.add(rs.getDate("yearmonth"));
				}
				stmt.clearParameters();
				rs.close();
			}
			
			// コネクションなどをクローズ
			stmt.close();
			dbconnPS.closeConection(connPS);
			dbconnKK.closeConection(connKK);
			
			info.setYearmonth(yearmonth);
			info.setUsers(list);
			info.setSendlog(array_sendlog);
			
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(_stmt != null ? !_stmt.isClosed() : false) _stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(connKK != null ? !connKK.isClosed() : false) dbconnKK.closeConection(connKK);
				if(connPS != null ? !connPS.isClosed() : false) dbconnPS.closeConection(connPS);
			} catch (SQLException e) {
			}
		}
		
		// ヒットしたデータが無かった場合はエラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundNumberException();
			} catch (NotFoundNumberException e) {
				//e.printStackTrace();
			}
		}
		return info;
	}
}
