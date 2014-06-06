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
<style type="text/css">
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/mail4.jpg");
	background-size: 100% auto;
}
</style>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br><br><br>
<%--チェックボックス部 --%>


<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB Mail = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Maillist = null;
	String sql = "select id,name,mail,hurigana from shainmst where zaiseki_flg='1' order by hurigana asc";
	Maillist = Mail.getShain(sql);%>

<div class="uk-width-2-3 uk-container-center uk-text-center">
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-width-1-1">
	<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-text-center"><font color="#FFFFFF"></font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#FFFFFF">氏名</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-4-10 uk-text-center"><font color="#FFFFFF">メールアドレス</font></th>
		</tr>
		<%
		//ホントノヤツfor (int i = 0; i < Maillist.size(); i++) {
						for (int i = 0; i < 20; i++) {
			HashMap<String, String> Mailmap = Maillist.get(i);%>


		<tr>
			<td bgcolor="#FFFFFF"><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="<%=Mailmap.get("id")%>"></a></td>
			<td bgcolor="#FFFFFF"><%=Mailmap.get("name")%></td>
			<td bgcolor="#FFFFFF"><%=Mailmap.get("hurigana")%></td>
			<td bgcolor="#FFFFFF"><%=Mailmap.get("mail")%></td>
		</tr>
	<%}%>
	</table>

<a class="uk-button uk-button-primary" href="mailto:" id="mail"> メール作成</a>
</div>
<br><br>
<%--/チェックボックス部 --%>

<script>
	$(function() {

		$(document).ready(
				function() {
					/* チェックボックスにチェックがついたかを判別する */
					$('[name="check"]').click(
							function() {
								var checkbox = $("#" + $(this).attr("id"));
								if (checkbox.attr("flag") === "0") {
									checkbox.attr("flag", "1");
									$("#" + checkbox.attr("id")).attr("class",
											"uk-icon-check-square-o");
								} else {
									checkbox.attr("flag", "0");
									$("#" + checkbox.attr("id")).attr("class",
											"uk-icon-square-o");
								}
							});
					$("#mail").click(function() {
						var str = "";
						var ids = [];
						var news = $('[name="check"]');
						for ( var n = 0; n < news.length; n++) {
							if (news[n].getAttribute("flag") == "1")
								ids.push(news[n].getAttribute("id"));
						}
						for ( var i = 0; i < ids.length; i++) {
							if (str != "")
								str = str + "";
							str = str + ids[i] +"@lucentsquare.co.jp;";
						}
						$("#mail").attr("href", "mailto:" + str);

					});

				});
	});
</script>
</body>
</html>