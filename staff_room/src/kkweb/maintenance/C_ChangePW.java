package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Errmsg;
import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.dao.LoginDAO;
import kkweb.superclass.C_ChangePageBase;

import org.apache.commons.codec.digest.DigestUtils;

public class C_ChangePW extends C_ChangePageBase {

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
			/// 2013/07/12 新井 機能追加
			/// 目的:エラーページへ書き込み成功時に正しく遷移するため
			else{	// else句を追加
				HttpSession session = request.getSession(true);
				session.setAttribute("changedpw", "true");
			}
			///
			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}
	}

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/jsp/shanai_s/PW_Change_kanryou.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return "";
		}
	}

	public String backPage(HttpServletRequest request){

		try{
			//String nextpage ="/Shain_tuika_error.jsp";
			/// 2013/07/12 新井　変更
			/// 目的 : エラー画面を変更するため
			String nextpage ="/jsp/shanai_s/PW_Change_error.jsp";
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
			C_CheckWord word = new C_CheckWord();

			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String new_pw1 = request.getParameter("new_pw1");
			String new_pw2 = request.getParameter("new_pw2");

			id = word.checks(id);
			pw = word.checks(pw);
			new_pw1 = word.checks(new_pw1);
			new_pw2 = word.checks(new_pw2);

			if(id.equals("") || pw.equals("") || new_pw1.equals("") || new_pw2.equals("")){

				return "未入力の項目があります。";

			}
			String pw2 = DigestUtils.sha1Hex(pw);
			String sql = " where id = '"+id+"' and pw = '"+pw2+"'";
			LoginDAO ldao = new LoginDAO();

			if(ldao.isThereTbl(sql) != true){

				return "入力されたIDとパスワードは正しくありません。";

			}

			if(!new_pw1.equals(new_pw2)){

				return "新しいパスワードをもう一度入力して下さい。";

			}
			
			if(new_pw1.equals(id)){
				return "IDと同じパスワードは設定できません。";
			}

			int kousin = 0;
			String New_Password = DigestUtils.sha1Hex(new_pw1);
			//System.out.println("ハッシュ"+New_Password);
	//		sql = " update shainMST set pw = '"+new_pw1+"' where id = '"+id+"' and pw = '"+pw+"'";
			sql = " update shainMST set pw = '"+New_Password+"' where id = '"+id+"' and pw = '"+pw2+"'";
			cdbc = new C_DBConnection();
			con = cdbc.createConnection();
			stmt = con.createStatement();

			con.setAutoCommit(false);

			kousin = stmt.executeUpdate(sql);

			if(kousin > 0){

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
