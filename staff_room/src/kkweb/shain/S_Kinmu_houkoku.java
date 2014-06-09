package kkweb.shain;

//import java.util.*;
//import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import kkweb.superclass.C_ChangePageBase;

//import common.*;
//import beans.B_Kinmu_nyuryoku_2;
//import beans.B_Year_month;
//import beans.B_ShainMST;
//import beans.B_GoukeiMST;

public class S_Kinmu_houkoku extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{

		String nextpage = "/Shouninirai.jsp";
		return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return "";
		}
	}

//	public void doMain (HttpServletRequest request){



//		try{

//			HttpSession session = request.getSession(true);

//			request.setCharacterEncoding("Windows-31J");

//			B_Year_month bym = (B_Year_month)session.getAttribute("Year_month");

//			String flg = bym.getFlg();
//			String year_month = bym.getYear_month();

//			B_ShainMST shainmst = (B_ShainMST)session.getAttribute("ShainMST");

//			String id = shainmst.getId();

//			B_GoukeiMST bgmst = (B_GoukeiMST)session.getAttribute("Goukei");

//			String sql = "";

//			ArrayList parray = (ArrayList) session.getAttribute("pkinmu");
//			ArrayList carray = (ArrayList) session.getAttribute("ckinmu");
//			ArrayList sarray = (ArrayList) session.getAttribute("skinmu");
//			ArrayList earray = (ArrayList) session.getAttribute("ekinmu");
//			ArrayList cyarray = (ArrayList) session.getAttribute("cykinmu");
//			ArrayList siarray = (ArrayList) session.getAttribute("sikinmu");
//			ArrayList cyoarray = (ArrayList) session.getAttribute("cyokinmu");
//			ArrayList rarray = (ArrayList) session.getAttribute("rkinmu");
//			ArrayList farray = (ArrayList) session.getAttribute("fkinmu");
//			ArrayList barray = (ArrayList) session.getAttribute("bkinmu");

//			String[] p = (String[])parray.toArray(new String[0]);
//			String[] c = (String[])carray.toArray(new String[0]);
//			String[] s = (String[])sarray.toArray(new String[0]);
//			String[] e = (String[])earray.toArray(new String[0]);
//			String[] cy = (String[])cyarray.toArray(new String[0]);
//			String[] si = (String[])siarray.toArray(new String[0]);
//			String[] cyo = (String[])cyoarray.toArray(new String[0]);
//			String[] r = (String[])rarray.toArray(new String[0]);
//			String[] f = (String[])farray.toArray(new String[0]);
//			String[] b = (String[])barray.toArray(new String[0]);

//			C_DBConnection cdbc = new C_DBConnection();

//			Connection con = cdbc.createConnection();

//			Statement stmt = con.createStatement();

//			Calendar cal = Calendar.getInstance();
//			C_Lastday cld = new C_Lastday();
//			int lastday = cld.lastday(bym.getYear(),bym.getMonth());

//			C_GetWeekday cgwd = new C_GetWeekday();

//			if(flg.equals("3")){

//				for(int i = 0; i < lastday; i++){
//					String youbi = cgwd.weekday(bym.getYear(),bym.getMonth(),i+1);

//					sql = " insert into kinmuMST values ('"+id+"','"+year_month+"','"+Integer.toString(i+1)+"','"+youbi+"','"+p[i]+"','"+c[i]+"','"+s[i]+"','"+e[i]+"','"+r[i]+"','"+cy[i]+"','"+si[i]+"','"+cyo[i]+"','"+b[i]+"','"+""+"','"+f[i]+"')";

//					stmt.executeUpdate(sql);

//				}

//				sql = " insert into goukeiMST values ('"+id+"','"+year_month+"','"+bgmst.getCyoukaMONTH()+"','"+bgmst.getSinyaMONTH()+"','"+bgmst.getFurouMONTH()+"','"+bgmst.getKyudeMONTH()+"','"+bgmst.getDaikyuMONTH()+"','"+bgmst.getNenkyuMONTH()+"','"+bgmst.getKekkinMONTH()+"','"+bgmst.getAkyuMONTH()+"','"+bgmst.getBkyuMONTH()+"','"+bgmst.getGoukeiMONTH()+"','2')";

//				stmt.executeUpdate(sql);

//			}else{

//				for(int i = 0; i < lastday; i++){

//					sql = " update kinmuMST set PROJECTcode='"+p[i]+"', KINMUcode='"+c[i]+"', startT='"+s[i]+"', endT='"+e[i]+"', restT='"+r[i]+"', cyoukaT='"+cy[i]+"', sinyaT='"+si[i]+"', cyokuT='"+cyo[i]+"', PROJECTname='', SYUKUJITUname='', furouT='"+f[i]+"' where id='"+id+"' AND year_month='"+year_month+"' AND hizuke='"+Integer.toString(i+1)+"'";

//					stmt.executeUpdate(sql);

//				}

//				sql = " update goukeiMST set cyoukaMONTH='"+bgmst.getCyoukaMONTH()+"', sinyaMONTH='"+bgmst.getSinyaMONTH()+"', furouMONTH='"+bgmst.getFurouMONTH()+"', kyudeMONTH='"+bgmst.getKyudeMONTH()+"', daikyuMONTH='"+bgmst.getDaikyuMONTH()+"', nenkyuMONTH='"+bgmst.getNenkyuMONTH()+"', kekkinMONTH='"+bgmst.getKekkinMONTH()+"', akyuMONTH='"+bgmst.getAkyuMONTH()+"', bkyuMONTH='"+bgmst.getBkyuMONTH()+"', goukeiMONTH='"+bgmst.getGoukeiMONTH()+"', flg='2' where id='"+id+"' AND year_month='"+year_month+"'";;

//				stmt.executeUpdate(sql);

//			}


//		}catch(Exception e){

//			e.printStackTrace();

//		}
//	}

}


