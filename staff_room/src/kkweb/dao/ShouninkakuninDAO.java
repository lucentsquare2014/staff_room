package kkweb.dao;

import java.sql.*;

import kkweb.common.*;

public class ShouninkakuninDAO {

	public boolean updateTbl(String strUpdate,String strUpdate2,String nenkyu_new,String nenkyu_all,String nenkyu_year,String nenkyu_kurikoshi,String nenkyu_fuyo,boolean check){

		int updated = 0;
		int updated2 = 1;
		int updated3 = 0;
		int updated4 = 0;
		boolean flg = true;

		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con =dbcon.createConnection();

			String sql = "update goukeimst set flg = '0'  where number = '"+ strUpdate + "' and year_month = '"+ strUpdate2 + "'";

			Statement stmt = con.createStatement();
			updated = stmt.executeUpdate(sql);

			if(check){

			sql = "delete from syouniniraimst  where irainumber = '"+ strUpdate + "' and year_month = '"+ strUpdate2 + "'";

			updated2 = stmt.executeUpdate(sql);

			}

			sql = "update nenkyumst set nenkyu_new ='"+nenkyu_new+"',nenkyu_all='"+nenkyu_all+"',nenkyu_year='"+nenkyu_year+"',nenkyu_kurikoshi='"+nenkyu_kurikoshi+"',nenkyu_fuyo='"+nenkyu_fuyo+"' where number='"+strUpdate+"'";

			updated3 = stmt.executeUpdate(sql);

			sql = "delete from nenkyumst_work where number ='"+strUpdate+"' and year_month='"+strUpdate2+"'";

			updated4 = stmt.executeUpdate(sql);

			if(updated > 0 && updated2 > 0 && updated3 > 0 && updated4 > 0){
				flg = true;
			}else{
				flg = false;
			}
			return flg;

		}catch(SQLException e){
			e.printStackTrace();

			return false ;

		}finally{
			dbcon.closeConection(con);
		}
	}
}
