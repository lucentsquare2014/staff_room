<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->

<%@ include file="code.jsp" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<title>入力確認</title>
</head>
<body>
	<h1>入力確認</h1>

<%if(request.getParameter("inputTitle")==""||request.getParameter("inputText")==""){ %>
	エラー！<br>
	タイトルと本文は必ず入力してください！
	<%}%>
	<!-- 入力フォーム データ→確認画面-->


		<table border="1">
			<tr>
				<th>分類</th>
				<td>
				<%String [] POST = new String []{"総務","人事","行事","開発","その他"};%>
				<%=POST[Integer.parseInt(request.getParameter("inputPostid"))-1]%>
				</td>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><%= jpn2unicode(request.getParameter("inputTitle"),"UTF-8") %></td>
			</tr>
			<tr>
				<th>本文</th>
				<td>
				<pre><%= jpn2unicode(request.getParameter("inputText"),"UTF-8") %></pre>
				</td>
			</tr>

			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" disabled>
				<%= jpn2unicode(request.getParameter("inputFile"),"UTF-8") %>
				</td>
		</tr>
		-->

			<tr>
				<th>保存者</th>
				<td><%= jpn2unicode(request.getParameter("inputWriter"),"UTF-8") %></td>
			</tr>
			</table>

			<!-- 決定ボタン   入力・編集フォームから渡されたデータ→write_finish.jsp-->
	<%if(request.getParameter("inputTitle")!=""||request.getParameter("inputText")!=""){ %>
	<form method="POST" action="	write_finish.jsp">

		<!-- 管理編集画面→編集フォーム→確認画面と渡されたnews_idを渡すnewsWrite.jsp-->

		<input type="hidden" name="inputNewsid"
			value="<%=request.getParameter("inputNewsid")%>">

		<input type="hidden" name="inputPostid"
			value="<%=request.getParameter("inputPostid")%>">

		<input type="hidden" name="inputTitle"
			value="<%=jpn2unicode(request.getParameter("inputTitle"), "UTF-8")%>">

		<input type="hidden" name="inputText"
			value="<%=jpn2unicode(request.getParameter("inputText"), "UTF-8")%>">

		<!-- 添付ファイル いったん保留
		<input type="hidden" name="inputFile"
			value="<%=jpn2unicode(request.getParameter("inputFile"), "UTF-8")%>">
		-->

		<input type="hidden" name="inputWriter"
			value="<%=jpn2unicode(request.getParameter("inputWriter"), "UTF-8")%>">

		<input type="submit" value="決定">
	</form>
	<%}%>

	<%-- 内容を編集するボタン 入力・編集フォームから渡されたデータ→updateForm.jsp--%>
	<form method="POST" action="updateForm.jsp">

		<input type="hidden" name="inputNewsid"
			value="<%=request.getParameter("inputNewsid")%>">


		<input type="hidden" name="inputPostid"
			value="<%=request.getParameter("inputPostid")%>">

		<%
			if (request.getParameter("inputTitle") !="") {
		%>
		<input type="hidden" name="inputTitle"
			value="<%=jpn2unicode(request.getParameter("inputTitle"),"UTF-8")%>">
		<%
			}
		%>
		<%
			if (request.getParameter("inputText") !="") {
		%>
		<input type="hidden" name="inputText"
			value="<%=jpn2unicode(request.getParameter("inputText"),"UTF-8")%>">
		<%
			}
		%>

		<%--  添付ファイル いったん保留
		<%if (request.getParameter("inputFile") != null) {%>
		<input type="hidden" name="inputFile"
			value="jpn2unicode(<%=request.getParameter("inputFile")UTF-8")%>">
			<%}%>
		--%>

		<%
			if (request.getParameter("inputWriter") != "") {
		%>
		<input type="hidden" name="inputWriter"
			value="<%=jpn2unicode(request.getParameter("inputWriter"),"UTF-8")%>">
		<%
			}
		%>

		<input type="submit" value="内容を編集する">
	</form>

</body>
</html>