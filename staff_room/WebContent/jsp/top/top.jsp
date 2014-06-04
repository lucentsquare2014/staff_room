<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<%@ page import="java.util.List, java.util.Arrays"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<link rel="stylesheet" href="/staff_room/css/top.css">
<script src="/staff_room/script/read_check.js"></script>
<title>スタッフルーム</title>

</head>
<body>
	<nobr>
		<jsp:include page="/jsp/header/header.jsp" />
		<div class="main-container uk-container uk-container-center">
			<div class="changelog">
				<div style="margin-botom: 20px;" class="changelog-title"
					class="uk-panel-box">
					<h1 class=" uk-text-bold ">連絡事項</h1>
				</div>
				<!-- 切り替わるボタンを6個作成 -->
				<ul class="uk-subnav uk-subnav-pill" data-uk-switcher="{connect:'#subnav-pill-content'}">
					<li class="uk-active"><a href="#">all</a></li>
					<li class=""><a href="#">総務</a></li>
					<li class=""><a href="#">人事</a></li>
					<li class=""><a href="#">行事</a></li>
					<li class=""><a href="#">開発企画</a></li>
					<li class=""><a href="#">その他</a></li>
				</ul>
				<%
				//未読のnews_idをvalueに入れる
				String value3 = null;
				List<String> read_check = null;
				if(session.getAttribute("unread") !=""){
					 value3 = String.valueOf(session.getAttribute("unread"));
					 read_check = Arrays.asList(value3.split(","));
				}
				//データベースにアクセスしてデータをとってくる
					NewsDAO dao = new NewsDAO();
					ArrayList<HashMap<String, String>> table = dao
							.getNews("select news_id, TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,postname,news.post_id,title from news, post where news.post_id = post.post_id order by created desc");
					ArrayList<HashMap<String, String>> t_copy = new ArrayList<HashMap<String, String>>(
							table);
				%>
				<!-- 以下、種別ごとにテーブルを作る -->
				<ul id="subnav-pill-content" class="uk-switcher">
					<!-- 「all」のテーブル -->
					<li class="uk-active"><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>
									&nbsp;<div class="uk-badge uk-badge-danger">new</div>
									</td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a>
									</td>
								<%}%>
							</tr><%}%>
						</table></li>
					<!-- 「総務」のテーブル -->	
					<li class=""><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("1")) {
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>
									&nbsp;<div class="uk-badge uk-badge-danger">new</div></td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a></td>
								<%}%>
							</tr><%}}%>
						</table></li>
					<!-- 「人事」のテーブル -->	
					<li class=""><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("2")) {
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>
									&nbsp;<div class="uk-badge uk-badge-danger">new</div></td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a></td>
								<%}%>
							</tr><%}}%>
						</table></li>
					<!-- 「行事」のテーブル -->	
					<li class=""><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("3")) {
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>
									&nbsp;<div class="uk-badge uk-badge-danger">new</div></td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a></td>
								<%}%>
							</tr>
							<%}}%>
						</table></li>
					<!-- 「開発企画」のテーブル -->	
					<li class=""><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("4")) {
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>
									&nbsp;<div class="uk-badge uk-badge-danger">new</div></td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a></td>
								<%}%>
							</tr>
							<%}}%>
						</table></li>
					<!-- 「その他」のテーブル -->	
					<li class=""><table class="changelog-content"class="uk-panel-box">
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("5")) {
							%>
							<tr class="changelog-ul ">
								<td><%=row.get("created")%></td>
								<td><%=row.get("postname")%></td>
								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold"><%=row.get("title")%></a>&nbsp;<div class="uk-badge uk-badge-danger">new</div></td>
								<%}else{%>
									<td><a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}"><%=row.get("title")%></a></td>
								<%}%>
							</tr>
							<%}}%>
						</table></li>
				</ul>

			</div>

		</div>
	</nobr>
	<div id="my-id" class="uk-modal">
    	<div class="uk-modal-dialog">
        	<a class="uk-modal-close uk-close"></a>
        	<h3 id="title"></h3>
        	<p><pre id="text"></pre></p>
        	<p id="filename"></p>
    	</div>
	</div>
</body>
</html>