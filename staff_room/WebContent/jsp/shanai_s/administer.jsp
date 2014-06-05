<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.GetCookie" %>
<%
	if(session.getAttribute("login") != null){
		String user = String.valueOf(session.getAttribute("login"));
		if (!user.equals("admin")){
			response.sendRedirect("/staff_room/jsp/top/top.jsp");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang = "ja">
<head>
<jsp:include page="/html/head.html" />
<title>認証画面（システム管理）</title>
<script type="text/javascript">
window.onload = function() {
    document.theform.submit();
};
function submit1() {
    document.body.style.cursor = 'wait';
    document.theform.aa.disabled = true;
    document.theform.bb.disabled = true;
    document.theform.submit();
}
</script>
</head>
<body>
<form method="POST" action="//www.lucentsquare.co.jp:8080/kk_web/c_checkpwsystem" name="theform">
<input type="hidden" name="action" value="gate">
<input type="hidden" name="Pwd"  value="qqqq" size="25">
</form>
</body>
</html>