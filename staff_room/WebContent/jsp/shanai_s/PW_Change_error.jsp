<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<jsp:useBean id="errmsg" scope="session" class="kkweb.beans.B_Errmsg"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
/// 2013/07/12 新井 追加
/// 目的 : パスワード変更エラー用に新規作成
/// TODO : コーディングスタイルから逸脱しているのでエラーページの共有化を検討する必要あり
if(errmsg == null || errmsg.getErrmsg() == null){
	pageContext.forward("/ID_PW_Nyuryoku.jsp");
}else{%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="message.css" type="text/css">
<title>エラー</title>
</head>
<body>
<center>
<div class="location"><div class="location2"><font class="error"><%= errmsg.getErrmsg() %></font>
<%	session.removeAttribute("errmsg");%><br><br>
<button onClick="history.back()">再入力</button></div></div>
</center>
</body>
</html>
<%}%>