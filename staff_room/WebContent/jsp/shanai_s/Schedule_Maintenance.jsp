<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="schedule.GetGroup, schedule.GetSection, java.util.ArrayList, java.util.HashMap" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String flag = session.getAttribute("admin").toString();
	if(!flag.equals("1")){
		response.sendRedirect("/staff_room/jsp/shanai_s/Login_error.jsp");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>スケジュールマスタメンテナンス</title>
<link rel="stylesheet" href="report.css" type="text/css">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script src="/staff_room/script/jquery.min.js"></script>
<script src="/staff_room/script/schedule.js"></script>
<style type="text/css">
input[type="text"]{
	ime-mode: disabled;
}
table{
	text-align: center;
}
#order2{
	display: none;
}
</style>
</head>
<body>
<center>
	<%
		GetGroup gg = new GetGroup();
		ArrayList<HashMap<String, String>> group_list = gg.getGroup();
	%>
	<font class="title">グループ一覧</font><br>
	<hr color = "#008080">
	<table>
		<tr><td align="left"><small>1.追加する場合は全ての項目を入力後「追加」のボタンを押してください。</small></td></tr>
		<tr><td align="left"><small>2.変更する場合は変更後「更新」のボタンを押してください。</small></td></tr>
		<tr><td align="left"><small>3.削除する場合は削除する行の項目を空欄にした後「更新」のボタンを押してください。</small></td></tr>
	</table>
	<hr color = "#008080"><br>
	<form method="post" action="NewGroup">
		<table border="1" class ="mainte">
			<tr>
				<th class="t-koumoku"><font color="white">番号</font></th>
				<th class="t-koumoku"><font color="white">グループ名</font></th>
			</tr>
			<tr>
				<td><input type="text" size="5" maxlength="3" name="add_gruno"></td>
				<td><input type="text" size="35" name="add_grname"></td>
			</tr>
		</table>
		<table>
			<tr><td><input type="submit" value="　追加　"  class="bottom" id="add_gruop"></td></tr>
		</table>
	</form><br>
	<form method="post" action="UpdateGroup">
		<table border="1" class ="mainte" id="main">
			<tr>
				<th class="t-koumoku"><font color="white">番号</font></th>
				<th class="t-koumoku"><font color="white">グループ名</font></th>
			</tr>
			<%
				for(int i = 0; i < group_list.size(); i++){
					HashMap<String, String> map = group_list.get(i);
					String no = map.get("g_gruno");
					String name = map.get("g_grname");
			%>
			<tr>
				<td><input type="text" size="5" maxlength="3" name="gruno" value="<%= no %>"></td>
				<td><input type="text" size="35" name="grname" value="<%= name %>"></td>
			</tr>
			<% } %>
		</table>
		<table>
			<tr>
				<td>
					<input type="submit" value="　更新　" class="bottom" id="update">
				</td>
			</tr>
		</table>
	</form><br><br>
	<%
		GetSection gs = new GetSection();
		ArrayList<HashMap<String, String>> section_list = gs.getSection();
		ArrayList<String> list1 = new ArrayList<String>();
		ArrayList<String> list2 = new ArrayList<String>();
		ArrayList<HashMap<String, String>> yotei = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> place = new ArrayList<HashMap<String, String>>();
		for(int m = 1;m < 28; m++){
			list1.add(String.valueOf(m));
		}
		for(int n = 28; n < 50; n++){
			list2.add(String.valueOf(n));
		}
		for(int j = 0; j < section_list.size(); j++){
			String x = section_list.get(j).get("順番");
			if(section_list.get(j).get("区分").equals("1 ")){	
				list1.remove(x);
				yotei.add(section_list.get(j));
			}else{
				list2.remove(x);
				place.add(section_list.get(j));
			}
		}
	%>
	<font class="title">予定区分一覧</font><br>
	<hr color = "#008080">
	<table>
		<tr><td align="left"><small>1.追加する場合は全ての項目を入力後「追加」のボタンを押してください。</small></td></tr>
		<tr><td align="left"><small>2.削除する場合は削除ボタンを押してください。</small></td></tr>
	</table>
	<hr color = "#008080"><br>
	<form method="post" action="NewSection">
		<table>
			<tr>
				<td>区分</td>
				<td align="left">
					<select name="section" id="section">
						<option value="1">予定</option>
						<option value="2">場所</option>
					</select>
					<select name="order1" id="order1">
					<%
						for(int i = 0; i < list1.size(); i++){
					%>
						<option value="<%= list1.get(i) %>"><%= list1.get(i) %></option>
					<% } %>
					</select>
					<select name="order2" id="order2">
					<%
						for(int j = 0; j < list2.size(); j++){
					%>
						<option value="<%= list2.get(j) %>"><%= list2.get(j) %></option>
					<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<td>内容</td>
				<td><input type="text" size="30" name="content"></td>
			</tr>
		</table>
		<table>
			<tr><td><input type="submit" value="　追加　"  class="bottom" ></td></tr>
		</table>
	</form><br>
	<table>
		<tr>
			<td>
				<table border="1" class ="mainte">
					<tr>
						<th>予定内容</th><th>Function</th>
					</tr>
					<% for(int m = 0; m < yotei.size(); m++){ %>
					<tr>
						<td><%= yotei.get(m).get("場所") %></td>
						<td>
							<form method="post" action="DeleteSection">
								<input type="submit" value="削除">
								<input type="hidden" name="delete" value="<%= yotei.get(m).get("順番") %>">
							</form>
						</td>
					</tr>
					<% } %>
				</table>
			</td>
			<td>
				<table border="1" class ="mainte">
					<tr>
						<th>場所</th><th>Function</th>
					</tr>
					<% for(int n = 0; n < place.size(); n++){ %>
					<tr>
						<td><%= place.get(n).get("場所") %></td>
						<td>
							<form method="post" action="DeleteSection">
								<input type="submit" value="削除">
								<input type="hidden" name="delete" value="<%= place.get(n).get("順番") %>">
							</form>
						</td>
					</tr>
					<% } %>
				</table>
			</td>
		</tr>
	</table><br>
	<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>