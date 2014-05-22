<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<script type="text/javascript">
	var display_tag;
	window.onload = function() {
		if (!document.getElementsByTagName)
			return;

		var change_tag = document.getElementsByTagName("h4"); // タイトルの部分のタグ
		display_tag = document.getElementsByTagName("dl"); // 非表示させたい部分のタグ

		for (var i = 0; i < change_tag.length; i++) {
			// 非表示させたいタグの処理
			display_tag.item(i).style.display = "none";

			// タイトルの文字を取得して表示切り替えのリンクに変更
			var ele = change_tag.item(i);
			var str = ele.innerText || ele.innerHTML;
			ele.innerHTML = '<a href="javascript:show(' + i + ');">' + str
					+ '<\/a>';
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
	<div class="content">
		<p>
		<h1>管理・編集</h1>
		</p>
		<form method="POST" action="updateForm.jsp">
			<input type="submit" value="新規作成">
		</form>
		<%
			//配列
			ArrayList<Integer> x = new ArrayList<Integer>();
			int j = 0, z = 0;
			NewsDAO dao = new NewsDAO();
			ArrayList<HashMap<String, String>> list = null;
			list = dao
					.getNews("select news_id,created,post.post_id,postname,title,text,writer from news, post where news.post_id = post.post_id order by created desc");

			out.println("<table border='1'>");
			for (int i = 0; i < list.size(); i++) {
				HashMap<String, String> row = list.get(i);
				if (!row.get("created").equals("")) {
					out.println("<tr>");
					out.println("<td>");
					out.println("<input type=\"checkbox\" name=\"delete_check\" value=\""
							+ row.get("news_id") + "\">");
					out.println("</td>");
					out.println("<td>");
					out.println(row.get("created"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("postname"));
					out.println("&nbsp;</td>");
					out.println("<td>");
		%>
		<h4><%=row.get("title")%></h4>
		<dl>
			<dt><pre><%=row.get("text")%></pre></dt>
		</dl>
		<%
			out.println("&nbsp;</td>");

					out.println("<td>");
		%>
		<form method="POST" action="updateForm.jsp">

			<input type="hidden" name="inputNewsid"
				value="<%=row.get("news_id")%>"> <input type="hidden"
				name="inputPostid" value="<%=row.get("post_id")%>"> <input
				type="hidden" name="inputTitle" value="<%=row.get("title")%>">

			<input type="hidden" name="inputText" value="<%=row.get("text")%>">

			<input type="hidden" name="inputWriter"
				value="<%=row.get("writer")%>"> <input type="submit"
				value="編集">
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
				out.println("<input type=\"checkbox\" name=\"delete_check\" value=\""
						+ row.get("news_id") + "\">");
				out.println("</td>");
				out.println("<td>");
				out.println(row.get("created"));
				out.println("&nbsp;</td>");
				out.println("<td>");
				out.println(row.get("postname"));
				out.println("&nbsp;</td>");
				out.println("<td>");
		%>
        <h4><%=row.get("title")%></h4>
        <dl>
            <dt><pre><%=row.get("text")%></pre></dt>
        </dl>
		<%
			out.println("&nbsp;</td>");
				out.println("<td>");
		%>
		<form method="POST" action="updateForm.jsp">

			<input type="hidden" name="inputNewsid"
				value="<%=row.get("news_id")%>"> <input type="hidden"
				name="inputPostid" value="<%=row.get("post_id")%>"> <input
				type="hidden" name="inputTitle" value="<%=row.get("title")%>">

			<input type="hidden" name="inputText" value="<%=row.get("text")%>">

			<input type="hidden" name="inputWriter"
				value="<%=row.get("writer")%>"> <input type="submit"
				value="編集">
		</form>
		<%
			out.println("&nbsp;</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		%>
		<div class="delete_button">
		<button type="button" onclick="delete()">削除</button>
		</div>
	</div>
</body>
</html>