<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html"></jsp:include>
<title>社内掲示板</title>
<style>
body {
	width: 100%;
	height: 610px;
	background-attachment: fixed;
	background-color:white;
	background-size: 100% 100%;
}
.conetent{
	padding: 0; 
	padding-top: 42px; 
	height: 100%; 
	width: 100%;
	margin-left:auto;
	margin-right:auto;
	background-color:white;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="conetent">
		<%
		String value = null;
		value = request.getParameter("etc");%>
		<%if(value.equals("1")){%><iframe width="100%" height="100%" src="//www.lucentsquare.co.jp/gps/pc/"></iframe><%} %>
		<%if(value.equals("2")){%><iframe width="100%" height="100%" src="//www.lucentsquare.co.jp:8080/etalent5_27/main.jsp"></iframe><%}%>
		<%if(value.equals("3")){%><iframe width="100%" height="100%" src="//www.lucentsquare.co.jp/staff/WorkingGroup/Advance_WorkingGroup.html"></iframe><%} %>
		<%if(value.equals("4")){%><iframe width="100%" height="100%" src="//www.lucentsquare.co.jp/staff/newstaff_2014/newstaff_index.html"></iframe><%} %>		
	</div>
</body>
</html>