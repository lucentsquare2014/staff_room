<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html" />
<link rel="stylesheet" href="/staff_room/css/readCheck_data.css">
<%@ page import="dao.ShainDB,
				java.util.ArrayList,
				java.sql.Connection,
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
	String sql = "select shainmst.id,shainmst.name,shainmst.hurigana,shainkanri.read_check from shainmst,shainkanri where shainmst.number = shainkanri.shain_number order by shainmst.hurigana asc";
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
		Connection con =primary.openShainDB();
		Statement stmt;
		for (int i = 0; i < Newslist.size(); i++) {
			HashMap<String, String> Newsmap = Newslist.get(i);
			String[] unread = Newsmap.get("read_check").split(",");
			String sql_in = "";
			int primary_count = 0;
			for(int j = 0; j < unread.length; j++){
				if(j != unread.length - 1){
					sql_in += "'" + unread[j] + "',";
				}else{
					sql_in += "'" + unread[j] + "'";
				}

			}
			if(!sql_in.equals("")){

				String sql2 = "select count(*) from news where news_id in (" +sql_in+ ")" + " and primary_flag = '1'";

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
			<td align="right" id = "na" bgcolor="#FFFFFF"><%=unread.length%>
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