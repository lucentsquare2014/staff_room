<%@ page language="java" contentType="text/html; charset=shift-jis"
	pageEncoding="utf-8"%>
<%@ page import="kkweb.dao.*"%>
<%@ page import="kkweb.beans.*"%>
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
<link rel="stylesheet" href="css/systemselect.css" type="text/css">

<%!// リンク用文字列
	//String kintai_login = "http://localhost:8080/kk_local/ID_PW_Nyuryoku.jsp";
	//String kintai_login = "http://www.lucentsquare.co.jp:8080/kk_web/ID_PW_Nyuryoku.jsp";
	String kintai_login = "ID_PW_Nyuryoku.jsp";
	//String officedocuments = "OfficeDocuments.jsp";
	//String officedocuments = "http://www.lucentsquare.co.jp:8080/pc_web/OfficeDocuments.jsp";
	String officedocuments = "OfficeDocuments.jsp";
	//String kintai_menu = "http://localhost:8080/kk_local/Menu_Gamen.jsp";
	//String kintai_menu = "http://www.lucentsquare.co.jp:8080/kk_web/Menu_Gamen.jsp";
	String kintai_menu = "Menu_Gamen.jsp";
	String msj = "menu.jsp";%>

<title>システム選択画面</title>
</head>
<body>
	<center>
		<div class=main>
			<div class="shadowbox">
				<div class="mainbox">
					<table class="main">
						<tr>
							<th><font class=title>システム選択</font>
								<hr></th>
						</tr>
						<tr>
							<td class="tdMsj">
							<center>
							<form action="<%=msj%>" method="post" name="MSJform">
								<input type="hidden" name="id" value="<%=ShainMST.getId()%>">
								<div class="pMsj"><input class="msj" type="submit" value="社内スケジュール" ></div>
							</form>
							</center>
							</td>
						</tr>
						<tr>
							<td><a class=a1
								href="<%=kintai_menu%>">社内勤怠システム
									&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
						</tr>
						<tr>
							<td><a class=a1 href="<%=officedocuments%>">社内文書システム
									&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
						</tr>
						<tr>
							<td class=b><a class=a2
								href="http://www.lucentsquare.co.jp/staff/staff_main.html">［スタッフルームに戻る］
							</a></td>
						</tr>

					</table>
				</div>
			</div>
		</div>
	</center>
</body>
</html>
<%}%>