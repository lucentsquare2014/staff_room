package kkweb.maintenance;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Errmsg;
import kkweb.beans.B_ShainMentenanceMST;
import kkweb.common.C_CheckComm;
import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.common.C_ErrMsg;
import kkweb.common.C_HankakuCheck;
import kkweb.dao.GroupDAO;
import kkweb.dao.LoginDAO;
import kkweb.superclass.C_ChangePageBase;

public class C_Shain_update extends C_ChangePageBase {

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
			C_CheckWord word = new C_CheckWord();
			HttpSession session = request.getSession(true);
			
			
			B_ShainMentenanceMST shainmst = (B_ShainMentenanceMST)session.getAttribute("Shain");
			String shainchecked = shainmst.getChecked();
			String shainNumber = shainmst.getNumber();
			
			
			String f_name = request.getParameter("f_name").trim();
			f_name = word.checks(f_name);
			String g_name = request.getParameter("g_name").trim();
			g_name = word.checks(g_name);
			String id = request.getParameter("id").trim();
			id = word.checks(id);
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
			String name = f_name+"　"+g_name;
			// フリガナを追加 2014-06-11
			String hurigana = request.getParameter("hurigana").trim();
			hurigana = word.checks(hurigana);
			//管理者権限を追加
			String administrator = request.getParameter("administrator").trim();
			administrator = word.checks(administrator);
			
			//本番用
			String mail = request.getParameter("mail").trim();
			mail = word.checks(mail);
			
			//テスト用
			//String mail = "h-shibui@lucentsquare.co.jp";	
			if(mail.equals("") || f_name.equals("") || g_name.equals("") || id.equals("") || number.equals("") || groupnumber.equals("") || checked.equals("")){
				//System.out.println("値の未入力の項目があります。");
				return "値の未入力の項目があります。";
			}

			if(checkChecked(checked) != true){
				//System.out.println("承認者チェックは半角数字の0か1を入力して下さい");
				return "承認者チェックは半角数字の0か1を入力して下さい";

			}
			// 管理者権限の入力が正しいかどうか
			if(checkAdministrator(administrator) != true){
				return "管理者権限は半角数字の0か1を入力して下さい";
			}

			if(checkShaingroup(groupnumber) != true){
				//System.out.println("正しいグループ番号を入力して下さい");
				return "正しいグループ番号を入力して下さい";
			}

			//本番移行時に以下の行を追加

			if(checkMail(mail,shainNumber) == true){
				//System.out.println("入力されたメールアドレスは使用されています。");
				return "入力されたメールアドレスは使用されています。";

			}
			
			String nenkyu_new = request.getParameter("nenkyu_new").trim();
			String nenkyu_all = request.getParameter("nenkyu_all").trim();
			String nenkyu_year = request.getParameter("nenkyu_year").trim();
			String nenkyu_kurikoshi = request.getParameter("nenkyu_kurikoshi").trim();
			String nenkyu_fuyo = request.getParameter("nenkyu_fuyo").trim();
		
			if(nenkyu_new.equals("") || nenkyu_all.equals("") || nenkyu_year.equals("") || nenkyu_kurikoshi.equals("") || nenkyu_fuyo.equals("")){
				return "年休日数は全ての欄を入力して下さい。";
			}

			double this_nenkyu_new = Double.parseDouble(nenkyu_new);
			double this_nenkyu_all = Double.parseDouble(nenkyu_all);
			double this_nenkyu_year = Double.parseDouble(nenkyu_year);
			double this_nenkyu_kurikoshi = Double.parseDouble(nenkyu_kurikoshi);
			double this_nenkyu_fuyo = Double.parseDouble(nenkyu_fuyo);

			double nenkyu_work1 = this_nenkyu_all + this_nenkyu_year;
			double nenkyu_work2 = this_nenkyu_kurikoshi + this_nenkyu_fuyo;
			
			if(this_nenkyu_new != nenkyu_work1 || this_nenkyu_new != nenkyu_work2){

				return "正しい年休の値を入力して下さい";

			}

			int kousin1 = 0;
			int kousin2 = 0;
			int kousin3 = 0;
			String sql = "";

			cdbc = new C_DBConnection();
			con = cdbc.createConnection();
			stmt = con.createStatement();
			
			con.setAutoCommit(false);

			if(shainchecked.equals(checked)){
				
				if(shainchecked.equals("1")){
				
					sql = " update syouninshaMST set name ='"+name+"',mail ='"+mail+"',groupnumber ='"+groupnumber+"',hyouzijun ='"+hyouzijun+"' where number ='"+shainNumber+"'";
	
					kousin1 = stmt.executeUpdate(sql);
					
				}else{
			
					kousin1 = 1;
				
				}

			}else{
				
				if(checked.equals("1")){
				
					sql = "insert into syouninshaMST values ('"+name+"','"+id+"','"+mail+"','"+groupnumber+"','"+number+"','"+hyouzijun+"')";
				
					kousin1 = stmt.executeUpdate(sql);
				
				}else{
					
					sql = "delete from syouninshaMST where number='"+shainNumber+"'";
					
					kousin1 = stmt.executeUpdate(sql);
					
				}
			}
			
			sql =" update shainmst set name ='"+name+"',checked='"+checked+"',groupnumber ='"+groupnumber+"',mail ='"+mail+"',hyouzijun='"+hyouzijun+"',yakusyoku='"+yakusyoku+"',hurigana='"+hurigana+"',administrator='"+administrator+"' where number = '"+number+"'";
			
			kousin2 = stmt.executeUpdate(sql);
			
			sql = " update nenkyumst set nenkyu_new ='"+nenkyu_new+"',nenkyu_all='"+nenkyu_all+"',nenkyu_year ='"+nenkyu_year+"',nenkyu_kurikoshi ='"+nenkyu_kurikoshi+"',nenkyu_fuyo ='"+nenkyu_fuyo+"' where number = '"+number+"'";
	
			kousin3 = stmt.executeUpdate(sql);
			
			if(kousin1 > 0 && kousin2 > 0 && kousin3 > 0){
				
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

	private boolean checkMail(String mail,String number){
		
		LoginDAO ldao = new LoginDAO();
		String sql = " where mail = '"+mail+"' and number != '"+number+"' and zaiseki_flg='1'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShain(String id,String pw){
		
		LoginDAO ldao = new LoginDAO();
		String sql = " where id ='"+id+"' AND pw ='"+pw+"'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShainnumber(String number){
		
		LoginDAO ldao = new LoginDAO();
		String sql = " where number ='"+number+"'";

		return ldao.isThereTbl(sql);
	}

	private boolean checkShainmail(String mail){
		
		LoginDAO ldao = new LoginDAO();
		String sql = " where mail ='"+mail+"'";

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
