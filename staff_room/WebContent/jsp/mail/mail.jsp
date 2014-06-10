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
	height: 100%;
	background-attachment: fixed;
	background-image: url("/staff_room/images/mail5.jpg");
	background-size: 100% 100%;
}
div#con{position: fixed;
	top: 42px;
	overflow-y: scroll;
	max-width:100%;
	max-height: 88%;
	white-space: nowrap;
}
td#na {
padding-left:20px;
}
div#button{
position:fixed;
top:30%;
left:5%;}
.uk-table {width:55%;
		   margin-right:auto;
		   margin-left:auto;
		   margin-top:5%;
		   }
div#button ul{margin-top:20px;
  			  padding-left:0px}
div#button ul>li{list-style-type: none;}
div#button ul>li>a{width:50px;
text-align:center;}

</style>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<div id=button>
<a class="uk-button uk-button-primary" href="mailto:" id="mail"> メール作成</a>
<ul>
<li><a class="uk-button" href="#a">ア</a>
<a class="uk-button" href="#k">カ</a></li>
<li><a class="uk-button" href="#s">サ</a>
<a class="uk-button" href="#t">タ</a></li>
<li><a class="uk-button" href="#n">ナ</a>
<a class="uk-button" href="#h">ハ</a></li>
<li><a class="uk-button" href="#m">マ</a>
<a class="uk-button" href="#y">ヤ</a></li>
<li><a class="uk-button" href="#r">ラ</a>
<a class="uk-button" href="#w">ワ</a></li>
</ul>
</div>
<%--チェックボックス部 --%>

<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB Mail = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Maillist = null;
	String sql = "select id,name,mail,hurigana from shainmst where zaiseki_flg='1' order by hurigana asc";
	Maillist = Mail.getShain(sql);%>

<div id="con" class="uk-width-1-1 uk-container-center ">
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-width-3-5">
	<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-text-center "><font color="#FFFFFF"></font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-1-4 uk-text-center"><font color="#FFFFFF">氏名</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#FFFFFF">フリガナ</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-11-20 uk-text-center"><font color="#FFFFFF">メールアドレス</font></th>
		</tr>
		
		<%
		for (int i = 0; i < Maillist.size(); i++) {
			HashMap<String, String> Mailmap = Maillist.get(i);
			String str1 = Mailmap.get("mail");
    		int index = str1.indexOf("@");
    		String str2 = Mailmap.get("id");
            int inde = str2.indexOf("-");
            String moji = str2.substring(inde+1);
            System.out.println(moji.substring(0,1));%>


		<tr id="<%=moji.substring(0,1)%>">
			<td bgcolor="#FFFFFF"><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="<%=str1.substring(0,index)%>"></a></td>
			<td id = "na" bgcolor="#FFFFFF"><%=Mailmap.get("name")%></td>
			<td id = "na" bgcolor="#FFFFFF"><%=Mailmap.get("hurigana")%></td>
			<td id = "na" bgcolor="#FFFFFF"><a href="mailto:<%=Mailmap.get("mail")%>"><%=Mailmap.get("mail")%></a></td>
		</tr>
	<%}%>
	</table>
	<div id=button>
<a class="uk-button uk-button-primary" href="mailto:" id="mail"> メール作成</a>
<ul>
<li><a class="uk-button" href="#a">ア</a>
<a class="uk-button" href="#k">カ</a></li>
<li><a class="uk-button" href="#s">サ</a>
<a class="uk-button" href="#t">タ</a></li>
<li><a class="uk-button" href="#n">ナ</a>
<a class="uk-button" href="#h">ハ</a></li>
<li><a class="uk-button" href="#m">マ</a>
<a class="uk-button" href="#y">ヤ</a></li>
<li><a class="uk-button" href="#r">ラ</a>
<a class="uk-button" href="#w">ワ</a></li>
</ul>
</div>
</div>

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