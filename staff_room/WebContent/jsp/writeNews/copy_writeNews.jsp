<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO,
				java.text.DateFormat,
            	java.text.SimpleDateFormat,
           		java.util.Date,
            	java.util.Locale"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%
	if(session.getAttribute("admin") != null){
	    String user = String.valueOf(session.getAttribute("admin"));
		if (!user.equals("1")){
			response.sendRedirect("/staff_room/jsp/top/top.jsp");
		}
	}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<!--  javascriptを外部ファイルに移動 -->
<script src="/staff_room/script/writeNews.js"></script>
<script type="text/javascript" src="/staff_room/script/notifIt.js"></script>
<link rel="stylesheet" type="text/css" href="/staff_room/css/notifIt.css">
<style type="text/css">
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/input.png");
}

.contents {
	padding-top: 100px;
	min-width: 950px;
}
</style>
<title>管理編集</title>
</head>

<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="contents uk-width-2-3 uk-container-center">
		<h1>管理・編集</h1>
	     <div align="right">
			<a href="/staff_room/jsp/writeNews/inputForm.jsp">
				<button class="uk-button uk-button-primary">
					<i class="uk-icon-pencil uk-icon-small"></i>　新規作成</button></a>
			<button id="delete_button" class="uk-button uk-button-danger" disabled>
				<i class="uk-icon-trash-o uk-icon-small"></i>　削除</button>
		</div>
		<%
			//配列
			ArrayList<Integer> x = new ArrayList<Integer>();
			int j = 0, z = 0;
			NewsDAO dao = new NewsDAO();
			ArrayList<HashMap<String, String>> list = null;
			// 条件式ごとに文字列を分割
			String select, from, where, order, offset, limit;
			select = "news_id,created,post.post_id,postname,title,text,filename,writer,primary_flag";
			from = "news, post";
			where = "news.post_id = post.post_id";
			order = "created desc";
			limit = "100";
			String page_num = request.getParameter("page");
			if (page_num == null || !NumberUtils.isNumber(page_num)) {
				page_num = "1";
			}

			// offsetにゲットパラメータで取得したページ数を代入
			offset = String.valueOf((Integer.parseInt(page_num) * Integer
					.parseInt(limit)) - 100);

			String sql = "select " + select + " from " + from + " where "
					+ where + " order by " + order + " offset " + offset
					+ " limit " + limit;
			//System.out.println(sql);
			list = dao.getNews(sql);
			//System.out.println(list.size());
		%>
		<table border="10" bordercolorlight="#000000"bordercolordark="#696969" class="uk-h4 uk-table uk-table-striped uk-table-condensed  uk-text-center uk-width-medium-2-4 uk-panel-box">
			<tr>
				<td Background="../../images/blackwhite1.png"></td>
				<td Background="../../images/blackwhite1.png" class="uk-h3 uk-width-medium-1-10"><font color="#ffffff">作成日</font></td>
				<td Background="../../images/blackwhite1.png" class="uk-h3 uk-width-medium-1-10"><font color="#ffffff">分類</font></td>
				<td Background="../../images/blackwhite1.png" class="uk-h3 uk-width-medium-7-10 uk-text-left"><font color="#ffffff">タイトル</font></td>
				<td Background="../../images/blackwhite1.png"></td>
			</tr>
			<%
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> row = list.get(i);
					//時刻がある記事だけの表示
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						Date date = format.parse(row.get("created"));
						DateFormat dddate = new SimpleDateFormat("GGGGyy年 MM月 dd日 ",new Locale("ja", "JP", "JP"));

			%>
			<tr id="row<%=row.get("news_id")%>">
				<td><a flag="0" class="uk-icon-square-o uk-text-center delete-box"
					name="delete_check" id="<%=row.get("news_id")%>"></a></td>
				<td nowrap><%=dddate.format(date)%>&nbsp;</td>
				<td nowrap><%=row.get("postname")%>&nbsp;</td>
				<td class="uk-text-left" nowrap>
					<!-- title→タイトル --> <a t_id="<%=row.get("news_id")%>"
					class="body-title"><%=StringEscapeUtils.escapeHtml4(row.get("title")) %></a>
					<dl>
						<dt id="text<%=row.get("news_id")%>" class="body-text">
							<!-- text→文章 -->
							<pre><%=row.get("text")%></pre>
						</dt>
						<dt style="display: none"></dt>
					</dl>
				</td>
				<td>
					<form method="POST" action="inputForm.jsp">
						<input type="hidden" name="inputNewsid" value="<%=row.get("news_id")%>">
						<input type="hidden" name="inputPostid" value="<%=row.get("post_id")%>">
						<input type="hidden" name="inputTitle" value="<%=StringEscapeUtils.escapeHtml4(row.get("title")) %>">
						<input type="hidden" name="inputText" value="<%=StringEscapeUtils.escapeHtml4(row.get("text")) %>">
						<input type="hidden" name="inputFile" value="<%=StringEscapeUtils.escapeHtml4(row.get("filename")) %>">
						<input type="hidden" name="inputWriter" value="<%=StringEscapeUtils.escapeHtml4(row.get("writer")) %>">


						<input type="hidden" name="inputPrimary" value="<%=row.get("primary_flag")%>">

						<input type="submit" class="uk-button uk-button-success" value="編集">

					</form>
				</td>
			</tr>
			<%
				}
			%>

		</table>
		<%

		%>
		<div class="uk-grid" style="padding-bottom: 50px;">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left">
				<%if (page_num.equals("1")) {
					out.print("　");
				} else {%>
				<span><a class="prev-page uk-button uk-button-primary"
					href="/staff_room/jsp/writeNews/writeNews.jsp?page=<%=Integer.parseInt(page_num) - 1%>"><b>&lt;&lt;前へ</b></a></span>
			<%}%>
			</div>
			<div class="uk-width-1-2 page-next uk-text-large uk-text-right"
				style="<%if (list.size() < 100) {
				out.print("display: none;");
			}%>">
				<span><a class="next-page uk-button uk-button-primary"
					href="/staff_room/jsp/writeNews/writeNews.jsp?page=<%=Integer.parseInt(page_num) + 1%>"><b>次へ&gt;&gt;</b></a></span>
			</div>
		</div>
	</div>
</body>
</html>