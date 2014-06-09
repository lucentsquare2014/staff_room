package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class PROJECTnameDAO {

	public ArrayList selectTbl(String strWhere){

		ArrayList plist = new ArrayList();

		B_Projectname ptbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = strWhere;

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				ptbl = new B_Projectname();

				String PROJECTname = rs.getString("PROJECTname");
				String PROJECTcode = rs.getString("PROJECTcode");

				ptbl.setPROJECTname(PROJECTname);
				ptbl.setPROJECTcode(PROJECTcode);

				plist.add(ptbl);
			}
			return plist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}finally{
			dbcon.closeConection(con);
		}
	}
}


