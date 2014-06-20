<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="code.jsp" %>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Arrays"%>
<%@ page import="org.apache.commons.codec.binary.StringUtils"%>

<%
	List<String> file_list = new ArrayList<String>();

	if(request.getParameter("inputFile") != "" && request.getParameter("inputFile") != null) {
		String file_str = String.valueOf(jpn2unicode(request.getParameter("inputFile"),"UTF-8"));
		file_list = Arrays.asList(file_str.split(","));
	}
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/upload.js"></script>
<script src="/staff_room/script/inputform.js"></script>
<title>入力フォーム</title>
<link rel="stylesheet" href="/staff_room/css/inputform.css">
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />
<br><br>
<form class="uk-form uk-form-horizontal" method="post" action="write_finish.jsp">
	<!-- 入力フォーム -->
	<div class="uk-width-medium-3-5 uk-container-center confirm">
		<div class="uk-h1 uk-text-center"><% if(request.getParameter("inputNewsid")==null){%>
			新規記事の作成
			<%}else{%>
			既存記事の編集
			<%}%>
		</div><br>
		<div class="uk-form-row">
			<label class="uk-form-label uk-text-bold uk-text-large">分類</label>
			<% if(request.getParameter("inputPostid")==null){%>
				<select name="inputPostid">
					<option value="1">総務</option>
					<option value="2">人事</option>
					<option value="3">行事</option>
					<option value="4">ビジネス推進室</option>
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
		<div class="uk-form-row" id="uploaded">
			<label class="uk-form-label uk-text-bold uk-text-large">添付</label>
			<div class="uk-form-file">
				<button class="uk-button">ファイルを選択</button>
				<input type="file" name="inputFile" id="upload-select" multiple>
				<div id="progressbar" class="uk-progress uk-hidden" style="width: 500px;">
    				<div class="uk-progress-bar" style="width: 0%;">...</div>
				</div>
			</div>
		</div>
		<div class="uk-form-row">
			<div class="uk-form-controls">
				<div id="loop">
					<% if(!file_list.isEmpty()) {
						for(int i = 0; i < file_list.size(); i++){ %>
						<div class="uk-alert">
							<a href="" class="uk-alert-close uk-close" data-uk-alert></a>
							<a href="/staff_room/upload/<%= file_list.get(i) %>"><%= file_list.get(i) %></a>
						</div>
					<% 	}
					}
					%>
				</div>
			</div>
		</div>
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
		<div class="uk-form-row">
			<label class="uk-form-label"></label>
			<% if(request.getParameter("inputPrimary") == null){ %>
				<input type="checkbox" name="inputPrimary" value="">
			<% }else if(request.getParameter("inputPrimary").equals("1")){ %>
				<input type="checkbox" name="inputPrimary" value="" checked>
			<% }else{ %>
				<input type="checkbox" name="inputPrimary" value="">
			<% } %>
			<label class="uk-text-bold uk-text-large">緊急</label>
		</div>
		<div class="uk-form-row">
			<label class="uk-form-label"></label>
			<div class="uk-width-3-4 uk-container-center uk-text-right">
				<button class="uk-button uk-button-large uk-button-primary" data-uk-toggle="{target:'.confirm'}">確認</button>
				<a href="/staff_room/jsp/writeNews/writeNews.jsp" class="uk-button uk-button-large uk-button-success uk-align-left">一覧へ</a>
			</div>
		</div>
	</div>
<br>
	<!-- 確認画面 -->
	<div class="uk-width-medium-3-5 uk-container-center confirm uk-hidden">
		<div class="uk-h1 uk-text-center">入力確認</div>
		<div class="uk-panel uk-panel-box">
			<div id="primary"></div>
			<p class="uk-text-danger uk-text-large uk-text-center" id="alert"></p>
			 <div class="uk-form-row">
			 	<label class="uk-form-label uk-text-bold uk-text-large">分類：</label>
			 	<div id="select" class="uk-form-label"></div>
			 </div>
			 <div class="uk-form-row">
			 	<label class="uk-form-label uk-text-bold uk-text-large">タイトル：</label>
			 	<div id="title" class="uk-form-label"></div>
			 </div>
			 <div class="uk-form-row">
			 	<label class="uk-form-label uk-text-bold uk-text-large">本文：</label>
			 	<div id="text" class="uk-form-label"></div>
			 </div>
			 <div class="uk-form-row">
			 	<label class="uk-form-label uk-text-bold uk-text-large">添付：</label>
			 	<div class="uk-form-label">
			 		<div class="uk-panel" id="file">
						<ul class="uk-list uk-list-line">
						</ul>
					</div>
			 	</div>
			 </div>
			 <div class="uk-form-row">
			 	<label class="uk-form-label uk-text-bold uk-text-large">保存者：</label>
				<div id="author" class="uk-form-label"></div>
			 </div>
			<div class="uk-form-row">
				<div class="uk-width-3-4 uk-container-center uk-text-right">
					<button class="uk-button uk-button-large uk-button-primary" data-uk-toggle="{target:'.confirm'}">戻る</button>
					<input class="uk-button uk-button-large uk-button-danger" type="submit" value="決定">
				</div>
			</div>
		</div>
	</div>
	<% if(request.getParameter("inputNewsid")!=null){ %>
	<input type="hidden" name="inputNewsid" value="<%= request.getParameter("inputNewsid") %>">
	<% } %>
	<% if(request.getParameter("inputFile") != "" && request.getParameter("inputFile") != null){ %>
	<input type="hidden" name="inputFiles" value="<%= jpn2unicode(request.getParameter("inputFile"),"UTF-8") %>">
	<% }else{ %>
	<input type="hidden" name="inputFiles" value="">
	<% } %>
</form>
</body>
</html>