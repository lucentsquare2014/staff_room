<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO,
                 news.ReadCheck,
                 java.text.DateFormat,
            	 java.text.SimpleDateFormat,
           		 java.util.Date,
            	 java.util.Locale"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<%@ page import="java.util.List, java.util.Arrays"%>

<%
	if(session.getAttribute("login") != null){
		String id = String.valueOf(session.getAttribute("login"));
		ReadCheck rc = new ReadCheck();
		String unread = rc.getUnread(id);
		session.setAttribute("unread", unread);
	}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<link rel="stylesheet" href="/staff_room/css/top.css">
<script src="/staff_room/script/read_check.js"></script>
<script src="/staff_room/script/print.js"></script>
<script>
$(function() {
	$('#btn_print').click(function(){
	    $.jPrintArea("#my-id");
	  });
	var agent = navigator.userAgent;
	if(agent.search(/iPhone/) != -1 || agent.search(/iPad/) != -1 
		|| agent.search(/iPod/) != -1 || agent.search(/Android/) != -1){
		$(".uk-modal-dialog").css("top", "35px");
	}
});
</script>
<title>スタッフルーム</title>

</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	
	<p id="version">ver.4.0.0</p>

		<div class="main-container uk-container uk-container-center">
			<div class="changelog">
				<div style="margin-botom: 20px;" class="changelog-title"
					class="uk-panel-box">
					<h1 class="uk-text-bold">連絡事項</h1>
				</div>
				<!-- 切り替わるボタンを6個作成 -->
				<ul class="uk-subnav uk-subnav-pill" data-uk-switcher="{connect:'#subnav-pill-content'}">
					<li class="uk-active"><a href="#">すべて</a></li>
					<li class=""><a href="#">総務</a></li>
					<li class=""><a href="#">人事</a></li>
					<li class=""><a href="#">行事</a></li>
					<li class=""><a href="#">ビジネス推進室</a></li>
					<li class=""><a href="#">その他</a></li>
				</ul>
				<%
				//未読のnews_idをvalueに入れる
				String value3 = null;
				List<String> read_check = null;
				if(session.getAttribute("unread") != null){
					 value3 = String.valueOf(session.getAttribute("unread"));
					 read_check = Arrays.asList(value3.split(","));
				}
				//データベースにアクセスしてデータをとってくる
					NewsDAO dao = new NewsDAO();
					ArrayList<HashMap<String, String>> table = dao
							.getNews("select news_id,created,postname,news.post_id,title,primary_flag from news, post where news.post_id = post.post_id order by created desc");
				%>
				<!-- 以下、種別ごとにテーブルを作る -->
				<ul id="subnav-pill-content" class="uk-switcher">
					<!-- 「all」のテーブル -->
					<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						     <th class="coL1"></th>
  							 <th class="coL2 uk-text-left">日付</th>
 							  <th class="coL3 uk-text-left">件名</th>
 							  <th class="coL4 uk-text-left">分類</th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);

									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:200px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>
<!-- ジャンル -->
								<td class="coL4"><%=row.get("postname")%></td>



							</tr><%}%>
						</tbody>
						</table></div></div></li>
					<!-- 「総務」のテーブル -->
					<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						     <th class="coL1"><font color="#FFFFFF">　　</font></th>
  							 <th class="coL2 uk-text-left"><font color="#FFFFFF">日付</font></th>
 							  <th class="coL3 uk-text-left"><font color="#FFFFFF">件名</font></th>
 							  <th class="coL4 uk-text-left"><font color="#FFFFFF">　　</font></th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("1")) {
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:40px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>



							</tr><%}}%>
						</tbody>
						</table></div></div></li>
					<!-- 「人事」のテーブル -->
<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						     <th class="coL1"><font color="#FFFFFF">　　</font></th>
  							 <th class="coL2 uk-text-left"><font color="#FFFFFF">日付</font></th>
 							  <th class="coL3 uk-text-left"><font color="#FFFFFF">件名</font></th>
  								 <th class="coL4 uk-text-left"><font color="#FFFFFF">　　</font></th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("2")) {
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:40px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>



							</tr><%}}%>
						</tbody>
						</table></div></div></li>
					<!-- 「行事」のテーブル -->
					<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						    <th class="coL1"><font color="#FFFFFF">　　</font></th>
   							<th class="coL2 uk-text-left"><font color="#FFFFFF">日付</font></th>
 							  <th class="coL3 uk-text-left"><font color="#FFFFFF">件名</font></th>
 							  <th class="coL4 uk-text-left"><font color="#FFFFFF">　　</font></th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("3")) {
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:40px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>



							</tr><%}}%>
						</tbody>
						</table></div></div></li>
					<!-- 「開発企画」のテーブル -->
					<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						    <th class="coL1"><font color="#FFFFFF">　　</font></th>
  							 <th class="coL2 uk-text-left"><font color="#FFFFFF">日付</font></th>
  							 <th class="coL3 uk-text-left"><font color="#FFFFFF">件名</font></th>
 							  <th class="coL4 uk-text-left"><font color="#FFFFFF">　　</font></th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("4")) {
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:40px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>



							</tr><%}}%>
						</tbody>
						</table></div></div></li>
					<!-- 「その他」のテーブル -->
					<li class="uk-active"><div id="out_Div"><div id="in_Div">
					<table class="changelog-content"class="uk-panel-box">
					<thead>
						<tr>
						     <th class="coL1"><font color="#FFFFFF">　　</font></th>
							   <th class="coL2 uk-text-left"><font color="#FFFFFF">日付</font></th>
							   <th class="coL3 uk-text-left"><font color="#FFFFFF">件名</font></th>
  							 <th class="coL4 uk-text-left"><font color="#FFFFFF">　　</font></th>
						</tr>
					</thead>
					<tbody>
							<%
								for (int i = 0; i < table.size(); i++) {
									HashMap<String, String> row = table.get(i);
									if (row.get("post_id").equals("5")) {
									SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
									Date date = format.parse(row.get("created"));
									DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
							%>
							<tr class="changelog-ul ">
								<td style="width:40px;">
								<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div></td>
								<%}%>

								<%if(read_check.indexOf(row.get("news_id")) != -1){%>
	                             <td><%=dddate.format(date)%></td>
								<td><div class="uk-badge uk-badge-danger">New</div>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="uk-text-danger uk-text-bold kiji">
										<%=row.get("title")%>
									</a></td>

								<%}else{%>
								<td><%=dddate.format(date)%></td>
								<td>
									<a id="<%= row.get("news_id") %>" data-uk-modal="{target:'#my-id'}" class="kiji">
										<%=row.get("title")%></a></td>
	<%}%>



							</tr><%}}%>
						</tbody>
						</table></div></div></li>
				</ul>
			</div>
		</div>
	<div id="my-id" class="uk-modal">
    	<div class="uk-modal-dialog uk-animation-scale-up">
        	<a class="uk-modal-close uk-close"></a>
        	<div id="title" class="uk-badge uk-text-large uk-width-1-1 uk-text-left"></div>
        	<pre id="text" class="uk-overflow-container"></pre>
        	<p id="filename"></p>
        	<a href="#" id="btn_print" class="uk-text-primary">
        		<i class="uk-icon-print" data-uk-tooltip title="プリント"></i>
        	</a>
    	</div>
	</div>
</body>
</html>