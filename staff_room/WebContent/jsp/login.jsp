<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="uk-height-1-1">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../html/head.html" />
</head>
<body class="uk-height-1-1 uk-vertical-align uk-text-center">
	<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
		<h1>ルーセントスクエアStaff Roomへ</h1>
		<div class="uk-panel uk-panel-box uk-width-1-2 uk-align-center">
			<h3 class="uk-panel-title uk-text-left">
				<i class="uk-icon-user"></i>社員アカウントでログイン
			</h3>
			<form class="uk-form" action="" method="post">
				<div class="uk-form-row">
					<input type="text" placeholder="ユーザ" name="id" class="uk-form-width-medium">
				</div>
				<div class="uk-form-row">
					<input type="text" placeholder="パスワード" name="password" class="uk-form-width-medium">
				</div>
				<div class="uk-form-row">
					<input type="submit" value="ログイン" class="uk-button uk-button-primary">
					<input type="reset" value="リセット" class="uk-button uk-button-primary">
				</div>
			</form>
		</div>
	</div>
</body>
</html>