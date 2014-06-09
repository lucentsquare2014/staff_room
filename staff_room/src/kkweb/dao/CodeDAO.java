package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class CodeDAO {

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from codemst ";

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

		ArrayList clist = new ArrayList();

		B_Code codetbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = strWhere;

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				codetbl = new B_Code();

				String PROJECTcode = rs.getString("PROJECTcode");
				String PROJECTname = rs.getString("PROJECTname");
				String KINMUcode = rs.getString("KINMUcode");
				String startTIME = rs.getString("startTIME");
				String endTIME = rs.getString("endTIME");
				String restTIME = rs.getString("restTIME");
				String bikou = rs.getString("bikou");
				String basyo = rs.getString("basyo");

				codetbl.setPROJECTcode(PROJECTcode);
				codetbl.setPROJECTname(PROJECTname);
				codetbl.setKINMUcode(KINMUcode);
				codetbl.setStartTIME(startTIME);
				codetbl.setEndTIME(endTIME);
			    codetbl.setRestTIME(restTIME);
				codetbl.setBikou(bikou);
				codetbl.setBasyo(basyo);

				clist.add(codetbl);
			}
			return clist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}
}
