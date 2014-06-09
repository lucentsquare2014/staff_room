package kkweb.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import kkweb.beans.B_GamenInsatu;
import kkweb.common.C_DBConnection;



public class GameninsatuDAO {

	public ArrayList insatuTbl(String strWhere){
		//ArrayList型変数の作成
		ArrayList ilist = new ArrayList();

		B_GamenInsatu tbl = null;
		C_DBConnection dbcon = new C_DBConnection();
		Connection con = null;

		try{

			con = dbcon.createConnection();
			//勤務マスタと合計マスタをnumberで関連付ける文を作成
			//String sql = "select * from  ( ( ( goukeiMST inner join kinmuMST on  kinmuMST.number = goukeiMST.number and kinmuMST.year_month = goukeiMST.year_month ) inner join shainMST on goukeiMST.number = shainMST.number ) inner join groupMST on shainMST.groupnumber = groupMST.groupnumber ) inner join nenkyuMST on nenkyuMST.number = shainMST.number ";
			String sql = "select * from   ( ( goukeiMST inner join kinmuMST on  kinmuMST.number = goukeiMST.number and kinmuMST.year_month = goukeiMST.year_month ) inner join shainMST on goukeiMST.number = shainMST.number ) inner join nenkyuMST on nenkyuMST.number = shainMST.number ";
			if(strWhere != null){
				sql = sql + strWhere;
			}
			//ステートメントオブジェクトを作成
			Statement stmt = con.createStatement();
			//実行して結果のsetを取得する
			ResultSet rs = stmt.executeQuery(sql);

			//行が無くなるまで繰り返す
			while (rs.next()){

				tbl = new B_GamenInsatu();
			//データベースから取り寄せたものをstring型に
				String id = rs.getString("id");
				String year_month = rs.getString("year_month");
				String cyoukamonth = rs.getString("cyoukamonth");
				String sinyamonth = rs.getString("sinyamonth");
				String furoumonth = rs.getString("furoumonth");
				String kyudemonth = rs.getString("kyudemonth");
				String daikyumonth = rs.getString("daikyumonth");
				String nenkyumonth = rs.getString("nenkyumonth");
				String kekkinmonth = rs.getString("kekkinmonth");
				String akyumonth = rs.getString("akyumonth");
				String bkyumonth = rs.getString("bkyumonth");
				String goukeimonth = rs.getString("goukeimonth");
				String flg = rs.getString("flg");
				String syouninroot = rs.getString("syouninroot");
				String iraisha = rs.getString("iraisha");
				String hizuke = rs.getString("hizuke");
				String youbi = rs.getString("youbi");
				String projectcode = rs.getString("projectcode");
				String kinmucode = rs.getString("kinmucode");
				String startt = rs.getString("startt");
				String endt = rs.getString("endt");
				String restt = rs.getString("restt");
				String cyoukat = rs.getString("cyoukat");
				String sinyat = rs.getString("sinyat");
				String cyokut = rs.getString("cyokut");
				String PROJECTname = rs.getString("projectname");
				String syukujituname = rs.getString("syukujituname");
				String furout = rs.getString("furout");
				String name = rs.getString("name");
				String pw = rs.getString("pw");
				String checked = rs.getString("checked");
				String number = rs.getString("number");
				String groupnumber = rs.getString("groupnumber");
				String mail = rs.getString("mail");
				String nenkyu_all = rs.getString("nenkyu_all");
				String nenkyu_new = rs.getString("nenkyu_new");
				String nenkyu_year = rs.getString("nenkyu_year");
				String nenkyu_kurikoshi = rs.getString("nenkyu_kurikoshi");
				String nenkyu_fuyo = rs.getString("nenkyu_fuyo");

			//それをb_Eturangamen型にセット
				tbl.setId(id);
				tbl.setYear_month(year_month);
				tbl.setCyoukaMONTH(cyoukamonth);
				tbl.setSinyaMONTH(sinyamonth);
				tbl.setFurouMONTH(furoumonth);
				tbl.setKyudeMONTH(kyudemonth);
				tbl.setDaikyuMONTH(daikyumonth);
				tbl.setNenkyuMONTH(nenkyumonth);
				tbl.setAkyuMONTH(akyumonth);
				tbl.setKekkinmonth(kekkinmonth);
				tbl.setBkyuMONTH(bkyumonth);
				tbl.setGoukeiMONTH(goukeimonth);
				tbl.setFlg(flg);
				tbl.setSyouninroot(syouninroot);
				tbl.setIraisha(iraisha);
				tbl.setHizuke(hizuke);
				tbl.setYoubi(youbi);
				tbl.setPROJECTcode(projectcode);
				tbl.setKINMUcode(kinmucode);
				tbl.setStartT(startt);
				tbl.setEndT(endt);
				tbl.setRestT(restt);
				tbl.setCyoukaT(cyoukat);
				tbl.setPROJECTname(PROJECTname);
				tbl.setSinyaT(sinyat);
				tbl.setCyokuT(cyokut);
				tbl.setSYUKUJITUname(syukujituname);
				tbl.setFurouT(furout);
				tbl.setName(name);
				tbl.setPw(pw);
				tbl.setChecked(checked);
				tbl.setNumber(number);
				tbl.setGROUPnumber(groupnumber);
				tbl.setMail(mail);
				tbl.setNenkyu_all(nenkyu_all);
				tbl.setNenkyu_new(nenkyu_new);
				tbl.setNenkyu_year(nenkyu_year);
				tbl.setNenkyu_kurikoshi(nenkyu_kurikoshi);
				tbl.setNenkyu_fuyo(nenkyu_fuyo);

			//後付でlistに加えていく
				ilist.add(tbl);
			}
		return ilist;

//例外を投げる
	}catch(SQLException e){
		e.printStackTrace();
		return null;
	}finally{
		dbcon.closeConection(con);
	}
	}
}


