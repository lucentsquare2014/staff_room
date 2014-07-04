<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="holiday.GetHoliday, java.util.ArrayList, java.util.HashMap" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>祝日マスタメンテナンス</title>
<link rel="stylesheet" href="report.css" type="text/css">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script src="/staff_room/script/jquery.min.js"></script>
<script src="/staff_room/script/holiday.js"></script>
<style type="text/css">
input[type="text"]{
	ime-mode: disabled;
}
</style>
</head>
<body>
<center>
	<%
		GetHoliday gethld = new GetHoliday();
		String thisyear = gethld.getThisYear();
		ArrayList<HashMap<String, String>> hld_list = gethld.getHoliday(thisyear);
	%>
	<font class="title">祝日一覧</font><br>
	<hr color = "#008080">
	<table>
		<tr><td align="left"><small>1.追加する場合は全ての項目を入力後「追加」のボタンを押してください。</small></td></tr>
		<tr><td align="left"><small>・入力する月、日が1桁の場合は"0"をつけてください。（4月 = 04）</small></td></tr>
		<tr><td align="left"><small>2.変更する場合は変更後「更新」のボタンを押してください。</small></td></tr>
		<tr><td align="left"><small>3.削除する場合は削除する行の"祝日名"項目を空欄にした後「更新」のボタンを押してください。</small></td></tr>
	</table>
	<hr color = "#008080"><br>
	<form method="post" action="NewHoliday">
		<table border="1" class ="mainte">
			<tr>
				<th class="t-koumoku"><font color="white">月</font></th>
				<th class="t-koumoku"><font color="white">日</font></th>
				<th class="t-koumoku"><font color="white">祝日名</font></th>
			</tr>
			<tr>
				<td><input type="text" size="5" maxlength="2" name="add_month"></td>
				<td><input type="text" size="5" maxlength="2" name="add_day"></td>
				<td><input type="text" size="30" name="add_holiday"></td>
			</tr>
		</table>
		<table>
			<tr>
				<td align="left">
					<label>年：</label>
					<select name="year" id="year">
						<option value="<%= thisyear %>" selected><%= thisyear %></option>
						<%
							int year = Integer.valueOf(thisyear);
							for(int y = year + 1; y < year + 3; y++){
						%>
						<option value="<%= y %>"><%= y %></option>
						<% } %>
					</select>
				</td>
				<td><input type="submit" value=" 追加  " class="bottom" id="add"></td>
			</tr>
		</table>
	</form><br>
	<form method="post" action="UpdateHoliday">
		<table border="1" class ="mainte" id="main">
			<tr>
				<th class="t-koumoku"><font color="white">月</font></th>
				<th class="t-koumoku"><font color="white">日</font></th>
				<th class="t-koumoku"><font color="white">祝日名</font></th>
			</tr>
			<%
				for(int i = 0; i < hld_list.size(); i ++){
					HashMap<String, String> hld_map = hld_list.get(i);
					String ymd = hld_map.get("h_年月日");
					String month = ymd.substring(4, 6);
					String day = ymd.substring(6);
					String name = hld_map.get("h_休日名");
			%>
			<tr>
				<td><input type="text" size="5" maxlength="2" name="month" value="<%= month %>"></td>
				<td><input type="text" size="5" maxlength="2" name="day" value="<%= day %>"></td>
				<td><input type="text" size="30" name="holiday" value="<%= name %>"></td>
			</tr>
			<% } %>
		</table>
		<table>
			<tr>
				<td>
					<input type="submit" value="　更新　" class="bottom" id="update">
					<input type="hidden" name="select" value="">
				</td>
			</tr>
		</table>
	</form><br>
	<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>