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
			String nextpage = "/jsp/shanai_s/Shain_data.jsp";
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
			// フリガナと管理者権限を追加 2014-06-13
			String hurigana = shain.getHurigana();
			String administrator = shain.getAdministrator();
			//スケジュール用グループ番号と表示順を追加2014-07-08
			String k_gruno = shain.getK_gruno();
			String k_pass2 = shain.getK_pass2();
						
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
			// フリガナを追加 2014-06-11
			mshain.setHurigana(hurigana);
			mshain.setAdministrator(administrator);
			//スケジュール用グループ番号と表示順を追加2014-07-08
			mshain.setK_gruno(k_gruno);
			mshain.setK_pass2(k_pass2);
						
			HttpSession session = request.getSession(true);
			session.setAttribute("Shain",mshain);

		}catch(Exception e){

			//e.printStackTrace();

		}
	}

}
