<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="dao.AccessDB,
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
	<link rel="stylesheet" href="/staff_room/css/mail.css">
<%
		String value = null;
		value = request.getParameter("mmail");
		if(value==null){value = "0";}%>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div id="con" class="uk-width-1-1 uk-container-center ">
		<div id="come">
			<%if(value.equals("1")){%>
				<a class="uk-button uk-button-success" href="/staff_room/jsp/writeNews/writeNews.jsp">管理編集ページに戻る</a>
				<div>※「未読」には全記事の中から、未読の件数を表示します。<br> 　&nbsp;「緊急」には緊急とされた記事の中から、未読の件数を表示します。</div>
			<%}%><%else{%>
			<div class="uk-text-bold" style="float:left;margin-left:120px;">一度に選択できるのは70名までです。<br>全社員宛てのメールならば、作成することができます。全てにチェックを入れ、メール作成をして下さい。</div>
			<%}%>
			</div>
		<div id="out_Div">
		<div id=button>
		<div id=button-con>
		<a class="uk-button uk-button-primary" id="mail" style="white-space:nowrap;"> メール作成</a>
		<a class="uk-button uk-button-primary" id="all_check" style="white-space:nowrap;">&nbsp;&nbsp;全選択&nbsp;</a>
		<a class="uk-button uk-button-danger" id="clear" style="white-space:nowrap;"> 選択解除</a>
			<ul>
				<li>
					<a class="uk-button" href="#a" style="white-space:nowrap;">ア</a>
					<a class="uk-button" href="#h">ハ</a>
				</li>
				<li>
					<a class="uk-button" href="#k" style="white-space:nowrap;">カ</a>
					<a class="uk-button" href="#m">マ</a>
				</li>
				<li>
					<a class="uk-button" href="#s" style="white-space:nowrap;">サ</a>
					<a class="uk-button" href="#y">ヤ</a>
				</li>
				<li>
					<a class="uk-button" href="#t" style="white-space:nowrap;">タ</a>
					<a class="uk-button" href="#r">ラ</a>
				</li>
				<li>
					<a class="uk-button" href="#n" style="white-space:nowrap;">ナ</a>
					<a class="uk-button" href="#w">ワ</a>
				</li>
			</ul>


		</div>
		<div id="tyu">(注)outlook起動後、メールアドレスの読み込みまで少し時間がかかります。</div></div>
		<div id="in_Div">
		<table border="1" class="uk-table uk-width-medium-1-1">
		<thead>
			<tr class="uk-text-large">
				<%if(value.equals("1")){%>
				<th  class="coL1  uk-text-center" style="padding: 4px;"><font color="#FFFFFF"></font></th>
				<th  class="coL2  uk-text-center"><font color="#FFFFFF">氏名</font></th>
				<th  class="coL3  uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
				<th  class="coL4  uk-text-left"><font color="#FFFFFF">　　　メールアドレス</font></th>
				<th  class="coL5 uk-text-center"><font color="#FFFFFF">未読</font></th>
			    <th  class="coL5 uk-text-center"><font color="#FFFFFF">緊急</font></th>
			    <th  class="coL6 uk-text-center "><font color="#FFFFFF"></font></th>
			    <%} else {%>
				<th  class="coL1  uk-text-center" style="padding: 4px;"><font color="#FFFFFF"></font></th>
				<th  class="coL2  uk-text-center"><font color="#FFFFFF">氏名</font></th>
				<th  class="coL3  uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
				<th  class="coL4  uk-text-left"><font color="#FFFFFF">　　　メールアドレス</font></th>
				<th  class="coL6 uk-text-center "><font color="#FFFFFF"></font></th>
			    <%} %>
			</tr>
		</thead>
<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetMail mails = new Mail.GetMail();
	ArrayList<HashMap<String, String>> Maillist = null;
	String sql = "select shainmst.id,shainmst.mail,shainmst.name,shainmst.hurigana,shainkanri.read_check,shainkanri.access_time" +
				" from shainmst,shainkanri where shainmst.number = shainkanri.shain_number and shainmst.zaiseki_flg="
				+"'"
				+"1"
				+"'"
				+"order by shainmst.hurigana asc";
	Maillist = mails.getShainMail(sql);
	AccessDB access = new AccessDB();
	Connection con = access.openDB();
	Statement stmt;
	for (int i = 0; i < Maillist.size(); i++) {
		HashMap<String, String> Newsmap = Maillist.get(i);
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
%>

       			<tr id="<%=moji.substring(0,1)%>">
       				<td class="coL1 uk-text-center" style="padding: 4px;">
       					<input type="checkbox" name="check" id="<%=str1.substring(0,index)%>">
       				</td>
       				<td class="coL2" ><%=Newsmap.get("name")%></td>
       				<td class="coL3"><%=Newsmap.get("hurigana")%></td>
       				<td class="coL4" id="address"><a href="mailto:<%=Newsmap.get("mail")%>"><%=Newsmap.get("mail")%></a></td>
       				<%if(value.equals("1")){%>
       				<td align="right" class="coL5"><font>
					<%if(unread.length == 1 && unread[0].equals("")){%>
					<%}else{%><%=unread.length%><%}%></font></td>
					<td align="right" class="coL5"><font><%=primary_count%></font></td><%} %>
       			</tr>
<%
	}
    access.closeDB(con);
%>
		</table>
		</div></div>
	</div>
</body>
</html>