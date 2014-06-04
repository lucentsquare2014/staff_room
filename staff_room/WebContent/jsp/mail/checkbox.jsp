<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html" />
</head>

<%--チェックボックス部 --%>

<table>
	<tr>
		<td>高麗和穂</td>
		<td><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="k-kouma"></a></td>
	</tr>
	<tr>
		<td>川橋和之</td>
		<td><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="k-kawahashi"></a></td>
	</tr>
	<tr>
		<td>野島大地</td>
		<td><a flag="0"
			class="uk-icon-square-o uk-text-center delete-box"
			name="check" id="d-nojima"></a></td>
	</tr>
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