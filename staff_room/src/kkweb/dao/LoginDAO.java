package kkweb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import kkweb.beans.B_ShainMST;
import kkweb.common.C_DBConnection;

public class LoginDAO {

	public B_ShainMST getShainMSTUniqueData(String strWhere) {

		try{

		ArrayList ShainMSTList =selectTbl(strWhere);
		B_ShainMST b_shainmst = (B_ShainMST)ShainMSTList.get(0);

		return b_shainmst;

		}catch(Exception e){

			e.printStackTrace();

			return null;
		}
	}

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from shainMST ";
			
			if(strWhere != null){
				sql = sql + strWhere;
			}
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()){

				return true;

			}else{

				return false;
		}

		}catch(SQLException e){
			e.printStackTrace();
			return false;

		}finally{
			dbcon.closeConection(con);
		}
}

	public ArrayList selectTbl(String strWhere){

		ArrayList alist = new ArrayList();

		B_ShainMST b_shainmst = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from shainMST ";

			if(strWhere != null){
			sql = sql + strWhere;
		}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){
				b_shainmst = new B_ShainMST();

				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String checked = rs.getString("checked");
				String name = rs.getString("name");
				String number = rs.getString("number");
				String GROUPnumber = rs.getString("GROUPnumber");
				String mail = rs.getString("mail");
				String zaiseki_flg = rs.getString("zaiseki_flg");
				String hyouzijun = rs.getString("hyouzijun");
				String yakusyoku = rs.getString("yakusyoku");
				// フリガナと管理者権限を追加 2014-06-13
				String hurigana = rs.getString("hurigana");
				String administrator = rs.getString("administrator");

				b_shainmst.setId(id);
				b_shainmst.setPw(pw);
				b_shainmst.setChecked(checked);
				b_shainmst.setName(name);
				b_shainmst.setNumber(number);
				b_shainmst.setGROUPnumber(GROUPnumber);
				b_shainmst.setMail(mail);
				b_shainmst.setZaiseki_flg(zaiseki_flg);
				b_shainmst.setHyouzijun(hyouzijun);
				b_shainmst.setYakusyoku(yakusyoku);
				// フリガナと管理者権限追加 2014-06-11
				b_shainmst.setHurigana(hurigana);
				b_shainmst.setAdministrator(administrator);

				alist.add(b_shainmst);
			}
			return alist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
	
	public HashMap<String, String> loginInfo(String login_id){
		HashMap<String,String> result = new HashMap<String,String>();
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;
		
		con = dbcon.createConnection();
		String sql = "select id, pw from shainmst where id = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, login_id);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				result.put("id", rs.getString("id"));
				result.put("password", rs.getString("pw"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbcon.closeConection(con);
		}
		return result;
	}
}
