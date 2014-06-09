package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Errmsg;
import kkweb.beans.B_ShainMentenanceMST;
import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Shain_delete extends C_ChangePageBase {

	public String checkRequest(HttpServletRequest request){

		try{

			String errmsg = "";

			errmsg = dbKakikomi(request);

			if(!errmsg.equals("")){

				HttpSession session = request.getSession(true);

				B_Errmsg bmsg = new B_Errmsg();
				bmsg.setErrmsg(errmsg);

				session.setAttribute("errmsg", bmsg);

			}

			return errmsg;


		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}
	}

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/jsp/shanai_s/Shain_tuika_kanryou.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return "";
		}
	}

	public String backPage(HttpServletRequest request){

		try{
			String nextpage ="/jsp/shanai_s/Shain_tuika_error.jsp";
			return nextpage;

		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}
	}

	private String dbKakikomi(HttpServletRequest request) throws SQLException{

		C_DBConnection cdbc = null;
		Connection con = null;
		Statement stmt = null;

		try{
			request.setCharacterEncoding("UTF-8");

			HttpSession session = request.getSession(true);
			C_CheckWord word = new C_CheckWord();
			B_ShainMentenanceMST shainmst = (B_ShainMentenanceMST)session.getAttribute("Shain");
			String checked = shainmst.getChecked();
			checked = word.checks(checked);
			String shainNumber = shainmst.getNumber();
			shainNumber = word.checks(shainNumber);
			int kousin = 0;
			int kousin1 = 1;
			String sql = "";

			cdbc = new C_DBConnection();
			con = cdbc.createConnection();
			stmt = con.createStatement();

			con.setAutoCommit(false);

			if(checked.equals("1")){

				sql = "delete from syouninshaMST where number ='"+shainNumber+"'";

				kousin1 = stmt.executeUpdate(sql);

			}

			sql = " update shainMST set zaiseki_flg = '0',checked = '0',groupnumber = '0' where number ='"+shainNumber+"'";

			kousin = stmt.executeUpdate(sql);
			
			if(kousin > 0 && kousin1 > 0){

				con.commit();

				return "";

			}else{

				con.rollback();

				return "書き込み失敗";

			}

		}catch(Exception e){

			//e.printStackTrace();

			con.rollback();

			return "書き込み失敗";

		}
	}


}
