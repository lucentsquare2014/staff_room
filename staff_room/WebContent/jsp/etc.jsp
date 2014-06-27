<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html"></jsp:include>
<%
		String value = null;
		value = request.getParameter("etc");%>
		<%if(value.equals("1")){%><title>GPS</title><%}%>
		<%if(value.equals("2")){%><title>e-talent</title><%}%>
		<%if(value.equals("3")){%><title>Advance meeting</title><%}%>
		<%if(value.equals("4")){%><title>新入社員紹介</title><%}%>
		<%if(value.equals("5")){%><title>401K説明書類</title><%}%>
		<%if(value.equals("6")){%><title>Pマーク関係書類</title><%}%>
		<%if(value.equals("7")){%><title>社内報2005</title><%}%>
		<%if(value.equals("8")){%><title>社内報2006</title><%}%>

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
iframe{
	width:100%;
	height:100%;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="conetent">
		<%if(value.equals("1")){%><iframe src="//www.lucentsquare.co.jp/gps/pc/"></iframe><%} %>
		<%if(value.equals("2")){%><iframe src="//www.lucentsquare.co.jp:8080/etalent5_27/main.jsp"></iframe><%}%>
		<%if(value.equals("3")){%><iframe src="/staff_room/html/etc/WorkingGroup/Advance_WorkingGroup.html"></iframe><%} %>
		<%if(value.equals("4")){%><iframe src="/staff_room/html/etc/newstaff_2014/newstaff_index.html"></iframe><%} %>
		<%if(value.equals("5")){%><iframe src="//www.lucentsquare.co.jp/401KDVD/401K/401K_top.html"></iframe><%} %>
		<%if(value.equals("6")){%><iframe src="/staff_room/html/etc/PMark/indexVer9.html"></iframe><%} %>
		<%if(value.equals("7")){%><iframe src="/staff_room/html/etc/syanaihou/syanaihou/lsc01.htm"></iframe><%} %>
		<%if(value.equals("8")){%><iframe src="/staff_room/html/etc/syanaihou/syanaihou/lsc02.htm"></iframe><%} %>

	</div>
</body>
</html>