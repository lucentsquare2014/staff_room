<%@ page language="java" contentType="text/html; charset=shift_JIS"pageEncoding="shift_JIS"%>
<%@ page import = "kkweb.beans.B_GamenInsatu" %><%@ page import = "kkweb.beans.B_ZangyouMST" %><%@ page import = "kkweb.beans.B_Year_month" %><%@ page import = "javax.servlet.*" %><%@ page import = "kkweb.beans.B_HolidayMST" %>
<%@ page import = "kkweb.dao.ZangyouDAO" %><%@ page import = "kkweb.common.*" %><%@ page import = "kkweb.common.C_CheckGoukei" %><%@ page import = "kkweb.dao.HolidayDAO" %>
<%@ page import = "kkweb.common.C_HolidayBackcolor" %><%@ page import = "kkweb.common.C_CheckMonth" %><%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.text.DateFormat" %><%@ page import = "java.text.SimpleDateFormat" %><%@ page import = "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="EscapeDATA" scope="session" type="java.util.ArrayList"/>
<html>
<head>
<SCRIPT TYPE="text/javascript">
function PrintPage(){
	if(document.getElementById || document.layers){
		window.print();	
	}
}
</SCRIPT>		
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<link rel="stylesheet" href="Insatu.css" type="text/css">
<title>勤務報告書閲覧</title>
</head>
<body>
<center>			
<font class="title">勤務報告書</font>
<div class="noprint">			
<%	request.setCharacterEncoding("shift_JIS");
	String escapeflg =request.getParameter("escapeflg");
	String STRAT="";
	String END="";
	B_GamenInsatu syouninroot = (B_GamenInsatu)EscapeDATA.get(0);
	String S1 = (String)syouninroot.getSyouninroot();	
		if (S1 == null || S1.equals("")){%><br>		
<%		}else{%>
<center>
<br/><br/><A HREF="javascript:PrintPage()">印刷</A><br/> 
</center>
</div><div align="left"><b>＜＜承認経路＞＞</b></div><div align="left"><%= S1 %></div>		
<%		}
	B_GamenInsatu year_month = (B_GamenInsatu)EscapeDATA.get(0);
	String ym = (String)year_month.getYear_month();
	C_CheckMonth mont = new C_CheckMonth();%>
<center>
<font size="4"><b><%= ym.substring( 0 , 4 ) %>年<%= mont.MonthCheck(ym.substring( 4 , 6 )) %>月 ： <%= year_month.getName() %></b></font><br>
<table border="0" width="800px">
<tr>
<td>
<table border="1" class="houkoku">
<tr>
<th class="t-koumoku"><font class="f-koumoku"><B>日</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>曜日</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>Pコード</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>出勤時間</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>退勤時間</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>超過時間</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>深夜時間</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>直接時間</B></font></th>
<th class="t-koumoku"><font class="f-koumoku"><B>備考</B></font></th>
</tr>			
<%	String holiday = "";
	String day = "";
	String month = "";
	String month_day = "";
	int thisMonth = Integer.parseInt(mont.MonthCheck(ym.substring( 4 , 6 ))+"00");
	int nextMonth = thisMonth+100;
	
	C_CheckGoukei gou = new C_CheckGoukei();
	C_HolidayBackcolor color = new C_HolidayBackcolor();
	C_Holiday check = new C_Holiday();
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);
	
	B_HolidayMST bhmst = new B_HolidayMST();
	int cnt = 0;
	
	for (int i = 0 ; i < EscapeDATA.size() ; i++ ){
	B_GamenInsatu itiniti = (B_GamenInsatu)EscapeDATA.get(i);
	
		if(thisMonth<1000){
			month_day = "0" + Integer.toString(thisMonth + i+1);
		}else{
			month_day = Integer.toString(thisMonth + i+1);				
		}
		if(holiArray.size() != 0 && holiArray != null && holiArray.size() > cnt){
			bhmst = (B_HolidayMST)holiArray.get(cnt);
			
			if(month_day.equals(bhmst.getSYUKUJITUdate())){
				holiday = bhmst.getSYUKUJITUname();
				cnt++;
				
			}
		}
		STRAT=gou.checkgoukei(itiniti.getStartT());
		END= gou.checkgoukei(itiniti.getEndT());%>
<tr bgcolor="<%= color.holidaycolor(itiniti.getYoubi(),holiday) %>">
<td align="center" style="width:25"><center><%= itiniti.getHizuke() %><br></center></td>
<td align="center"><center><%= itiniti.getYoubi() %><br></center></td>
<td align="center"><center>
<% if(STRAT.equals("") && END.equals("") || STRAT.equals("0:00") && END.equals("0:00")){		
}else{%>
<%= itiniti.getPROJECTcode() %>
<%}  %><br></center></td>
<%		if (gou.checkgoukei(itiniti.getCyokuT())=="0:00"){%>
<td align="center"><center><br></center></td>
<td align="center"><center><br></center></td>
<td align="center"><center><br></center></td>
<td align="center"><center><br></center></td>
<td align="center"><center><br></center></td>
<td align="center" class="biko"><font class="biko"><%= itiniti.getPROJECTname()+""+itiniti.getSYUKUJITUname() %></font><div align="right"><FONT size="1">-<br></font></div></td>
<%		}else {%>
<td align="center"><center><%= gou.checkgoukei(itiniti.getStartT()) %><br></center></td>
<td align="center"><center><%= gou.checkgoukei(itiniti.getEndT()) %><br></center></td>
<td align="center"><center><%= gou.checkgoukei(itiniti.getCyoukaT()) %><br></center></td>
<td align="center"><center><%= gou.checkgoukei(itiniti.getSinyaT()) %><br></center></td>
<td align="center"><center><%= gou.checkgoukei(itiniti.getCyokuT()) %><br></center></td>
<td align="center" class="biko"><font class="biko"><%= itiniti.getPROJECTname()+""+itiniti.getSYUKUJITUname() %></font><div align="right"><FONT size="1">-<%= gou.checkgoukei(itiniti.getFurouT()) %><br></font></div></td>
<%		}%>
</tr>				
<%	holiday = "";
}%>
</table >
</td>
</tr><tr></tr><tr>
<td>
<table border="1"class="houkoku">
<tr>
<th class="t-koumoku"><font class="f-koumoku">超過時間</font></th>
<th class="t-koumoku"><font class="f-koumoku">深夜時間</font></th>
<th class="t-koumoku"><font class="f-koumoku">不労時間</font></th>
<th class="t-koumoku"><font class="f-koumoku">休出日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">代休日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">年休日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">欠勤日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">Ａ休計</font></th>
<th class="t-koumoku"><font class="f-koumoku">Ｂ休計</font></th>
<th class="t-koumoku"><font class="f-koumoku">合計時間</font></th>
</tr>
<%	B_GamenInsatu tuki = (B_GamenInsatu)EscapeDATA.get(0);%>
<tr>
<td align="right"><%= gou.checkgoukei(tuki.getCyoukaMONTH()) %></td>
<td align="right"><%= gou.checkgoukei(tuki.getSinyaMONTH()) %></td>
<td align="right"><%= gou.checkgoukei(tuki.getFurouMONTH()) %></td>
<td align="right"><%= gou.checknissu(tuki.getKyudeMONTH()) %></td>
<td align="right"><%= gou.checknissu(tuki.getDaikyuMONTH()) %></td>
<td align="right"><%= gou.checknissu(tuki.getNenkyuMONTH()) %></td>
<td align="right"><%= gou.checknissu(tuki.getKekkinmonth()) %></td>
<td align="right"><%= gou.checknissu(tuki.getAkyuMONTH()) %></td>
<td align="right"><%= gou.checknissu(tuki.getBkyuMONTH()) %></td>
<td align="right"><%= gou.checkgoukei(tuki.getGoukeiMONTH()) %></td>
</tr>
</table>
</td>
</tr><tr>
<td>
<table border="1"class="houkoku">
<%	Calendar cal = Calendar.getInstance();
	int yes = cal.get(Calendar.YEAR);
	int muri = cal.get(Calendar.MONTH);
	muri++;
	String yea = String.valueOf(yes);
	String mon = String.valueOf(muri);
	String murim = mont.CheckMonth(mon);
	String yemo = yea + murim;
	int kotosi = Integer.parseInt(yemo);
	int s = Integer.parseInt(ym);				
	if (kotosi == s || (kotosi - 1) == s){%>
<tr>
<th class="t-koumoku"><font class="f-koumoku">当年付与日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">繰越年休日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">使用年休日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">残年休日数</font></th>
<th class="t-koumoku"><font class="f-koumoku">月間残業時間</font></th>
<th class="t-koumoku"><font class="f-koumoku">年間累積残業時間</font></th>
</tr>	
<tr>
<td align="center"><%=  tuki.getNenkyu_fuyo()  %></td>
<td align="center"><%=  tuki.getNenkyu_kurikoshi() %></td>
<td align="center"><%=  tuki.getNenkyu_year()  %></td>
<td align="center"><%=  tuki.getNenkyu_all()  %></td>				
<%	}else{%>
<tr>
<th align="center" class="t-koumoku"><font class="f-koumoku">月間残業時間</font></th>
<th align="center" class="t-koumoku"><font class="f-koumoku">年間累積残業時間</font></th>
</tr><tr>
<%	} 
	ZangyouDAO zdao = new ZangyouDAO();
	year_month = (B_GamenInsatu)EscapeDATA.get(0);
	String y = year_month.getYear_month();
	String number = year_month.getNumber();
	String t = y.substring( 0 , 4 );
	String m = mont.MonthCheck(y.substring( 4 , 6 ));
	String sql = " where year = '" + t + "' and number = '" + number + "' and month = '"+ m +"'";
	ArrayList zlist = zdao.selectTbl(sql);
	B_ZangyouMST nenkan = (B_ZangyouMST)zlist.get(0);				
	if(Integer.parseInt(nenkan.getZangyoumonth()) > 9000){%>
<td align="center"><font style="color:red;"><%=  gou.checkgoukei(nenkan.getZangyoumonth())  %></font></td>				
<%	}else{%>
<td align="center"><%=  gou.checkgoukei(nenkan.getZangyoumonth())  %></td>
<%	}
	if(Integer.parseInt(nenkan.getGoukeiZangyou()) > 100000){%>
<td align="center"><font style="color:red;"><%= gou.checkgoukei(nenkan.getGoukeiZangyou()) %></font></td>
<%	}else{%>
<td align="center"><%= gou.checkgoukei(nenkan.getGoukeiZangyou()) %></td>
<%	}%>	
</tr>
</table>
</td>
</tr>
</table>
</center><br>
</body>
</html>