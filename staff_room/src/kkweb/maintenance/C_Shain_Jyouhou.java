package kkweb.maintenance;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_ShainMST;
import kkweb.beans.B_ShainMentenanceMST;
import kkweb.common.C_CheckWord;
import kkweb.dao.LoginDAO;
import kkweb.superclass.C_ChangePageBase;

public class C_Shain_Jyouhou extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/Shain_data.jsp";
			return nextpage;

		}catch(Exception e){
			//e.printStackTrace();
			return null;
		}
	}

	public void doMain(HttpServletRequest request){

		try{
			C_CheckWord word = new C_CheckWord();
			String ShainNumber = request.getParameter("shain_number");
			ShainNumber = word.checks(ShainNumber);
			LoginDAO dao = new LoginDAO();
			String sql = " where number ='"+ShainNumber+"'";
			ArrayList slist = dao.selectTbl(sql);

			B_ShainMST shain = (B_ShainMST)slist.get(0);
			String id = shain.getId();
			String pw = shain.getPw();			
			String checked = shain.getChecked();			
			String name = shain.getName();			
			String GROUPnumber = shain.getGROUPnumber();			
			String mail = shain.getMail();			
			String zaiseki_flg = shain.getZaiseki_flg();			
			String hyouzijun = shain.getHyouzijun();
			String yakusyoku = shain.getYakusyoku();
						
			String f_name = "";
			String g_name = "";
			int index = name.lastIndexOf("　");

			if(index < 0){
				f_name = name;

			}else{
				f_name = name.substring(0,index).trim();
				g_name = name.substring(index+1).trim();
			}

			B_ShainMentenanceMST mshain = new B_ShainMentenanceMST();
			mshain.setId(id);
			mshain.setPw(pw);
			mshain.setChecked(checked);
			mshain.setF_name(f_name);
			mshain.setG_name(g_name);
			mshain.setNumber(ShainNumber);
			mshain.setGROUPnumber(GROUPnumber);
			mshain.setMail(mail);
			mshain.setZaiseki_flg(zaiseki_flg);
			mshain.setHyouzijun(hyouzijun);
			mshain.setYakusyoku(yakusyoku);
						
			HttpSession session = request.getSession(true);
			session.setAttribute("Shain",mshain);

		}catch(Exception e){

			//e.printStackTrace();

		}
	}

}
