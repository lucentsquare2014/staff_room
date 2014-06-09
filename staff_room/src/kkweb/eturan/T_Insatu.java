package kkweb.eturan;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.dao.GameninsatuDAO;
import kkweb.superclass.C_ChangePageBase;

public class T_Insatu  extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage;
			HttpSession session = request.getSession(false);
			String id2 = (String)session.getAttribute("key2");
			if(id2 == null || id2.equals("false")){
				
				nextpage = "/jsp/shanai_s/Pw_Nyuryoku_system.jsp";
			}else{
				nextpage = "/jsp/shanai_s/Taishokusha_Gamen_Insatu.jsp";
				
			}			
			return nextpage;

		}catch(Exception e){
			String nextpage = "/jsp/shanai_s/ID_PW_Nyuryoku.jsp";
			
			return nextpage;
			//e.printStackTrace();
		}
	}

	public String backPage(HttpServletRequest request){
		try{
			String nextpage = "/jsp/shanai_s/Login_error.jsp";
			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public void doMain (HttpServletRequest request){
		try{
			request.setCharacterEncoding("UTF-8");

			String number = request.getParameter("number");
			String this_year_month = request.getParameter("year_month");

			int index = number.lastIndexOf(" ");

			number = number.substring(index);

			number = number.trim();

			String sql = "where shainMST.number = '" + number + "' and goukeiMST.year_month = '" + this_year_month + "' order by to_number(hizuke,'99') asc " ;

			ArrayList InsatuDATA = new ArrayList();
			GameninsatuDAO dao = new GameninsatuDAO();

			InsatuDATA = dao.insatuTbl(sql);

			HttpSession session = request.getSession(true);

			session.setAttribute("InsatuDATA",InsatuDATA);


	}catch(Exception e){
		//e.printStackTrace();
	   }

}}
