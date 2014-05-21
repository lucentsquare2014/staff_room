<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="dao.NewsDAO"%>

<script>
function show_block(){
   if(document.getElementById("hoge").style.display == ""){
      document.getElementById("hoge").style.display = "none";
   }else{
      document.getElementById("hoge").style.display = "";
   }
}
</script>

<title>連絡事項</title>
</head>
<body>
	<h1>連絡事項</h1>

	<%
		String value = null;
		value = request.getParameter("bunrui");
		value = "1";

		int j = 0;
		NewsDAO dao = new NewsDAO();
		ArrayList<HashMap<String, String>> list = null;
		list = dao
				.getNews("select created,title,text,writer from news where post_id = '"
						+ value + "' order by update desc");

		out.println("<table>");
		out.println("<tr>");
		out.println("<td>");
		out.println("日付");
		out.println("</td>");
		out.println("<td>");
		out.println("件名");
		out.println("</td>");
		out.println("<td>");
		out.println("保存者");
		out.println("</td>");
		out.println("</tr>");
		
		for (int i = 1; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			out.println("<tr>");
			out.println("<td>");
			//if (!row.get("created").equals("")) {
				out.println(row.get("created"));
				out.println("&nbsp;</td>");
				out.println("<td>");
				%>
				
				<p><a href="javascript:void(0)" onclick="show_block();"><%= row.get("title") %></a></p>
				<div id="hoge" style="display:none;"><%= row.get("text") %></div>
				<%
				//out.println(row.get("title"));
				out.println("&nbsp;</td>");
				out.println("<td>");
				out.println(row.get("writer"));
				out.println("</td>");
				out.println("</tr>");
			//} else {
			//	j=i;
			//}
		}
		/*
		HashMap<String, String> row = list.get(j);
		out.println("<tr>");
		out.println("<td>");
		out.println(row.get("created"));
		out.println("&nbsp;</td>");
		out.println("<td>");
		out.println(row.get("title"));
		out.println("&nbsp;</td>");
		out.println("<td>");
		out.println(row.get("writer"));
		out.println("</td>");
		out.println("</tr>");
		*/
		
	%>

</body>
</html>