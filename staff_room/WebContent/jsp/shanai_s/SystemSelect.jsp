<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=shift_JIS"
	pageEncoding="shift_JIS"%>
<%@ page import="login.GetCookie"%>
<%
	if (session.getAttribute("login") == null) {
		response.sendRedirect("/staff_room/jsp/top/top.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="ja">
<head>
<script type="text/javascript">
	window.onload = function() {
		document.theform.submit();
	};
	window.onunload = function() {
		document.body.style.cursor = 'auto';
		document.theform.aa.disabled = false;
		document.theform.bb.disabled = false;
	}
	function submit1() {
		document.body.style.cursor = 'wait';
		document.theform.aa.disabled = true;
		document.theform.bb.disabled = true;
		document.theform.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=shift-jis">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="login.css" type="text/css">
<title>認証画面</title>
</head>
<body>
	<form method="POST"
		action="//www.lucentsquare.co.jp:8080/kk_web/s_login" name="theform">
		<input type="hidden" name="action" value="gate"> <input
			type="hidden" name="shainID"
			value="<%if (session.getAttribute("login") != null) {%><%=session.getAttribute("login")%><%}%>"
			size="30" maxlength="20" class="text"> <input type="hidden"
			name="Pwd"
			value="<%if (GetCookie.get("pass_cookie", request) != null) {%><%=GetCookie.get("pass_cookie", request).getValue()%><%}%>"
			size="25" maxlength="20">
	</form>
</body>
</html>