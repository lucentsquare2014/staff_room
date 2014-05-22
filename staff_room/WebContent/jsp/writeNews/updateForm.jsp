<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="code.jsp" %>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<%@ page import="org.apache.commons.codec.binary.StringUtils"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">





<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>

<title>入力フォーム</title>
</head>
<body>
	<h1><% if(request.getParameter("inputNewsid")==null){%>
		新規記事の作成
		<%}else{%>
		既存記事の編集
		<%}%>
	</h1>

	<!-- 入力フォーム データ→確認画面-->

	<form method="POST" action="inputCheck.jsp">
		<table border="1">
			<tr>
				<th>分類</th><% if(request.getParameter("inputPostid")==null)
				{%>
						<td>
						<select name="inputPostid">
						<option value="1">総務</option>
						<option value="2">人事</option>
						<option value="3">行事</option>
						<option value="4">開発</option>
						<option value="5">その他</option>
						</select>
					</td>
				<%}else{%>
				<td><select name="inputPostid">
						<option value="1"
							<%if (request.getParameter("inputPostid").equals("1") ){%> selected
							<%}%>>総務</option>
						<option value="2"
							<%if (request.getParameter("inputPostid").equals("2")) {%> selected
							<%}%>>人事</option>
						<option value="3"
							<%if (request.getParameter("inputPostid").equals("3")) {%> selected
							<%}%>>行事</option>
						<option value="4"
							<%if (request.getParameter("inputPostid").equals("4")) {%> selected
							<%}%>>開発</option>
						<option value="5"
							<%if (request.getParameter("inputPostid").equals("5")) {%> selected
							<%}%>>その他</option>
				</select></td>
				<%}%>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><input type="text" name="inputTitle" size="40"
				<% if(request.getParameter("inputTitle")!=null){%>
				value="<%= jpn2unicode(request.getParameter("inputTitle"),"UTF-8") %>">
				<%}%>
				</td>
			</tr>
			<tr>
				<th>本文</th>
				<td><%if(request.getParameter("inputText")==null){%>
				<textarea name="inputText" rows="10" cols="40"></textarea>
				<%}else{%>
				<textarea name="inputText" rows="10" cols="40"><%= jpn2unicode(request.getParameter("inputText"),"UTF-8")%></textarea>
				<%}%>
				</td>
			</tr>

			<!-- 添付ファイル いったん保留
			<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" />
				<%= jpn2unicode(request.getParameter("file"),"UTF-8") %>
				</td>
			</tr>
			-->

			<tr>
				<th>保存者</th>
				<td><input type="text" name="inputWriter" size="40"
				<% if(request.getParameter("inputWriter")!=null){%>
				value="<%= jpn2unicode(request.getParameter("inputWriter"),"UTF-8") %>">
				<%}%>
				</td>
			</tr>
		</table>

	<!-- 管理編集画面から渡されたinputNewsidをinputCheck.jspへ渡す -->
		<%if(request.getParameter("inputNewsid")!=null){%>
		<input type="hidden" name="inputNewsid" value="<%=request.getParameter("inputNewsid") %>">
		<%}%>
		<input type="submit" value="確認する">
		<input type="reset"value="リセット">
	</form>

</body>
</html>