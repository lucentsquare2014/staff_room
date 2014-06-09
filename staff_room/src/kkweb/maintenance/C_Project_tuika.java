package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Project_tuika extends  C_ChangePageBase {

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

			String nextpage = "/Project_Maintenance.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String backpage = "/Maintenance_error.jsp";

			return backpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	private String dbKakikomi(HttpServletRequest request) throws SQLException{

		C_DBConnection dbcon = null;
		Connection con = null;
		Statement stmt = null;

		try {

			request.setCharacterEncoding("Windows-31J");

			C_CheckWord word = new C_CheckWord();

			dbcon = new C_DBConnection();
			con = dbcon.createConnection();
			stmt = con.createStatement();
			con.setAutoCommit(false);

			int update = 0;
			int work = 0;

			//時間記入が数値型じゃない場合にエラーを発生させる処理
			for(int x=0 ;x<=10; ++x){

				String kaisi_jikan = request.getParameter("kaisi_jikan"+String.valueOf(x));
				String shuuryou_jikan = request.getParameter("shuuryou_jikan"+String.valueOf(x));
				String kyuukei_jikan = request.getParameter("kyuukei_jikan"+String.valueOf(x));

				boolean kaisi_check = Nyuryokucheck(kaisi_jikan);
				boolean shuuryou_check = Nyuryokucheck(shuuryou_jikan);
				boolean kyuukei_check = Nyuryokucheck(kyuukei_jikan);

				if(kaisi_check != true || shuuryou_check != true || kyuukei_check != true){
					con.rollback();
					return "時間は数字のみで入力して下さい。";
				}

				kaisi_check = checkLength(kaisi_jikan);
				shuuryou_check = checkLength(shuuryou_jikan);

				if(kaisi_check != true || shuuryou_check != true){
					con.rollback();
					return "時間は４桁で入力して下さい。";
				}

				kaisi_check = checkMinute(kaisi_jikan);
				shuuryou_check = checkMinute(shuuryou_jikan);

				if(kaisi_check != true || shuuryou_check != true){
					con.rollback();
					return "正しい時間を入力して下さい。";
				}

				kaisi_check = checkJikan(kaisi_jikan);
				shuuryou_check = checkJikan(shuuryou_jikan);

				if(kaisi_check != true || shuuryou_check != true){
					con.rollback();
					return "正しい時間を入力して下さい。";
				}

				if(kaisi_jikan.equals("") && !shuuryou_jikan.equals("")){
					con.rollback();
					return "未入力の時間があります。";
				}

				if(!kaisi_jikan.equals("") && shuuryou_jikan.equals("")){
					con.rollback();
					return "未入力の時間があります。";
				}

				String k_code = request.getParameter("k_code"+String.valueOf(x));
				k_code=word.checks(k_code);
				String k_name = request.getParameter("k_name"+String.valueOf(x));
				k_name=word.checks(k_name);
				String p_name = request.getParameter("p_name"+String.valueOf(x));
				p_name = word.checks(p_name);
				String p_code = request.getParameter("p_code"+String.valueOf(x));
				p_code=word.checks(p_code);
				String basho = request.getParameter("basho"+String.valueOf(x));
				basho=word.checks(basho);

				if(k_code.equals("") || k_name.equals("")){

				}else{

					String sql = " INSERT INTO codemst ( projectcode, projectname, kinmucode, starttime, endtime, resttime, bikou, basyo, flg ) VALUES ('" + p_code + "' ,  '" + p_name + "' , '" + k_code + "' , '" + kaisi_jikan + "' , '" + shuuryou_jikan + "' ,  '" + kyuukei_jikan + "' , '" + k_name + "' , '" + basho + "', '0'  )";

					update = stmt.executeUpdate(sql);

					if(update <= 0){

						con.rollback();

						return "書き込み失敗";

					}

				}
			}

			con.commit();

			return "";

		}catch(Exception e){

			//e.printStackTrace();

			con.rollback();

			return "書き込みに失敗しました。";

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

