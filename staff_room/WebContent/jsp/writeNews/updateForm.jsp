<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="code.jsp" %>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->


<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<h1>記事の編集</h1>

	<!-- 入力フォーム データ→確認画面-->

	<form method="POST" action="inputCheck.jsp">
		<table border="1">
		<!-- 管理編集画面から渡されたnews_idをnewsWrite.jspへ渡す記述 保留
		<tr>
		<th>news_id</th>
		<td>
		<input type="text"name="inputNewsid" size="40" disabled>
		<%= request.getParameter("news_id") %>
		</td>
		下に習ってみたがフォームにする必要はないし、見せたくない
		 -->
			<tr>
				<th>分類</th>
				<td><select name="inputPost">
						<option value="1"
							<%if (request.getParameter("post_id").equals("1")) {%> selected
							<%}%>>総務</option>
						<option value="2"
							<%if (request.getParameter("post_id").equals("2")) {%> selected
							<%}%>>人事</option>
						<option value="3"
							<%if (request.getParameter("post_id").equals("3")) {%> selected
							<%}%>>行事</option>
						<option value="4"
							<%if (request.getParameter("post_id").equals("4")) {%> selected
							<%}%>>開発</option>
						<option value="5"
							<%if (request.getParameter("post_id").equals("5")) {%> selected
							<%}%>>その他</option>
				</select></td>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><input type="text" name="inputTitle" size="40">
				<%= request.getParameter("title") %>
				</td>
			</tr>
			<tr>
				<th>本文</th>
				<td><textarea name="inputText" rows="10" cols="40"></textarea>
				<%= request.getParameter("text") %>
				</td>
			</tr>

			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" />
				<%= request.getParameter("file") %>
				</td>
		</tr>
		-->

			<tr>
				<th>保存者</th>
				<td><input type="text" name="inputWriter" size="40">
				<%= request.getParameter("writer") %>
				</td>
			</tr>
		</table>

	<!-- 管理編集画面から渡されたnews_idをinputCheck.jspへ渡す -->
		<input type="hidden" name="inputNewsid"
				value="<%= jpn2unicode(request.getParameter("news_id"),"UTF-8") %>">

		<input type="submit" value="確認する">
		<input type="reset"value="リセット">
	</form>

	<!-- /入力フォーム -->

</body>
</html>