package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

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
}
