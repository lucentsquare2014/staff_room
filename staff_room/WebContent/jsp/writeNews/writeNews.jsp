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

		for ( var i = 0; i < change_tag.length; i++) {
			// 非表示させたいタグの処理
			display_tag.item(i).style.display = "none";

			// タイトルの文字を取得して表示切り替えのリンクに変更
			var ele = change_tag.item(i);
			var str = ele.innerText || ele.innerHTML;
			ele.innerHTML = '<a href="javascript:show(' + i + ');">' + str
					+ '<\/a>';
		}
	}
	// チェックボックスにチェックがついたかを判別する
	function del_checked(id) {
		var checkbox = $("#" + id);
		if (checkbox.attr("flag") === "0") {
			checkbox.attr("flag", "1");
		} else {
			checkbox.attr("flag", "0");
		}
	}
	// 記事を削除するdeleteNews.jspに記事IDを渡す関数
	function delete_news() {
		var ids = [];
		var news = $(".delete_check");
		//console.debug(news);
		// 削除する記事のIDを格納した配列を生成
		for ( var n = 0; n < news.length; n++) {
			// チェックボックスにチェックがついていたらIDを配列に格納
			if (news[n].getAttribute("flag") == "1") {
				ids.push(news[n].getAttribute("id"));
				$("#row" + news[n].getAttribute("id")).fadeOut();
			}
		}
		console.debug(ids);
		$.ajax({
			type : "POST",
			url : "deleteNews.jsp",
			data : {
				"del_id" : "" + ids
			}
		}).done(function() {

		});
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
		<div class="delete_button">
			<button type="button" onclick="delete_news()">削除</button>
		</div>
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
					out.println("<tr id=\"row" + row.get("news_id") + "\">");
					out.println("<td>");
					out.println("<input type=\"checkbox\" flag=\"0\" class=\"delete_check\" id=\""
							+ row.get("news_id")
							+ "\" onclick=\"del_checked(this.id)\">");
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
			<dt>
				<pre><%=row.get("text")%></pre>
			</dt>
			<dt style="display: none"></dt>
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
				out.println("<tr id=\"row" + row.get("news_id") + "\">");
				out.println("<td>");
				out.println("<input type=\"checkbox\" flag=\"0\" class=\"delete_check\" id=\""
						+ row.get("news_id")
						+ "\" onclick=\"del_checked(this.id)\">");
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
			<dt>
				<pre><%=row.get("text")%></pre>
			</dt>
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
	</div>
</body>
</html>