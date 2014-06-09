<%@page
	import="java.util.*,kkweb.beans.*,kkweb.common.*,kkweb.mail.*,org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=shift-jis"
	pageEncoding="UTF-8"%>
<jsp:useBean id="SendList" scope="session" class="kkweb.beans.SendList" />
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
	String id2 = (String)session.getAttribute("key");
	if(id2 != null ? id2.equals("鍵") : false){	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift-jis">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<link rel="stylesheet" href="css/mailsendtoselecteduserpayslip.css" type="text/css">
<title>給与明細書URL送信完了</title>
<%
	ArrayList<ShainInfo> usersmst = new ArrayList<ShainInfo>();
	if(SendList != null) usersmst = SendList.getUsers();
	ArrayList<String> numberList = new ArrayList<String>();
	for (ShainInfo s : usersmst)
		numberList.add(s.getNumber());
%>
</head>
<body>
	<center>
		<h1>送信完了しました</h1>
		<div id="sendlist">

			<table>
				<tr>
					<th colspan=3>以下の方にメールを送信しました。
						<hr class=title_bottom size="1px" color="#008080">
					</th>
				</tr>
				<%
					int tr_pos = 1;
					for (ShainInfo u : usersmst) {
						if(tr_pos % 3 == 1) out.println("<tr>");
						out.println("<td>" + u.getName() + "さん</td>");
						if(tr_pos % 3 == 0) out.println("</tr>");
						tr_pos++;
					}
					if(tr_pos % 3 != 1) out.println("</tr>");
				%>
			</table>
		</div>
		<a href="OfficeDocuments.jsp">[社内文書システムに戻る]</a>
		
	</center>
	<%--
		if (session.getAttribute("key") != null) {
			for (ShainInfo s : users) {
				sb = new StringBuffer();
				C_MailSend mail = new C_MailSend();
				mail.setSmtpHost("mail.lucentsquare.co.jp");
				mail.setFrom(ShainMST.getMail());
				//mail.setFrom("y-arai@lucentsquare.co.jp");
				mail.setTo(s.getMail());
				//mail.setTo("h-seki@lucentsquare.co.jp");
				mail.setSubject("[社内文書システム] 最新の給与明細書を公開しました。");
				sb.append("最新の給与明細書を公開しました。以下のURLからご確認ください。" + br);
				sb.append("-------------------------------------------------------------------"
						+ br);

				sb.append("URL : " + url
						+ DigestUtils.shaHex(s.getNumber()) + br);
				//sb.append("URL : " + url + DigestUtils.shaHex("21301") + br);
				mail.setBody(sb.toString());
				System.out.println(mail.toString() + br);
				//mail.run();
			}
		}
	--%>
</body>
</html>
<%}%>