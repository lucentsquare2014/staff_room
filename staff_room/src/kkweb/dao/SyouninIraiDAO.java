package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class SyouninIraiDAO {

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from syouninIraiMST ";

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

		ArrayList sylist = new ArrayList();

		B_SyouninIraiMST syouniniraitbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from syouniniraiMST";
			if(strWhere != null){
				sql += strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				syouniniraitbl = new B_SyouninIraiMST();

				String year_month = rs.getString("year_month");
				String iraiNumber = rs.getString("iraiNumber");
				String syouninNumber = rs.getString("syouninNumber");

				syouniniraitbl.setYear_month(year_month);
				syouniniraitbl.setIraiNumber(iraiNumber);
				syouniniraitbl.setSyouninNumber(syouninNumber);

				sylist.add(syouniniraitbl);
			}
			return sylist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
}
