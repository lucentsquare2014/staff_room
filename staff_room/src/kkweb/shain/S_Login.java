package kkweb.shain;

import java.util.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import kkweb.beans.B_ShainMST;
import kkweb.common.*;
import kkweb.dao.LoginDAO;
import kkweb.superclass.C_ChangePageBase;

public class S_Login extends C_ChangePageBase {


	/// 処理1番目
	///
	public String checkRequest(HttpServletRequest request){

		try{

			String errmsg = "";
			String errmsg2 = "";
			String errmsg3 = "";

			/// 適切な入力かどうかをチェック
			errmsg = checkshainID(request);
			errmsg2 = checkPwd(request);

			if(errmsg.equals("") && errmsg2.equals("")){
				// 社員IDとパスワードが在籍社員として登録されているかチェック
				errmsg3 = checkshainIDPwd(request);
				return errmsg3;

			}
			return errmsg+errmsg2;

		}catch(Exception e){

			//e.printStackTrace();
			//return null;


			String nextpage="/";
			return nextpage;

		}

	}

	private String checkshainID(HttpServletRequest request){

		try{

			request.setCharacterEncoding("UTF-8");

			String shainName = request.getParameter("shainID").trim();

			int kigou1 = shainName.lastIndexOf("'");
			int kigou2 = shainName.lastIndexOf(";");

			if(kigou1 > 0 || kigou2 > 0){

				return "適切な文字を入力してください。";

			}

			String errmsg = "";
			String workErrMsg = "";
			String ObjName = "社員ID： ";

			C_ErrMsg errPlus = new C_ErrMsg();

			C_CheckComm ckCC = new C_CheckComm();
			workErrMsg = ckCC.retCheckNull(shainName,1);
			errmsg = errPlus.errMsgConn(errmsg,workErrMsg,ObjName);

			if(errmsg.equals("")){

				C_HankakuCheck ckHan = new C_HankakuCheck();
				workErrMsg = ckHan.retCheckHanAlph(shainName, 1);
				errmsg = errPlus.errMsgConn(errmsg, workErrMsg, ObjName);
			}
			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();
			return null;

		}

	}

	private String checkPwd(HttpServletRequest request){

		try{

			request.setCharacterEncoding("UTF-8");

			String PassWord = request.getParameter("Pwd").trim();

			int kigou1 = PassWord.lastIndexOf(";");
			int kigou2 = PassWord.lastIndexOf("'");

			if(kigou1 > 0 || kigou2 > 0){

				return "適切な文字を入力してください。";

			}

			String errmsg = "";
			String workErrMsg = "";
			String ObjName = "パスワード： ";

			C_ErrMsg errPlus = new C_ErrMsg();

			C_CheckComm ckCC = new C_CheckComm();
			workErrMsg = ckCC.retCheckNull(PassWord,1);
			errmsg = errPlus.errMsgConn(errmsg,workErrMsg,ObjName);

			if(errmsg.equals("")){
				C_HankakuCheck ckHan = new C_HankakuCheck();
				workErrMsg = ckHan.retCheckHanAlph(PassWord, 1);
				errmsg = errPlus.errMsgConn(errmsg, workErrMsg, ObjName);
			}
			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	private String checkshainIDPwd(HttpServletRequest request){

		try{

			request.setCharacterEncoding("UTF-8");

			String ShainID = request.getParameter("shainID").trim();
			String PassWord = request.getParameter("Pwd").trim();

			String errmsg = "";
			//// 2013/07/14　新井　処理追加
			//// 目的 : id同じpwを使用不可能にするため
			if(ShainID.equals(PassWord)){
				errmsg = "IDと同じパスワードは使用できません。";
				return errmsg;
			}
			////
			C_CheckLogin ckKK = new C_CheckLogin();
			errmsg = ckKK.retCheckIsThereshain(ShainID, PassWord, 1);

//			if(errmsg.equals("")){

//				LoginDAO dao = new LoginDAO();
//				String sql = "where id ='"+ShainID+"'AND pw ='"+PassWord+"'";
//				B_ShainMST b_shainmst = (B_ShainMST)dao.getShainMSTUniqueData(sql);
//			}
			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String nextPage(HttpServletRequest request){

		try{

//			HttpSession session = request.getSession(true);
//			session.setAttribute("ShainMST",errmsg3);
			String Key = "鍵";
			HttpSession hs = request.getSession(true);
			hs.setAttribute("key",Key);
			String np = (String)hs.getAttribute("target"); // 次に遷移するページ
			hs.removeAttribute("target");
			//System.out.println("target : "+np);
			String nextpage = "/jsp/shanai_s/SystemSelect.jsp";
			
			// modeのパラメータで選択するシステムを決定する 2014-06-09
			String mode = "?mode="+request.getParameter("mode").toString();
			nextpage += mode;
			if(np != null && np.length() > 0){
				nextpage = np;
			}
			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String nextpage ="/jsp/shanai_s/Login_error.jsp";
			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public void setBean(HttpServletRequest request,String errmsg){

		try{

			B_ShainMST bshainmst = new B_ShainMST();
			bshainmst.setId("");

			HttpSession session = request.getSession(true);
			session.setAttribute("ShainMST",bshainmst);


		}catch(Exception e){

			//e.printStackTrace();
		}
	}

	public void doMain(HttpServletRequest request){
//						,HttpServletResponse response){

		try{

			String ShainID = request.getParameter("shainID");
			ShainID = ShainID.replaceAll("'","");
			ShainID = ShainID.replaceAll("<","");
			ShainID = ShainID.replaceAll(";","");
			ShainID = ShainID.replaceAll(",","");
			ShainID = ShainID.replaceAll(" ","");
			LoginDAO dao = new LoginDAO();
			String sql = " where id ='"+ShainID+"'";
			ArrayList slist = dao.selectTbl(sql);


			B_ShainMST login_shain = (B_ShainMST)slist.get(0);
			String pw = login_shain.getPw();
			String checked = login_shain.getChecked();
			String name = login_shain.getName();
			String number = login_shain.getNumber();
			String GROUPnumber = login_shain.getGROUPnumber();
			String mail = login_shain.getMail();

			B_ShainMST bshainmst = new B_ShainMST();
			bshainmst.setId(ShainID);
			bshainmst.setPw(pw);
			bshainmst.setChecked(checked);
			bshainmst.setName(name);
			bshainmst.setNumber(number);
			bshainmst.setGROUPnumber(GROUPnumber);
			bshainmst.setMail(mail);

			HttpSession session = request.getSession(true);
			session.setAttribute("ShainMST",bshainmst);

		}catch(Exception a){

		}

	}
}


