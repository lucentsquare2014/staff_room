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
<title>�G���[</title>
</head>
<body>
<center><div class="location">
<center><div class="location2"><font class="error">���F��Ƃ͐������I������܂���ł���</font><br><br>
<button onClick="history.back()">�ē���</button></div>
</center></div>
</center>
</body>
</html>
<%}%>