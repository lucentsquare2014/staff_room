<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.common.C_CheckTime" %><%@ page import = "kkweb.common.C_CheckGoukei" %>
<%@ page import = "kkweb.common.C_JikanKeisan" %><%@ page import = "kkweb.common.C_HolidayBackcolor" %><%@ page import = "kkweb.common.C_Holiday" %>
<%@ page import = "kkweb.common.C_Lastday" %><%@ page import = "kkweb.common.C_GetWeekday" %><%@ page import = "kkweb.beans.B_ShainMST" %>
<%@ page import = "kkweb.beans.B_KinmuMST" %><%@ page import = "kkweb.beans.B_GoukeiMST" %><%@ page import = "kkweb.beans.B_ZangyouMST" %><%@ page import = "kkweb.beans.B_HolidayMST" %>
<%@ page import = "kkweb.beans.B_NenkyuMST" %><%@ page import = "javax.servlet.http.HttpSession" %><%@ page import = "javax.servlet.http.HttpServletRequest" %>
<%@ page import = "kkweb.dao.LoginDAO" %><%@ page import = "kkweb.dao.KinmuDAO" %><%@ page import = "kkweb.dao.GoukeiDAO" %><%@ page import = "kkweb.dao.ZangyouDAO" %><%@ page import = "kkweb.dao.NenkyuDAO" %><%@ page import = "kkweb.dao.HolidayDAO" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST"/><jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
	if(id2 == null || id2.equals("false")){
		pageContext.forward("/");
	}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<title>承認作業終了の勤務報告書</title>
</head>
<body>
<center>
<font class="title">勤務報告書（承認済み）</font><BR><hr color = "#008080">
<table>
<tr><td align="left"><font color ="red"><small>過去の勤務報告書の再入力を行う場合はそれ以後の勤務報告書も再入力してください。</small></font></td></tr>
<tr><td align="left"><small>・例）8月のデータを承認後、7月のデータを再入力する場合は7月を更新後、8月のデータも更新してください。</small></td></tr>
</table><hr color = "#008080"><br>
<font size="4"><b><%= Year_month.getYear() %>年　<%= Year_month.getMonth() %>月</b></font>
<table border="1"  cellspacing="0" class="houkoku">
<tr>
<th class="t-koumoku"  ><font class="f-koumoku">日</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">曜日</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">Pコード</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">出勤時間</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">退勤時間</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">超過時間</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">深夜時間</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">直接時間</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">備考</font></th>
</tr>
<%	String sql = "";
	int thisMonth = Integer.parseInt(Year_month.getMonth()+"00");
	int nextMonth = thisMonth+100;
	C_Lastday cld = new C_Lastday();
	int lastday = cld.lastday(Year_month.getYear(),Year_month.getMonth());
	C_GetWeekday cgwd = new C_GetWeekday();
	C_HolidayBackcolor chbc = new C_HolidayBackcolor();
	C_CheckTime cct = new C_CheckTime();
	C_CheckGoukei ccg = new C_CheckGoukei();
	C_Holiday ch = new C_Holiday();
	request.setCharacterEncoding("Windows-31J");
	KinmuDAO kdao = new KinmuDAO();
	sql = " where number='"+ShainMST.getNumber()+"' AND year_month='"+Year_month.getYear_month()+"' ORDER BY to_number(hizuke,'99') ASC ";
	ArrayList klist = kdao.selectTbl(sql);
	B_KinmuMST bkmst = new B_KinmuMST();
	
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);

	String day = "";
	String month = "";
	String month_day = "";
	String holiday = "";
	String holiday5 = "";
	String STRAT="";
	String END="";
	
	B_HolidayMST bhmst = new B_HolidayMST();
	int cnt = 0;
	
	for(int i = 1; i <= lastday; i++){
		bkmst = (B_KinmuMST)klist.get(i-1);
		String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
		if(thisMonth<1000){
			month_day = "0" + Integer.toString(thisMonth + i);
		}else{
			month_day = Integer.toString(thisMonth + i);				
		}
		if(holiArray.size() != 0 && holiArray != null && holiArray.size() > cnt){
			bhmst = (B_HolidayMST)holiArray.get(cnt);
			
			if(month_day.equals(bhmst.getSYUKUJITUdate())){
				holiday = bhmst.getSYUKUJITUname();
				cnt++;
				
			}
		}
		
		STRAT=cct.checktime(bkmst.getStartT());
		END=cct.checktime(bkmst.getEndT());
		
//		String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td align="center" style="width:25"><%= i %><br></td>
<td align="center"><%= youbi %><br></td>
<td align="center">
<% if(STRAT.equals("") && END.equals("") || STRAT.equals("0:00") && END.equals("0:00")){		
}else{%>
<%= bkmst.getPROJECTcode() %>
<%}  %><br></td>
<td align="center"><%= cct.checktime(bkmst.getStartT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getEndT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyoukaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getSinyaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyokuT()) %><br></td>
<td align="center" class="biko"><font class="biko"><%= bkmst.getPROJECTname()+""+bkmst.getSYUKUJITUname() %></font><br><div align="right"><font size="1">-<%= cct.checktime(bkmst.getFurouT()) %><br></font></div></td>
</tr>
<%holiday = "";
}%>
</table>
<br />
<table border="1"class="houkoku" cellspacing="0">
<tr>
<th class="t-koumoku" ><font class="f-koumoku">超過時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">深夜時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">不労時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">休出日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">代休日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">年休日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">欠勤日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">Ａ休計</font></th>
<th class="t-koumoku" ><font class="f-koumoku">Ｂ休計</font></th>
<th class="t-koumoku" ><font class="f-koumoku">合計時間</font></th>
</tr>
<%	GoukeiDAO gdao = new GoukeiDAO();
	sql = " where number ='"+ShainMST.getNumber()+"'AND year_month ='"+Year_month.getYear_month()+"'";
	ArrayList glist = gdao.selectTbl(sql);
	B_GoukeiMST gmst = new B_GoukeiMST();
	gmst = (B_GoukeiMST)glist.get(0);
	C_CheckGoukei ckgk = new C_CheckGoukei();%>
<tr>
<td align="right"><%= ckgk.checkgoukei(gmst.getCyoukaMONTH()) %></td>
<td align="right"><%= ckgk.checkgoukei(gmst.getSinyaMONTH()) %></td>
<td align="right"><%= ckgk.checkgoukei(gmst.getFurouMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getKyudeMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getDaikyuMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getNenkyuMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getKekkinMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getAkyuMONTH()) %></td>
<td align="right"><%= ckgk.checknissu(gmst.getBkyuMONTH()) %></td>
<td align="right"><%= ckgk.checkgoukei(gmst.getGoukeiMONTH()) %></td>
</tr>
</table>
</center><center>
<table border="1"class="houkoku" cellspacing="0">
<tr>
<th class="t-koumoku" ><font class="f-koumoku">当年付与日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">繰越年休日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">使用年休日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">残年休日数</font></th>
<th class="t-koumoku" ><font class="f-koumoku">月間残業時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">年間累積残業時間</font></th>
</tr>
<%	NenkyuDAO ndao = new NenkyuDAO();
	sql = " where number ='"+ShainMST.getNumber()+"'";
	ArrayList nlist = ndao.selectTbl(sql);
	B_NenkyuMST nmst = new B_NenkyuMST();
	nmst = (B_NenkyuMST)nlist.get(0);%>
<tr>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_fuyo())  %></td>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_kurikoshi()) %></td>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_year())  %></td>
<%	if(!nmst.getNenkyu_all().equals("") && nmst.getNenkyu_all().substring(0,1).equals("-")){%>
<td align="center"><font color="red"><%=  ccg.checknissu(nmst.getNenkyu_all())  %></font></td>
<%	}else{%>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_all())  %></td>
<%	}ZangyouDAO zdao = new ZangyouDAO();
	sql = " where number ='"+ShainMST.getNumber()+"' AND year ='"+Year_month.getYear()+"' AND month ='"+Year_month.getMonth()+"'";
	ArrayList zlist = zdao.selectTbl(sql);
	B_ZangyouMST zmst = new B_ZangyouMST();
	zmst = (B_ZangyouMST)zlist.get(0);
	if(Integer.parseInt(zmst.getZangyoumonth()) > 9000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></td>
<%	}if(Integer.parseInt(zmst.getGoukeiZangyou()) > 100000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></td>
<%	}%>
</tr>
</table><br>
<form action="Kinmu_nyuryoku.jsp" method="post">
<input type="submit" value="再入力" style="cursor: pointer;">
</form><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>