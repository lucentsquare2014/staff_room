<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<jsp:useBean id="errmsg" scope="session" class="kkweb.beans.B_Errmsg"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
	if(id2 == null || id2.equals("false")){
		pageContext.forward("/ID_PW_Nyuryoku.jsp");
	}else{	
%>
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="message.css" type="text/css">
<title>エラー</title>
</head>
<body>
<center>
<div class="location"><div class="location2"><font class="error"><%= errmsg.getErrmsg() %></font><br><br>
<button onClick="history.back()">再入力</button>
</div></div>
</center>
</body>
</html>
<%}%>