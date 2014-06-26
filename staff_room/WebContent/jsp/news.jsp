<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="dao.NewsDAO, news.ReadCheck"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%
	if(session.getAttribute("login") != null){
		String id = String.valueOf(session.getAttribute("login"));
		ReadCheck rc = new ReadCheck();
		String unread = rc.getUnread(id);
		session.setAttribute("unread", unread);
	}
%>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/read_check.js"></script>
<script src="/staff_room/script/print.js"></script>
<link rel="stylesheet" href="/staff_room/css/news.css">
<title>連絡事項</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" /><br><br>
<!--	<img src="/staff_room/images/renraku5.jpg"> -->
	<div style="position:relative; top:-80px; left:0px; width: 100%;">

	<div align="center">
<%-- 保留 後ろにNEWSの画像入れるなら
<img src="/staff_room/images/newswall.png" style="position:relative;height: 600; width:100%">
--%>

	<div style="position:relative; top:60px; left:0px; width:100%">

	<%
		String value = null,value2 = null,value3 = null;
		List<String> read_check = null;
		value = request.getParameter("news");
		System.out.println(value);
		value2 = request.getParameter("news_id");
		//未読記事のnews_idを受け取る
		if(session.getAttribute("unread") != null){
			 value3 = String.valueOf(session.getAttribute("unread"));
			 read_check = Arrays.asList(value3.split(","));
		}


		//配列
		ArrayList<Integer> x = new ArrayList<Integer>();
		NewsDAO dao = new NewsDAO();
		ArrayList<HashMap<String, String>> list = null;
		HashMap<String, String> raw = null;
		String page_num = request.getParameter("page");
		if (page_num == null || !NumberUtils.isNumber(page_num)) {
			page_num = "1";
		}
		// offsetにゲットパラメータで取得したページ数を代入
					String limit = "100";
					String offset = String.valueOf((Integer.parseInt(page_num) * Integer
							.parseInt(limit)) - 100);
		if(value.equals("all")){
			list = dao.getNews("select * from news order by created desc " + " limit " + limit + " offset " + offset);
		}else{
			list = dao
					.getNews("select created,news_id,title,filename,text,writer,primary_flag from news where post_id = "
					+ value + " order by created desc " +" limit " + limit +" offset " + offset );
			ArrayList<HashMap<String, String>> name = null;
			name = dao.getNews("select postname from post where post_id =" + value);
			raw = name.get(0);
			System.out.println(raw.get("postname"));
		}
			%>
			<div style="position:fixed; top:220px; left:80px;">
			<div class="uk-grid">
			<div class="uk-width-1-4 uk-pull-1-6 uk-text-center">
			<font face="ＭＳ Ｐゴシック">
			<span style="font-size: 32px;">
			<nobr>
				<% if(value.equals("all")){ %>
					すべて
				<% }else{ %>
					<%=raw.get("postname")%>
				<% } %>
			</nobr><br></span>
			</font>
			</div></div></div>


		<div id="out_Div"><div id="in_Div">
		<table border="1" class="uk-table uk-text-center uk-width-medium-1-1">
		<thead>
		<tr class="uk-text-large">
		<td Background="../images/blackwhite1.png" class="coL1 uk-h2 uk-width-medium-2-10"><font color="#ffffff">日付</font></td>
		<td Background="../images/blackwhite1.png" class="coL2 uk-h2 uk-width-medium-8-10"><font color="#ffffff">件名</font></td>
		</tr>
		</thead>
		<%
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date = format.parse(row.get("created"));
			DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd",new Locale("JP", "JP", "JP"));
				%>
				<tr>
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-2-10 uk-text-center"><%=dddate.format(date)%>&nbsp;</td>
				<td id="print<%=row.get("news_id") %>" bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-left">
				<!--記事のタイトルなどを表示-->
				<%if(row.get("primary_flag").equals("1")){%>
									&nbsp;<div class="uk-badge uk-badge-warning">緊急</div>
								<%}%>
					<%if(read_check.indexOf(row.get("news_id")) != -1){%>
					<div class="uk-badge uk-badge-danger">new</div>
						<a id="<%= row.get("news_id") %>" data-uk-toggle="{target:'#my-id<%=i%>'}" class="uk-text-danger uk-text-bold kiji">
							<%= row.get("title") %>
						</a>
						<a href="#" id="btn_print<%=row.get("news_id") %>" class="uk-text-primary">
							<i class="uk-icon-print" data-uk-tooltip title="プリント"></i>
						</a>
					<%}else{%>
						<a data-uk-toggle="{target:'#my-id<%=i%>'}" class="kiji"><%= row.get("title") %></a>
						<a href="#" id="btn_print<%=row.get("news_id") %>" class="uk-text-primary">
							<i class="uk-icon-print" data-uk-tooltip title="プリント"></i>
						</a>
					<%}%>
					<%if (!row.get("filename").equals("")){ %>
                    	<div id="my-id<%=i%>" class="uk-h4 uk-text-left uk-hidden">
                    		<pre><%= row.get("text") %></pre>
                    		<p>添付：
                    			<%
                    				String arr[] = row.get("filename").split( "," );
                    				for (int f = 0; f<arr.length; f++){
                    			%>
                    			<a href="/staff_room/upload/<%= arr[f] %>"><%= arr[f] %></a>&nbsp;
                    			<% } %>
                    		</p>
                    	</div>
					<%}else{ %>
					<div id="my-id<%=i%>" class="uk-h4 uk-text-left uk-hidden">
						<pre><%= row.get("text") %></pre>
					</div>
					<%} %>
					<script>
						$(function() {
							$('#btn_print' + <%=row.get("news_id") %>).click(function(){
	    						$.jPrintArea("#print" + <%=row.get("news_id") %>);
	    						return false;
	  						});
						});
					</script>
				<%} %>
			</td>
		</table>
		</div></div><br>
		<!-- 次へボタン、戻るボタンの処理　 -->
		<div class="uk-width-3-5 uk-container-center">
		<div class="uk-grid">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left">
				<%if (page_num.equals("1")) {
					out.print("　");
				} else {%>
				<span><a class="prev-page uk-button uk-button-primary"
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) - 1%>&news=<%=value%>">&lt;&lt;前へ</a></span>
			<%}%>
			</div>
			<div class="uk-width-1-2 page-next uk-text-large uk-text-right"
				style="<%if (list.size() < 100) {
				out.print("display: none;");
			}%>">
				<span><a class="next-page uk-button uk-button-primary"
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) + 1%>&news=<%=value%>">次へ&gt;&gt;</a></span>
			</div>
		</div>
		</div>
</div></div></div>
</body>
</html>
