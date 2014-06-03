<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>パスワード変更</title>
<link rel="stylesheet" href="/staff_room/css/inputform.css">
</head>
<body>
<form class="uk-form uk-form-horizontal" method="post" action="pwChange_finish.jsp">
<div class="uk-form-row" align="center">
			<label class="uk-form-label uk-text-bold uk-text-large">変更するパスワードを入力してください</label><br>
			<input class="uk-form-width-medium"  value='' type="password" name="new_pw1" maxlength="20" required><br>
			<label class="uk-form-label uk-text-bold uk-text-large">確認のためもう一度入力してください</label><br>
			<input class="uk-form-width-medium"  value='' type="password" name="new_pw2" maxlength="20" required><br>
</div>
<div class="uk-form-row" align="center">
			<div class="uk-width-3-4 uk-container-center uk-text-right">
				<button class="uk-button uk-button-large uk-button-primary" data-uk-toggle="{target:'.confirm'}">変更</button>
			</div>
		</div>
</form>
</body>
</html>