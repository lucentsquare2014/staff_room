package kkweb.shain;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

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

public class S_Kinmu_nyuryoku_kakunin extends C_ChangePageBase {

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

			return "半角数字で入力してください。";

		}
	}

	public String nextPage(HttpServletRequest request){

		try{

			String nextpage = "/Kinmu_nyuryoku_kakunin.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
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
			request.setCharacterEncoding("Windows-31J");
			HttpSession session = request.getSession(true);
			C_CheckWord word = new C_CheckWord();
			session.removeAttribute("Hyoujyun");
			session.removeAttribute("IchijiDATA");
			B_Year_month bym = (B_Year_month)session.getAttribute("Year_month");
			String year_month = bym.getYear_month();
			C_Lastday cld = new C_Lastday();
			
//			勤務報告をしようとしている月が何日あるか"/common/C_lastday.java"のlastday()で求めている。
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
			ArrayList hlist = new ArrayList();
			ArrayList blist = new ArrayList();
			ArrayList listH = new ArrayList();

			String pcode = "";
			String pcode2 = "";
			String code = "";
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

			String goukeicyouka = "0";
			String goukeisinya = "0";
			String goukeifurou = "0";
			String goukeicyokusetu = "0";
			int goukeikyude = 0;
			int goukeidaikyu = 0;
			int goukeinenkyu = 0;
			int goukeikekkin = 0;
			int goukeiakyu = 0;
			int goukeibkyu = 0;
			int syukuzitu = 0;
			int count = 0;
			
			B_Code ctbl = new B_Code();
//			CodeDAO cdao = new CodeDAO();
			B_HolidayMST bhmst = new B_HolidayMST();
			
			HolidayDAO hdao = new HolidayDAO();
			

			String month2 = bym.getYear_month().substring(4);
			String sqlH = " where syukujitudate like'"+month2+"%'";
			
//			isThereTblは勤務報告する月に祝日があるかないかをtrueとfalseで返すメソッド
			boolean hday2 = hdao.isThereTbl(sqlH);
			
			
			if(hday2 == true){
//				もし祝日があったら、listHに勤務報告する月の祝日を全て挿入する。	
				listH = hdao.selectTbl(sqlH);
			}
			
//			勤務報告書に入力した内容を、後にDBに挿入するために１日ずつlistに加えていく。
			for(int i = 1; i <= lastday; i++ ){	
				
				
//				勤務報告をする月に祝日があり、且つlistHから全ての祝日を引き出していない場合はifの中へ入る。
				if(hday2 == true && listH.size() > syukuzitu){
					
					if(i < 10){

						day = "0"+Integer.toString(i);

					}else{

						day = Integer.toString(i);

					}

					bhmst = (B_HolidayMST)listH.get(syukuzitu);
//					祝日の日付をbeansから引き出している。
					day2 = bhmst.getSYUKUJITUdate().substring(2);
//					listHに残っている祝日の日付と日付をループしているiの値が一致した場合は、ifの中へ入る。
						if(day2.equals(day)){
//							祝日の名前をbeansから引き出している。
							hday = bhmst.getSYUKUJITUname();
//							listHの次の祝日を引き出すためにsyukuzituを１足す。
							syukuzitu = syukuzitu+1;
						}
				}
				


//				勤務報告書に入力されたデータをここで１日ずつ取得している。
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
				bikou = word.checks(bikou);
				
//				勤務報告書を全ての日を空白で報告しようとした場合にエラー画面に飛んで”入力してください”とメッセージを表示する。
				if(pcode.equals("") && code.equals("") && start.equals("") && end.equals("") && cyouka_work.equals("") && sinya_work.equals("") && cyoku_work.equals("") && furou_work.equals("") && rest_work.equals("")){
					count = count + 1;
				}				
				if(count == lastday){
					return "入力してください";
				}
	
				
//				Ｐコードとコードと出勤時間と退勤時間が空欄の場合に他の項目を入力していた時、エラー画面に飛ぶ。
				if(pcode.equals("") && code.equals("") && start.equals("") && end.equals("") ){
					if(!cyouka_work.equals("")){
						return i + "日：超過は入力しないでください";
					}else if(!sinya_work.equals("")){
						return i + "日：深夜は入力しないでください";
					}else if(!cyoku_work.equals("")){
						return i + "日：直接は入力しないでください";
					}else if(!rest_work.equals("")){
						return i + "日：休憩は入力しないでください";
					}else if(!furou_work.equals("")){
						return i + "日：不労は入力しないでください";
					}
				}
					
				
//				コードが入力されていてＰコードが空欄の場合はエラー画面へ飛ぶ。
				if(pcode.equals("") && !code.equals("")){
//					if(i==1){
						return i + "日：Ｐコードが入力されていません";
//					}else{
//						for(int s=i;s<2;s--){
//							pcode = (String)plist.get(s-2);
//							if(!pcode.equals("")){
//								break ;
//							}
//						}
//					}
				}

				
//				Ｐコードが入力されていてコードが空欄の場合はエラー画面へ飛ぶ。
				if(code.equals("") && !pcode.equals("")){
					return i + "日：コードが入力されていません";					
				}
				
//				出勤時間と退勤時間が入力されていて、コードが空欄だった場合はエラー画面へ飛ぶ。
				if(!(start.equals("")) || !(end.equals(""))){
					if(code.equals("")){
						return i + "日：コードが入力されていません";
					}							
				}
			
//				ここの処理の意味は不明・・・				
				if(pcode.equals("")){

					pcode = pcode_work;

				}else if(!pcode.equals("")){

					pcode_work = pcode;

				}

//				ここでコードが空欄の場合にＰコードも空欄にしようとしているから、１日分の入力がされていなかった場合の処理かもしれない。
				if(code.equals("")){

					pcode = "";

				}

//				コードの"n"は年休、"k"は欠勤、"50"は特別休暇、"88"は代休で、コードがいずれかの場合に
//				出勤時間と退勤時間を空欄にしている。
				if(code.equals("n") || code.equals("k") || code.equals("50") || code.equals("88")){

					start = "";
					end = "";

				}
//				入力された値が正しい形式で入力されているか"/common/C_JikanKeisan.java"のメソッドでチェックしている。
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

//				上記のチェックでいずれかがfalseの場合はエラー画面へ飛ぶ。
				if(start_check != true || end_check != true || cyouka_check != true || sinya_check != true || cyoku_check != true || furou_check != true || rest_check != true){

					return i + "日：半角数字で入力してください。";

				}

//				退勤時間が入力されていて出勤時間が空欄の場合はエラー画面へ飛ぶ。
				if(start.equals("") && !end.equals("") ){

					return  i + "日：出勤時間を入力してください。";

				}
				
//				出勤時間が入力されていて退勤時間が空欄の場合はエラー画面へ飛ぶ。
				if(!start.equals("") && end.equals("") ){

					return i + "日：退勤時間を入力してください。";

				}
				
//				コードに"n","k","50","88"のいずれかが入力されていない場合、ifのなかへ入る。
				if(!(code.equals("n") || code.equals("k") || code.equals("50") || code.equals("88"))){
					
//					コードが空欄ではなくて、出勤時間が空欄の場合はエラー画面へ飛ぶ。
					if(!code.equals("") && start.equals("")){
						return  i + "日：出勤時間を入力してください。";
					}
					
//					コードが空欄ではなくて、退勤時間が空欄の場合はエラー画面へ飛ぶ。					
					if((!code.equals("") && end.equals(""))){
						return i + "日：退勤時間を入力してください。";
					}				
				}	
				
				
				if(start.equals("0000") && end.equals("0000")){

					return i + "日：年休・代休・特別休暇の際は所定のコードを入力してください。" ;

				}

				if(start_end_check != true || check_minute != true){

					return i + "日：出勤時間と退勤時間を正しく入力してください。";

				}

				if(start_end_digit != true){

					return i + "日：出勤時間と退勤時間は４桁で入力してください。";
				}

				
				
				String code1="";
				
//				ここからはシフト勤務の場合の処理を行っている。
//				シフト勤務の場合はコードの先頭にfかＦを入れる。コードがシフト勤務を表しているかを判断する為にコードの先頭の文字を抽出している。
				if(!(code==null) && !(code.equals(""))){
					code1=code.substring(0,1);
				}
			
//				コードの先頭にシフト勤務を表すfかFがあった場合はifの中に入る。
				if(code1.equals("f") || code1.equals("F")){
//					変数pnameは備考欄に挿入する。
					pname = "<シフト勤務>";
//					fかFを取り除いたコードを変数code3に挿入する。
					code3=code.substring(1);
					
//					シフト勤務の場合、全ての項目を自分で入力しなければエラー画面へ飛ぶ。
					if(start.equals("")){
						
						return i+"日：出勤時間を入力して下さい。";
						
					}else if(end.equals("")){
						
						return i+"日：退勤時間を入力して下さい。";
						
					}else if(cyouka_work.equals("")){
						
						return i+"日：超過時間を入力して下さい。";
						
					}else if(sinya_work.equals("")){
						
						return i+"日：深夜時間を入力して下さい。";
						
					}else if(cyoku_work.equals("")){
						
						return i+"日：直接時間を入力して下さい。";
						
					}else if(furou_work.equals("") ){
						
						return i+"日：不労時間を入力して下さい。";
						
					}else if(rest_work.equals("")){
						
						return i+"日：休憩時間を入力して下さい。";
						
					}
				}
				
				
				if(!pcode.equals("") && !code.equals("")){
					
//					前の日とＰコード、コード、備考欄が同じ場合は、ＤＢへのアクセス作業を省略して備考欄には前日と同じ内容を入れる。
					if(pcode.equals(pcode2) && code.equals(code2) && bikou1.equals(bikou2)){
					
						pname=bikou3;

					
					}else{

						ctbl = cjk.checkPname2(pcode,code3);
						
						if(ctbl == null){
							return i + "日：入力されたコードは正しくありません。";
						}
					
					pname = ctbl.getPROJECTname()+pname+"("+ctbl.getBikou()+")";

				}
			}
				
//				超過時間、深夜時間、不労時間、直接時間、休憩時間の計算を"/common/C_JikanKeisan.java"のメソッドで行っている。
				cyouka = cjk.cyoukaJikan(end,pcode,code,cyouka_work,start,ctbl);
				sinya = cjk.sinyaJikan(start,end,code,sinya_work);
				furou = cjk.furoujikan(start, end, pcode, code,furou_work,ctbl);
				cyoku = cjk.cyokusetuJikan(start, end,code,cyoku_work,cyouka,pcode,ctbl);				
				rest = cjk.restJikan(start, end, code, cyoku, rest_work);		
//				hday = holiday.holiday(bym.getYear_month(),i);
				
//				この日が祝日の場合は備考欄に祝日名を追加するメソッド。
				bikou = cjk.bikou(bikou, hday).trim();
						
//				リストにそれぞれの値を追加する。
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

//				それぞれの時間の１カ月の合計を出している。
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
				
//				次の日のＰコード、コード、備考を参照する為の処理。
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

//			勤務報告をしている社員のＩＤ、社員番号、年月をB_shainMSTから取得している。
			B_ShainMST shainmst = (B_ShainMST)session.getAttribute("ShainMST");
			String id = shainmst.getId();
			String number = shainmst.getNumber();
			String year = bym.getYear();
			String month = bym.getMonth();
			
//			１ヶ月の深夜時間と超過時間の合計を足した時間を１ヶ月の残業時間としている。
			String zangyou_month = cgk.cyouka(goukeisinya, goukeicyouka);
			String zangyou_year = "";

			if(month.equals("4")){
				
//				もし勤務報告する月が４月なら、その年度の残業時間は４月の残業時間のみなので、４月の残業時間をその年度の合計残業時間とする。
				zangyou_year = zangyou_month;

			}else{

				String s_month = "";
				String s_year = "";

//				s_monthは前月を表す変数、s_yearは前年を表す変数、ここでは前月の年月を出している。
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
				
//				isThereTblメソッドで前月の残業データがzangyouMSTにあるかないかをtrueかfalseで返している。
				if(zdao.isThereTbl(sql2)){

					
//					selectTblメソッドはセットしたsql文の結果をbeansにセットする仕掛けになっている。
//					ここで前月の残業データを呼び出すsql文を実行している。
					ArrayList zlist = zdao.selectTbl(sql2);
					
	//				int z = zlist.size();
	//				if(zlist != null && z != 0){
						
					
//					B_ZangyouMSTから上記で実行したsql文の結果を取得している。
					B_ZangyouMST zmst = new B_ZangyouMST();					
					zmst = (B_ZangyouMST)zlist.get(0);	
					String s_zangyou = zmst.getGoukeiZangyou();

//					ここでその月の時点での年度の合計残業時間を算出している。	
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
			
//			勤務報告する月のデータがgoukeiMSTにすでにあるかないかをisThereTblメソッドでtrueかfalseで表している。
			sql3 = "where number ='"+number+"' AND year_month ='"+year_month+"'";
			boolean check = gdao.isThereTbl(sql3);
						
			NenkyuDAO ndao = new NenkyuDAO();
			sql = " where number ='"+number+"'";
			
//			すでにgoukeiMSTにデータがあった場合ifの中に入る。
			if(check == true){
				
				ArrayList glist = gdao.selectTbl(sql3);

		//		if(glist != null){
				
				B_GoukeiMST gmst = new B_GoukeiMST();
				gmst = (B_GoukeiMST)glist.get(0);

//				goukeiMSTには勤務報告の状況を表すgetflgという列がある。
//				０と１と２で承認済みか承認作業中か保存しているだけかを表している。
//				※０は承認済み
				if(gmst.getFlg().equals("0")){
		
					double this_nenkyu = Double.parseDouble(gmst.getNenkyuMONTH());
					double this_akyu = Double.parseDouble(gmst.getAkyuMONTH());
					double this_bkyu = Double.parseDouble(gmst.getBkyuMONTH());
		
//					ここでgoukeiMSTに入っているデータを元に有給日数を算出している。
//					Ａ休とＢ休は午前と午後の半休の事なので、１回は0.5日とカウントしている。
					double this_yukyu = this_nenkyu + ((this_akyu + this_bkyu) /2);

//					ここから年休の処理で、nenkyuMSTに社員の年休データがあるかをチェックしている。
					if(ndao.isThereTbl(sql)){

						ArrayList list = ndao.selectTbl(sql);
						
//						if(list != null){
						B_NenkyuMST nenkyumst = new B_NenkyuMST();

//						nenkyuMSTへの書き込みが成功したかをチェックする為の変数。
						int updatenenkyumst = 0;

						nenkyumst = (B_NenkyuMST)list.get(0);
						double nenkyu_all1 = Double.parseDouble(nenkyumst.getNenkyu_all());
						double nenkyu_year1 = Double.parseDouble(nenkyumst.getNenkyu_year());

//						前月までの年休データに今月入力した分の年休データを戻して計算し、nenkyuMSTに更新している。
						nenkyu_all1 = nenkyu_all1 + this_yukyu;
						nenkyu_year1 = nenkyu_year1 - this_yukyu;
			
						sql = " update nenkyuMST set nenkyu_all ='"+String.valueOf(nenkyu_all1)+"',nenkyu_year ='"+String.valueOf(nenkyu_year1)+"' where number ='"+number+"'";
						
						updatenenkyumst = stmt.executeUpdate(sql);

//						nenkyuMSTの更新に失敗したらロールバックしてエラー画面へ飛ぶ。
						if(updatenenkyumst < 1){

							con.rollback();

							return "書き込み失敗";

						}else{

							con.commit();

						}

					}
		
				}

			}

//			ここからは今月の年休データをnenkyuMST_workに一時挿入する為の処理で、
//			1ヶ月分の年休、半休日数を算出している。
			sql = " where number ='"+number+"'";
			int updatenenkyumstwork = 0;

			double nenkyu_month = goukeinenkyu;
			double hankyu_month = goukeiakyu + goukeibkyu;
					
			hankyu_month = hankyu_month/2;

			
//			上記に同じ処理があるのでそちらを参照。
			if(ndao.isThereTbl(sql)){
				
//				ここで勤務報告した月の時点での年休データをnenkyuMST_workに一時挿入する処理を行っていて、
//				nenkyuMST_workは年休データを承認作業が完了するまで保持している。
//				年休データの計算方法についてはシステム管理の年休マスタメンテナンスのページに載っている。
				ArrayList nlist = ndao.selectTbl(sql);		
//				if(nlist != null){
				B_NenkyuMST nmst = new B_NenkyuMST();
				nmst = (B_NenkyuMST)nlist.get(0);

				double n_all = Double.parseDouble(nmst.getNenkyu_all());
				double n_year = Double.parseDouble(nmst.getNenkyu_year());

				String nenkyu_all = String.valueOf(n_all-nenkyu_month-hankyu_month);
				String nenkyu_year = String.valueOf(n_year+nenkyu_month+hankyu_month);

				NenkyuDAO_work ndao_work = new NenkyuDAO_work();

				sql = "where number='" + number + "' and year_month='" + year_month + "'" ;

//				nenkyuMST_workにすでにデータがある場合とないとでupdateするかinsertするかを分岐している。
				if(ndao_work.isThereTbl(sql)){

					sql = " update nenkyuMST_work set nenkyu_new ='"+nmst.getNenkyu_new()+"',nenkyu_all ='"+nenkyu_all+"',nenkyu_year ='"+nenkyu_year+"',nenkyu_kurikoshi ='"+nmst.getNenkyu_kurikoshi()+"',nenkyu_fuyo ='"+nmst.getNenkyu_fuyo()+"' where number ='"+number+"' and year_month='" + year_month +"'" ;

					updatenenkyumstwork = stmt.executeUpdate(sql);

				}else{

					sql = " insert into nenkyuMST_work values ('"+number+"','"+nmst.getNenkyu_new()+"','"+nenkyu_all+"','"+nenkyu_year+"','"+nmst.getNenkyu_kurikoshi()+"','"+nmst.getNenkyu_fuyo()+"','"+year_month+"')";

					updatenenkyumstwork = stmt.executeUpdate(sql);

				}

			}


			String youbi = "";
			C_GetWeekday cgwd = new C_GetWeekday();

			int work = 0;

			int updatekinmumst = 0;
			int updategoukeimst = 0;
			int updatezangyoumst = 0;

//			勤務報告をする時はまずdeleteしてからデータを挿入するようにしている。
			sql = "delete from kinmuMST where number='"+number+"' AND year_month='"+year_month+"'";
			updatekinmumst = stmt.executeUpdate(sql);
			
			sql = "delete from goukeiMST where number='"+number+"' AND year_month='"+year_month+"'";
			updategoukeimst = stmt.executeUpdate(sql);
			
			sql = "delete from zangyouMST where number ='"+number+"' AND year ='"+year+"' AND month ='"+month+"'";
			updatezangyoumst = stmt.executeUpdate(sql);
			
//			if(check == true){
//			if(glist != null){
//				for(int i = 0; i < plist.size(); i++){
//					sql = " update kinmuMST set PROJECTcode='"+plist.get(i)+"', KINMUcode='"+clist2.get(i)+"', startT='"+slist.get(i)+"', endT='"+elist.get(i)+"', restT='"+rlist.get(i)+"', cyoukaT='"+cylist.get(i)+"', sinyaT='"+silist.get(i)+"', cyokuT='"+cyolist.get(i)+"', PROJECTname='"+blist.get(i)+"', SYUKUJITUname='"+hlist.get(i)+"', furouT='"+flist.get(i)+"' where number='"+number+"' AND year_month='"+year_month+"' AND hizuke='"+Integer.toString(i+1)+"'";
//					work = stmt.executeUpdate(sql);
//					updatekinmumst = updatekinmumst + work;
//				}
//				sql = " update goukeiMST set cyoukaMONTH='"+goukeicyouka+"', sinyaMONTH='"+goukeisinya+"', furouMONTH='"+goukeifurou+"', kyudeMONTH='"+Integer.toString(goukeikyude)+"', daikyuMONTH='"+Integer.toString(goukeidaikyu)+"', nenkyuMONTH='"+Integer.toString(goukeinenkyu)+"', kekkinMONTH='"+Integer.toString(goukeikekkin)+"', akyuMONTH='"+Integer.toString(goukeiakyu)+"', bkyuMONTH='"+Integer.toString(goukeibkyu)+"', goukeiMONTH='"+goukeicyokusetu+"', flg='2', syouninroot ='',iraisha='' where number='"+number+"' AND year_month='"+year_month+"'";
//				updategoukeimst = stmt.executeUpdate(sql);
//				sql = " update zangyouMST set zangyouYEAR ='"+zangyou_year+"' , zangyouMONTH ='"+zangyou_month+"' where number ='"+number+"' AND year ='"+year+"' AND month ='"+month+"'";
//				updatezangyoumst = stmt.executeUpdate(sql);
//			}else{

			
//				ここでひと月分の勤務データを挿入している。
				for(int i = 0; i < plist.size(); i++){
					youbi = cgwd.weekday(year,month,i+1);
					
					sql = " insert into kinmuMST values ('"+id+"','"+number+"','"+year_month+"','"+Integer.toString(i+1)+"','"+youbi+"','"+plist.get(i)+"','"+clist2.get(i)+"','"+slist.get(i)+"','"+elist.get(i)+"','"+rlist.get(i)+"','"+cylist.get(i)+"','"+silist.get(i)+"','"+cyolist.get(i)+"','"+blist.get(i)+"','"+hlist.get(i)+"','"+flist.get(i)+"')";

					work = stmt.executeUpdate(sql);

					updatekinmumst = updatekinmumst + work;

				}
				
				sql = " insert into goukeiMST values ('"+id+"','"+number+"','"+year_month+"','"+goukeicyouka+"','"+goukeisinya+"','"+goukeifurou+"','"+Integer.toString(goukeikyude)+"','"+Integer.toString(goukeidaikyu)+"','"+Integer.toString(goukeinenkyu)+"','"+Integer.toString(goukeikekkin)+"','"+Integer.toString(goukeiakyu)+"','"+Integer.toString(goukeibkyu)+"','"+goukeicyokusetu+"','2','')";
				
				updategoukeimst = stmt.executeUpdate(sql);

				sql = " insert into zangyouMST values ('"+number+"','"+year+"','"+zangyou_year+"','"+month+"','"+zangyou_month+"')";

				updatezangyoumst = stmt.executeUpdate(sql);

//			}

			
//			DBへの書き込みがひとつでも失敗したらロールバックしてエラー画面へ飛ぶ。
			if(updatenenkyumstwork > 0 && updatekinmumst >= plist.size() && updategoukeimst > 0 && updatezangyoumst > 0){

				con.commit();
				cdbc.closeConection(con);

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
