package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Project_kousin extends  C_ChangePageBase {

	public String checkRequest(HttpServletRequest request){

		try{

			String errmsg = dbKakikomi(request);

			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}

	}

	public String nextPage(HttpServletRequest request){

		try{

			String nextpage = "/jsp/shanai_s/Project_Maintenance.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String backpage = "/jsp/shanai_s/Maintenance_error.jsp";

			return backpage;

		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}
	}

	private String dbKakikomi(HttpServletRequest request) throws SQLException{

		C_DBConnection dbcon = null;
		Connection con = null;
		Statement stmt = null;

		try{
			request.setCharacterEncoding("Windows-31J");

			String p_size = request.getParameter("p_size");
			int size = Integer.parseInt(p_size);
			C_CheckWord word = new C_CheckWord();

			dbcon = new C_DBConnection();
			con = dbcon.createConnection();
			stmt = con.createStatement();
			con.setAutoCommit(false);

			String pro_name = request.getParameter("pro_name");
			pro_name=word.checks(pro_name);
			String pro_code = request.getParameter("pro_code");
			pro_code=word.checks(pro_code);

			if (pro_name.equals("")){

				String sql = " update codemst set flg = '1' where projectcode = '" + pro_code + "'";
				int delete = stmt.executeUpdate(sql);

				if(delete > 0){

					con.commit();

					return "";

				}else{

					con.rollback();

					return "削除に失敗しました。";

				}

			}

			int update = 0;
			int work = 0;

			//時間記入が数値型じゃない場合にエラーを発生させる処理
			for(int x=0 ;x<=size-1; ++x){

				String pro_kaisi = request.getParameter("pro_kaisi"+String.valueOf(x));
				String pro_shuuryou = request.getParameter("pro_shuuryou"+String.valueOf(x));
				String pro_kyuukei = request.getParameter("pro_kyuukei"+String.valueOf(x));

				boolean kaisi_check = Nyuryokucheck(pro_kaisi);
				boolean shuuryou_check = Nyuryokucheck(pro_shuuryou);
				boolean kyuukei_check = Nyuryokucheck(pro_kyuukei);

				if(kaisi_check != true || shuuryou_check != true || kyuukei_check != true){
				break;
				}

				kaisi_check = checkLength(pro_kaisi);
				shuuryou_check = checkLength(pro_shuuryou);

				if(kaisi_check != true || shuuryou_check != true){
				break;
				}

				kaisi_check = checkMinute(pro_kaisi);
				shuuryou_check = checkMinute(pro_shuuryou);

				if(kaisi_check != true || shuuryou_check != true){
				break;
				}

				kaisi_check = checkJikan(pro_kaisi);
				shuuryou_check = checkJikan(pro_shuuryou);

				if(kaisi_check != true || shuuryou_check != true){
				break;
				}

				if(pro_kaisi.equals("") && !pro_shuuryou.equals("")){
				break;
				}

				if(!pro_kaisi.equals("") && pro_shuuryou.equals("")){
				break;
				}

				String pro_basho = request.getParameter("pro_basho"+String.valueOf(x));
				pro_basho = word.checks(pro_basho);
				String pro_bikou = request.getParameter("pro_bikou"+String.valueOf(x));
				pro_bikou=word.checks(pro_bikou);

				String sql2 =" update codemst set projectname = '" + pro_name + "' , starttime = '" + pro_kaisi + "' , endtime = '" + pro_shuuryou + "' , resttime = '"+pro_kyuukei+"' , basyo = '" + pro_basho + "' where projectcode = '" + pro_code + "' and bikou = '"+ pro_bikou +"'";
				work = stmt.executeUpdate(sql2);

				update += work;

			}

			if(update < size){

				con.rollback();

				return "書き込みを失敗しました。";

			}else{

				con.commit();

				return "";

			}

		}catch(Exception e){

			//e.printStackTrace();

			con.rollback();

			return "書き込みを失敗しました。";

		}

	}

	private boolean Nyuryokucheck(String strWhere){

		if(strWhere.equals("")){

			return true;

		}else if(checkHanNum(strWhere) == true){

			return true;

		}else{

			return false;

		}
	}

	private boolean checkHanNum(String item){	//チェックする文字列

		boolean flag = true;

		for(int i=0; item.length()>i && flag==true; i++){
			if('0'<=item.charAt(i) && item.charAt(i)<='9') {

			}else{
				flag=false;
			}
		}
		return flag;
	}

	private boolean checkLength(String strWhere){

		if(strWhere.equals("")){
			return true;
		}else{
			if(strWhere.length() != 4){
				return false;
			}else{
				return true;
			}
		}
	}

	private boolean checkMinute(String strWhere){

		if(strWhere.equals("")){
			return true;
		}else{
			int minute = Integer.parseInt(strWhere.substring(2));
			if(minute > 59){
				return false;
			}else{
				return true;
			}
		}
	}

	private boolean checkJikan(String strWhere){

		if(strWhere.equals("")){
			return true;
		}else{
			int jikan = Integer.parseInt(strWhere);
			if(jikan >= 2400){
				return false;
			}else{
				return true;
			}
		}
	}

}
