<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="menu.css" type="text/css">
<title>マスタメンテナンスメニュー</title>
</head>
<body>
<center>
<div class="box4"></div><div class="box1">
<table>
<tr>
<th><font class="title1">Manager's room</font></th>
</tr>
</table><hr color = "#008080"><ul><li><font class="index2">Maintenance</font></li></ul>
<table>
<tr>
<td>
<form method="post" action="Shain_Ichiran.jsp">
<input type="submit" value="社員マスタメンテナンス" class="botton2">
</form>
</td>
<td>
<form method="post" action="Project_Maintenance.jsp">
<input type="submit" value="プロジェクトマスタメンテナンス" class="botton2">
</form>
</td>
</tr>
<tr>
<td>
<form method="post" action="Group_Maintenance.jsp">
<input type="submit" value="グループマスタメンテナンス" class="botton2">
</form>
</td>
<td>
<form method="post" action="Holiday_Maintenance.jsp">
<input type="submit" value="祝日マスタメンテナンス" class="botton2">
</form>
</td>
</tr>
</table><br><ul><li><font class="index2">Reports</font></li></ul>
<table>
<tr>
<td>
<form method="post" action="Escape_NameSelect.jsp">
<input type="submit" value="退職者勤務報告書" class="botton2">
<input type="hidden" name="escapeflg" id="escapeflg" value="1">
</form>
</td>
</tr>
</table><br>
<a href="ID_PW_Nyuryoku.jsp" class="link"><font class="link"><small>[ ID・パスワード入力へ戻る ]</small></font></a></div>
</center>
</body>
</html>
<%}%>