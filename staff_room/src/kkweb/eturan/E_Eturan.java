package kkweb.eturan;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.dao.GameninsatuDAO;
import kkweb.superclass.C_ChangePageBase;

public class E_Eturan extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{
			request.setCharacterEncoding("Windows-31J");

			String nextpage = "/Escape_Eturan.jsp";
			String check = request.getParameter("check");

			if(check != null && !check.equals("")){

				nextpage = "/Escape_Insatu.jsp";
			}
			return nextpage;

		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}

	}

	public String backPage(HttpServletRequest request){

		try{
			String nextpage = "/Nyuryoku_file_error.jsp";
			return nextpage;
		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}
	}

	public void doMain(HttpServletRequest request){

		try{
			request.setCharacterEncoding("Windows-31J");
			String number = request.getParameter("number");
			String yearmonth = request.getParameter("yearmonth");
			String sql = "where shainMST.number = '" + number + "' and goukeiMST.year_month = '" + yearmonth + "' order by to_number(hizuke,'99') asc " ;

			ArrayList EscapeDATA = new ArrayList();
			GameninsatuDAO dao = new GameninsatuDAO();

			EscapeDATA = dao.insatuTbl(sql);
			HttpSession session = request.getSession(true);
			session.setAttribute("EscapeDATA",EscapeDATA);
		}catch(Exception e){
			//e.printStackTrace();
		}
	}
}
