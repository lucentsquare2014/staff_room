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
	<jsp:include page="/jsp/header/header.jsp" /><br><br>
	<img src="/staff_room/images/renraku2.jpg" style="height: 300; width:100%">
	<div style="position:absolute; top:520px; left:80px; width: 100%;">
	<div align="right"><h1><i><u><font color="#000000" face="HGP明朝E" style="font-size:50pt;">連絡事項</font></u></i>　　　　　</h1></div>
	</div>
	<div align="center">
	<img src="/staff_room/images/newswall.png" style="height: 300; width:100%">
	<div style="position:absolute; top:600px; left:0px; width: 100%;">
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
		ArrayList<HashMap<String, String>> name = null;
		name = dao.getNews("select postname from post where post_id =" + value);
		System.out.print(name);

		for (int i = 0; i < name.size(); i++) {
			HashMap<String, String> raw = name.get(i);
			out.println("<div align=\"left\">");
			out.println("<font face=\"HGP創英角ﾎﾟｯﾌﾟ体\">");
			out.println("<font size =\"7\">");
			out.println("<br><br><br>　　　　　");
			out.println(raw.get("postname"));
			out.println("<br>");
			out.println("</font>");
			out.println("</font>");
			out.println("</div>");
		}
		out.println("<br><br><br><br>");
		System.out.print(list);
		out.println("<table class=\" uk-text-center uk-width-medium-3-4\">");
		out.println("<tr>");
		out.println("<td class=\"uk-h2 uk-width-medium-1-4\">");
		out.println("日付");
		out.println("</td>");
		out.println("<td class=\"uk-h2 uk-width-medium-2-4\">");
		out.println("件名");
		out.println("</td>");
		out.println("<td class=\"uk-h2 uk-width-medium-1-4\">");
		out.println("保存者");
		out.println("</td>");
		out.println("</tr>");

		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			if (!row.get("created").equals("")) {
				out.println("<tr>");
				out.println("<td class=\"uk-h3 uk-width-medium-1-4 \">");
				out.println(row.get("created"));
				out.println("&nbsp;</td>");
				out.println("<td class=\"uk-h3 uk-width-medium-2-4\">");
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
				out.println("<td class=\"uk-h3 uk-width-medium-1-4\">");
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
	</div>
</body>
</html>