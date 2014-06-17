<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% //String user = String.valueOf(session.getAttribute("admin")); %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<html>
<head>
	<jsp:include page="/html/head.html" />
	<title>メール</title>
	<script src="/staff_room/script/MailCheckbox.js"></script>
	<link rel="stylesheet" href="/staff_room/css/copy_mail.css">
	<script>
function side(){
	var w = $(window).width();
	if(w <= 700){
		$("#button").hide();
		$("#hide").show();
	}
	if(w > 700){
		$("#button").show();
		$("#hide").hide();
	}
}
$(function(){
	side();
});
$(window).resize(function(){
	side();
});
</script>
<%
		String value = null;
		value = request.getParameter("mmail");
		if(value==null){value = "0";}%>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
		
	<div id="con" class="uk-width-1-1 uk-container-center ">
		<% //if(user.equals("1")){ %> 
		<%if(value.equals("1")){%>
			<div id="come">
				※「記事未読件数」には全記事の中で、未読の総数を表示します。<br> 「緊急記事未読件数」には緊急とされた記事の中で、未読の総数を表示します。
				<a class="uk-button uk-button-success" href="/staff_room/jsp/writeNews/writeNews.jsp" style="float:right;">管理編集ページに戻る</a>
			</div><%}%>
			
		<div id="hide">
		<a class="uk-button uk-button-primary" href="mailto:" id="mail">作成</a>
			<ul>
				<li><a class="uk-button " href="#a">ア</a></li>
				<li><a class="uk-button " href="#k">カ</a></li>
				<li><a class="uk-button " href="#s">サ</a></li>
				<li><a class="uk-button " href="#t">タ</a></li>
				<li><a class="uk-button " href="#n">ナ</a></li>
				<li><a class="uk-button " href="#h">ハ</a></li>
				<li><a class="uk-button " href="#m">マ</a></li>
				<li><a class="uk-button " href="#y">ヤ</a></li>
				<li><a class="uk-button " href="#r">ラ</a></li>				
				<li><a class="uk-button " href="#w">ワ</a></li>
			</ul>
		</div>
		<table border="5" bordercolorlight="#000000" bordercolordark="#696969" class="uk-table uk-width-3-5">
			<tr class="uk-text-large">
				<th Background="../../images/blackwhite1.png" class=" uk-text-center "><font color="#FFFFFF"></font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-1-4 uk-text-center"><font color="#FFFFFF">氏名</font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-11-20 uk-text-center"><font color="#FFFFFF">メールアドレス</font></th>
				<% //if(user.equals("1")){ %>
				<%if(value.equals("1")){%>
				<th nowrap Background="/staff_room/images/blackwhite1.png" class=" uk-width-1-4 uk-text-center"><font color="#FFFFFF">記事<br>未読件数</font></th>
			    <th nowrap Background="/staff_room/images/blackwhite1.png" class=" uk-width-1-4 uk-text-center"><font color="#FFFFFF">緊急記事<br>未読件数</font></th>
			    <%} %>
			</tr>
		<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB News = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Newslist = null;
	String sql = "select shainmst.id,shainmst.mail,shainmst.name,shainmst.hurigana,shainkanri.read_check,shainkanri.access_time" +
				" from shainmst,shainkanri where shainmst.number = shainkanri.shain_number and shainmst.zaiseki_flg="
				+"'"
				+"1"
				+"'"
				+"order by shainmst.hurigana asc";
	System.out.println(sql);
	Newslist = News.getShain(sql);
		
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
			String str1 = Newsmap.get("mail");
    		int index = str1.indexOf("@");
    		String str2 = Newsmap.get("id");
            int inde = str2.indexOf("-");
            String moji = str2.substring(inde+1);
            System.out.println(moji.substring(0,1));
                %>
       			<tr id="<%=moji.substring(0,1)%>">
       				<td ><a flag="0"
       				class="uk-icon-square-o uk-text-center delete-box"
       				name="check" id="<%=str1.substring(0,index)%>"></a></td>
       				<td id = "na" ><%=Newsmap.get("name")%></td>
       				<td id = "na"><%=Newsmap.get("hurigana")%></td>
       				<td id = "na"><a href="mailto:<%=Newsmap.get("mail")%>"><%=Newsmap.get("mail")%></a></td>
       				<% //if(user.equals("1")){ %>
       				<%if(value.equals("1")){%>
       				<td align="right" id = "na">
					<% if(unread.length == 1 && unread[0].equals("")){ %>0
					<% }else{ %><%=unread.length%><% } %></td>
					<td align="right" id = "na"><%=primary_count%></td><%} %>
       			</tr>
       		<%}%>
         
		</table>
		<br><br><br><br><br><br><br><br><br>
		<div id=button>
		<div id=button-con>
		<a class="uk-button uk-button-primary" href="mailto:" id="mail" style="white-space:nowrap;margin-left:10px"> メール作成</a>
			<ul>
				<li>
					<a class="uk-button" href="#a" style="white-space:nowrap;margin-left:13px">ア</a>
					<a class="uk-button" href="#h">ハ</a>
				</li>
				<li>
					<a class="uk-button" href="#k" style="white-space:nowrap;margin-left:13px">カ</a>
					<a class="uk-button" href="#m">マ</a>
				</li>
				<li>
					<a class="uk-button" href="#s" style="white-space:nowrap;margin-left:13px">サ</a>
					<a class="uk-button" href="#y">ヤ</a>
				</li>
				<li>
					<a class="uk-button" href="#t" style="white-space:nowrap;margin-left:13px">タ</a>
					<a class="uk-button" href="#r">ラ</a>
				</li>
				<li>
					<a class="uk-button" href="#n" style="white-space:nowrap;margin-left:13px">ナ</a>
					<a class="uk-button" href="#w">ワ</a>
				</li>
			</ul>
			
			
		</div>
		<%if(value.equals("1")){%><a class="uk-button uk-button-primary" href="mailto:all@lucentsquare.co.jp;" id="mail" style="white-space:nowrap;margin-left:2px"> 全社員へメール</a><%} %>
		<div id="tyu">(注)outlook起動後、メールアドレスの読み込みまで少し時間がかかります。</div>
		</div>
	</div>
</body>
</html>