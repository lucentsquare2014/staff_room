<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page import="kkweb.dao.*"%>
<%@ page import="kkweb.beans.*"%>
<jsp:useBean id="ShainMST" scope="session"
	class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String id2 = (String) session.getAttribute("key");
	if (id2 != null ? id2.equals("鍵") : false) {
%>
<%
/*modeの情報に応じてリダイレクトするところを変えている*/
	String mode = request.getParameter("mode");
		if (mode == null) {
			mode = "1";
		}
		if (mode.equals("2")) {
			response.sendRedirect("./Menu_Gamen.jsp");
			return;
		} else if (mode.equals("3")) {
			response.sendRedirect("./OfficeDocuments.jsp");
			return;

		}
%>
<html>
<head>
<% /*modeが１ならページが読み込まれると自動的にフォームを送信するJavaScriptを生成する。*/
	if (mode.equals("1")) {
%>
<script>
	window.onload = function() {
		document.MSJform.submit();
	};
</script>
<%
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%!// リンク用文字列
	String kintai_login = "ID_PW_Nyuryoku.jsp";
	String officedocuments = "OfficeDocuments.jsp";
	String kintai_menu = "Menu_Gamen.jsp";
	String msj = "Schedule.jsp";%>
</head>
<body>
	<form action="<%=msj%>" method="post" name="MSJform">
		<input type="hidden" name="id" value="<%=ShainMST.getId()%>">
	</form>
</body>
</html>
<%
	} else{
%>
<%
response.sendRedirect("/");
return;
	}
%>