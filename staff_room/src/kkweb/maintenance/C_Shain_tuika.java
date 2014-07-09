package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Errmsg;
import kkweb.common.C_CheckComm;
import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.common.C_ErrMsg;
import kkweb.common.C_HankakuCheck;
import kkweb.dao.GroupDAO;
import kkweb.dao.LoginDAO;
import kkweb.superclass.C_ChangePageBase;

import org.apache.commons.codec.digest.DigestUtils;

public class C_Shain_tuika extends C_ChangePageBase {

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

//			HttpSession session = request.getSession(true);
			C_CheckWord word = new C_CheckWord();
			String f_name = request.getParameter("f_name").trim();
			f_name = word.checks(f_name);
			String g_name = request.getParameter("g_name").trim();
			g_name = word.checks(g_name);

			//フリガナの追加 2014-06-13
			String hurigana = request.getParameter("hurigana").trim();
			hurigana = word.checks(hurigana);
			//管理者権限を追加
			String administrator = request.getParameter("administrator").trim();
			administrator = word.checks(administrator);
			
			String id = request.getParameter("id").trim();
			id = word.checks(id);
			String pw = request.getParameter("pw").trim();
			pw = word.checks(pw);
			String number = request.getParameter("number").trim();
			number = word.checks(number);
			String groupnumber = request.getParameter("groupnumber").trim();
			groupnumber = word.checks(groupnumber);
			String checked = request.getParameter("checked").trim();
			checked = word.checks(checked);
			String hyouzijun = request.getParameter("hyouzijun").trim();
			hyouzijun = word.checks(hyouzijun);
			String yakusyoku = request.getParameter("yakusyoku").trim();
			yakusyoku = word.checks(yakusyoku);
			//スケジュール用グループ番号と表示順を追加2014-07-08
			String k_gruno = request.getParameter("k_gruno").trim();
			k_gruno = word.checks(k_gruno);
			String k_pass2 = request.getParameter("k_pass2").trim();
			k_pass2 = word.checks(k_pass2);
						
			String name = f_name+"　"+g_name;

			//本番用
			String mail = request.getParameter("mail").trim();
			mail = word.checks(mail);

			if(!mail.equals("")){

				mail = mail + "@lucentsquare.co.jp";

			}

			//テスト用
			//String mail = "h-shibui@lucentsquare.co.jp";

			if(mail.equals("") || f_name.equals("") || g_name.equals("") || id.equals("") || pw.equals("") || number.equals("") || groupnumber.equals("") || checked.equals("")){
				return "値の未入力の項目があります。";
			}

			if(checkChecked(checked) != true){
				return "承認者チェックは半角数字の0か1を入力してください。";
			}

			if(checkAdministrator(administrator) != true){
				return "管理者権限は半角数字の0か1を入力してください。";
			}

			if(checkShain(id) == true){

				return "入力されたIDは現在使用されています";

			}else if(checkShainnumber(number) == true){

				return "入力された社員番号は現在使用されています";

			}else if(checkShaingroup(groupnumber) != true){

				return "正しいグループ番号を入力して下さい";

			//本番時に以下の２行を追加
			}else if(checkShainmail(mail)){

				return "入力されたメールアドレスは現在使用されています";

			}else{

				int kousin1 = 1;
				int kousin2 = 0;
				int kousin3 = 0;
				int kousin4 = 0;
				String sql = "";

				cdbc = new C_DBConnection();
				con = cdbc.createConnection();
				stmt = con.createStatement();

				con.setAutoCommit(false);

				if(checked.equals("1")){

					sql = "insert into syouninshaMST values ('"+name+"','"+id+"','"+mail+"','"+groupnumber+"','"+number+"','"+hyouzijun+"')";

					kousin1 = stmt.executeUpdate(sql);

				}
				String pw1 = DigestUtils.sha1Hex(pw);
		//		System.out.println("ハッシュ"+pw1);
		//		sql = " insert into shainMST values ('"+id+"','"+pw+"','"+checked+"','"+name+"','"+number+"','"+groupnumber+"','"+mail+"','1')";
		//		sql = " insert into shainMST values ('"+id+"','"+pw1+"','"+checked+"','"+name+"','"+number+"','"+groupnumber+"','"+mail+"','1','"+hyouzijun+"','"+yakusyoku+"')";
				// フリガナと管理者権限を追加したsql↓
				sql = " insert into shainMST values ('"+id+"','"+pw1+"','"+checked+"','"+name+"','"+number+"','"+groupnumber+"','"+mail+"','1','"+hyouzijun+"','"+yakusyoku+
						"','"+hurigana+"','"+administrator+"','"+k_gruno+"','"+k_pass2+"')";

				kousin2 = stmt.executeUpdate(sql);

				sql = " insert into nenkyuMST values ('"+number+"','10','10','0','0','10')";

				kousin3 = stmt.executeUpdate(sql);
				

				if(kousin1 > 0 && kousin2 > 0 && kousin3 > 0){

					con.commit();
					// shainkanriに行を追加  2014-06-13
					String sql1 = "insert into shainkanri(shain_number) values('"+number+"')";
					
					kousin4 = stmt.executeUpdate(sql1);
					con.commit();

					return "";

				}else{

					con.rollback();

					return "書き込み失敗";

				}

			}


		}catch(Exception e){

			//e.printStackTrace();

			con.rollback();

			return "書き込み失敗";

		}
	}

	private boolean checkShain(String id){

		LoginDAO ldao = new LoginDAO();
		String sql = " where id ='"+id+"' and zaiseki_flg='1'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShainnumber(String number){

		LoginDAO ldao = new LoginDAO();
		String sql = " where number ='"+number+"'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShainmail(String mail){

		LoginDAO ldao = new LoginDAO();
		String sql = " where mail ='"+mail+"' and zaiseki_flg='1'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShaingroup(String groupnumber){

		GroupDAO gdao = new GroupDAO();
		String sql = " where GROUPnumber ='"+groupnumber+"'";

		return gdao.isThereTbl(sql);
	}


	private boolean checkHankaku(String strWhere){

		try{

			String errmsg = "";
			String workErrMsg = "";
			String ObjName = "社員： ";

			C_ErrMsg errPlus = new C_ErrMsg();

			C_CheckComm ckCC = new C_CheckComm();
			workErrMsg = ckCC.retCheckNull(strWhere,1);
			errmsg = errPlus.errMsgConn(errmsg,workErrMsg,ObjName);

			if(errmsg.equals("")){

				C_HankakuCheck ckHan = new C_HankakuCheck();
				workErrMsg = ckHan.retCheckHanAlph(strWhere, 1);
				errmsg = errPlus.errMsgConn(errmsg, workErrMsg, ObjName);
			}
			if(errmsg.equals("")){

				return true;

			}else{

				return false;
			}

		}catch(Exception e){

			//e.printStackTrace();
			return false;
		}

	}


	private boolean checkChecked(String checked){

		try{
			if(checked.equals("1") || checked.equals("0")){
				return true;

			}else{
				return false;
			}

		}catch(Exception e){

			//e.printStackTrace();

			return false;

		}
	}

	private boolean checkAdministrator(String admin){

		try{
			
			if(admin.equals("1") || admin.equals("0")){
				return true;

			}else{
				
				return false;
			}

		}catch(Exception e){

			//e.printStackTrace();

			return false;

		}
	}



}
