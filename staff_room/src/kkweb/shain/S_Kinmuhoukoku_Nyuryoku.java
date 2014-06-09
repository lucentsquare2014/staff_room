package kkweb.shain;

import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Code;
import kkweb.beans.B_GoukeiMST;
import kkweb.beans.B_Jido_Keisan;
import kkweb.beans.B_ShainMST;
import kkweb.beans.B_Year_month;
import kkweb.common.*;
import kkweb.dao.CodeDAO;
import kkweb.dao.GoukeiDAO;
import kkweb.superclass.C_ChangePageBase;

public class S_Kinmuhoukoku_Nyuryoku extends C_ChangePageBase {

	String chk_flg;

	public String checkSession(HttpServletRequest request){
		try{
	
		String chk_flg = "";
		
		HttpSession session = request.getSession();
		B_ShainMST shainmst = (B_ShainMST)session.getAttribute("ShainMST");
		String A=shainmst.getId();
		
		if(shainmst.getId().equals("")){
	
		
			chk_flg = "NG";
			
		}else{}
	
			return chk_flg;
		}catch(Exception e){
	
			chk_flg="NG";
			return chk_flg;
		}
	}

	public String checkRequest(HttpServletRequest request){

		try{
			
			String errmsg = "";

			errmsg = checkDB(request);

			if(errmsg.equals("1")){

				return "承認依頼中です。";
			}

			return null;

		}catch(Exception e){

			//e.printStackTrace();
			
			return null;
			
			//String nextpage="/ID_PW_Nyuryoku.jsp";
			//return nextpage;
			
		}
	}

	private String checkDB(HttpServletRequest request){

		try{
			
			request.setCharacterEncoding("UTF-8");
			C_CheckWord word = new C_CheckWord();
			String this_year = request.getParameter("year");
			String this_month = request.getParameter("month");
			
			C_CheckMonth ckmn = new C_CheckMonth();
			this_month = ckmn.CheckMonth(this_month);

			HttpSession session = request.getSession();
			B_ShainMST shainmst = (B_ShainMST)session.getAttribute("ShainMST");
			String shainNumber = shainmst.getNumber();
			shainNumber = word.checks(shainNumber);
			String errmsg = "";

			C_Checkkinmuhoukokusyo ckKK = new C_Checkkinmuhoukokusyo();
			errmsg = ckKK.retCheckIsTherekinmuhoukokusyo(shainNumber, this_year, this_month, 1);
			
			if(errmsg==null){

				String year_month = this_year + this_month;
				
				year_month = word.checks(year_month);
				GoukeiDAO dao = new GoukeiDAO();
				String sql = " where number ='"+shainNumber+"' AND year_month ='"+year_month+"'";
				ArrayList list = dao.selectTbl(sql);

				B_GoukeiMST goukeitbl = new B_GoukeiMST();
				goukeitbl = (B_GoukeiMST)list.get(0);

				String now_flg = goukeitbl.getFlg();

				return now_flg;

			}else{
				
			return "3";

			}

		}catch(Exception e){
			
			//e.printStackTrace();

			//return null;
			return "error";
		}
	}


	public String nextPage(HttpServletRequest request){

		try{
			
			String flg = checkDB(request);
			String nextpage = "";

			if(flg.equals("0")){
				
				nextpage = "/jsp/shanai_s/Syounin_zumi.jsp";
			}else if(flg.equals("error")){
				
				nextpage = "/jsp/shanai_s/ID_PW_Nyuryoku.jsp";
			}else{
				
				nextpage = "/jsp/shanai_s/Kinmu_nyuryoku.jsp";
			}
			
			return nextpage;

		}catch(Exception e){
			
			//e.printStackTrace();

			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{
			
			String nextpage = "/jsp/shanai_s/Nyuryoku_file_error.jsp";

			return nextpage;

		}catch(Exception e){
			
			//e.printStackTrace();

			return null;
		}
	}

	public void setBean(HttpServletRequest request, String errmsg){

		try{
			
			B_Year_month y_m = new B_Year_month();
			y_m.setYear_month("");
			
			HttpSession session = request.getSession(true);
			session.setAttribute("Year_month", y_m);

		}catch(Exception e){
			
			//e.printStackTrace();

		}
	}

	public void doMain(HttpServletRequest request){

		try{
			//System.out.println("処理時間2=");
//			long time11 = System.currentTimeMillis();
			request.setCharacterEncoding("UTF-8");

			HttpSession session = request.getSession(true);

			String now_flg = checkDB(request);

			String this_year = request.getParameter("year");
			String this_month = request.getParameter("month");

			C_CheckMonth ckmn = new C_CheckMonth();
			String month = ckmn.CheckMonth(this_month);

			String year_month = this_year + month;
			
			B_Year_month y_m = new B_Year_month();
			y_m.setMonth(this_month);
			y_m.setYear(this_year);
			y_m.setYear_month(year_month);
			y_m.setFlg(now_flg);

			session.setAttribute("Year_month", y_m);

			CodeDAO cdao = new CodeDAO();
			String sql = " select * from codemst where flg= '0'";
			ArrayList klist = cdao.selectTbl(sql);

			String pcode[] = new String[klist.size()];
			String code[] = new String[klist.size()];
			String start[] = new String[klist.size()];
			String end[] = new String[klist.size()];
			String rest[] = new String[klist.size()];

			B_Code bcode = new B_Code();

			
			
			for(int i = 0; i < klist.size(); i++){

				bcode = (B_Code)klist.get(i);

				pcode[i] = bcode.getPROJECTcode();
				code[i] = bcode.getKINMUcode();
				start[i] = bcode.getStartTIME();
				end[i] = bcode.getEndTIME();
				rest[i] = bcode.getRestTIME();

			}

			B_Jido_Keisan bjk = new B_Jido_Keisan();

			bjk.setPROJECTcode(pcode);
			bjk.setKINMUcode(code);
			bjk.setStartTIME(start);
			bjk.setEndTIME(end);
			bjk.setRestTIME(rest);
			
			session.setAttribute("codedata",bjk);
			
		}catch(Exception e){
			
			//e.printStackTrace();
		}
	}
}
