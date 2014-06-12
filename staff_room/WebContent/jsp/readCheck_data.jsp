<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html" />
<link rel="stylesheet" href="/staff_room/css/readCheck_data.css">
<%@ page import="dao.ShainDB,
				dao.NewsDAO,
				java.util.ArrayList,
				java.sql.Connection,
				java.sql.PreparedStatement,
				java.sql.Statement,
				java.sql.ResultSet,
				java.sql.SQLException,
				java.util.HashMap,
				org.apache.commons.lang3.StringEscapeUtils,
				java.util.Vector"
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>記事未読件数一覧</title>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br><br><br><br><br>
<div class="uk-h1" id="title">
記事未読件数一覧
</div>
<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB News = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Newslist = null;
	String sql = "select shainmst.id,shainmst.name,shainmst.hurigana,shainkanri.read_check,shainkanri.access_time" +
				" from shainmst,shainkanri where shainmst.number = shainkanri.shain_number order by shainmst.hurigana asc";
	Newslist = News.getShain(sql);
	%>

<div id="con" class="uk-width-3-5 uk-container-center ">
	<table border="5"  class="uk-table uk-table-hover uk-width-1-1">
	<tr class="uk-text-large">
			<th Background="/staff_room/images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">ID</font></th>
			<th Background="/staff_room/images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">氏名</font></th>
			<th Background="/staff_room/images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
			<th nowrap Background="/staff_room/images/blackwhite1.png" class=" uk-width-1-10 uk-text-center"><font color="#FFFFFF">記事<br>未読件数</font></th>
			<th nowrap Background="/staff_room/images/blackwhite1.png" class=" uk-width-1-10 uk-text-center"><font color="#FFFFFF">緊急記事<br>未読件数</font></th>
		</tr>

		<%
		ShainDB primary = new ShainDB();
		NewsDAO nd = new NewsDAO();
		Connection con =primary.openShainDB();
		Statement stmt;
		for (int i = 0; i < Newslist.size(); i++) {
			HashMap<String, String> Newsmap = Newslist.get(i);
			String past_unread = Newsmap.get("read_check");
			String last_access = Newsmap.get("access_time");
			if(last_access.indexOf(".") != -1){
				last_access = last_access.substring(0, last_access.indexOf("."));
			}else{
				last_access = last_access.substring(0, last_access.indexOf("+"));
			}
			String result = null;
			// 最後にログインした時間よりも日付が新しい記事を取ってくるsql文
			String sql3 = "select news_id from news where created > ?";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql3);
				pstmt.setTimestamp(1, java.sql.Timestamp.valueOf(last_access));
				ResultSet rs2 = pstmt.executeQuery();
				StringBuilder builder = new StringBuilder();
				while(rs2.next()){
					builder.append(rs2.getString("news_id")).append(",");
					result =  builder.toString();
				}
				} catch (SQLException e) {
					System.out.println(e);
				}
			if(result != null){
				past_unread += result;
			}
			//String result = nd.getNewsFromLastLogin(last_access);
			//if(result != null){
			//	past_unread += result;
			//}
			if(past_unread.startsWith(",")){
				past_unread = past_unread.substring(1, past_unread.length());
			}
			String[] unread = past_unread.split(",");
			String sql_in = "";
			int primary_count = 0;
			for(int j = 0; j < unread.length; j++){
				if(j != unread.length - 1){
					sql_in += "'" + unread[j] + "',";
				}else{
					sql_in += "'" + unread[j] + "'";
				}

			}
			if(!sql_in.equals("''")){

				String sql2 = "select count(*) from news where news_id in (" + sql_in + ")" 
							+ " and primary_flag = '1'";

				try{
					stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql2);
					while(rs.next()){
						primary_count = rs.getInt("count");
					}
				}catch (SQLException e) {
					System.out.println(e);
				}
			}
			%>
		<tr>
			<td id = "na" bgcolor="#FFFFFF"><%=Newsmap.get("id")%></td>
			<td id = "na" bgcolor="#FFFFFF"><%=Newsmap.get("name")%></td>
			<td id = "na" bgcolor="#FFFFFF"><%=Newsmap.get("hurigana")%></td>
			<td align="right" id = "na" bgcolor="#FFFFFF">
				<% if(unread.length == 1 && unread[0].equals("")){ %>0
				<% }else{ %><%=unread.length%><% } %></td>
			<td align="right" id = "na" bgcolor="#FFFFFF"><%=primary_count%></td>
		</tr>
	<%
		}
		primary.closeShainDB(con);
	%>
	</table>
	<div id=button><a class="uk-button uk-button-primary" href="/staff_room/jsp/writeNews/writeNews.jsp" id="mail"> 管理・編集ページに戻る</a>
	</div>
	</div>
</body>
</html>