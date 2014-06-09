package kkweb.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kkweb.common.C_DBConnection;

public class HokokuDAO {

	public boolean updateTbl(String strUpdate ,String strUpdate2,String strUpdate3,String login_id,String shouninsha_number){

		int updated = 0;
		int updated2 = 0;
		ResultSet rs;
		boolean flg = true;
		String iraiSql = "";

		strUpdate = strUpdate.trim();
		strUpdate2 = strUpdate2.trim();
		strUpdate3 = strUpdate3.trim();
		login_id = login_id.trim();
		shouninsha_number = shouninsha_number.trim();

		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;


		try{

			con =dbcon.createConnection();
			Statement stmt = con.createStatement();

			String sql = "select syouninroot from goukeimst ";
				   sql += "where number = '" + strUpdate2 + "' and year_month = '" + strUpdate3 + "'";

			rs = stmt.executeQuery(sql);

			while(rs.next()){
				if(rs.getString("syouninroot") == null || rs.getString("syouninroot").equals("")){

					sql = "update goukeimst set flg = '1',syouninroot = '" + strUpdate + "',iraisha = '" + login_id + "'";
					sql += "  where number = '"+ strUpdate2 + "' and year_month = '"+ strUpdate3 + "'";

					iraiSql = "insert into syouniniraimst(year_month,irainumber,syouninnumber)";
					iraiSql += " values ('" + strUpdate3 + "','" + strUpdate2 + "','" + shouninsha_number + "')";

				}else{
					strUpdate = rs.getString("syouninroot") + " → " + strUpdate;

					sql = "update goukeimst set flg = '1',syouninroot = '" + strUpdate + "',iraisha = '" + login_id + "'";
					sql += "  where number = '"+ strUpdate2 + "' and year_month = '"+ strUpdate3 + "'";

					iraiSql = "update syouniniraimst set syouninnumber = '" + shouninsha_number + "'";
					iraiSql += " where year_month = '" + strUpdate3 + "' and irainumber = '" + strUpdate2 + "'";
				}
				break;
			}

			updated = stmt.executeUpdate(sql);
			updated2 = stmt.executeUpdate(iraiSql);

			if(updated > 0 && updated2 > 0){
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

	public boolean reUpdateTbl(String strUpdate2,String strUpdate3,String login_id){

		int updated = 0;
		int deleted = 0;
		ResultSet rs;
		ResultSet rs2;
		ResultSet rs3;
		boolean flg = false;
		String before = "";
		String before2 = "";
		String iraiid = "";

		strUpdate2 = strUpdate2.trim();
		strUpdate3 = strUpdate3.trim();
		login_id = login_id.trim();

		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;



		try{

			con =dbcon.createConnection();
			Statement stmt = con.createStatement();

			String sql = "select syouninroot from goukeimst ";
				   sql += "where number = '" + strUpdate2 + "' and year_month = '" + strUpdate3 + "'";

			rs = stmt.executeQuery(sql);

			while(rs.next()){

				String root = rs.getString("syouninroot");

				int endIndex = root.lastIndexOf("→");

				if(endIndex < 0){

						sql = "update goukeimst set flg = '2',syouninroot = '',iraisha = ''";
						sql += "  where number = '"+ strUpdate2 + "' and year_month = '"+ strUpdate3 + "'";

						updated = stmt.executeUpdate(sql);

						sql = "delete from syouniniraimst";
						sql += " where year_month = '" + strUpdate3 + "' and irainumber = '" + strUpdate2 + "'";

						deleted = stmt.executeUpdate(sql);

				}else{

					root = root.substring(0, endIndex - 1);

					int beginIndex = root.lastIndexOf("→");

					if(beginIndex < 0){

						root = root.trim();

						before = root;

						sql = "select id from ShainMST where number = '" + strUpdate2 + "'";
						rs3 = stmt.executeQuery(sql);
						rs3.next();
						iraiid = rs3.getString("id");

					}else{

						before = root.substring(beginIndex + 1);

						before = before.trim();

						before2 = root.substring(0, beginIndex - 1);

						beginIndex = before2.lastIndexOf("→");

						if(beginIndex >= 0){
							before2 = before2.substring(beginIndex + 1);
							before2 = before2.trim();
						}

						sql = "select id from ShainMST where name = '" + before2 + "'";
						rs2 = stmt.executeQuery(sql);
						rs2.next();
						iraiid = rs2.getString("id");

					}

					sql = "select number from ShainMST where name = '" + before + "'";
					rs2 = stmt.executeQuery(sql);
					rs2.next();
					String number = rs2.getString("number");

					sql = "update goukeimst set flg = '1',syouninroot = '" + root + "',iraisha = '" + iraiid + "'";
					sql += "  where number = '"+ strUpdate2 + "' and year_month = '"+ strUpdate3 + "'";

					updated = stmt.executeUpdate(sql);

					sql = "update syouniniraimst set syouninnumber = '" + number + "'";
					sql += " where year_month = '" + strUpdate3 + "' and irainumber = '" + strUpdate2 + "'";

					deleted = stmt.executeUpdate(sql);


				}
				break;
			}

			if(updated > 0 && deleted > 0){
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
