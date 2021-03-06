<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.File" %>
<% String user = String.valueOf(session.getAttribute("admin")); %>
<%
	File doc_folder = new File(application.getRealPath(File.separator + "manual"));
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
<link rel="stylesheet" type="text/css" href="/staff_room/css/document.css">
<link rel="stylesheet" href="/staff_room/css/jquery.mCustomScrollbar.css">
<script src="/staff_room/script/jquery.mCustomScrollbar.js"></script>
<title>組織表/規程</title>
</head>
<body class="manual">
<jsp:include page="/jsp/header/header.jsp" />

<div class="changelog uk-container-center" style="padding-top: 40px; width:820px;">
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
			<input type="hidden" name="page" value="manual">
			<div class="uk-form-file">
				<button class="uk-button uk-button-success">
				<i class="uk-icon-file-text uk-icon-small"></i><b>　添付</b></button>
				<input type="file" name="inputFile" id="upload-select" multiple>
			</div>
			<button id="add" class="uk-button uk-button-primary" disabled>
			<i class="uk-icon-upload uk-icon-small"></i><b>　追加</b></button>
		</form>
		</div>
	</div>
	<div id="select_files">
		<div class="uk-panel">
			<a href="" class="uk-close uk-align-right"></a>
			<p class="uk-text-primary uk-text-bold">以下のファイルをアップロードします：</p>
			<div class="content">
				<ul class="uk-list uk-list-line">
				</ul>
			</div>
		</div>
	</div>
	<div id="out_Div"><div id="in_Div">
	<table border="1" class="uk-table uk-width-1-1" >
	<thead>
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" style="width:27px;" class="uk-text-center"><font color="#FFFFFF"></font></th>
			<th Background="../../images/blackwhite1.png" style="width:182px;" class="uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" style="width:121px;" class="uk-text-center"><font color="#ffffff">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class="coL4  uk-text-left"><font color="#ffffff">　ファイル名</font></th>
			<th Background="../../images/blackwhite1.png" class="coL5  uk-text-left"><font color="#ffffff"></font></th>
		</tr>
	</thead>
		<!-- includeディレクトリを使い、"manual_source.jsp"ファイルを埋め込む -->
		<%@ include file="manual_source.jsp"%>
	</table>
	</div></div>
<%}else{ %>
	<div id="out_Div"><div id="in_Div">
	<table border="1" class="uk-table uk-width-1-1" >
	<thead>
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" style="width:182px;" class="uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" style="width:121px;" class="uk-text-center"><font color="#ffffff">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class="coL4 uk-text-left"><font color="#ffffff">　ファイル名</font></th>
			<th Background="../../images/blackwhite1.png" class="coL5  uk-text-left"><font color="#ffffff"></font></th>
		</tr>
	</thead>
		<!-- includeディレクトリを使い、"manual_source.jsp"ファイルを埋め込む -->
		<%@ include file="manual_source.jsp"%>
	</table>
	</div></div>
<%} %>
</div>
<br><br>
<div id="edit_form" class="uk-modal">
    <div class="uk-modal-dialog">
        <a class="uk-modal-close uk-close"></a>
        <div class="uk-form uk-width-2-3 uk-align-center">
        	<p id="msg">新しいファイル名を入力してください。</p>
        	<div class="uk-form-row">
        		<input type="text" name="new_name" class="uk-form-width-large">
        	</div>
        	<div class="uk-form-row">
        		<div class="uk-width-1-2 uk-align-center">
        			<button class="uk-button uk-button-success uk-width-1-1" id="enter">変更</button>
        		</div>
        	</div>
        </div>
    </div>
</div>
</body>
</html>
