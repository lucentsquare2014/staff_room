<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>メールリンク</title>
</head>
<body>
<img src="/staff_room/images/mail3.jpg" style="margin-bottom:20px;">
    <jsp:include page="/jsp/header/header.jsp" />
    <div class="conetent"
        style="padding: 0; padding-top: 42px; height:600px;width:800px;margin-left:auto;margin-right:auto; ">
        <iframe  style="height:100%;width:100%;"
            src="/staff_room/html/mail_link.html">
        </iframe>
    </div>
</body>
</html>