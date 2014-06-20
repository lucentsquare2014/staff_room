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
	background-attachment: fixed;
	background-image: url("/staff_room/images/input.png");
}

.contents {
	padding-top: 80px;
	min-width: 950px;
}
p.scroll{
	height: 5em;
	overflow: scroll;
	}
#out_Div {
  position: relative;
  padding-top: 38px;
  width: 900px;
}

#in_Div {
	overflow-y: scroll;
	line-height: 1.75em;
	height: 360px;
	background-color: whitesmoke;
    }

table >thead{

}
table >thead>tr{
  position: absolute;
  top: 0px;
  left: 0px;
  width: 900px;


}
.coL1 { width:15px; }/* colgroupの列幅指定 */

.coL2 { width:110px; }

.coL3 { width:120px; }

.coL4 { width:500px; }

.coL5 { width:70px; }
</style>
<title>管理編集</title>
</head>

<body>
			<div style="position:absolute; top:75px; left:150px;">
			<div class="uk-grid">
			<div class="uk-width-1-4 uk-pull-1-6 uk-text-center">
			<font face="ＭＳ Ｐゴシック">
			<span style="font-size: 50px;">
			<nobr>
			管理・連絡
			</nobr><br></span>
			</font>
			</div></div></div>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="contents uk-width-2-3 uk-container-center" style="height:60px;">
	     <div class="uk-width-1-1 uk-text-right">
	     <a href="/staff_room/jsp/mail/mail.jsp?mmail=1">
	       <button class="uk-button uk-button-success"　value="未読記事">
	       <i class="uk-icon-user uk-icon-small"></i>　記事未読件数確認へ</button></a>
			<a href="/staff_room/jsp/writeNews/inputForm.jsp">
				<button class="uk-button uk-button-primary">
					<i class="uk-icon-pencil uk-icon-small"></i>　新規作成</button></a>
                      <button id="delete_button" class="uk-button uk-button-danger" disabled>
				<i class="uk-icon-trash-o uk-icon-small"></i>　削除</button>　　　　　　
		</div><br>
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
		<div id="out_Div"><div id="in_Div">
		<table border="10" bordercolorlight="#000000"bordercolordark="#696969" class="uk-h4 uk-table uk-table-striped uk-container-center uk-table-condensed  uk-text-center uk-width-medium-2-4 uk-panel-box">
			<thead>
				<tr>
					<th Background="../../images/blackwhite1.png" class="coL1"><font color="#FFFFFF"></font></th>
  					<th Background="../../images/blackwhite1.png" class="coL2 uk-h3 uk-text-center"><font color="#FFFFFF">作成日</font></th>
 					<th Background="../../images/blackwhite1.png" class="coL3 uk-h3 uk-text-center"><font color="#FFFFFF">分類</font></th>
 					<th Background="../../images/blackwhite1.png" class="coL4 uk-h3 uk-text-left"><font color="#FFFFFF">タイトル</font></th>
 					<th Background="../../images/blackwhite1.png" class="coL5"><font color="#FFFFFF"></font></th>
				</tr>
			</thead>
			<tbody>
			<%
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> row = list.get(i);
					//時刻がある記事だけの表示
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						Date date = format.parse(row.get("created"));
						DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));

			%>
			<tr id="row<%=row.get("news_id")%>">
				<td class="coL1"><a flag="0" class=" uk-icon-square-o uk-text-left delete-box"
					name="delete_check" id="<%=row.get("news_id")%>"></a></td>
				<td nowrap class="coL2 uk-text-center"><%=dddate.format(date)%>&nbsp;</td>
				<td nowrap class="coL3 uk-text-center"><%=row.get("postname")%>&nbsp;</td>
				<td class="coL4 uk-text-left" nowrap>
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
				<td class="coL1">
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
		</tbody>
		</table>
		</div></div>
		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<div class="uk-grid uk-width-5-6" style="padding-bottom: 50px;">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left">
				<%if (page_num.equals("1")) {
					out.print("　");
				} else {%>
				<span>　　　　　　　　　　　　　　　　　　<a class="prev-page uk-button uk-button-primary"
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
