<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8" session="true"%>
<%@ page import="kkweb.mail.C_MailSend" %><%@ page import="kkweb.beans.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){	
	pageContext.forward("/");
		}else{
%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" /><jsp:useBean id="mailsend"  scope ="session" class ="kkweb.mail.C_MailSend"/>
<%	request.setCharacterEncoding("UTF-8");
	String iraisha_number = request.getParameter("iraisha_number");
	String iraisha_name = request.getParameter("iraisha_name");
	String iraisha_year_month = request.getParameter("iraisha_year_month");
	String okurisaki_name = request.getParameter("okurisaki_name");
	String okurisaki_mail = request.getParameter("okurisaki_mail");
	String shouninsha_root = request.getParameter("shouninsha_root");
	String login_name = ShainMST.getName();%>
<HTML>
<HEAD>
<script type="text/javascript">
	window.onunload=function(){};
		history.forward();
	function submit1(){
		document.body.style.cursor='wait';
		document.a.aa.disabled=true;
		document.a.submit()	
	}	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<title>返却</title>
</HEAD>
<BODY>
<CENTER><BR><BR>
<hr color = "#008080">
<table>
<tr><td align="left"><small>本文を入力後「送信」ボタンを押してください。入力された文章はそのままメールで送信されます。</small></td></tr>
</table>
<hr color = "#008080"><br>
<FORM action="MailSend_Gamen.jsp" method="POST" name="a">
<TABLE>
<TR>
<TD>
<TEXTAREA NAME="body" COLS="80" ROWS="10" ISTYLE="1" >
　認証ページ：http://www.lucentsquare.co.jp:8080/kk_web/Menu_Gamen.jsp

<%= okurisaki_name %>さんへ



　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　<%= login_name %>より
</TEXTAREA><BR><BR>
<INPUT TYPE="submit" STYLE="cursor: pointer;background-color:gray" VALUE="　送信　" name="aa" onClick="submit1()">
<INPUT TYPE="hidden" NAME="okurisaki_mail" VALUE="<%=okurisaki_mail%>">
<INPUT TYPE="hidden" NAME="iraisha_number" VALUE="<%=iraisha_number%>">
<INPUT TYPE="hidden" NAME="iraisha_year_month" VALUE="<%=iraisha_year_month%>">
<INPUT TYPE="hidden"  NAME="shouninsha_root" VALUE="<%=shouninsha_root %>">
<INPUT TYPE="hidden"  NAME="subject" VALUE="＜勤務報告＞<%= iraisha_name %>さんの勤務報告の再チェックをお願いします。">
</TD>
</TR>
</TABLE>
</FORM>
</CENTER>
</BODY>
</HTML>
<%}%>