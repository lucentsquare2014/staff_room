<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.NewsDAO,java.util.Map, java.util.Map.Entry,java.util.ArrayList, java.util.HashMap,java.util.Iterator"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>スタッフルーム</title>
</head>
<body>
<div class="changelog">
<p><strong>更新履歴</strong></p>
<div class="changelog_content">
<%
NewsDAO dao = new NewsDAO();
String sql = "select newsid, created, postname,title from news, post where news.postid = post.postid order by created desc;";
ArrayList<HashMap<String,String>> table = dao.getNews(sql);

out.println("<table border='1'>");
for(int i=0; i< table.size();i++){
    HashMap<String,String> row = table.get(i);
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
</body>
</html>