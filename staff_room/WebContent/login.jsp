<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.GetCookie" %>
<%
    // 新しいセッションならば入力回数を０から始める
	if(session.isNew()){
		session.setAttribute("count", 0);
	}else{
		// 新しいセッションではなくとも入力回数がnullなら０から始める
		if(session.getAttribute("count")==null){
			session.setAttribute("count", 0);
		}
	}
    // ５回入力に失敗するとエラーページに遷移させる
    // ５分間入力できないようにする
	if(session.getAttribute("count") != null){
		String str = String.valueOf(session.getAttribute("count"));
		if(Integer.valueOf(str) > 4){
			session.setMaxInactiveInterval(300);
			response.sendRedirect("./error.jsp");
			return;
		}
	}
%>
<%
// クッキーがあればTop画面に遷移
Cookie login_cookie = GetCookie.get("login_cookie", request);
if(login_cookie!=null){
	    response.sendRedirect("/staff_room/CookieChecked");
	    return;
}else{
	// クッキーなくてもセッションが保存されていればTop画面に遷移
	if(session.getAttribute("login")!=null){
		response.sendRedirect("/staff_room/jsp/top/top.jsp");
	}
}
%>
<!DOCTYPE html>
<html lang="ja" class="uk-height-1-1">
<head>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/logincheck.js"></script>
<title>ログイン</title>
</head>
<body class="uk-height-1-1 uk-vertical-align uk-text-center">
	<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
		<h1>ルーセントスクエアStaff Roomへ</h1>
		<div class="uk-panel uk-panel-box uk-width-1-2 uk-align-center">
			<h3 class="uk-panel-title uk-text-left">
				<i class="uk-icon-user"></i>社員アカウントでログイン
			</h3>
			<p class="uk-text-success uk-text-left">
				1.必要事項を入力し、ログインを押してください。<br>
				2.全角カナは使用しないでください。
			</p>
			<p class="uk-text-danger" id="alert">
				<% if(request.getAttribute("error") != null){ %>
					<%= request.getAttribute("error")%>
				<% } %>
			</p>
			<form class="uk-form" action="./Login" method="post">
				<div class="uk-form-row">
					<input type="text" placeholder="ユーザ" name="id" class="uk-form-width-medium">
				</div>
				<div class="uk-form-row">
					<input type="password" placeholder="パスワード" name="password" class="uk-form-width-medium">
				</div>
				<div class="uk-form-row">
					<input type="checkbox" name="remember_me" value="1">
					<label>ログイン状態を保持する</label>
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
