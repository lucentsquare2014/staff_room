package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class ZangyouDAO {

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from zangyouMST ";

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

		ArrayList mlist = new ArrayList();

		B_ZangyouMST zangyoutbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select * from zangyouMST";
			if(strWhere != null){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				zangyoutbl = new B_ZangyouMST();

				String number = rs.getString("number");
				String year = rs.getString("year");
				String goukeiZangyou = rs.getString("zangyouyear");
				String month = rs.getString("month");
				String zangyoumonth = rs.getString("zangyoumonth");

				zangyoutbl.setNumber(number);
				zangyoutbl.setYear(year);
				zangyoutbl.setGoukeiZangyou(goukeiZangyou);
				zangyoutbl.setMonth(month);
				zangyoutbl.setZangyoumonth(zangyoumonth);

				mlist.add(zangyoutbl);
			}
			return mlist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}


public ArrayList selectTbl2(String strWhere){

	ArrayList mlist = new ArrayList();

	B_ZangyouMST zangyoutbl = null;
	C_DBConnection dbcon = new C_DBConnection();
	Connection con = null;

	try{

		con =dbcon.createConnection();

		String sql = "select * from zangyouMST";
		if(strWhere != null){
			sql = sql + strWhere;
		}

		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		while(rs.next()){

			zangyoutbl = new B_ZangyouMST();

			String number = rs.getString("number");
			String year = rs.getString("year");
			String goukeiZangyou = rs.getString("zangyouyear");
			String month = rs.getString("month");
			String zangyoumonth = rs.getString("zangyoumonth");

			zangyoutbl.setNumber(number);
			zangyoutbl.setYear(year);
			zangyoutbl.setGoukeiZangyou(goukeiZangyou);
			zangyoutbl.setMonth(month);
			zangyoutbl.setZangyoumonth(zangyoumonth);

			mlist.add(zangyoutbl);
		}
		return mlist;

	}catch(SQLException e){
		
		return null;
	}finally{
		dbcon.closeConection(con);
		}
	}
}
