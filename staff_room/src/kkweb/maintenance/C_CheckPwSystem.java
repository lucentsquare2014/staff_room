package kkweb.maintenance;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.common.*;
import kkweb.superclass.C_ChangePageBase;

public class C_CheckPwSystem extends C_ChangePageBase {

	public String checkRequest(HttpServletRequest request){

		try{
			request.setCharacterEncoding("Windows-31J");
			C_CheckWord word = new C_CheckWord();


			String password = request.getParameter("Pwd");
			password=word.checks(password);

			String errmsg = "";

			C_CheckSystemLogin ccsl = new C_CheckSystemLogin();
			errmsg = ccsl.retCheckIsTherePw(password,1);

			return errmsg;

		}catch(Exception e){

			//e.printStackTrace();

			return "";

		}
	}

	public String nextPage(HttpServletRequest request){

		try{
			String Key = "鍵";
			HttpSession hs = request.getSession(true);    
			hs.setAttribute("key2",Key);
			
			String nextpage = "/jsp/shanai_s/SystemKanri_MenuGamen.jsp";
			return nextpage;

		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{
			String nextpage ="/jsp/shanai_s/SystemLoginError.jsp";
			return nextpage;

		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}
	}

}