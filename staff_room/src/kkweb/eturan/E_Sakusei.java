package kkweb.eturan;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.beans.B_GamenInsatu;
import kkweb.beans.B_ZangyouMST;
import kkweb.common.C_CheckGoukei;
import kkweb.common.C_CheckMonth;
import kkweb.common.C_FileCopy;
import kkweb.common.C_FileDelete;
import kkweb.common.C_FileExecution;
import kkweb.common.C_FileWrite;
import kkweb.dao.GameninsatuDAO;
import kkweb.dao.ZangyouDAO;
import kkweb.superclass.C_ChangePageBase;

public class E_Sakusei extends C_ChangePageBase{

	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/jsp/shanai_s/Gamen_Insatu.jsp";
			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String backPage(HttpServletRequest request){
		try{
			String nextpage = "/jsp/shanai_s/Login_error.jsp";
			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}


	public void doMain(HttpServletRequest request){
		try{

			request.setCharacterEncoding("UTF-8");
	//最初に必要なデータをDBから入手
			String number = request.getParameter("number");
			String this_year_month = request.getParameter("year_month");
			String sql = "where shainMST.number = '" + number + "' and goukeiMST.year_month = '" + this_year_month + "' order by to_number(hizuke,'99') asc " ;
			ArrayList InsatuDATA = new ArrayList();
			GameninsatuDAO dao = new GameninsatuDAO();
			InsatuDATA = dao.insatuTbl(sql);
			B_GamenInsatu Shain = (B_GamenInsatu)InsatuDATA.get(0);
			String onamae = (String)Shain.getName();
			C_CheckGoukei gou = new C_CheckGoukei();
			C_CheckMonth mont = new C_CheckMonth();
			ZangyouDAO zdao = new ZangyouDAO();
			String t = this_year_month.substring( 0 , 4 );
			String m = mont.MonthCheck(this_year_month.substring( 4 , 6 ));
			sql = " where year = '" + t + "' and number = '" + number + "' and month = '"+ m +"'";
			ArrayList zlist = zdao.selectTbl(sql);
			B_ZangyouMST nenkan = (B_ZangyouMST)zlist.get(0);
	//マクロ入りエクセルをコピーする
			String genpon = "C:\\temp\\報告書雛型\\雛型.xls";
			String copy = "C:\\temp\\報告書\\"+t+"年\\"+onamae+"\\"+onamae+"_"+t+"年"+m+"月.xls";
			File file = new File("C:\\temp\\報告書\\"+t+"年");
			if(!file.exists()){
				file.mkdir();
			}
			file = new File("C:\\temp\\報告書\\"+t+"年\\"+onamae);
			if(!file.exists()){
				file.mkdir();
			}


			C_FileCopy sakusei = new C_FileCopy();
			sakusei.copy(genpon,copy);

	//専用vbsファイルを作成する
			ArrayList str = new ArrayList();
			str.add("Dim ExceApp");
			str.add("Dim ExcelBook");
			str.add("Set ExcelApp = CreateObject"+"("+"\"Excel.Application\""+")");
			str.add("set ExcelBook = ExcelApp.Workbooks.Open"+"("+"\"C:\\temp\\報告書\\"+t+"年\\"+onamae+"\\"+onamae+"_"+t+"年"+m+"月.xls\""+")");
			str.add("ExcelApp.Application.Visible = False");
			str.add("ExcelApp.DisplayAlerts = False");

			str.add("With ExcelApp");
			str.add("'.Workbooks.Open "+"\"C:\\temp\\報告書\\"+t+"年\\"+onamae+"\\"+onamae+"_"+t+"年"+m+"月.xls\"");
			str.add(".Run "+"\"Macro1\"");
			str.add("ExcelBook.Save");
			str.add(".Workbooks.Close");
			str.add(".Quit");
			str.add("End With");

			str.add("ExcelApp.Application.Quit");
			str.add("Set ExcelApp = Nothing");
			str.add("Set ExcelBook = Nothing");


			str.add("Dim FSO");
			str.add("Dim oLog");
			str.add("Set FSO = CreateObject"+"("+"\"Scripting.FileSystemObject\""+")");
			str.add("Set oLog = FSO.CreateTextFile"+"("+"\"C:\\temp\\"+this_year_month+""+onamae+".txt\""+")");
			str.add("Set oLog = Nothing");
			str.add("Set oLog = Nothing");

			String name = "C:\\temp\\Test"+onamae+"_"+t+"年"+m+"月.vbs";
			C_FileWrite write = new C_FileWrite();
			write.writeTextfile(str,name);
	//batファイルを作成する
			ArrayList baty = new ArrayList();
			baty.add("@echo off");
			baty.add("@cls");
			baty.add("cd c:\\temp\\");
			baty.add("cscript Test"+onamae+"_"+t+"年"+m+"月.vbs ");
			baty.add("exit");
			String namae =onamae.replaceAll("　","");
			String bat = "C:\\temp\\Test"+namae+"_"+t+"年"+m+"月.bat";
			write.writeTextfile(baty,bat);

	//dbよりtxtファイルを作成する
			ArrayList texty = new ArrayList();
			texty.add(",,,,勤 務 報 告 書");
			if(Shain.getSyouninroot().equals("")){
				texty.add(",");
				texty.add(",");
			}else{
				texty.add(",<<承認者経路>>");
				String shounin = Shain.getSyouninroot();
				String shounin2=shounin.replaceAll(" ","");
				String shounin3=shounin2.replaceAll("　","");
				texty.add(""+shounin3+"");
			}
			texty.add(",,,"+t+"年"+m+"月："+onamae+"");
			texty.add("日,曜日,Pコード,出勤時間,退勤時間,超過時間,深夜時間,直接時間,備考");
	int x = InsatuDATA.size();
			for (int i = 0 ; i < InsatuDATA.size() ; i++ ){
				B_GamenInsatu itiniti = (B_GamenInsatu)InsatuDATA.get(i);
				String oldbikou3=itiniti.getPROJECTname();
				String oldbikou2=oldbikou3.replaceAll(" ","、");
				String oldbikou=oldbikou2.replaceAll("　","、");
				String newbikou=oldbikou.replaceAll(",","、");
				if(gou.checkgoukei(itiniti.getCyokuT())=="0:00"){
					texty.add(""+itiniti.getHizuke()+","+itiniti.getYoubi()+",,,,,,,"+newbikou+""+itiniti.getSYUKUJITUname()+",");
				}else{
			texty.add(""+itiniti.getHizuke()+","+itiniti.getYoubi()+","+itiniti.getPROJECTcode()+","+gou.checkgoukei(itiniti.getStartT())+","+gou.checkgoukei(itiniti.getEndT())+","+gou.checkgoukei(itiniti.getCyoukaT())+","+gou.checkgoukei(itiniti.getSinyaT())+","+gou.checkgoukei(itiniti.getCyokuT())+","+newbikou+itiniti.getSYUKUJITUname()+",,,"+gou.checkgoukei(itiniti.getFurouT())+"");
			}}
			if(x == 31){

			}else if(x == 30){
				texty.add(",");
			}else if(x == 29){
				texty.add(",");
				texty.add(",");
			}else if(x == 28){
				texty.add(",");
				texty.add(",");
				texty.add(",");
			}
			texty.add(",");
			texty.add("超過時間,,深夜時間,不労時間,休出日数,代休日数,年休日数,欠勤日数,A休計,B休計,合計時間");
			texty.add(""+gou.checkgoukei(Shain.getCyoukaMONTH())+",,"+gou.checkgoukei(Shain.getSinyaMONTH())+","+gou.checkgoukei(Shain.getFurouMONTH())+","+Shain.getKyudeMONTH()+","+Shain.getDaikyuMONTH()+","+Shain.getNenkyuMONTH()+","+Shain.getKekkinmonth()+","+Shain.getAkyuMONTH()+","+Shain.getBkyuMONTH()+","+gou.checkgoukei(Shain.getGoukeiMONTH())+"");
			texty.add(",");
			texty.add("月間残業,,,,,,年間累積残業時間");
			texty.add(""+gou.checkgoukei(nenkan.getZangyoumonth())+",,,,,,"+gou.checkgoukei(nenkan.getGoukeiZangyou())+"");
			name = "C:\\temp\\"+onamae+"_"+t+"年"+m+"月.xls.txt";
			write.writeTextfile(texty,name);
	//マクロを実行させる
			C_FileExecution ex = new C_FileExecution();
			ex.main("cmd.exe /c start C:\\temp\\Test"+namae+"_"+t+"年"+m+"月.bat");
	//ファイル出現をフラグとし、最後までマクロを実行させる
			file = new File("C:\\temp\\"+this_year_month+"" + onamae + ".txt");
			while(!file.exists()){
			}
			Thread.sleep(3000);

	//excelファイル以外削除する
			file = new File("C:\\temp\\Test"+onamae+"_"+t+"年"+m+"月.vbs");
			C_FileDelete.deleteFile(file);
			file = new File("C:\\temp\\"+this_year_month+""+onamae+".txt");
			C_FileDelete.deleteFile(file);
			file = new File("C:\\temp\\Test"+namae+"_"+t+"年"+m+"月.bat");
			C_FileDelete.deleteFile(file);
			file = new File("C:\\temp\\"+onamae+"_"+t+"年"+m+"月.xls.txt");
			C_FileDelete.deleteFile(file);

			HttpSession session = request.getSession(true);
			session.setAttribute("InsatuDATA",InsatuDATA);

			}catch(Exception e){
				//e.printStackTrace();
			   }
	}}

