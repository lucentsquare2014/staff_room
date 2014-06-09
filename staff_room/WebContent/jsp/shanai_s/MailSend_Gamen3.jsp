<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.mail.C_MailSend"%><%@ page import="java.util.*"%><%@ page
	import="kkweb.beans.*"%><%@ page import="kkweb.dao.*"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" /><jsp:useBean
	id="mailsend" scope="session" class="kkweb.mail.C_MailSend" />
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
		String name = request.getParameter("iraisha_name");
		String shouninsha_number = request
				.getParameter("shouninsha_number");
		String shouninsha_name = request
				.getParameter("shouninsha_name");
%><jsp:setProperty
	name="mailsend" property="smtpHost" value="mail.lucentsquare.co.jp" />
<%
	String login_mail = ShainMST.getMail();
		String login_name = ShainMST.getName();
%><jsp:setProperty
	name="mailsend" property="from" value="<%=login_mail%>" />
<%
	String sql = " where number = '" + shouninsha_number + "'";
		ArrayList alist = new ArrayList();
		LoginDAO logindao = new LoginDAO();
		alist = logindao.selectTbl(sql);
		B_ShainMST b_shain = new B_ShainMST();
		b_shain = (B_ShainMST) alist.get(0);
%><jsp:setProperty name="mailsend"
	property="to" value="<%=b_shain.getMail()%>" />
<jsp:setProperty name="mailsend" property="subject"
	value="＜勤務報告＞勤務報告承認依頼" /><jsp:setProperty name="mailsend"
	property="body" value="<%=body%>" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="message.css" type="text/css">
<title>承認依頼完了</title>
</head>
<body>
	<center>
		<div class="location">
			<div class="location2">
				<font class="msg">承認依頼完了</font><BR>
				<br> <a href="Menu_Gamen.jsp" class="link"><font
					class="link">[ メニューへ戻る ]</font></a>
			</div>
		</div>
		<%
			mailsend.run();
				HokokuDAO H_dao = new HokokuDAO();
				H_dao.updateTbl(shouninsha_name, number, year_month,
						ShainMST.getId(), shouninsha_number);
		%>
	</center>
</body>
</html>
<%}%>