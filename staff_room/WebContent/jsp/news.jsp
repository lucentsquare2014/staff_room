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
<%@page import="java.util.*"%>

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

<title>連絡事項</title>
</head>
<body>
	<h1>連絡事項</h1>

	<%
		String value = null;
		value = request.getParameter("news");
		if(value == null){
			value = "1";
		}
		int flag = Integer.parseInt(value);
		if(!(flag == 1 || flag == 2 ||flag == 3 ||flag == 4 || flag == 5)){
			value = "1";
		}

		//配列
		ArrayList<Integer> x = new ArrayList<Integer>();
		int j=0,z=0;
		NewsDAO dao = new NewsDAO();
		ArrayList<HashMap<String, String>> list = null;
		list = dao
				.getNews("select created,title,text,writer from news where post_id = "
						+ value + " order by update desc");
		System.out.print(list);
		out.println("<table border='1'>");
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
		
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			if (!row.get("created").equals("")) {
				out.println("<tr>");
				out.println("<td>");
				out.println(row.get("created"));
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
				out.println(row.get("writer"));
				out.println("</td>");
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
			%>
			<h4><%= row.get("title") %></h4>
			<dl>
			<dt><%= row.get("text") %></dt>
			</dl>
			<%
			out.println("&nbsp;</td>");
			out.println("<td>");
			out.println(row.get("writer"));
			out.println("</td>");
			out.println("</tr>");
		}
	%>

</body>
</html>