<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html" />
<style type="text/css">
	body {
		background-image: url("/staff_room/images/input.png");	
	}
</style>
<head>
<title>保存完了</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="uk-height-1-1 uk-vertical-align uk-text-center">
		<div style="position:relative; top:250px;">
			<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
				<div class="uk-panel uk-panel-box uk-text-center">
					<h1 class="uk-text-success"><i class="uk-icon-smile-o"></i>記事の保存が完了しました。</h1>
					<br>
					<a href="writeNews.jsp" class="uk-button uk-button-success uk-button-large">管理・編集に戻る</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>