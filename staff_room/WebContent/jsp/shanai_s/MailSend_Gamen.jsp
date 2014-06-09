<%@ page language="java" contentType="text/html; charset=shift_JIS"
	pageEncoding="shift_JIS" session="true"%>
<%@ page import="kkweb.mail.C_MailSend"%><%@ page import="java.util.*"%>
<%@ page import="kkweb.beans.*"%><%@ page import="kkweb.dao.*"%><%@ page import="java.sql.*"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<jsp:useBean id="mailsend" scope="session" class="kkweb.mail.C_MailSend" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String) session.getAttribute("key");
	if (id2 == null || id2.equals("false")) {
		pageContext.forward("/ID_PW_Nyuryoku.jsp");
	} else {
		request.setCharacterEncoding("windows-31j");
		String body = request.getParameter("body");
		String number = request.getParameter("iraisha_number");
		String year_month = request.getParameter("iraisha_year_month");
		String mail = request.getParameter("okurisaki_mail");
		String root = request.getParameter("shouninsha_root");
		String subject = request.getParameter("subject");
%>
<jsp:setProperty name="mailsend" property="smtpHost"
	value="mail.lucentsquare.co.jp" />
<%
	String login_mail = ShainMST.getMail();
%><jsp:setProperty
	name="mailsend" property="from" value="<%=login_mail%>" /><jsp:setProperty
	name="mailsend" property="to" value="<%=mail%>" />
<%
	int i = root.indexOf("→");
		if (i == -1) {
%><jsp:setProperty name="mailsend" property="subject"
	value="＜勤務報告＞修正通知" />
<%
	} else {
%><jsp:setProperty name="mailsend" property="subject"
	value="<%=subject%>" />
<%
	}
%><jsp:setProperty name="mailsend" property="body"
	value="<%=body%>" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="message.css" type="text/css">
<title>メール送信</title>
</head>
<body>
	<center>
		<div class="location">
			<div class="location2">
				<font class="msg">送信完了</font><br>
				<br> <a href="Menu_Gamen.jsp" class="link"><font
					class="link">[ メニューへ戻る ]</font></a>
			</div>
		</div>
		<%
			mailsend.run();
				HokokuDAO H_dao = new HokokuDAO();
				H_dao.reUpdateTbl(number, year_month, ShainMST.getId());
		%>
	</center>
</body>
</html>
<%}%>