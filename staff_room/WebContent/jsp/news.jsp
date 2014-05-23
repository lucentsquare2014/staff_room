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
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<jsp:include page="/html/head.html" />
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
};
function show(a) {
	var ele = display_tag.item(a);
	ele.style.display = (ele.style.display == "none") ? "block" : "none";
}
</script>

<title>連絡事項</title>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<div class="changelog" style="padding-top: 50px;">
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
				.getNews("select TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,news_id,title,text,writer from news where post_id = "
						+ value + " order by update desc");
		System.out.print(list);
		out.println("<table class=\"uk-table uk-table-condensed uk-table-striped\">");
		out.println("<tr>");
		out.println("<td class=\"uk-text-center uk-h2 uk-width-medium-1-4\">");
		out.println("日付");
		out.println("</td>");
		out.println("<td class=\"uk-text-center uk-h2 uk-width-medium-2-4\">");
		out.println("件名");
		out.println("</td>");
		out.println("<td class=\"uk-text-center uk-h2 uk-width-medium-1-4\">");
		out.println("保存者");
		out.println("</td>");
		out.println("</tr>");
		
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			if (!row.get("created").equals("")) {
				out.println("<tr>");
				out.println("<td class=\"uk-text-center\">");
				out.println(row.get("created"));
				out.println("&nbsp;</td>");
				out.println("<td>");
				%>
				<h4><%= row.get("title") %></h4>
				<dl><pre><%= row.get("text") %></pre></dl>
				
				<!--
				<a href="#<%= row.get("news_id") %>" data-uk-modal class="uk-h4"><%= row.get("title") %></a>
				<div id="<%= row.get("news_id") %>" class="uk-modal">
    				<div class="uk-modal-dialog">
        				<a class="uk-modal-close uk-close"></a>
        				<div class="uk-h3"><%= row.get("text") %></div>
    				</div>
				</div>
				-->
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
			out.println("<td class=\"uk-text-center\">");
			out.println("&nbsp;</td>");
			out.println("<td>");
			%>
			<h4><%= row.get("title") %></h4>
		    <dl><pre><%= row.get("text") %></pre></dl>
			<!--
			<a href="#<%= row.get("news_id") %>" data-uk-modal class="uk-h4"><%= row.get("title") %></a>
				<div id="<%= row.get("news_id") %>" class="uk-modal">
    				<div class="uk-modal-dialog">
        				<a class="uk-modal-close uk-close"></a>
        				<div class="uk-h3"><%= row.get("text") %></div>
    				</div>
				</div>
				-->
			<%
			out.println("&nbsp;</td>");
			out.println("<td>");
			out.println(row.get("writer"));
			out.println("</td>");
			out.println("</tr>");
		}
	%>
</div>
</body>
</html>