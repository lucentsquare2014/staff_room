<%@ page language="java" contentType="text/html; charset=shift_JIS"pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="message.css" type="text/css">
<title>���F��Ɗ���</title>
</head>
<body>
<center>
<div class="location">
<center>
<div class="location2"><font class="msg">���F��Ɗ���</font><br><br>
<a href="Menu_Gamen.jsp" class="link"><font class="link">[ ���j���[�֖߂� ]</font></a></div>
</center></div>
</center>
</body>
</html>
<%}%>