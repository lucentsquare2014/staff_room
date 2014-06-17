<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="dao.NewsDAO,
				java.util.ArrayList,
				java.util.HashMap,
				org.apache.commons.lang3.StringEscapeUtils"
%>
<html>
<head>
	<jsp:include page="/html/head.html" />
	<title>メール</title>
	<script src="/staff_room/script/MailCheckbox.js"></script>
	<link rel="stylesheet" href="/staff_room/css/mail.css">
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
		
	<div id="con" class="uk-width-1-1 uk-container-center ">
		<table border="5" bordercolorlight="#000000" bordercolordark="#696969" class="uk-table uk-table-hover uk-width-3-5">
			<tr class="uk-text-large">
				<th Background="../../images/blackwhite1.png" class=" uk-text-center "><font color="#FFFFFF"></font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-1-4 uk-text-center"><font color="#FFFFFF">氏名</font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
				<th Background="../../images/blackwhite1.png" class=" uk-width-11-20 uk-text-center"><font color="#FFFFFF">メールアドレス</font></th>
			</tr>
		<%
		ArrayList<Integer> x = new ArrayList<Integer>();
		Mail.GetShainDB Mail = new Mail.GetShainDB();
		ArrayList<HashMap<String, String>> Maillist = null;
		String sql = "select id,name,mail,hurigana from shainmst where zaiseki_flg='1' order by hurigana asc";
		Maillist = Mail.getShain(sql);
		
		for (int i = 0; i < Maillist.size(); i++) {
			HashMap<String, String> Mailmap = Maillist.get(i);
			String str1 = Mailmap.get("mail");
    		int index = str1.indexOf("@");
    		String str2 = Mailmap.get("id");
            int inde = str2.indexOf("-");
            String moji = str2.substring(inde+1);
            System.out.println(moji.substring(0,1));
            
            if(!Mailmap.get("hurigana").equals("")){
                %>
       			<tr id="<%=moji.substring(0,1)%>">
       				<td bgcolor="#FFFFFF"><a flag="0"
       				class="uk-icon-square-o uk-text-center delete-box"
       				name="check" id="<%=str1.substring(0,index)%>"></a></td>
       				<td id = "na" bgcolor="#FFFFFF"><%=Mailmap.get("name")%></td>
       				<td id = "na" bgcolor="#FFFFFF"><%=Mailmap.get("hurigana")%></td>
       				<td id = "na" bgcolor="#FFFFFF"><a href="mailto:<%=Mailmap.get("mail")%>"><%=Mailmap.get("mail")%></a></td>
       			</tr>
       		<%}}%>
         
		</table>
		<div id=button>
		<div id=button-con>
		<a class="uk-button uk-button-primary" href="mailto:" id="mail"> メール作成</a>
			<ul>
				<li>
					<a class="uk-button" href="#a">ア</a>
					<a class="uk-button" href="#h">ハ</a>
				</li>
				<li>
					<a class="uk-button" href="#k">カ</a>
					<a class="uk-button" href="#m">マ</a>
				</li>
				<li>
					<a class="uk-button" href="#s">サ</a>
					<a class="uk-button" href="#y">ヤ</a>
				</li>
				<li>
					<a class="uk-button" href="#t">タ</a>
					<a class="uk-button" href="#r">ラ</a>
				</li>
				<li>
					<a class="uk-button" href="#n">ナ</a>
					<a class="uk-button" href="#w">ワ</a>
				</li>
			</ul>
			<a class="uk-button uk-button-primary" href="mailto:all@lucentsquare.co.jp;" id="mail"> 全社員へメール</a>
			<a class="uk-button uk-button-primary" href="/staff_room/jsp/writeNews/copy_writeNews.jsp" > 管理・編集ページへ戻る</a>
			
			
		</div><div id="tyu">（注）outlook起動後、メールアドレスの読み込みまで少し時間がかかります。</div>
		</div>
	</div>
</body>
</html>