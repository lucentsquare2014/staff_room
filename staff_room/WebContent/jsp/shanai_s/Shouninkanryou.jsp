<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8s">
<link rel="stylesheet" href="message.css" type="text/css">
<title>承認作業完了</title>
</head>
<body>
<center>
<div class="location">
<center>
<div class="location2"><font class="msg">承認作業完了</font><br><br>
<a href="Menu_Gamen.jsp" class="link"><font class="link">[ メニューへ戻る ]</font></a></div>
</center></div>
</center>
</body>
</html>
<%}%>