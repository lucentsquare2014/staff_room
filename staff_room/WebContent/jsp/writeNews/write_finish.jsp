<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- code.jsp＝jpn2unicodeメソッド 文字化け防止の文字コード変換メソッド --%>

<%@ include file="code.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="dao.NewsDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.SQLException" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<title>保存完了</title>
</head>
<body>

	<%
		//入力フォームから渡されたデータをHashMap型newsWriteに格納
		HashMap<String, String> Newsdata = new HashMap<String, String>();
		Newsdata.put("post_id",
				request.getParameter("inputPostid"));
		Newsdata.put("title",
				jpn2unicode(request.getParameter("inputTitle"), "UTF-8"));
		Newsdata.put("text",
				jpn2unicode(request.getParameter("inputText"), "UTF-8"));

		/*添付ファイル いったん保留
		Newsdata.put("file", jpn2unicode(request.getParameter("inputFile"), "Windows-31J")); */

		Newsdata.put("writer",
				jpn2unicode(request.getParameter("inputWriter"), "UTF-8"));
		// DAOからメソッドの呼び出し
		NewsDAO dao = new NewsDAO();

		//確認画面から渡されたname="inputNewsid"がnullかどうかで呼ぶメソッドを判断 文字コード変換のせいでnullという文字列になっていることに注意
		if(request.getParameter("inputNewsid").equals("null")){
			Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");
	        Newsdata.put("created", sdf.format(date));

		//データベースにhashMapから書き込み
		dao.writeNews(Newsdata);
		}else{
			Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");
	        Newsdata.put("update", sdf.format(date));
			//データベースにhashMapから更新
		dao.updateNews(Newsdata);
		}

	%>
	記事の保存が完了しました。
	<form method="POST" action="writeNews.jsp">
		<input type="submit" value="管理・編集に戻る">
	</form>

	<%--テスト用 --%>
	以下、テスト用<br>
	DBにそれぞれ書き込む内容<br>
	post_id：<%= Newsdata.get("post_id") %><br>
	title：<%= Newsdata.get("title") %><br>
	text：<pre><%= Newsdata.get("text") %></pre>
	<%-- Newsdata.get("file") --%>
	writer：<%= Newsdata.get("writer") %><br>
	created：<%= Newsdata.get("created") %><br>
	news_id：<%=request.getParameter("inputNewsid")%><br>
	<%if(request.getParameter("inputNewsid").equals("null")){
						out.println("記事の新規作成メソッドを選択");
						 }else{
						out.println("既存記事更新メソッドを選択");
						 }
						%>


</body>
</html>