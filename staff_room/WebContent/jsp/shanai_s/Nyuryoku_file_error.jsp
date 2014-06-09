<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="message.css" type="text/css">
<title>勤務報告書承認中</title>
</head>
<body>
<center>
<div class="location">
<div class="location2">
<font class="error">選択された勤務報告書は只今承認作業中です<br>内容は<a href="/kk_web/Escape_NameSelect.jsp?escapeflg=0" class="link"><font class="link">こちら</font></a>からご確認ください</font><br><br>
<a href="Menu_Gamen.jsp" class="link"><font class="link">[ メニューへ戻る ]</font></a></div></div>
</center>
</body>
</html>
<%}%>