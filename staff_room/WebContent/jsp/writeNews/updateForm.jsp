<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="code.jsp" %>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<%@ page import="org.apache.commons.codec.binary.StringUtils"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/html/head.html" />
<title>入力フォーム</title>
<style type="text/css">
	body {
		background-image: url("/staff_room/images/input.png");
	}
	label {
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<br><br><br><br>
	<div class="uk-width-medium-3-5 uk-container-center">
		<div class="uk-h1 uk-text-center"><% if(request.getParameter("inputNewsid")==null){%>
			新規記事の作成
			<%}else{%>
			既存記事の編集
			<%}%>
		</div><br>

	<!-- 入力フォーム データ→確認画面-->

	<form class="uk-form uk-form-horizontal" method="POST" action="inputCheck.jsp">
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">分類</label>
			<% if(request.getParameter("inputPostid")==null){%>
				<select name="inputPostid">
					<option value="1">総務</option>
					<option value="2">人事</option>
					<option value="3">行事</option>
					<option value="4">開発</option>
					<option value="5">その他</option>
				</select>
			<% } else { %>
				<select name="inputPostid">
					<option value="1"
						<%if (request.getParameter("inputPostid").equals("1") ){%> selected
						<%}%>>総務</option>
					<option value="2"
						<%if (request.getParameter("inputPostid").equals("2")) {%> selected
						<%}%>>人事</option>
					<option value="3"
						<%if (request.getParameter("inputPostid").equals("3")) {%> selected
						<%}%>>行事</option>
					<option value="4"
						<%if (request.getParameter("inputPostid").equals("4")) {%> selected
						<%}%>>開発</option>
					<option value="5"
						<%if (request.getParameter("inputPostid").equals("5")) {%> selected
						<%}%>>その他</option>
				</select>
			<% } %>
		</div>
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">タイトル</label>
			<input class="uk-form-width-medium" type="text" name="inputTitle"
			<% 
				if(request.getParameter("inputTitle")!=null){
					String title = jpn2unicode(request.getParameter("inputTitle"),"UTF-8");
					out.print("value=\"" + title + "\"");
				}
			%>
			>
		</div>
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">本文</label>
			<% if(request.getParameter("inputText")==null){ %>
				<textarea class="uk-form-width-large" rows="10" name="inputText"></textarea>
			<% } else { %>
				<textarea class="uk-form-width-large" rows="10" name="inputText"><%= jpn2unicode(request.getParameter("inputText"),"UTF-8")%></textarea>
			<% } %>
		</div>
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">添付</label>
			<input type="text" disabled>
			<div class="uk-form-file">
				<button class="uk-button">ファイルを選択</button>
				<input type="file" name="inputFile">
			</div>
		</div>
			<!-- 添付ファイル いったん保留
				<%= jpn2unicode(request.getParameter("file"),"UTF-8") %>
			-->
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">保存者</label>
			<input type="text" name="inputWriter"
			<% if(request.getParameter("inputWriter")!=null){
				String author = jpn2unicode(request.getParameter("inputWriter"),"UTF-8");
				out.print("value=\"" + author + "\"");
			}
			%>
			>
		</div>	

	<!-- 管理編集画面から渡されたinputNewsidをinputCheck.jspへ渡す -->
		<div class="uk-form-row">
			<% if(request.getParameter("inputNewsid")!=null){ %>
			<input type="hidden" name="inputNewsid" value="<%=request.getParameter("inputNewsid") %>">
			<% } %>
			<div class="uk-width-3-4 uk-container-center uk-text-right">
				<input class="uk-button uk-button-large uk-button-danger" type="submit" value="確認">
			</div>
		</div>
	</form>
	</div>
</body>
</html>