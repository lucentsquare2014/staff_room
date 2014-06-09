package kkweb.dao;

import java.sql.*;
import java.util.*;

import kkweb.beans.*;
import kkweb.common.*;

public class KekkinDAO {

	public ArrayList selectTbl(String strWhere){

		ArrayList klist = new ArrayList();

		B_KekkinMST kekkintbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
			con = dbcon.createConnection();

			String sql = "select * from kekkinMST";
			if(strWhere != null){
				sql += strWhere;
			}

			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while(rs.next()){

				kekkintbl = new B_KekkinMST();

				String number = rs.getString("number");
				String year = rs.getString("year");
				String goukeiKekkin = rs.getString("goukeiKekkin");

				kekkintbl.setNumber(number);
				kekkintbl.setYear(year);
				kekkintbl.setGoukeiKekkin(goukeiKekkin);

				klist.add(kekkintbl);
			}
			return klist;

		}catch(SQLException e){
			e.printStackTrace();
			return null;

		}finally{
			dbcon.closeConection(con);
		}
	}
}
