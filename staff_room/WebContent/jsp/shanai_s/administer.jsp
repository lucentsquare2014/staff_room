<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("login") != null){
		String user = String.valueOf(session.getAttribute("login"));
		if (!user.equals("admin")){
			response.sendRedirect("/staff_room/jsp/top/top.jsp");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>管理 - 社内システム</title>
</head>
<body>
    <jsp:include page="/jsp/header/header.jsp" />
<p style="padding-top: 60px;">管理 - 社内システムです。</p>

</body>
</html>