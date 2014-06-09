package kkweb.shain;

import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_Code;
import kkweb.beans.B_Errmsg;
import kkweb.beans.B_GoukeiMST;
import kkweb.beans.B_HolidayMST;
import kkweb.beans.B_NenkyuMST;
import kkweb.beans.B_ShainMST;
import kkweb.beans.B_Year_month;
import kkweb.beans.B_ZangyouMST;
import kkweb.common.*;
import kkweb.dao.CodeDAO;
import kkweb.dao.GoukeiDAO;
import kkweb.dao.HolidayDAO;
import kkweb.dao.NenkyuDAO;
import kkweb.dao.NenkyuDAO_work;
import kkweb.dao.ZangyouDAO;
import kkweb.superclass.C_ChangePageBase;

public class S_Kinmu_hozon extends C_ChangePageBase {

	public String checkRequest(HttpServletRequest request){

		try{

			String errmsg = "";

			errmsg = dbKakikomi(request);

			if(!errmsg.equals("")){

				HttpSession session = request.getSession(true);

				B_Errmsg bmsg = new B_Errmsg();
				bmsg.setErrmsg(errmsg);
				
				session.setAttribute("errmsg", bmsg);

			}

			return errmsg;


		}catch(Exception e){

			//e.printStackTrace();

			return "入力されたコードは正しくありません。";

		}
	}

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/Kinmu_hozon.jsp";
			//HttpSession session = request.getSession();
			//B_ShainMST shainmst = (B_ShainMST)session.getAttribute("ShainMST");
			return nextpage;

		}catch(Exception e){
			
			//e.printStackTrace();
			//String nextpage ="/Kinmu_hozon_error.jsp";
			//String nextpage = "/ID_PW_Nyuryoku.jsp";
			return "";
		}
	}

	public String backPage(HttpServletRequest request){

		try{
			String nextpage ="/Kinmu_hozon_error.jsp";
			return nextpage;

		}catch(Exception e){
			
			//e.printStackTrace();
			return null;
		}
	}


	private String dbKakikomi(HttpServletRequest request) throws SQLException{

		C_DBConnection cdbc = null;
		Connection con = null;
		Statement stmt = null;

		try{
//			long time11 = System.currentTimeMillis();
			C_CheckWord word = new C_CheckWord();
			request.setCharacterEncoding("Windows-31J");

			HttpSession session = request.getSession(true);

			session.removeAttribute("Hyoujyun");

			session.removeAttribute("IchijiDATA");

			B_Year_month bym = (B_Year_month)session.getAttribute("Year_month");

			C_Lastday cld = new C_Lastday();
			int lastday = cld.lastday(bym.getYear(),bym.getMonth());
		
			ArrayList plist = new ArrayList();
//			ArrayList clist = new ArrayList();
			ArrayList clist2 = new ArrayList();
			ArrayList slist = new ArrayList();
			ArrayList elist = new ArrayList();
			ArrayList cylist = new ArrayList();
			ArrayList silist = new ArrayList();
			ArrayList cyolist = new ArrayList();
			ArrayList rlist = new ArrayList();
			ArrayList flist = new ArrayList();
			ArrayList blist = new ArrayList();
			ArrayList hlist = new ArrayList();
			ArrayList list2 = new ArrayList();

			String pcode = "";
			String pcode2 = "";
			String code = "";
			String code1 = "";
			String code2 = "";
			String code3 = "";
			String start = "";
			String end = "";
			String cyouka  = "";
			String sinya = "";
			String cyoku =  "";
			String rest = "";
			String furou = "";
			String bikou = "";
			String bikou1 = "";
			String bikou2 = "";
			String bikou3 = "";
			String pname = "";
			String hday = "";
			String pcode_work = "";
			String cyouka_work = "";
			String sinya_work = "";
			String cyoku_work = "";
			String furou_work = "";
			String rest_work = "";
			String day = "";
			String day2 = "";
			boolean start_check = true;
			boolean end_check = true;
			boolean sinya_check = true;
			boolean cyouka_check = true;
			boolean cyoku_check = true;
			boolean rest_check = true;
			boolean furou_check = true;
			boolean start_end_check = true;
			boolean start_end_digit = true;
			boolean check_minute = true;

			C_JikanKeisan cjk = new C_JikanKeisan();
			C_GoukeiKeisan cgk = new C_GoukeiKeisan();
			//C_Holiday holiday = new C_Holiday();

			String goukeicyouka = "";
			String goukeisinya = "";
			String goukeifurou = "";
			String goukeicyokusetu = "";
			int goukeikyude = 0;
			int goukeidaikyu = 0;
			int goukeinenkyu = 0;
			int goukeikekkin = 0;
			int goukeiakyu = 0;
			int goukeibkyu = 0;
			int syukuzitu = 0;
			
			B_Code ctbl = new B_Code();
	//		CodeDAO cdao = new CodeDAO();
			
			B_HolidayMST bhmst = new B_HolidayMST();
			
			String month2 = bym.getYear_month().substring(4);
			
			HolidayDAO hdao = new HolidayDAO();
			String sql4 = " where syukujitudate like'"+month2+"%'";


			boolean hday2 = hdao.isThereTbl(sql4);
			
			
			if(hday2 == true){
				
				list2 = hdao.selectTbl(sql4);
			
				
				
			}
	//		long time11 = System.currentTimeMillis();
			for(int i = 1; i <= lastday; i++ ){
				
				if(hday2 == true && list2.size() > syukuzitu){
				
					if(i < 10){

						day = "0"+Integer.toString(i);

					}else{

						day = Integer.toString(i);

					}



					bhmst = (B_HolidayMST)list2.get(syukuzitu);
					day2 = bhmst.getSYUKUJITUdate().substring(2);

						if(day2.equals(day)){
					
							hday = bhmst.getSYUKUJITUname();
							syukuzitu = syukuzitu+1;
						}
				}
				


				pcode = request.getParameter("pcode"+String.valueOf(i));
				pcode = word.checks(pcode);
				code = request.getParameter("code"+String.valueOf(i));
				code = word.checks(code);
				code3 = code;
				start = request.getParameter("start"+String.valueOf(i));
				start = word.checks(start);
				end = request.getParameter("end"+String.valueOf(i));
				end = word.checks(end);
				cyouka_work = request.getParameter("cyouka"+String.valueOf(i));
				cyouka_work = word.checks(cyouka_work);
				sinya_work = request.getParameter("sinya"+String.valueOf(i));
				sinya_work = word.checks(sinya_work);
				cyoku_work = request.getParameter("cyoku"+String.valueOf(i));
				cyoku_work = word.checks(cyoku_work);
				furou_work = request.getParameter("furou"+String.valueOf(i));
				furou_work = word.checks(furou_work);
				rest_work = request.getParameter("rest"+String.valueOf(i));
				rest_work = word.checks(rest_work);
				bikou = request.getParameter("bikou"+String.valueOf(i));
				bikou= word.checks(bikou);
				if(pcode.equals("")){

					pcode = pcode_work;

				}else if(!pcode.equals("")){

					pcode_work = pcode;

				}

				if(code.equals("")){

					pcode = "";

				}

				if(code.equals("n") || code.equals("k") || code.equals("50") || code.equals("88")){

					start = "";
					end = "";

				}
						
				start_check = cjk.Nyuryokucheck(start);
				end_check = cjk.Nyuryokucheck(end);
				cyouka_check = cjk.Nyuryokucheck(cyouka_work);
				sinya_check = cjk.Nyuryokucheck(sinya_work);
				cyoku_check = cjk.Nyuryokucheck(cyoku_work);
				furou_check = cjk.Nyuryokucheck(furou_work);
				rest_check = cjk.Nyuryokucheck(rest_work);

				start_end_check = cjk.check_start_end(start, end);
				start_end_digit = cjk.checkDigit(start, end);
				check_minute = cjk.checkMinute(start, end);

				if(start_check != true || end_check != true || cyouka_check != true || sinya_check != true || cyoku_check != true || furou_check != true || rest_check != true){

					return "半角数字で入力してください。";

				}

//				if(start.equals("") && !end.equals("")){

//					return i + "日：出勤時間を入力してください。";

//				}

//				if(!start.equals("") && end.equals("")){

//					return i + "日：退勤時間を入力してください。";

//				}

				if(start_end_check != true || check_minute != true){

					return i + "日：出勤時間と退勤時間を正しく入力してください。";

				}

				if(start_end_digit != true){

					return i + "日：出勤時間と退勤時間は４桁で入力してください。";
				}
				
				if(!(code==null) && !(code.equals(""))){
					code1=code.substring(0,1);
				
				
					if(code1.equals("f") || code1.equals("F")){
						pname = "<シフト勤務>";
						code3=code.substring(1);
					
					}
				}
				
				if(!pcode.equals("") && !code.equals("")){
										
			
					if(pcode.equals(pcode2) && code.equals(code2) && bikou1.equals(bikou2)){
					
						pname=bikou3;
					
					}else{
						ctbl = cjk.checkPname2(pcode,code3);
//						String sql = "select * from codeMST where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+code3+"'";
//						pname = cjk.checkPname(pcode,code);
//						clist = cdao.selectTbl(sql);
//						ctbl = (B_Code)clist.get(0);
						
						if(ctbl == null){
							return i + "日：入力されたコードは正しくありません。";

						}
						
						pname = ctbl.getPROJECTname()+pname+"("+ctbl.getBikou()+")";

					}
				}
				
				cyouka = cjk.cyoukaJikan(end,pcode,code,cyouka_work,start,ctbl);
				sinya = cjk.sinyaJikan(start,end,code,sinya_work);
				furou = cjk.furoujikan(start, end, pcode, code,furou_work,ctbl);
				cyoku = cjk.cyokusetuJikan(start, end,code,cyoku_work,cyouka,pcode,ctbl);
				rest = cjk.restJikan(start, end, code, cyoku, rest_work);
			//	hday = holiday.holiday(bym.getYear_month(),i);
				bikou = cjk.bikou(bikou, hday).trim();

				plist.add(pcode);
				clist2.add(code);
				slist.add(start);
				elist.add(end);
				cylist.add(cyouka);
				silist.add(sinya);
				cyolist.add(cyoku);
				rlist.add(rest);
				flist.add(furou);
				hlist.add(hday);
				blist.add(pname+bikou);

				goukeicyouka = cgk.cyouka(goukeicyouka, cyouka);
				goukeisinya = cgk.cyouka(goukeisinya, sinya);
				goukeifurou = cgk.cyouka(goukeifurou, furou);
				goukeicyokusetu = cgk.cyouka(goukeicyokusetu, cyoku);
				goukeikyude = cgk.kyudemonth(goukeikyude, code);
				goukeidaikyu = cgk.daikyumonth(goukeidaikyu, code);
				goukeinenkyu = cgk.nenkyumonth(goukeinenkyu, code);
				goukeikekkin = cgk.kekkinmonth(goukeikekkin, code);
				goukeiakyu = cgk.akyumonth(goukeiakyu, code);
				goukeibkyu = cgk.bkyumonth(goukeibkyu, code);
				
				if(!pcode.equals("") && !code.equals("")){
					
					bikou1=pname+bikou;
					pcode2=pcode;
					code2=code;
					bikou2=bikou1;
					bikou3=pname;
				}
				pname="";
				hday ="";

			}

			String year_month = bym.getYear_month();
			String year = bym.getYear();
			String month = bym.getMonth();

			B_ShainMST bshain = (B_ShainMST)session.getAttribute("ShainMST");

			String number = bshain.getNumber();
			String id = bshain.getId();

			String zangyou_month = cgk.cyouka(goukeisinya, goukeicyouka);
			String zangyou_year = "";

			if(month.equals("4")){

				zangyou_year = zangyou_month;

			}else{

				String s_month = "";
				String s_year = "";

				if(month.equals("1")){

					s_month = "12";

					int p = Integer.parseInt(year);

					s_year = Integer.toString(p-1);

				}else{

					int z = Integer.parseInt(month);

					s_month = Integer.toString(z-1);
					s_year = year;

				}

				ZangyouDAO zdao = new ZangyouDAO();
				String sql2 = " where number ='"+number+"' AND year ='"+s_year+"' AND month ='"+s_month+"'";

				if(zdao.isThereTbl(sql2)){
				ArrayList zlist = zdao.selectTbl(sql2);
				
//				int z = zlist.size();
//				if(zlist != null && z != 0){

					B_ZangyouMST zmst = new B_ZangyouMST();
					zmst = (B_ZangyouMST)zlist.get(0);

					String s_zangyou = zmst.getGoukeiZangyou();

					zangyou_year = cgk.cyouka(s_zangyou, zangyou_month);

				}else{

					zangyou_year = zangyou_month;

				}

			}

			String sql = "";
			String sql3 = "";

			cdbc = new C_DBConnection();
			con = cdbc.createConnection();
			stmt = con.createStatement();
			con.setAutoCommit(false);

			GoukeiDAO gdao = new GoukeiDAO();
			sql3 = "where number ='"+number+"' AND year_month ='"+year_month+"'";
			boolean check = gdao.isThereTbl(sql3);

			NenkyuDAO ndao = new NenkyuDAO();
			sql = " where number ='"+number+"'";

			if(check == true){

			ArrayList glist = gdao.selectTbl(sql3);
			
//			if(glist != null){
				
				B_GoukeiMST gmst = new B_GoukeiMST();
				gmst = (B_GoukeiMST)glist.get(0);

				if(gmst.getFlg().equals("0")){
					System.out.println("処理時間4=");
					double this_nenkyu = Double.parseDouble(gmst.getNenkyuMONTH());
					double this_akyu = Double.parseDouble(gmst.getAkyuMONTH());
					double this_bkyu = Double.parseDouble(gmst.getBkyuMONTH());
					double this_yukyu = this_nenkyu + ((this_akyu + this_bkyu) /2);
					

					if(ndao.isThereTbl(sql)){

					ArrayList list = ndao.selectTbl(sql);
					
		//			if(list != null){
						B_NenkyuMST nenkyumst = new B_NenkyuMST();

						int updatenenkyumst = 0;

						nenkyumst = (B_NenkyuMST)list.get(0);

						double nenkyu_all1 = Double.parseDouble(nenkyumst.getNenkyu_all());
						double nenkyu_year1 = Double.parseDouble(nenkyumst.getNenkyu_year());

						nenkyu_all1 = nenkyu_all1 - this_yukyu;
						nenkyu_year1 = nenkyu_year1 + this_yukyu;

						sql = " update nenkyuMST set nenkyu_all ='"+String.valueOf(nenkyu_all1)+"',nenkyu_year ='"+String.valueOf(nenkyu_year1)+"' where number ='"+number+"'";
						
						updatenenkyumst = stmt.executeUpdate(sql);

						if(updatenenkyumst < 1){

							con.rollback();

							return "書き込み失敗";

						}else{

							con.commit();

						}

					}

				}

			}
//			time2 = System.currentTimeMillis();
//			time = time2-time1;
//			System.out.println("処理時間5="+time);
			sql = " where number ='"+number+"'" ;

			int updatenenkyumstwork = 0;

			double nenkyu_month = goukeinenkyu;
			double hankyu_month = goukeiakyu + goukeibkyu;;
			hankyu_month = hankyu_month/2;

			if(ndao.isThereTbl(sql)){

			ArrayList nlist = ndao.selectTbl(sql);
			
//			if(nlist != null){
				B_NenkyuMST nmst = new B_NenkyuMST();

				nmst = (B_NenkyuMST)nlist.get(0);

				double n_all = Double.parseDouble(nmst.getNenkyu_all());
				double n_year = Double.parseDouble(nmst.getNenkyu_year());

				String nenkyu_all = String.valueOf(n_all-nenkyu_month-hankyu_month);
				String nenkyu_year = String.valueOf(n_year+nenkyu_month+hankyu_month);
				NenkyuDAO_work ndao_work = new NenkyuDAO_work();

				
				sql = "where number='" + number + "' and year_month ='"+year_month+"'";

				if(ndao_work.isThereTbl(sql)){

					sql = " update nenkyuMST_work set nenkyu_new ='"+nmst.getNenkyu_new()+"',nenkyu_all ='"+nenkyu_all+"',nenkyu_year ='"+nenkyu_year+"',nenkyu_kurikoshi ='"+nmst.getNenkyu_kurikoshi()+"',nenkyu_fuyo ='"+nmst.getNenkyu_fuyo()+
						"' where number ='"+number+"' and year_month ='" + year_month +"'";

					updatenenkyumstwork = stmt.executeUpdate(sql);

				}else{

					sql = " insert into nenkyuMST_work values ('"+number+"','"+nmst.getNenkyu_new()+"','"+nenkyu_all+"','"+nenkyu_year+"','"+nmst.getNenkyu_kurikoshi()+"','"+nmst.getNenkyu_fuyo()+"','"+year_month+"')";

					updatenenkyumstwork = stmt.executeUpdate(sql);

				}

			}	

			C_GetWeekday cgwd = new C_GetWeekday();
//			time2 = System.currentTimeMillis();
//			time = time2-time1;
//			System.out.println("処理時間6="+time);
			String youbi = "";

			int work = 0;

			int updatekinmumst = 0;
			int updategoukeimst = 0;
			int updatezangyoumst = 0;
//			 time2 = System.currentTimeMillis();
//			 time = time2-time1;
//			System.out.println("処理時間333="+time);		
			sql = "delete from kinmuMST where number='"+number+"' AND year_month='"+year_month+"'";
			updatekinmumst = stmt.executeUpdate(sql);
			
			sql = "delete from goukeiMST where number='"+number+"' AND year_month='"+year_month+"'";
			updategoukeimst = stmt.executeUpdate(sql);
			
			sql = "delete from zangyouMST where number ='"+number+"' AND year ='"+year+"' AND month ='"+month+"'";
			updatezangyoumst = stmt.executeUpdate(sql);
			
//			if(check == true){

//				for(int i = 0; i < lastday; i++){

//					sql = " update kinmuMST set PROJECTcode='"+plist.get(i)+"', KINMUcode='"+clist2.get(i)+"', startT='"+slist.get(i)+"', endT='"+elist.get(i)+"', restT='"+rlist.get(i)+"', cyoukaT='"+cylist.get(i)+"', sinyaT='"+silist.get(i)+"', cyokuT='"+cyolist.get(i)+"', PROJECTname='"+blist.get(i)+"', SYUKUJITUname='"+hlist.get(i)+"', furouT='"+flist.get(i)+"' where number='"+number+"' AND year_month='"+year_month+"' AND hizuke='"+Integer.toString(i+1)+"'";

//					work = stmt.executeUpdate(sql);

//					updatekinmumst = updatekinmumst + work;

//				}

//				sql = " update goukeiMST set cyoukaMONTH='"+goukeicyouka+"', sinyaMONTH='"+goukeisinya+"', furouMONTH='"+goukeifurou+"', kyudeMONTH='"+Integer.toString(goukeikyude)+"', daikyuMONTH='"+Integer.toString(goukeidaikyu)+"', nenkyuMONTH='"+Integer.toString(goukeinenkyu)+"', kekkinMONTH='"+Integer.toString(goukeikekkin)+"', akyuMONTH='"+Integer.toString(goukeiakyu)+"', bkyuMONTH='"+Integer.toString(goukeibkyu)+"', goukeiMONTH='"+goukeicyokusetu+"', flg='2',syouninroot='', iraisha=''  where number='"+number+"' AND year_month='"+year_month+"'";

//				updategoukeimst = stmt.executeUpdate(sql);

//				sql = " update zangyouMST set zangyouYEAR ='"+zangyou_year+"' , zangyouMONTH = '"+zangyou_month+"' where number ='"+number+"' AND year ='"+year+"' AND month ='"+month+"'";

//				updatezangyoumst = stmt.executeUpdate(sql);

//			}else{

				for(int i = 0; i < lastday; i++){
					youbi = cgwd.weekday(bym.getYear(),bym.getMonth(),i+1);

					sql = " insert into kinmuMST values ('"+id+"','"+number+"','"+year_month+"','"+Integer.toString(i+1)+"','"+youbi+"','"+plist.get(i)+"','"+clist2.get(i)+"','"+slist.get(i)+"','"+elist.get(i)+"','"+rlist.get(i)+"','"+cylist.get(i)+"','"+silist.get(i)+"','"+cyolist.get(i)+"','"+blist.get(i)+"','"+hlist.get(i)+"','"+flist.get(i)+"')";

					work = stmt.executeUpdate(sql);

					updatekinmumst = updatekinmumst + work;


				}

				sql = " insert into goukeiMST values ('"+id+"','"+number+"','"+year_month+"','"+goukeicyouka+"','"+goukeisinya+"','"+goukeifurou+"','"+Integer.toString(goukeikyude)+"','"+Integer.toString(goukeidaikyu)+"','"+Integer.toString(goukeinenkyu)+"','"+Integer.toString(goukeikekkin)+"','"+Integer.toString(goukeiakyu)+"','"+Integer.toString(goukeibkyu)+"','"+goukeicyokusetu+"','2','')";

				updategoukeimst = stmt.executeUpdate(sql);

				sql = " insert into zangyouMST values ('"+number+"','"+year+"','"+zangyou_year+"','"+month+"','"+zangyou_month+"')";

				updatezangyoumst = stmt.executeUpdate(sql);

//			}
			
			if(updatenenkyumstwork > 0 && updatekinmumst >= plist.size() && updategoukeimst > 0 && updatezangyoumst > 0){

				con.commit();
//				long time3 = System.currentTimeMillis();
//				long time5 = time3-time1;
//				System.out.println("保存時間"+time5);
//				 time3 = System.currentTimeMillis();
//				 time = time3-time2;
//				System.out.println("処理="+time);	
//				long time8 = System.currentTimeMillis();
//				long time9 = time8-time11;
//				System.out.println("保存総合時間"+time9);
				return "";

			}else{

				con.rollback();

				return "書き込み失敗";

			}

		}catch(Exception e){
			
			e.printStackTrace();

			con.rollback();

			return "書き込み失敗";

		}
	}

}
