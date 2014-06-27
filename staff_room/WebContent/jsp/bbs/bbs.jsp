<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>社内掲示板</title>
<style>
body {
	width: 100%;
	height: 100%;
	background-attachment: fixed;
	background-image: url("/staff_room/images/bbs4.jpg");
	background-size: 100% 100%;
}
.content{
	padding: 0;
	padding-top: 42px;
	height: 100%;
	width: 70%;
	margin-left:auto;
	margin-right:auto;
}
</style>
<script type="text/javascript">
function framesize(){
    var w = $(window).height();
    $('.content').css("height", w-42);
}
$(function(){
    framesize();
});
$(window).resize(function(){
    framesize();
});

</script>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="content">
		<iframe width="100%" height="100%"
			src="//www.lucentsquare.co.jp/staff/members/joyful/joyful.cgi">
		</iframe>
	</div>
</body>
</html>
