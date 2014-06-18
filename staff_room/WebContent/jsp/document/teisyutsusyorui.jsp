<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<% String user = String.valueOf(session.getAttribute("admin")); %>
<%
	File doc_folder = new File(application.getRealPath(File.separator + "Docs"));
	if(!doc_folder.exists()){
		doc_folder.mkdirs();
	}
	String folders[] = doc_folder.list();
%>
<html>
<head>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/document.js"></script>
<script type="text/javascript" src="/staff_room/script/notifIt.js"></script>
<link rel="stylesheet" type="text/css" href="/staff_room/css/notifIt.css">
 <style>
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/shinseisyorui01.jpg");
	background-size: 100% 100%;
}
#select_files {
	display:none;
}
</style>
<title>申請書類</title>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />

<div class="changelog" style="padding-top: 40px; white-space:nowrap;">
<div class="uk-width-3-5 uk-container-center">
<br>
	<!--------------  管理者用　 ----------------->　
	<% if(user.equals("1")){ %>
	<div class="uk-grid">
		<div class="uk-width-1-4 uk-text-left">
			<button id="delete" class="uk-button uk-button-danger" disabled="disabled">
			<i class="uk-icon-trash-o uk-icon-small"></i><b>　削除</b></button>
		</div>
		<div class="uk-width-3-4 uk-text-right">
		<form class="uk-form" action="/staff_room/document" enctype="multipart/form-data" method="post">
			<select name="category">
			<% if(folders.length == 0) %><option value="デフォルト">デフォルト</option>
			<%
				for(int i = 0; i < folders.length; i++){
			%>
				<option value="<%= folders[i] %>"><%= folders[i] %></option>
			<% } %>
			</select>
			<input type="hidden" name="page" value="Docs">
			<div class="uk-form-file">
				<button class="uk-button uk-button-success">
				<i class="uk-icon-file-text uk-icon-small"></i><b>　添付</b></button>
				<input type="file" name="inputFile" id="upload-select" multiple>
				<div id="progressbar" class="uk-progress uk-hidden" style="width: 500px;">
    				<div class="uk-progress-bar" style="width: 0%;">...</div>
				</div>
			</div>
			<button id="add" class="uk-button uk-button-primary" disabled>
			<i class="uk-icon-upload uk-icon-small"></i><b>　追加</b></button>
		</form>
		</div>
	</div>
	<div class="uk-width-1-2 uk-align-right" id="select_files">
		<br>
		<div class="uk-panel">
			<ul class="uk-list uk-list-line">
			</ul>
		</div>
	</div>
	<table border="5" class="uk-table uk-table-hover uk-width-1-1">
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-text-center"><font color="#FFFFFF">　　</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-6-10 uk-text-center"><font color="#FFFFFF">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
<% }else{ //-----------一般利用者の申請書類ページ----------%>
	<table border="5" class="uk-table uk-table-hover uk-width-1-1">
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-6-10 uk-text-center"><font color="#FFFFFF">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>
	</table>
<% } %>　　　　　　
	</div>
	<br><br>
</div>
</body>
</html>
