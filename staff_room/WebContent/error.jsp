<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja" class="uk-height-1-1">
<head>
<jsp:include page="/html/head.html" />
<title>エラー</title>
</head>
<body class="uk-height-1-1 uk-vertical-align uk-text-center">
	<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
		<div class="uk-panel uk-panel-box uk-text-danger uk-text-center">
			<h1 class="uk-text-danger"><i class="uk-icon-exclamation-circle"></i>ログインを制限しました</h1>
			<p>入力されたユーザとパスワードは5回連続して一致しなかったためログインを制限させていただきました。</p>
			<p>セキュリティロックは5分後解除いたします。</p>
		</div>
	</div>
</body>
</html>