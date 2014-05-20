<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->


<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<h1>連絡事項新規作成</h1>

	<!-- 入力フォーム データ→newsWrite.jsp-->

	<form method="POST" action="newsWrite.jsp">
		<table border="1">
			<tr>
				<th>分類</th>
				<td><select name="inputPost">
						<option value="1"
							<%if (request.getParameter("post_id").equals("1")) {%> select
							<%}%>>総務</option>
						<option value="2"
							<%if (request.getParameter("post_id").equals("2")) {%> select
							<%}%>>人事</option>
						<option value="3"
							<%if (request.getParameter("post_id").equals("3")) {%> select
							<%}%>>行事</option>
						<option value="4"
							<%if (request.getParameter("post_id").equals("4")) {%> select
							<%}%>>開発</option>
						<option value="5"
							<%if (request.getParameter("post_id").equals("5")) {%> select
							<%}%>>その他</option>
				</select></td>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><input type="text" name="inputTitle" size="40"></td>
			</tr>
			<tr>
				<th>本文</th>
				<td><textarea name="inputText" rows="10" cols="40"></textarea></td>
			</tr>

			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" /></td>
		</tr>
		-->

			<tr>
				<th>保存者</th>
				<td><input type="text" name="inputWriter" size="40"></td>
			</tr>
		</table>
		<input type="submit" value="投稿"> <input type="reset"
			value="元に戻す">
	</form>

	<!-- /入力フォーム -->

</body>
</html>