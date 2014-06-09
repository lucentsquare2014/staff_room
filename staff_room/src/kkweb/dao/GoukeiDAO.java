package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class GoukeiDAO{

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from goukeiMST ";

			if(strWhere != null){
				sql += strWhere;
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

		ArrayList golist = new ArrayList();

		B_GoukeiMST goukeitbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from goukeiMST ";
			if(strWhere != null){
				sql += strWhere;
			}
			
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				goukeitbl = new B_GoukeiMST();

				String id = rs.getString("id");
				String number = rs.getString("number");
				String year_month = rs.getString("year_month");
				String cyoukaMONTH = rs.getString("cyoukaMONTH");
				String sinyaMONTH = rs.getString("sinyaMONTH");
				String furouMONTH = rs.getString("furouMONTH");
				String kyudeMONTH = rs.getString("kyudeMONTH");
				String daikyuMONTH = rs.getString("daikyuMONTH");
				String nenkyuMONTH = rs.getString("nenkyuMONTH");
				String kekkinMONTH = rs.getString("kekkinMONTH");
				String akyuMONTH = rs.getString("akyuMONTH");
				String bkyuMONTH = rs.getString("bkyuMONTH");
				String goukeiMONTH = rs.getString("goukeiMONTH");
				String flg = rs.getString("flg");
				String syouninroot = rs.getString("syouninroot");
				String iraisha = rs.getString("iraisha");

				goukeitbl.setId(id);
				goukeitbl.setNumber(number);
				goukeitbl.setYear_month(year_month);
				goukeitbl.setCyoukaMONTH(cyoukaMONTH);
				goukeitbl.setSinyaMONTH(sinyaMONTH);
				goukeitbl.setFurouMONTH(furouMONTH);
				goukeitbl.setKyudeMONTH(kyudeMONTH);
				goukeitbl.setDaikyuMONTH(daikyuMONTH);
				goukeitbl.setNenkyuMONTH(nenkyuMONTH);
				goukeitbl.setKekkinMONTH(kekkinMONTH);
				goukeitbl.setAkyuMONTH(akyuMONTH);
				goukeitbl.setBkyuMONTH(bkyuMONTH);
				goukeitbl.setGoukeiMONTH(goukeiMONTH);
				goukeitbl.setFlg(flg);
				goukeitbl.setSyouninRoot(syouninroot);
				goukeitbl.setIraisha(iraisha);

				golist.add(goukeitbl);
			}
			return golist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}



public boolean isThereTbl2(String strWhere){
	C_DBConnection dbcon = new C_DBConnection();
	Connection con = null;

	try{
		con = dbcon.createConnection();
		String sql = " select * from goukeiMST ";

		if(strWhere != null){
			sql += strWhere;
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

public ArrayList selectTbl2(String strWhere){

	ArrayList golist = new ArrayList();

	B_GoukeiMST goukeitbl = null;
	C_DBConnection dbcon = new C_DBConnection();
	Connection con = null;

	try{
		con = dbcon.createConnection();

		
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(strWhere);

		while(rs.next()){

			goukeitbl = new B_GoukeiMST();

			String id = rs.getString("id");
			String number = rs.getString("number");		
			String flg = rs.getString("flg");
			String syouninroot = rs.getString("syouninroot");
			
			
			goukeitbl.setId(id);
			goukeitbl.setNumber(number);	
			goukeitbl.setFlg(flg);
			goukeitbl.setSyouninRoot(syouninroot);

			golist.add(goukeitbl);
		}
		return golist;

	}catch(SQLException e){
		e.printStackTrace();
		return null;

	}finally{
		dbcon.closeConection(con);
	}
}

public ArrayList selectTbl3(String strWhere){

	ArrayList golist = new ArrayList();

	B_GoukeiMST goukeitbl = null;
	C_DBConnection dbcon = new C_DBConnection();
	Connection con = null;

	try{
		con = dbcon.createConnection();

		
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(strWhere);

		while(rs.next()){

			goukeitbl = new B_GoukeiMST();

			String id = rs.getString("id");
			String number = rs.getString("number");
			String year_month = rs.getString("year_month");
			String cyoukaMONTH = rs.getString("cyoukaMONTH");
			String sinyaMONTH = rs.getString("sinyaMONTH");
			String furouMONTH = rs.getString("furouMONTH");
			String kyudeMONTH = rs.getString("kyudeMONTH");
			String daikyuMONTH = rs.getString("daikyuMONTH");
			String nenkyuMONTH = rs.getString("nenkyuMONTH");
			String kekkinMONTH = rs.getString("kekkinMONTH");
			String akyuMONTH = rs.getString("akyuMONTH");
			String bkyuMONTH = rs.getString("bkyuMONTH");
			String goukeiMONTH = rs.getString("goukeiMONTH");
			String flg = rs.getString("flg");
			String syouninroot = rs.getString("syouninroot");
			String iraisha = rs.getString("iraisha");

			goukeitbl.setId(id);
			goukeitbl.setNumber(number);
			goukeitbl.setYear_month(year_month);
			goukeitbl.setCyoukaMONTH(cyoukaMONTH);
			goukeitbl.setSinyaMONTH(sinyaMONTH);
			goukeitbl.setFurouMONTH(furouMONTH);
			goukeitbl.setKyudeMONTH(kyudeMONTH);
			goukeitbl.setDaikyuMONTH(daikyuMONTH);
			goukeitbl.setNenkyuMONTH(nenkyuMONTH);
			goukeitbl.setKekkinMONTH(kekkinMONTH);
			goukeitbl.setAkyuMONTH(akyuMONTH);
			goukeitbl.setBkyuMONTH(bkyuMONTH);
			goukeitbl.setGoukeiMONTH(goukeiMONTH);
			goukeitbl.setFlg(flg);
			goukeitbl.setSyouninRoot(syouninroot);
			goukeitbl.setIraisha(iraisha);

			golist.add(goukeitbl);
		}
		return golist;

	}catch(SQLException e){
		
		return null;

	}finally{
		dbcon.closeConection(con);
	}
}
}

