package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class ProjectDAO {

	public ArrayList selectTbl(String strWhere){

		ArrayList plist = new ArrayList();

		B_Project projecttbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "select * from project";
			if(strWhere != null){
				sql = sql + strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				projecttbl = new B_Project();

				String PROJECTname = rs.getString("PROJECTname");
				String PROJECTcode = rs.getString("PROJECTcode");
				String KINMUcode = rs.getString("KINMUcode");
				String KINMUname = rs.getString("KINMUname");

				projecttbl.setPROJECTname(PROJECTname);
				projecttbl.setPROJECTcode(PROJECTcode);
				projecttbl.setKINMUcode(KINMUcode);
				projecttbl.setKINMUname(KINMUname);

				plist.add(projecttbl);
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
