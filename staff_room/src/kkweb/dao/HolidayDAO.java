package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class HolidayDAO {

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from holidayMST ";

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

		ArrayList hlist = new ArrayList();

		B_HolidayMST holidaytbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select * from holidayMST";
			if(strWhere != null){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				holidaytbl = new B_HolidayMST();

				String SYUKUJITUdate = rs.getString("SYUKUJITUdate");
				String SYUKUJITUname = rs.getString("SYUKUJITUname");

				holidaytbl.setSYUKUJITUdate(SYUKUJITUdate);
				holidaytbl.setSYUKUJITUname(SYUKUJITUname);

				hlist.add(holidaytbl);
			}
			return hlist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}
}
