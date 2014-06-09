package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class KinmuDAO{

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from kinmuMST ";

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

		ArrayList klist = new ArrayList();

		B_KinmuMST kinmutbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from kinmuMST";
			if(strWhere != null){
				sql += strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				kinmutbl = new B_KinmuMST();

				String id = rs.getString("id");
				String number = rs.getString("number");
				String year_month = rs.getString("year_month");
				String hizuke = rs.getString("hizuke");
				String youbi = rs.getString("youbi");
				String PROJECTcode = rs.getString("PROJECTcode");
				String KINMUcode = rs.getString("KINMUcode");
				String startT = rs.getString("startT");
				String endT = rs.getString("endT");
				String restT = rs.getString("restT");
				String cyoukaT = rs.getString("cyoukaT");
				String sinyaT = rs.getString("sinyaT");
				String cyokuT = rs.getString("cyokuT");
				String PROJECTname = rs.getString("PROJECTname");
				String SYUKUJITUname = rs.getString("SYUKUJITUname");
				String furouT = rs.getString("furouT");

				kinmutbl.setId(id);
				kinmutbl.setNumber(number);
				kinmutbl.setYear_month(year_month);
				kinmutbl.setHizuke(hizuke);
				kinmutbl.setYoubi(youbi);
				kinmutbl.setPROJECTcode(PROJECTcode);
				kinmutbl.setKINMUcode(KINMUcode);
				kinmutbl.setStartT(startT);
				kinmutbl.setEndT(endT);
				kinmutbl.setRestT(restT);
				kinmutbl.setCyoukaT(cyoukaT);
				kinmutbl.setSinyaT(sinyaT);
				kinmutbl.setCyokuT(cyokuT);
				kinmutbl.setPROJECTname(PROJECTname);
				kinmutbl.setSYUKUJITUname(SYUKUJITUname);
				kinmutbl.setFurouT(furouT);

				klist.add(kinmutbl);
			}
			return klist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
}
