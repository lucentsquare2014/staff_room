<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.maintenance.*" %><%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="report.css" type="text/css">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<SCRIPT Language="JavaScript">
<!--
	function aboutbox() {
		var p = document.form1.holiday.value;
    	var aa = "\"";
	   	var bb = "\'";
	   	var cc = "\\";
	   	var dd = ">";
	   	var ee = "<";
	   	var ff = "\`";	
		if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1 | p.indexOf(dd) != -1 | p.indexOf(ee) != -1 | p.indexOf(ff) != -1){
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{
			return true;
		}
	}
// -->
</SCRIPT>
<title>祝日マスタメンテナンス</title>
</head>
<body>
<center>
<font class="title">祝日一覧</font><br>
<hr color = "#008080">
<table>
<tr><td align="left"><small>1.追加する場合は全ての項目を入力後「追加」のボタンを押してください。</small></td></tr>
<tr><td align="left"><small>・入力する月、日が1桁の場合は"0"をつけてください。（4月 = 04）</small></td></tr>
<tr><td align="left"><small>2.変更する場合は変更後「更新」のボタンを押してください。</small></td></tr>
<tr><td align="left"><small>3.削除する場合は削除する行の項目を全て空欄にした後「更新」のボタンを押してください。</small></td></tr>
</table>
<hr color = "#008080"><br>
<FORM method="post" action="c_holiday_tuika" name="form1" onSubmit="return aboutbox()">
<TABLE BORDER="1" class =" mainte">
<TR>
<TH class="t-koumoku"><font color="white">月</font></TH>
<TH class="t-koumoku"><font color="white">日</font></TH>
<TH class="t-koumoku"><font color="white">祝日名</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="5" style="ime-mode: disabled;" maxlength="2"  NAME="month"></TD>
<TD><INPUT TYPE="text" SIZE="5" style="ime-mode: disabled;" maxlength="2"  NAME="day"></TD>
<TD><INPUT TYPE="text" SIZE="30"  NAME="holiday"></TD>
</TR>
</TABLE>
<TABLE>
<TR><TD><INPUT TYPE="submit" VALUE="　追加　" class="bottom"></TD></TR>
</TABLE>
</FORM><BR>
<%	String sql = " order by to_number(syukujitudate,'9999') asc";
	ArrayList hlist = new ArrayList();
	HolidayDAO holidaydao = new HolidayDAO();
	hlist = holidaydao.selectTbl(sql);
	B_HolidayMST b_holiday = new B_HolidayMST();
	int kazu = hlist.size() -1;%>
<SCRIPT Language="JavaScript">
<!--
	function aboutbox2() {
	var A=0;	
<%
	for(int i = 0; i <= kazu; i++){%>
	var w = document.form2.h_holiday<%=i%>.value;
	var aa = "\"";
   	var bb = "\'";
   	var cc = "\\";
   	var dd = ">";
   	var ee = "<";
   	var ff = "\`";
		if (w.indexOf(aa) != -1 | w.indexOf(bb) != -1 | w.indexOf(cc) != -1 | w.indexOf(dd) != -1 | w.indexOf(ee) != -1 | w.indexOf(ff) != -1){
			A=1;	
		}else{}					
<%	}%>
		if(A==1){
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{
			return true;
		}
	}
// -->
</SCRIPT>
<FORM method="post" action="c_holiday_kousin" name="form2">
<TABLE BORDER="1" class =" mainte">
<TR>
<TH class="t-koumoku"><font color="white">月</font></TH>
<TH class="t-koumoku"><font color="white">日</font></TH>
<TH class="t-koumoku"><font color="white">祝日名</font></TH>
</TR>
<% for(int i=0; i<=hlist.size() -1 ;++i){
	b_holiday = (B_HolidayMST)hlist.get(i);
	String month_day = b_holiday.getSYUKUJITUdate();
	String month = month_day.substring(0,2);
	String day = month_day.substring(2,4);%>
<TR>
<TD><INPUT TYPE="text" SIZE="5"   NAME="h_month<%= i %>" VALUE="<%= month %>"style="ime-mode: disabled;" maxlength="2"></TD>
<TD><INPUT TYPE="text" SIZE="5"   NAME="h_day<%= i %>" VALUE="<%= day %>"style="ime-mode: disabled;" maxlength="2" ></TD>
<TD><INPUT TYPE="text" SIZE="30"  NAME="h_holiday<%= i %>" VALUE="<%= b_holiday.getSYUKUJITUname() %>" ></TD>
</TR>
<%	}
	String size = Integer.toString(hlist.size());%>
</TABLE>
<TABLE>
<TR>
<TD>
<INPUT TYPE="submit" VALUE="　更新　" class="bottom" onClick="return aboutbox2()" >
<INPUT TYPE="hidden"  NAME="h_size" VALUE="<%= size %>">
</TD>
</TR>
</TABLE>
</FORM><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>