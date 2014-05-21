<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript">
var display_tag;
window.onload = function() {
	if (!document.getElementsByTagName) return;

	var change_tag = document.getElementsByTagName("h4");		// タイトルの部分のタグ
	display_tag = document.getElementsByTagName("dl");		// 非表示させたい部分のタグ

	for (var i = 0; i < change_tag.length; i++) {
		// 非表示させたいタグの処理
		display_tag.item(i).style.display = "none";

		// タイトルの文字を取得して表示切り替えのリンクに変更
		var ele = change_tag.item(i);
		var str = ele.innerText || ele.innerHTML;
		ele.innerHTML = '<a href="javascript:show(' + i + ');">' + str + '<\/a>';
	}
}
function show(a) {
	var ele = display_tag.item(a);
	ele.style.display = (ele.style.display == "none") ? "block" : "none";
}
</script>

<title>管理編集</title>
</head>
<body>
	<div class="changelog">
		<p>
			<h1>管理・編集</h1>
		</p>
		<form method="POST" action="inputForm.jsp"><input type="submit" value="新規作成"></form>
			<%
				//配列
				ArrayList<Integer> x = new ArrayList<Integer>();
				int j=0,z=0;
			    NewsDAO dao = new NewsDAO();
			    ArrayList<HashMap<String, String>> list = null;
			    list = dao.getNews("select news_id,created,post.post_id,postname,title,text,writer from news, post where news.post_id = post.post_id order by created desc"  );

				out.println("<table border='1'>");
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> row = list.get(i);
					if (!row.get("created").equals("")) {
					    out.println("<tr>");
						out.println("<td>");
						out.println(row.get("created"));
						out.println("&nbsp;</td>");
						out.println("<td>");
						out.println(row.get("postname"));
						out.println("&nbsp;</td>");
						out.println("<td>");
						%>
						<h4><%= row.get("title") %></h4>
						<dl>
						<dt><%= row.get("text") %></dt>
						</dl>
						<%
						out.println("&nbsp;</td>");

						out.println("<td>");
						%>
						<form method="POST" action="updateForm.jsp">

						<input type="hidden" name="news_id"
						value="<%= row.get("news_id") %>">

						<input type="hidden" name="post_id"
						value="<%= row.get("post_id") %>">

						<input type="hidden" name="title"
						value="<%= row.get("title") %>">

						<input type="hidden" name="text"
						value="<%= row.get("text") %>">

						<input type="hidden" name="writer"
						value="<%= row.get("writer") %>">
						<input type="submit" value="編集">
						</form>
						<%
						out.println("&nbsp;</td>");
						out.println("</tr>");
					} else {
						x.add(i);
						z++;
					}
				}
				for (int i = 0; i < z; i++) {
					HashMap<String, String> row = list.get(x.get(i));
					out.println("<tr>");
					out.println("<td>");
					out.println(row.get("created"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("postname"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					%>
					<form method="POST" action="updateForm.jsp">

					<input type="hidden" name="news_id"
					value="<%= row.get("news_id") %>">

					<input type="hidden" name="post_id"
					value="<%= row.get("post_id") %>">

					<input type="hidden" name="title"
					value="<%= row.get("title") %>">

					<input type="hidden" name="text"
					value="<%= row.get("text") %>">

					<input type="hidden" name="writer"
					value="<%= row.get("writer") %>">
					<input type="submit" value="編集">
					</form>
					<%
					out.println("&nbsp;</td>");
					out.println("</tr>");
				}
				out.println("</table>");
			%>
		</div>
	<div class="page_title">
	</div>
</body>
</html>