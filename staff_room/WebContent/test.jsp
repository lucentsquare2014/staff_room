<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/upload.js"></script>
<script src="/staff_room/script/inputform.js"></script>
</head>
<body>
<div class="uk-form-file">
	<button class="uk-button">ファイルを選択</button>
	<input type="file" name="inputFile" id="upload-select" multiple>
</div>
<div id="progressbar" class="uk-progress uk-hidden">
    <div class="uk-progress-bar" style="width: 0%;">...</div>
</div>

</body>
</html>