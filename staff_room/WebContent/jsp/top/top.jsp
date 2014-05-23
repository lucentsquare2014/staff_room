<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<title>スタッフルーム</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class=" uk-container uk-container-center">
		<div class="changelog" style="padding-top: 50px;">
			<p>
				<strong>更新履歴</strong>
			</p>
			<div class="changelog_content">
				<%
					NewsDAO dao = new NewsDAO();
					// String sql = "select news_id, created, postname,title from news, post where news.post_id = post.post_id order by created desc limit '10'";
					String sql = "select news_id, TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created, postname,title from news, post where news.post_id = post.post_id order by created desc";
					ArrayList<HashMap<String, String>> table = dao.getNews(sql);
					ArrayList<HashMap<String, String>> t_copy = new ArrayList<HashMap<String, String>>(
							table);
					// createdがない行を配列から削除
					for (HashMap<String, String> row : t_copy) {
						if (row.get("created").equals("")) {
							table.remove(table.indexOf(row));
						}
					}
					out.println("<table border='1'>");
					for (int i = 0; i < table.size(); i++) {
						// 10こ表示したらループを止める
						if (i == 10) {
							break;
						}
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
	</div>
</body>
</html>