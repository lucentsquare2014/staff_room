<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.common.C_GetWeekday" %><%@ page import = "kkweb.common.C_HolidayBackcolor" %>
<%@ page import = "kkweb.common.C_CheckTime" %><%@ page import = "kkweb.common.C_CheckGoukei" %><%@ page import = "kkweb.common.C_Lastday" %>
<%@ page import = "kkweb.common.C_Holiday" %><%@ page import = "kkweb.beans.B_ShainMST" %><%@ page import = "kkweb.beans.B_Year_month" %>
<%@ page import = "kkweb.beans.B_Kinmu_nyuryoku_2"%><%@ page import =  "kkweb.beans.B_GoukeiMST" %><%@ page import = "kkweb.beans.B_KinmuMST" %><%@ page import = "kkweb.beans.B_HolidayMST" %>
<%@ page import = "kkweb.beans.B_NenkyuMST_work" %><%@ page import = "kkweb.beans.B_ZangyouMST" %><%@ page import = "kkweb.dao.LoginDAO" %><%@ page import = "kkweb.dao.HolidayDAO" %>
<%@ page import = "kkweb.dao.KinmuDAO" %><%@ page import = "kkweb.dao.GoukeiDAO" %><%@ page import = "kkweb.dao.NenkyuDAO_work" %><%@ page import = "kkweb.dao.ZangyouDAO" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST"/>
<jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/");
		}else{	%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<title>書き込み完了</title>
</head>
<body>
<center>
<font class="title">書き込み完了</font><br><br>
<font size="4"><b><%= ShainMST.getName() %> ： <%= Year_month.getYear() %>年　<%= Year_month.getMonth() %>月</b></font>
<table border="1" cellspacing="0"  class="houkoku">
<tr>
<th class="t-koumoku" ><font class="f-koumoku">日</font></th>
<th class="t-koumoku" ><font class="f-koumoku">曜日</font></th>
<th class="t-koumoku" ><font class="f-koumoku">出勤時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">退勤時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">超過時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">深夜時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">直接時間</font></th>
<th class="t-koumoku" ><font class="f-koumoku">備考</font></th>
</tr>
<%	String sql = "";
	String holiday = "";
	String day = "";
	String month = "";
	String month_day = "";
	int thisMonth = Integer.parseInt(Year_month.getMonth()+"00");
	int nextMonth = thisMonth+100;
	C_Lastday cld = new C_Lastday();
	int lastday = cld.lastday(Year_month.getYear(),Year_month.getMonth());
	C_GetWeekday cgwd = new C_GetWeekday();
	C_HolidayBackcolor chbc = new C_HolidayBackcolor();
	C_CheckTime cct = new C_CheckTime();
	C_CheckGoukei ccg = new C_CheckGoukei();
	C_Holiday ch = new C_Holiday();
	request.setCharacterEncoding("UTF-8");
	KinmuDAO kdao = new KinmuDAO();
	sql = " where number='"+ShainMST.getNumber()+"' AND year_month='"+Year_month.getYear_month()+"' ORDER BY to_number(hizuke,'99') ASC ";
	ArrayList klist = kdao.selectTbl(sql);
	B_KinmuMST bkmst = new B_KinmuMST();
	
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);
	
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
		//String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td align="center"><%= i %><br></td>
<td align="center"><%= youbi %><br></td>
<td align="center"><%= cct.checktime(bkmst.getStartT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getEndT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyoukaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getSinyaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyokuT()) %><br></td>
<td align="center" class="biko"><font class="biko"><%= bkmst.getPROJECTname()+""+bkmst.getSYUKUJITUname() %></font><br><div align="right"><font size="1">-<%= cct.checktime(bkmst.getFurouT()) %><br></font></div></td>
</tr>
<%holiday = "";
}%>
</table><br>
<form method="post" action="Kinmu_Nyuryoku.jsp">
<input type="button" onClick='history.back();' value="再入力" style="cursor: pointer;">
</form><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>