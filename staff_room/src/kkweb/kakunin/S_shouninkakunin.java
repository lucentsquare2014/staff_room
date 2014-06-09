package kkweb.kakunin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kkweb.beans.B_NenkyuMST_work;
import kkweb.dao.*;
import kkweb.superclass.C_ChangePageBase;

public class S_shouninkakunin extends C_ChangePageBase {

	/**
	 *
	 */
	private static final long serialVersionUID = 5223805396956493553L;


	public String checkRequest(HttpServletRequest request){
		
		String number = request.getParameter("iraisha_number");
		String year_month = request.getParameter("iraisha_year_month");
		
		
		
		NenkyuDAO_work ndao_work = new NenkyuDAO_work();
		String sql = " where number ='"+number+"' and year_month='"+year_month+"'";
		ArrayList nlist = ndao_work.selectTbl(sql);

		
		B_NenkyuMST_work nmst = new B_NenkyuMST_work();
		nmst = (B_NenkyuMST_work)nlist.get(0);

		
		String nenkyu_new = nmst.getNenkyu_new();
		String nenkyu_all = nmst.getNenkyu_all();
		String nenkyu_year = nmst.getNenkyu_year();
		String nenkyu_kurikoshi = nmst.getNenkyu_kurikoshi();
		String nenkyu_fuyo = nmst.getNenkyu_fuyo();

		
		SyouninIraiDAO sidao = new SyouninIraiDAO();
		sql = " where iraiNumber='"+number+"'";
		boolean check = sidao.isThereTbl(sql);

		
		ShouninkakuninDAO S_dao = new ShouninkakuninDAO();
		if (S_dao.updateTbl(number, year_month,nenkyu_new,nenkyu_all,nenkyu_year,nenkyu_kurikoshi,nenkyu_fuyo,check)){

			return "";

		}else{

			return "error";
		}
	}



	public String nextPage(HttpServletRequest request){

		try{
			
			String nextpage = "/Shouninkanryou.jsp";

			return nextpage;

		}catch(Exception e){

			
			e.printStackTrace();

		return null;
		}
	}


	public String backPage(HttpServletRequest request){

		try{
			
			String nextpage = "/Shounin_error.jsp";

			return nextpage;

		}catch(Exception e){

			
			e.printStackTrace();

		return null;
		}
	}
}

