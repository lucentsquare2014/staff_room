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
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br><br><br>
<%--チェックボックス部 --%>


<%
	ArrayList<Integer> x = new ArrayList<Integer>();
	Mail.GetShainDB Mail = new Mail.GetShainDB();
	ArrayList<HashMap<String, String>> Maillist = null;
	String sql = "select id,name,mail from shainmst where zaiseki_flg='1' order by name desc";
	Maillist = Mail.getShain(sql);
	
	for (int i = 0; i < Maillist.size(); i++) {
			HashMap<String, String> Mailmap = Maillist.get(i);
%>
<table>
	<tr>
		<td><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="<%=Mailmap.get("id")%>"></a></td>
			<td><%=Mailmap.get("name")%></td>
			<%-- <td><%=Mailmap.get("hurigana")%></td>--%>
			<td><%=Mailmap.get("mail")%></td>
	</tr>
	<%}%>
</table>
<a href="mailto:" id="mail"> 確定</a>

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