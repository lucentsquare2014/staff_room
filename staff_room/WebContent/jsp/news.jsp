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
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
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

<style type="text/css">
 	tr{white-space:nowrap;}
</style>

</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" /><br><br>
	<img src="/staff_room/images/renraku5.jpg">
	<div style="position:relative; top:-80px; left:0px; width: 100%;">

	<div align="center">
<%-- 保留 後ろにNEWSの画像入れるなら
<img src="/staff_room/images/newswall.png" style="position:relative;height: 600; width:100%">
--%>

	<div style="position:relative; top:60px; left:0px; width:100%">

	<%
		String value = null,value2 = null;
		value = request.getParameter("news");
		value2 = request.getParameter("news_id");
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
		String page_num = request.getParameter("page");
		if (page_num == null || !NumberUtils.isNumber(page_num)) {
			page_num = "1";
		}
		// offsetにゲットパラメータで取得したページ数を代入
					String limit = "10";
					String offset = String.valueOf((Integer.parseInt(page_num) * Integer
							.parseInt(limit)) - 10);
		list = dao
		.getNews("select TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,news_id,title,filename,text,writer from news where post_id = "
		+ value + " order by update desc " +" limit " + limit +" offset " + offset );
		ArrayList<HashMap<String, String>> name = null;
		name = dao.getNews("select postname from post where post_id =" + value);
		System.out.print(name);
		HashMap<String, String> raw = name.get(0);
			%>
			<div align="left">
			<font face="ＭＳ Ｐゴシック">
			<font size ="7">
			<br><br><br>　　　　　
			<nonbr><%=raw.get("postname")%></nonbr><br>
			</font>
			</font>
			</div>

		<br><br>
		<%System.out.print(list);%>
		<div class="uk-width-1-1 uk-container-center">
		<table class="uk-table  uk-table-striped uk-text-center uk-width-medium-1-1">
		<tr class="uk-text-large">
		<td class="uk-h2 uk-width-medium-2-10">日付</td>
		<td class="uk-h2 uk-width-medium-6-10">件名</td>
		<td class="uk-h2 uk-width-medium-2-10">保存者</td>
		</tr>
		<%
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			if (!row.get("created").equals("")) {
				%>
				<tr>
				<td class="uk-h3  uk-width-medium-2-10"><%=row.get("created")%>&nbsp;</td>
				<td class="uk-h3 uk-width-medium-6-10">
				<%
				//更新履歴から選択された記事を表示状態で連絡画面へ飛ぶ処理
				if(row.get("news_id").equals(value2)){
					%><a data-uk-toggle="{target:'#my-id'}"><%= row.get("title") %></a>
					<div id="my-id" class="uk-text-left">
						<pre class="uk-h3"><%= row.get("text") %></pre>
					</div>
				<%}else{%>
					<h4><%= row.get("title") %></h4>
					<%if (!row.get("filename").equals("")){ %>
					<dl><pre><div class="uk-h3 uk-text-left"><%= row.get("text") %><br><br>添付ファイル：<%= row.get("filename") %></div></pre></dl>
					<%} else{ %>
					<dl><pre><div class="uk-h3 uk-text-left"><%= row.get("text") %></div></pre></dl>
					<%} %>
				<%} %>
				<!--
				<a href="#<%= row.get("news_id") %>" data-uk-modal class="uk-h4"><%= row.get("title") %></a>
				<div id="<%= row.get("news_id") %>" class="uk-modal">
    				<div class="uk-modal-dialog">
        				<a class="uk-modal-close uk-close"></a>
        				<div class="uk-h3"><%= row.get("text") %></div>
    				</div>
				</div>
				-->
				
				&nbsp;</td>
				<td class="uk-h3 uk-width-medium-2-10"><%=row.get("writer")%></td>
				</tr>
				
			<%}else {
				x.add(i);
				z++;
			}
		}
		for (int i = 0; i < z; i++) {
			HashMap<String, String> row = list.get(x.get(i));
			%>
			<tr>
			<td class="uk-h3  uk-width-medium-2-10">
			<%=row.get("created")%>
			&nbsp;</td>
			<td class="uk-h3 uk-width-medium-6-10">
			
			<h4><%= row.get("title") %></h4>
				<%if (!row.get("filename").equals("")){ %>
				<dl><pre><div class="uk-h3 uk-text-left"><%= row.get("text") %><br><br>添付ファイル：<%= row.get("filename") %></div></pre></dl>
				<%} else{ %>
				<dl><pre><div class="uk-h3 uk-text-left"><%= row.get("text") %></div></pre></dl>
				<%} %>
			<!--
			<a href="#<%= row.get("news_id") %>" data-uk-modal class="uk-h4"><%= row.get("title") %></a>
				<div id="<%= row.get("news_id") %>" class="uk-modal">
    				<div class="uk-modal-dialog">
        				<a class="uk-modal-close uk-close"></a>
        				<div class="uk-h3"><%= row.get("text") %></div>
    				</div>
				</div>
			-->
			
&nbsp;</td>
<td class="uk-h3 uk-width-medium-2-10"><%=row.get("writer")%></td><%}%>
</tr>
</table>

<div class="uk-grid" style="padding-bottom: 50px;">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left"
				style="<%if (page_num.equals("1")) {
				out.print("display: none;");
			}%>">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) - 1%>">前へ&lt;&lt;</a></span>
			</div>
			<div class="uk-width-1-2 page-next uk-text-large uk-text-right"
				style="<%if (list.size() < 10) {
				out.print("display: none;");
			}%>">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) + 1%>">次へ&gt;&gt;</a></span>
			</div>
		</div>
</div></div></div></div>
</body>
</html>