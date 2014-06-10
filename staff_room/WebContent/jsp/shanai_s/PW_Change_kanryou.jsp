<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%> --%>
<%
/// 2013/07/12 新井 追加
/// 目的:パスワード変更成功時のみ表示できるようにするため
String changedpw = (String)session.getAttribute("changedpw");
if( changedpw == null || changedpw.equals("false")
  ){
	pageContext.forward("/");
}else{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="message.css" type="text/css">
<title>パスワード変更完了</title>
</head>
<body>
<center><div class="location">
<center><div class="location2">
<font class="msg">パスワードが正常に変更されました。</font><br><br>
<a href="ID_PW_Nyuryoku.jsp" class="link"><font class="link">[ ID・パスワード入力へ戻る ]</font></a>
</div></center></div></center>
</body>
</html>
<%
session.removeAttribute("changedpw");
}%>
