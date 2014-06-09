package kkweb.joukyou;


import java.util.ArrayList;







import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_GroupMST;
import kkweb.beans.B_Year_month_group;
import kkweb.common.C_CheckMonth;


import kkweb.dao.GroupDAO;
import kkweb.superclass.C_ChangePageBase;

public class S_Joukyou extends C_ChangePageBase{

	public void doMain(HttpServletRequest request){

		try{
			request.setCharacterEncoding("UTF-8");

			HttpSession session = request.getSession(true);

			String this_year = request.getParameter("year");
			String this_month = request.getParameter("month");
			String this_group = request.getParameter("group");

			String groupnumber = "";

			C_CheckMonth d = new C_CheckMonth();

			String this_year_month = this_year + d.CheckMonth(this_month);

			if(this_group.equals(" 全グループ ")){

				groupnumber = "";

			}else{

			GroupDAO gdao = new GroupDAO();
			String sql = " where GROUPname='"+this_group+"'";
			ArrayList array = gdao.selectTbl(sql);

			B_GroupMST gmst = new B_GroupMST();
			gmst = (B_GroupMST)array.get(0);

			groupnumber = gmst.getGROUPnumber();

			}

			B_Year_month_group bymg = new B_Year_month_group();
			bymg.setYear(this_year);
			bymg.setMonth(this_month);
			bymg.setYear_month(this_year_month);
			bymg.setGroupnumber(groupnumber);
			bymg.setGroupname(this_group);

			session.setAttribute("Year_month_group", bymg);


			}catch(Exception e){

		   }
	    }

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage;
			HttpSession session = request.getSession(false);
			String id2 = (String)session.getAttribute("key");
			if(id2 == null || id2.equals("false")){
				
				nextpage = "/jsp/shanai_s/ID_PW_Nyuryoku.jsp";
			}else{
				nextpage = "/jsp/shanai_s/Shouninjoukyou_Itiran.jsp";
				
			}	
			

			return nextpage;

		}catch(Exception e){


			String nextpage = "/jsp/shanai_s/ID_PW_Nyuryoku.jsp";
			
			return nextpage;
			
		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String nextpage = "/jsp/shanai_s/Nyuryoku_file_error.jsp";

			return nextpage;

		}catch(Exception e){



			return null;
		}
	}

	}




