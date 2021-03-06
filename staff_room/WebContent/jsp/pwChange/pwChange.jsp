<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>パスワード変更</title>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/pwcheck.js"></script>
<style type="text/css">
body {
	background-image: url("/staff_room/images/pwChange2.jpg");
	background-attachment: fixed;
	background-repeat:no-repeat;
	}
</style>
<%@ page import="dao.NewsDAO,
				java.util.ArrayList,
				java.util.HashMap,
				org.apache.commons.lang3.StringEscapeUtils"
%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br><br><br>
<div class="uk-h1 uk-text-center" style="white-space:nowrap">
ログインパスワード変更
</div>
<br>
	<div class="uk-panel uk-panel-box uk-align-center"style="width: 450px;">
		<div class="uk-text-center">
			<%--エラーメッセージを表示する。エラー処理はpwcheck.jsとPwChange.java --%>
			<p class="uk-text-danger" id="alert">
				<%
					if (request.getAttribute("error") != null) {
				%>
				<%=request.getAttribute("error")%>
				<%
					}
				%>
			</p>
			<div class="uk-text-danger uk-text-center" id="alert"></div>
		</div>
		<%--現在のパスワードと変更するパスワードの入力フォーム三つ。ＤＢに書き込む処理はPwChange.java--%>
		<form class="uk-form uk-form-horizontal" method="post"
			action="/staff_room/PwChange">
			<div class="uk-text-bold uk-text-large uk-text-center">現在のパスワードを入力してください</div><br>
			<input class="uk-form-width-medium uk-align-center"
				value='' type="password" name="now_pw1" maxlength="20"> <input
				value='<%=session.getAttribute("login")%>' type="hidden" name="id">

				<ul>
					<li>パスワードは4文字以上、20文字以下で設定して下さい。</li>
					<li>アカウントと同一のものはパスワードとして設定することはできません。</li>
				</ul>

			<div class="uk-text-bold uk-text-large uk-text-center">変更するパスワードを入力してください</div><br>
			<input class="uk-form-width-medium uk-align-center"
				value='' type="password" name="new_pw1" maxlength="20">
			<div class="uk-text-bold uk-text-large uk-text-center">確認のためもう一度入力してください</div><br>
			<input class="uk-form-width-medium uk-align-center"
				value='' type="password" name="new_pw2" maxlength="20"><br><br>
			<div class="uk-form-row" align="center">
				<input type="submit"
					class="uk-button uk-button-large uk-button-primary" value="変更">
			</div>
			<input type="hidden" name="user" value="<%= session.getAttribute("login") %>">
		</form>
	</div>
</body>
</html>