<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ page import="dao.NewsDAO,
				java.util.ArrayList,
				java.util.HashMap,
				org.apache.commons.lang3.StringEscapeUtils"
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>記事未読件数一覧</title>
</head>
<body>
<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB News = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Newslist = null;
	String sql = "select id,name,hurigana from shainmst where zaiseki_flg='1' order by hurigana asc";
	Newslist = News.getShain(sql);%>

<div id="con" class="uk-width-3-5 uk-container-center ">
	<table border="5"  class="uk-table uk-table-hover uk-width-1-1">
	<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">ID</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">氏名</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">記事未読件数</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">緊急記事未読件数</font></th>
		</tr>

		<%
		for (int i = 0; i < Newslist.size(); i++) {
			HashMap<String, String> Newsmap = Newslist.get(i);
			%>


		<tr>
			<td id = "na" bgcolor="#FFFFFF"><%=Newsmap.get("name")%></td>
			<td id = "na" bgcolor="#FFFFFF"><%=Newsmap.get("hurigana")%></td>
			<td id = "na" bgcolor="#FFFFFF"><a href="mailto:<%=Newsmap.get("mail")%>"><%=Newsmap.get("mail")%></a></td>
		</tr>
	<%}%>
	</table>
	</div>
</body>
</html>