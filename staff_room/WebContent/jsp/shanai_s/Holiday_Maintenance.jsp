<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.maintenance.*" %><%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
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
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{
			return true;
		}
	}
// -->
</SCRIPT>
<title>�j���}�X�^�����e�i���X</title>
</head>
<body>
<center>
<font class="title">�j���ꗗ</font><br>
<hr color = "#008080">
<table>
<tr><td align="left"><small>1.�ǉ�����ꍇ�͑S�Ă̍��ڂ���͌�u�ǉ��v�̃{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small>�E���͂��錎�A����1���̏ꍇ��"0"�����Ă��������B�i4�� = 04�j</small></td></tr>
<tr><td align="left"><small>2.�ύX����ꍇ�͕ύX��u�X�V�v�̃{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small>3.�폜����ꍇ�͍폜����s�̍��ڂ�S�ċ󗓂ɂ�����u�X�V�v�̃{�^���������Ă��������B</small></td></tr>
</table>
<hr color = "#008080"><br>
<FORM method="post" action="c_holiday_tuika" name="form1" onSubmit="return aboutbox()">
<TABLE BORDER="1" class =" mainte">
<TR>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">�j����</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="5" style="ime-mode: disabled;" maxlength="2"  NAME="month"></TD>
<TD><INPUT TYPE="text" SIZE="5" style="ime-mode: disabled;" maxlength="2"  NAME="day"></TD>
<TD><INPUT TYPE="text" SIZE="30"  NAME="holiday"></TD>
</TR>
</TABLE>
<TABLE>
<TR><TD><INPUT TYPE="submit" VALUE="�@�ǉ��@" class="bottom"></TD></TR>
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
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
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
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">�j����</font></TH>
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
<INPUT TYPE="submit" VALUE="�@�X�V�@" class="bottom" onClick="return aboutbox2()" >
<INPUT TYPE="hidden"  NAME="h_size" VALUE="<%= size %>">
</TD>
</TR>
</TABLE>
</FORM><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</center>
</body>
</html>
<%}%>