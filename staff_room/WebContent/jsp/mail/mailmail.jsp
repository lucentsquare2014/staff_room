<%@ page contentType="text/html; charset=UTF-8"%>
<% String user = String.valueOf(session.getAttribute("login")); %>
<html style="overflow-x:auto; white-space:nowrap;">
<head>
<jsp:include page="/html/head.html" />
<title>Mail</title>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<div class="changelog" style="padding-top: 40px;">
<img src="/staff_room/images/mail.jpg" style="margin-bottom:20px;">
        <div class="uk-width-2-3 uk-container-center">
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" 
	class="uk-table uk-table-hover uk-table-striped uk-width-1-1">
		<tr class="uk-text-large">
			<th class=" uk-width-1-6 uk-text-center">名前</th>
			<th class=" uk-width-2-6 uk-text-center">フリガナ</th>
			<th class=" uk-width-2-6 uk-text-center">Mail Address</th>
		</tr>
		<!-- includeディレクトリを使い、"newmail.jsp"ファイルを埋め込む -->
		<%@ include file="newmail.jsp"%>
	</table>
		</div>
</div>

<br>
</body>
</html>
