package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class SyouninshaDAO {

	public ArrayList selectTbl(String strWhere){

		ArrayList slist = new ArrayList();

		B_SyouninshaMST syouninshatbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from syouninshaMST " ;
			
			if(strWhere != null){
				sql += strWhere + " order by hyouzijun asc ";
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				syouninshatbl = new B_SyouninshaMST();

				String name = rs.getString("name");
				String id = rs.getString("id");
				String mail = rs.getString("mail");
				String GROUPnumber = rs.getString("GROUPnumber");
				String number = rs.getString("number");
				String hyouzijun = rs.getString("hyouzijun");


				syouninshatbl.setName(name);
				syouninshatbl.setId(id);
				syouninshatbl.setMail(mail);
				syouninshatbl.setGROUPnumber(GROUPnumber);
				syouninshatbl.setNumber(number);
				syouninshatbl.setHyouzijun(hyouzijun);

				slist.add(syouninshatbl);
			}
			return slist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
}


