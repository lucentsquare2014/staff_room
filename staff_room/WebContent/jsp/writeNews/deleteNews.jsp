<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>delete</title>
</head>
<body>
<%
String del_id = request.getParameter("del_id");
System.out.println(del_id);
NewsDAO dao = new NewsDAO();
//dao.deleteNews(del_id);
%>
</body>
</html>