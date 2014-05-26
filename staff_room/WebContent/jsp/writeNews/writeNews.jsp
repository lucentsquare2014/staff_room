<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>


<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<!--  javascriptを外部ファイルに移動 -->
<script src="/staff_room/script/writeNews.js"></script>
<style type="text/css">
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/renraku.png");
	background-size: 100% auto;
}
</style>
<title>管理編集</title>
</head>

<body>


	<jsp:include page="/jsp/header/header.jsp" />
	<div class="changelog" style="padding-top: 50px;"></div>
	<div class="content">
		<h1>管理・編集</h1>
		<a href="/staff_room/jsp/writeNews/updateForm.jsp"
			style="margin-top: 20px; width: 200px; height: 50px; color: black background:white;">
			新規作成 </a>
		<div  align="right" style="margin-right: 75px"
			style="margin-top:30px;">
			<button id="delete_button"
				style="width: 175px; height: 50px; color: black; background-color: darkgray; font-weight: 30;">
				削除
			 </button>
		</div>
		<%
			//配列
			ArrayList<Integer> x = new ArrayList<Integer>();
			int j = 0, z = 0;
			NewsDAO dao = new NewsDAO();
			ArrayList<HashMap<String, String>> list = null;
			// 条件式ごとに文字列を分割
			String select, from, where, order, offset, limit;
			select = "news_id,TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,post.post_id,postname,title,text,writer";
			from = "news, post";
			where = "news.post_id = post.post_id";
			order = "created desc";
			// offsetにゲットパラメータで取得したページ数を代入
			offset= request.getParameter("page");
			// １ページだった場合は１を代入
			if(offset==null){offset="1";}
			limit = "10";
			String sql = "select "+select+" from "+from
					    +" where "+where+" order by "+order
					    +" offset "+offset+" limit "+limit;
			System.out.println(sql);
			list = dao.getNews(sql);
		%>
		<table border='3' width='80%' cellspacing='20'cellpadding'0'>
			<%
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> row = list.get(i);
					//時刻がある記事だけの表示
					if (!row.get("created").equals("")) {
			%>
			<tr id="row<%=row.get("news_id")%>">
				<td>
				<a flag="0" class="uk-icon-square-o" name="delete_check" id="<%=row.get("news_id")%>"></a>
				</td>
				<td><%=row.get("created")%>&nbsp;</td>
				<td><%=row.get("postname")%>&nbsp;</td>
				<td>
					<!-- title→タイトル -->
					<a t_id="<%=row.get("news_id") %>" class="body-title"><%=row.get("title")%></a>
                    <dl>
                        <dt id="text<%=row.get("news_id") %>" class="body-text">
                            <!-- text→文章 -->
                            <pre><%=row.get("text")%></pre>
                        </dt>
                        <dt style="display: none"></dt>
                    </dl>
				</td>
				<td>
					<form method="POST" action="updateForm.jsp">
						<input type="hidden" name="inputNewsid"
							value="<%=row.get("news_id")%>">
						<input type="hidden"
							name="inputPostid" value="<%=row.get("post_id")%>">
						<input
							type="hidden" name="inputTitle" value="<%=row.get("title")%>">
						<input type="hidden" name="inputText" value="<%=row.get("text")%>">
						<input type="hidden" name="inputWriter"
							value="<%=row.get("writer")%>">
						<input type="submit"
							style="width: 200px; height: 50px; color: black background:white;"
							value="編集">
					</form>
				</td>
			</tr>
			<%
				} else {
						x.add(i);
						z++;
					}
				}
				//時刻が入っていない記事の表示はここから
				for (int i = 0; i < z; i++) {
					HashMap<String, String> row = list.get(x.get(i));
			%>
			<tr id="row<%=row.get("news_id")%>">
				<td>
				<a flag="0" class="uk-icon-square-o"
					name="delete_check" id="<%=row.get("news_id")%>">
				</a>
				</td>
				<td><%=row.get("created")%>&nbsp;</td>
				<td><%=row.get("postname")%>&nbsp;</td>
				<td>
					<!-- title→タイトル -->
                    <a t_id="<%=row.get("news_id") %>" class="body-title"><%=row.get("title")%></a>
                    <dl>
                        <dt id="text<%=row.get("news_id") %>" class="body-text">
                            <!-- text→文章 -->
                            <pre><%=row.get("text")%></pre>
                        </dt>
                        <dt style="display: none"></dt>
                    </dl>
 
 				</td>
				<td>
					<form method="POST" action="updateForm.jsp">

                        <input type="hidden" name="inputNewsid"
                            value="<%=row.get("news_id")%>">
                        <input type="hidden"
                            name="inputPostid" value="<%=row.get("post_id")%>">
                        <input
                            type="hidden" name="inputTitle" value="<%=row.get("title")%>">
                        <input type="hidden" name="inputText" value="<%=row.get("text")%>">
                        <input type="hidden" name="inputWriter"
                            value="<%=row.get("writer")%>">
                        <input type="submit"
                            style="width: 200px; height: 50px; color: black background:white;"
                            value="編集">
					</form>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		
	</div>

</body>
</html>