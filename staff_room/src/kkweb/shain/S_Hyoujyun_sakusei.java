package kkweb.shain;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Code;
import kkweb.beans.B_Codehyouji;
import kkweb.beans.B_KinmuMST;
import kkweb.beans.B_Kinmu_nyuryoku_2;
import kkweb.beans.B_ShainMST;
import kkweb.beans.B_Year_month;
import kkweb.common.*;
import kkweb.dao.CodeDAO;
import kkweb.dao.KinmuDAO;
import kkweb.superclass.C_ChangePageBase;

public class S_Hyoujyun_sakusei extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/Kinmu_nyuryoku.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return "";
		}
	}

	public void doMain(HttpServletRequest request){

		try{

			request.setCharacterEncoding("Windows-31J");

			HttpSession session = request.getSession(true);

			String pcode = request.getParameter("pname");

			if(pcode.equals("sengetu")){

				B_ShainMST bsm = (B_ShainMST)session.getAttribute("ShainMST");
				String number = bsm.getNumber();

				B_Year_month bym = (B_Year_month)session.getAttribute("Year_month");
				C_Sengetu cs =  new C_Sengetu();

				String year = cs.sengetu_year(bym.getYear(),bym.getMonth());
				String month = cs.sengetu_month(bym.getMonth());

				C_CheckMonth ccm = new C_CheckMonth();
				month = ccm.CheckMonth(month);

				String year_month = year + month;

				C_Lastday cld = new C_Lastday();
				int lastday = cld.lastday(year,month);

				String p = "";

				while(lastday>0){

					KinmuDAO kdao = new KinmuDAO();
					String sql1 = " where number = '"+number+"' AND year_month ='"+year_month+"' AND hizuke ='"+Integer.toString(lastday)+"'";

					if(kdao.isThereTbl(sql1) == true){
						ArrayList klist = kdao.selectTbl(sql1);

						B_KinmuMST bkmst = new B_KinmuMST();
						bkmst = (B_KinmuMST)klist.get(0);

						p = bkmst.getPROJECTcode();

					}

					if(!p.equals("")){
						break;
					}

					lastday--;

				}

				pcode = p;

			}

		    CodeDAO cdao = new CodeDAO();
		    String sql = " where PROJECTcode ='"+pcode+"'";

			if(cdao.isThereTbl(sql)){

				sql = " select * from codeMST where PROJECTcode ='"+pcode+"'";
				ArrayList clist = cdao.selectTbl(sql);

				B_Code bc = new B_Code();
				bc = (B_Code)clist.get(0);

				String pname = bc.getPROJECTname();

				B_Codehyouji bcode = new B_Codehyouji();

				bcode.setPROJECTname(pname);
				bcode.setPROJECTcode(pcode);

				session.setAttribute("Project",bcode);

			}

			session.removeAttribute("Hyoujyun");

			B_Year_month bym = (B_Year_month)session.getAttribute("Year_month");

			C_Lastday cld = new C_Lastday();
			int lastday = cld.lastday(bym.getYear(),bym.getMonth());
			int hizuke = 1;

			String[] pkinmu = new String[lastday];
			String[] ckinmu = new String[lastday];
			String[] skinmu = new String[lastday];
			String[] ekinmu = new String[lastday];
			String[] cykinmu = new String[lastday];
			String[] sikinmu = new String[lastday];
			String[] cyokinmu = new String[lastday];
			String[] rkinmu = new String[lastday];
			String[] fkinmu = new String[lastday];
			String[] bkinmu = new String[lastday];

			for(int i = 0; i < lastday; i++){

				pkinmu[i] = request.getParameter("pcode"+String.valueOf(hizuke));
				ckinmu[i] = request.getParameter("code"+String.valueOf(hizuke));
				skinmu[i] = request.getParameter("start"+String.valueOf(hizuke));
				ekinmu[i] = request.getParameter("end"+String.valueOf(hizuke));
				cykinmu[i] = request.getParameter("cyouka"+String.valueOf(hizuke));
				sikinmu[i] = request.getParameter("sinya"+String.valueOf(hizuke));
				cyokinmu[i] = request.getParameter("cyoku"+String.valueOf(hizuke));
				rkinmu[i] = request.getParameter("rest"+String.valueOf(hizuke));
				fkinmu[i] = request.getParameter("furou"+String.valueOf(hizuke));
				bkinmu[i] = request.getParameter("bikou"+String.valueOf(hizuke));

				hizuke++;

			}

			B_Kinmu_nyuryoku_2 bkn2 = new B_Kinmu_nyuryoku_2();
			bkn2.setPkinmu(pkinmu);
			bkn2.setCkinmu(ckinmu);
			bkn2.setSkinmu(skinmu);
			bkn2.setEkinmu(ekinmu);
			bkn2.setCykinmu(cykinmu);
			bkn2.setSikinmu(sikinmu);
			bkn2.setCyokinmu(cyokinmu);
			bkn2.setRkinmu(rkinmu);
			bkn2.setFkinmu(fkinmu);
			bkn2.setBkinmu(bkinmu);

			session.setAttribute("IchijiDATA",bkn2);
			
			sql = " where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+1+"'";

			if(cdao.isThereTbl(sql) == true){

				sql = " select * from codeMST where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+1+"'";
				ArrayList clist = cdao.selectTbl(sql);

				B_Code bcode = new B_Code();
				bcode = (B_Code)clist.get(0);
				String PROJECTname = bcode.getPROJECTname();
				String startTIME = bcode.getStartTIME();
				String endTIME = bcode.getEndTIME();
				String restTIME = bcode.getRestTIME();
				String bikou = bcode.getBikou();
				String basyo = bcode.getBasyo();

				B_Code bc = new B_Code();
				bc.setPROJECTcode(pcode);
				bc.setPROJECTname(PROJECTname);
				bc.setKINMUcode("1");
				bc.setStartTIME(startTIME);
				bc.setEndTIME(endTIME);
				bc.setRestTIME(restTIME);
				bc.setBikou(bikou);
				bc.setBasyo(basyo);

				session.setAttribute("Hyoujyun", bc);

			}

		}catch(Exception e){

			//e.printStackTrace();

		}
	}

}
