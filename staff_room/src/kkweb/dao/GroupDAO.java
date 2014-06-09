package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class GroupDAO {

	public boolean isThereTbl(String strWhere){
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();
			String sql = " select * from groupMST ";

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

		ArrayList glist = new ArrayList();

		B_GroupMST grouptbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select * from groupMST ";
			if(strWhere != null && !strWhere.equals("")){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				grouptbl = new B_GroupMST();

				String GROUPnumber = rs.getString("GROUPnumber");
				String GROUPname = rs.getString("GROUPname");

				grouptbl.setGROUPnumber(GROUPnumber);
				grouptbl.setGROUPname(GROUPname);

				glist.add(grouptbl);
			}
			return glist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}

	public ArrayList selectNmb(String strWhere){

		ArrayList glist = new ArrayList();

		B_GroupMST grouptbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select GROUPnumber from groupMST";
			if(strWhere != null && strWhere.equals("")){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				grouptbl = new B_GroupMST();

			String GROUPnumber = rs.getString("GROUPnumber");
//				String GROUPname = rs.getString("GROUPname");

				grouptbl.setGROUPnumber(GROUPnumber);
//				grouptbl.setGROUPname(GROUPname);

				glist.add(grouptbl);
			}
			return glist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}

	public ArrayList selectName(String strWhere){

		ArrayList glist = new ArrayList();

		B_GroupMST grouptbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select GROUPname from groupMST";
			if(strWhere != null && strWhere.equals("")){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				grouptbl = new B_GroupMST();

//			String GROUPnumber = rs.getString("GROUPnumber");
				String GROUPname = rs.getString("GROUPname");

//				grouptbl.setGROUPnumber(GROUPnumber);
				grouptbl.setGROUPname(GROUPname);

				glist.add(grouptbl);
			}
			return glist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}
}
