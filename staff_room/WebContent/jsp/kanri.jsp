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

<script>
function show_block(){
   if(document.getElementById("hoge").style.display == ""){
      document.getElementById("hoge").style.display = "none";
   }else{
      document.getElementById("hoge").style.display = "";
   }
}
</script>

<title>管理編集</title>
</head>
<body>
	<div class="changelog">
		<h1>管理・編集</h1>
			<%
			    NewsDAO dao = new NewsDAO();
			    ArrayList<HashMap<String, String>> list = null;
			    list = dao.getNews("select created,postname,title,text,writer from news, post where news.post_id = post.post_id order by created desc limit '10'"  );

				out.println("<table border='1'>");
				for (int i = 0; i < 10; i++) {
					HashMap<String, String> row = list.get(i);
					out.println("<tr>");
					out.println("<td>");
					out.println(row.get("created"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("postname"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					%>
					<p><a href="javascript:void(0)" onclick="show_block();"><%= row.get("title") %></a></p>
					<div id="hoge" style="display:none;"><%= row.get("text") %></div>
					<%
					//out.println(row.get("title"));
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