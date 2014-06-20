<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html"></jsp:include>
<%
		String value = null;
		value = request.getParameter("ph");%>
<%if(value.equals("1")){%><title>BBQ写真館</title><%} %>
<%if(value.equals("2")){%><title>創立２５周年記念</title><%} %>
<%if(value.equals("3")){%><title>テスト</title><%} %>
<!-- Photoページを作った際の変更点 -->
<style>
body {
	width: 100%;
	height: 580px;
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
		<%if(value.equals("1")){%>
		<iframe width="100%" height="100%" src="//www.lucentsquare.co.jp/staff/bbq_index.html"></iframe>
		<%}%>
		<%if(value.equals("2")){%>
		<iframe width="100%" height="100%" src="//www.lucentsquare.co.jp/staff/25%E5%91%A8%E5%B9%B4%E8%A8%98%E5%BF%B5%E8%A1%8C%E4%BA%8B%E6%A1%88%E5%86%85/25year_index.html"></iframe>
		<%}%>
		<!-- Photoページを作った際の変更点 -->
	</div>
</body>
</html>