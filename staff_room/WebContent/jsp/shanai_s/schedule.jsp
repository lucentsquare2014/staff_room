<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>社内スケジュール</title>
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
<form method="POST" action="//www.lucentsquare.co.jp:8080/kk_web/menu.jsp" name="theform">
<input type="hidden" name="id" value="<%=session.getAttribute("login") %>">
</form>
</body>
</html>