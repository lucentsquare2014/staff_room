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
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/renraku.png");
	background-size: 100% auto;
	}
</style>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br><br><br>
<div class="uk-h1 uk-text-center">
ログインパスワード変更
</div>
<br><br><br><br>
	<div class="uk-text-danger uk-text-center" id="alert"></div><br><br>
	<form class="uk-form uk-form-horizontal" method="post"
		action="pwChange_finish.jsp">
		<div class="uk-form-row" align="center">
			<div class="uk-h1 uk-text-center uk-text-large">変更するパスワードを入力してください</div><br><br>
			<input class="uk-form-width-medium" value='' type="password" name="new_pw1" maxlength="20"><br><br>
			<div class="uk-h1 uk-text-center uk-text-large">確認のためもう一度入力してください</div><br><br>
			<input class="uk-form-width-medium" value=''type="password" name="new_pw2" maxlength="20"><br><br>
		</div>
		<div class="uk-form-row" align="center">
			<input type="submit"
				class="uk-button uk-button-large uk-button-primary" value="変更">
		</div>
	</form>
</body>
</html>