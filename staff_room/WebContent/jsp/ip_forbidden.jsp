<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IP Forbidden</title>
<jsp:include page="/html/head.html" />
<style>
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/manual01.jpg");
	background-size: 100% 100%;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div style="position:relative; top:250px;">
	<div class="uk-height-1-1 uk-vertical-align uk-text-center">
		<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
			<div class="uk-panel uk-panel-box uk-text-center">
				<h1 class="uk-text-danger"><i class="uk-icon-exclamation-circle"></i>ファイルのアップロードと削除は社内で行ってください！</h1>
				<br>
				<a href="./top/top.jsp" class="uk-button uk-button-success uk-button-large">Topページに戻る</a>
			</div>
	</div>
	</div>
	</div>
</body>
</html>