<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->


<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<h1>記事の新規作成新規作成</h1>

	<!-- 入力フォーム データ→確認画面-->

	<form method="POST" action="inputCheck.jsp">
	<table border="1">
		<tr>
			<th>分類</th>
				<td>
					<select name="inputPost">
					<option value="1">総務</option>
					<option value="2">人事</option>
					<option value="3">行事</option>
					<option value="4">開発</option>
					<option value="5">その他</option>
					</select>
				</td>
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
	<input type="submit" value="確認する">
	<input type="reset" value="リセット">
	</form>

<!-- /入力フォーム -->

</body>
</html>