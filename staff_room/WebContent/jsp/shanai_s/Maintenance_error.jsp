<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="message.css" type="text/css">
<title>エラー</title>
</head>
<body>
<center>
<div class="location"><div class="location2"><font class="error">前画面の注を確認して再入力してください</font><br><br>
<button onClick="history.back()">再入力</button></div></div>
</center>
</body>
</html>
<%}%>