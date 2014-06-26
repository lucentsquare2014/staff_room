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
<jsp:include page="/html/head.html" />
<style type="text/css">
	body {
		background-image: url("/staff_room/images/input.png");	
	}
</style>
<head>
<title>保存完了</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="uk-height-1-1 uk-vertical-align uk-text-center">
	<%
		//入力フォームから渡されたデータをHashMap型newsWriteに格納
		HashMap<String, String> Newsdata = new HashMap<String, String>();
		Newsdata.put("post_id",
				request.getParameter("inputPostid"));
		Newsdata.put("title",
				jpn2unicode(request.getParameter("inputTitle"), "UTF-8"));
		Newsdata.put("text",
				jpn2unicode(request.getParameter("inputText"), "UTF-8"));
		Newsdata.put("filename",
				jpn2unicode(request.getParameter("inputFiles"), "UTF-8"));
		Newsdata.put("writer",
				jpn2unicode(request.getParameter("inputWriter"), "UTF-8"));
		Newsdata.put("primary_flag",
				jpn2unicode(request.getParameter("inputPrimary"), "UTF-8"));
		// DAOからメソッドの呼び出し
		NewsDAO dao = new NewsDAO();

		//確認画面から渡されたname="inputNewsid"がnullかどうかで呼ぶメソッドを判断 文字コード変換のせいでnullという文字列になっていることに注意
		if(request.getParameter("inputNewsid")==null || request.getParameter("inputNewsid").equals("null")){
			Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss");
	        Newsdata.put("created", sdf.format(date));

		//データベースにhashMapから書き込み
        // post_idのシーケンスを最新のものに更新
        dao.setPostIdSequence();
		dao.writeNews(Newsdata);
		}else{
			Newsdata.put("news_id",
	                request.getParameter("inputNewsid"));
			Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss");
	        Newsdata.put("update", sdf.format(date));
			//データベースにhashMapから更新

		dao.updateNews(Newsdata);
		}

	%>
	<div style="position:relative; top:250px;">
	<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
		<div class="uk-panel uk-panel-box uk-text-center">
			<h1 class="uk-text-success"><i class="uk-icon-smile-o"></i>記事の保存が完了しました。</h1>
			<br>
			<a href="writeNews.jsp" class="uk-button uk-button-success uk-button-large">管理・編集に戻る</a>
		</div>
	</div>
</div>
</div>
</body>
</html>