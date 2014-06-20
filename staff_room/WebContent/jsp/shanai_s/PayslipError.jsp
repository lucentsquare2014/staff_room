<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
	String id2 = (String)session.getAttribute("key");
	if(id2 != null ? id2.equals("鍵") : false){	
%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<STYLE type="text/css">
td {
	text-align: center;
}

a.menu {
	float: right;
	font-size: small;
	text-decoration: none;
}

p {
	font-size: 25px;
}
</STYLE>
<%
	String error = (String) session.getAttribute("error");
	String errorDiscription = (String) session.getAttribute("errorDescription");
	Exception e = (Exception) session.getAttribute("exception");
	session.removeAttribute("error");
	session.removeAttribute("errorDescription");
	session.removeAttribute("exception");
	// リンク用文字列
	String kintai_login = "/staff_room";
%>
<title></title>
</head>
<body>
	<center>
		<div class="main">

			<table class="main">
				<tbody>
					<tr>
						<td>
							<%
								
								out.println("<font class=title>" + error + "</font>");
								//StackTraceElement[] ste = e.getStackTrace();
							%>
						</td>
					</tr>
					<tr>
						<td>
							<p>
								<%
								if (errorDiscription != null){
									out.println(errorDiscription);
								}
								%>
							</p>
						</td>
					</tr>

					<tr>
						<td class=b>
							<div class=return_menu>
								
								<a class=menu href="<%=kintai_login%>">[スタッフルームに戻る]</a>
							</div>
						</td>
					</tr>

				</tbody>
			</table>

		</div>
	</center>
</body>

</html>
<%}%>