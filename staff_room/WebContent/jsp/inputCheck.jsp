<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->

<%@ include file="code.jsp" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<h1>連絡事項新規作成</h1>

	<!-- 入力フォーム データ→確認画面-->

	<form method="POST" action="inputCheck.jsp">
		<table border="1">
		<!-- 管理編集画面から渡されたnews_idを渡す記述 保留
		<tr>
		<th>news_id</th>
		<td>
		<input type="text"name="inputNewsid" size="40" disabled>
		<%= request.getParameter("news_id") %>
		</td>
		</tr>
		下に習ってみたがフォームにする必要はないし、見せたくない
		 -->
			<tr>
				<th>分類</th>
				<td><select name="inputPost" disabled>
						<option value="1"
							<%if (jpn2unicode(request.getParameter("inputPost"),"UTF-8").equals("1")) {%> selected
							<%}%>>総務</option>
						<option value="2"
							<%if (jpn2unicode(request.getParameter("inputPost"),"UTF-8").equals("2")) {%> selected
							<%}%>>人事</option>
						<option value="3"
							<%if (jpn2unicode(request.getParameter("inputPost"),"UTF-8").equals("3")) {%> selected
							<%}%>>行事</option>
						<option value="4"
							<%if (jpn2unicode(request.getParameter("inputPost"),"UTF-8").equals("4")) {%> selected
							<%}%>>開発</option>
						<option value="5"
							<%if (jpn2unicode(request.getParameter("inputPost"),"UTF-8").equals("5")) {%> selected
							<%}%>>その他</option>
				</select></td>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><input type="text" name="inputTitle" size="40" disabled>
				<%= jpn2unicode(request.getParameter("inputTitle"),"UTF-8") %>
				</td>
			</tr>
			<tr>
				<th>本文</th>
				<td><textarea name="inputText" rows="10" cols="40" disabled></textarea>
				<%= jpn2unicode(request.getParameter("inputText"),"UTF-8") %>
				</td>
			</tr>

			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" disabled>
				<%= jpn2unicode(request.getParameter("inputFile"),"UTF-8") %>
				</td>
		</tr>
		-->

			<tr>
				<th>保存者</th>
				<td><input type="text" name="inputWriter" size="40" disabled>
				<%= jpn2unicode(request.getParameter("inputWriter"),"UTF-8") %>
				</td>
			</tr>



			<!-- ついでに入力フォームか編集フォームかを判断する値を渡したらいいと思う
			name="formType" valueは"input"だとか"update"だとか
			-->




		</table>
		<input type="submit" value="投稿"> <input type="reset"
			value="元に戻す">
	</form>

	<!-- /入力フォーム -->

</body>
</html>