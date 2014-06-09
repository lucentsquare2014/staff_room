package kkweb.dao;

import java.sql.*;
import java.util.ArrayList;

import kkweb.beans.B_Eturangamen;
import kkweb.common.C_DBConnection;


public class EturangamenDAO {

	public ArrayList eturanTbl(String strWhere){
		//arraylist型変数の作成
		ArrayList elist = new ArrayList();

		B_Eturangamen tbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{
		//	select * from ( goukeiMST inner join shainMST on goukeiMST.number = shainMST.number ) inner join groupMST on groupMST.groupnumber = shainMST.groupnumber where flg = '0' and zaiseki_flg = '0' order by to_number(year_month,'999999') desc 
		//	select * from goukeiMST inner join shainMST on goukeiMST.number = shainMST.number where flg = '0' and zaiseki_flg = '0' order by to_number(year_month,'999999') desc  
			con = dbcon.createConnection();
			//合計マスタと社員マスタをnumberで関連付けるsql文を作成
			
			//String sql = "select * from ( goukeiMST inner join shainMST on goukeiMST.number = shainMST.number ) inner join groupMST on groupMST.groupnumber = shainMST.groupnumber ";
			String sql = "select goukeiMST.number,goukeiMST.year_month,goukeiMST.flg,shainMST.groupnumber,shainMST.zaiseki_flg from (goukeiMST inner join shainMST on goukeiMST.number = shainMST.number) ";
			
			if(strWhere != null){
				sql = sql + strWhere;
			}
			
			//ステートメントオブジェクトを作成
			Statement stmt = con.createStatement();
			//sqlを実行して結果のsetを取得する
			ResultSet rs = stmt.executeQuery(sql);
			
			//行が無くなるまで繰り返す
			while (rs.next()){
				
				tbl = new B_Eturangamen();
				
			//sqlでデータベースから取り寄せたものをstring型に
				String flg = rs.getString("flg");
				
			//	String name = rs.getString("name");
				
				String year_month = rs.getString("year_month");
				
				//String groupname = rs.getString("groupname");
				
			//	String id = rs.getString("id");
				
			//	String cyoukamonth = rs.getString("cyoukamonth");
				
			//	String sinyamonth = rs.getString("sinyamonth");
				
			//	String furoumonth = rs.getString("furoumonth");
				
			//	String kyudemonth = rs.getString("kyudemonth");
				
			//	String daikyumonth = rs.getString("daikyumonth");
				
			//	String nenkyumonth = rs.getString("nenkyumonth");
				
			//	String akyumonth = rs.getString("akyumonth");
				
			//	String bkyumonth = rs.getString("bkyumonth");
				
			//	String goukeimonth = rs.getString("goukeimonth");
				
			//	String syouninroot = rs.getString("syouninroot");
				
			//	String iraisha = rs.getString("iraisha");
				
			//	String pw = rs.getString("pw");
				
			//	String checked = rs.getString("checked");
				
				String number = rs.getString("number");
				
				String groupnumber = rs.getString("groupnumber");
				
			//	String mail = rs.getString("mail");
				
				String zaiseki_flg = rs.getString("zaiseki_flg");
				

			//それをb_Eturangamen型のtblにセット
				tbl.setFlg(flg);
				tbl.setName("");
				tbl.setYear_month(year_month);
				//tbl.setGroupname(groupname);
				tbl.setId("");
				tbl.setCyoukamonth("");
				tbl.setSinyamonth("");
				tbl.setFuroumonth("");
				tbl.setKyudemonth("");
				tbl.setDaikyumonth("");
				tbl.setNenkyumonth("");
				tbl.setAkyumonth("");
				tbl.setBkyumonth("");
				tbl.setGoukeimonth("");
				tbl.setSyouninroot("");
				tbl.setIraisha("");
				tbl.setPw("");
				tbl.setChecked("");
				tbl.setNumber(number);
				tbl.setGroupnumber(groupnumber);
				tbl.setMail("");
				tbl.setZaiseki_flg(zaiseki_flg);

			//後付でelistに加えていく
				elist.add(tbl);
			}
		return elist;

//例外を投げる
	}catch(SQLException e){
		e.printStackTrace();
		return null;
	}finally{
		dbcon.closeConection(con);
	}
	}
}
