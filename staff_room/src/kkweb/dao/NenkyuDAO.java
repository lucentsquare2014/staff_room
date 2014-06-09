package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class NenkyuDAO {


	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from nenkyuMST ";

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

		ArrayList nlist = new ArrayList();

		B_NenkyuMST nenkyutbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from nenkyuMST";
			if(strWhere != null){
				sql += strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				nenkyutbl = new B_NenkyuMST();

				String number = rs.getString("number");
				String nenkyu_new = rs.getString("nenkyu_new");
				String nenkyu_all = rs.getString("nenkyu_all");
				String nenkyu_year = rs.getString("nenkyu_year");
				String nenkyu_kurikoshi = rs.getString("nenkyu_kurikoshi");
				String nenkyu_fuyo = rs. getString("nenkyu_fuyo");

				nenkyutbl.setNumber(number);
				nenkyutbl.setNenkyu_new(nenkyu_new);
				nenkyutbl.setNenkyu_all(nenkyu_all);
				nenkyutbl.setNenkyu_year(nenkyu_year);
				nenkyutbl.setNenkyu_kurikoshi(nenkyu_kurikoshi);
				nenkyutbl.setNenkyu_fuyo(nenkyu_fuyo);

				nlist.add(nenkyutbl);
			}
			return nlist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
	
	public ArrayList selectTbl2(String strWhere){

		ArrayList nlist = new ArrayList();

		B_NenkyuMST nenkyutbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from nenkyuMST";
			if(strWhere != null){
				sql += strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				nenkyutbl = new B_NenkyuMST();

				String number = rs.getString("number");
				String nenkyu_new = rs.getString("nenkyu_new");
				String nenkyu_all = rs.getString("nenkyu_all");
				String nenkyu_year = rs.getString("nenkyu_year");
				String nenkyu_kurikoshi = rs.getString("nenkyu_kurikoshi");
				String nenkyu_fuyo = rs. getString("nenkyu_fuyo");

				nenkyutbl.setNumber(number);
				nenkyutbl.setNenkyu_new(nenkyu_new);
				nenkyutbl.setNenkyu_all(nenkyu_all);
				nenkyutbl.setNenkyu_year(nenkyu_year);
				nenkyutbl.setNenkyu_kurikoshi(nenkyu_kurikoshi);
				nenkyutbl.setNenkyu_fuyo(nenkyu_fuyo);

				nlist.add(nenkyutbl);
			}
			return nlist;

		}catch(SQLException e){
			
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
}
