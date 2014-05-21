<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.io.File"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<%String str = application.getRealPath(File.separator+"WebContent"+File.separator+"html"+File.separator+"head.html"); %>
<jsp:include page="/html/head.html" />
<title>スタッフルーム</title>
</head>
<body>
	<jsp:include page="../header/header.jsp" />
	<div class="changelog" style="padding-top: 50px;">
		<p>
			<strong>更新履歴</strong>
		</p>
		<div class="changelog_content">
			<%
				NewsDAO dao = new NewsDAO();
				String sql = "select news_id, created, postname,title from news, post where news.post_id = post.post_id order by created desc limit '10'";
				ArrayList<HashMap<String, String>> table = dao.getNews(sql);

				out.println("<table border='1'>");
				for (int i = 0; i < table.size(); i++) {
					HashMap<String, String> row = table.get(i);
					out.println("<tr>");
					out.println("<td>");
					out.println(row.get("created"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("postname"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("title"));
					out.println("</td>");
					out.println("</tr>");
				}
				out.println("</table>");
			%>
		</div>
	</div>
	<div class="page_title">
		<h1>staff_room</h1>
	</div>
</body>
</html>