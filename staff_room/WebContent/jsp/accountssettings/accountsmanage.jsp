<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja" class="uk-height-1-1">
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>管理者権限編集画面</title>
</head>
<body >
<jsp:include page="/jsp/header/header.jsp"></jsp:include>

<br><br><br><br>
<div class="uk-h1 uk-text-center">
管理者権限の追加 ・ 削除
</div>
<div class="uk-panel uk-panel-box uk-align-center uk-width-1-2">
<div class="uk-text-center">
<form class="uk-form" action="" method="POST">
<select>
<%// 一般的アカウントの人を表示
%>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<option value="">玉城 亨文</option>
<%
%>
</select>
<input class="uk-button uk-button-primary" type="submit" value="追加"/>
</form>
<div class="uk-h2 uk-text-center" style="padding-top: 30px;">
管理者一覧
</div>
<div class="uk-panel-box uk-panel uk-width-1-2 uk-align-center" style="background-color: white;">
</div>
</div>
</div>

</body>
</html>