package kkweb.dao;

import java.sql.*;
import java.util.ArrayList;

import kkweb.beans.B_ShainMST;
import kkweb.beans.B_Shouninjoukyou;
import kkweb.common.C_DBConnection;

public class ShouninjoukyouDAO {

	public ArrayList selectTbl(String strWhere){

		ArrayList slist = new ArrayList();

		B_Shouninjoukyou tbl =null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select * from goukeiMST right join shainMST on goukeiMST.number = shainMST.number ";
			if(strWhere != null){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				tbl = new B_Shouninjoukyou();

				String flg = rs.getString("flg");
				String name = rs.getString("name");
				String year_month = rs.getString("year_month");
				String group = rs.getString("groupnumber");
				String zaiseki_flg = rs.getString("zaiseki_flg");

				tbl.setFlg(flg);
				tbl.setName(name);
				tbl.setYear_month(year_month);
				tbl.setGroup(group);
				tbl.setZaiseki_flg(zaiseki_flg);

				slist.add(tbl);

			}
			return slist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}

	public ArrayList shainTbl(String strWhere){

		ArrayList shlist = new ArrayList();

		B_ShainMST tbl =null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();
			
			String sql = "select * from shainMST  ";
			if(strWhere != null){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				tbl = new B_ShainMST();

				String name = rs.getString("name");
				String groupnumber = rs.getString("groupnumber");
				String zaiseki_flg = rs.getString("zaiseki_flg");

				tbl.setName(name);
				tbl.setZaiseki_flg(zaiseki_flg);
				tbl.setGROUPnumber(groupnumber);

				shlist.add(tbl);

			}
			return shlist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}

}

