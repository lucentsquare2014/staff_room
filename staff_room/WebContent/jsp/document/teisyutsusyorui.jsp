<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String user = String.valueOf(session.getAttribute("login")); %>
<html style="overflow-x:auto; white-space:nowrap;">
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
	background-size: 100% auto;
}
textarea {
	width: 180px;
}
</style>
<title>申請書類</title>
</head>
<body>
<jsp:include page="/jsp/header/header.jsp" />

<div class="changelog" style="padding-top: 40px;">
<!-- <img src="/staff_room/images/sinseisyorui5-2.jpg" width="100%" height="100%" style="position:absolute; margin-bottom:20px; filter: progid:DXImageTransform.Microsoft.alpha (style=0, opacity=50)"> -->
<!-- <span style="position:absolute;top:40em;left:1100px"><font size="7" color="red" face="ＭＳ 明朝,平成明朝">申請書類</font></span>   -->
<div class="uk-width-2-3 uk-container-center">
<br><br><br><br>
<% if(user.equals("admin")){ //-----------管理者の申請書類ページ-----------%>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-width-1-1">
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-text-center"><font color="#FFFFFF">　　</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-6-10 uk-text-center"><font color="#FFFFFF">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
<%}else{ //-----------一般利用者の申請書類ページ----------%>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-width-1-1">
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">種別</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-2-10 uk-text-center"><font color="#FFFFFF">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-6-10 uk-text-center"><font color="#FFFFFF">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
	　<%} %>　　　　　　
	<!--------------  管理者用　 ----------------->　
	<% if(user.equals("admin")){ %>
	<div class="uk-grid">
		<div class="uk-width-1-2 uk-text-left">
			<button id="delete" class="uk-button uk-button-danger" disabled="disabled">
			<i class="uk-icon-trash-o uk-icon-small"></i><b>　削除</b></button>
		</div>
		<form class="uk-form" action="/staff_room/document" enctype="multipart/form-data" method="post">
		<div class="uk-width-1-2 uk-text-right">
			<select name="category">
				<option value="変更等届書類">変更等届書類</option>
				<option value="申請書類">申請書類</option>
				<option value="金銭に関係する書類">金銭に関係する書類</option>
				<option value="育児介護">育児介護</option>
			</select>
			<input type="hidden" name="page" value="document">
			<input name="select_files" type="text" class ="uk-container-right" disabled>
			<div class="uk-form-file">
				<button class="uk-button uk-button-success">
				<i class="uk-icon-file-text uk-icon-small"></i><b>　添付</b></button>
				<input type="file" name="inputFile" id="upload-select" multiple>
				<div id="progressbar" class="uk-progress uk-hidden" style="width: 500px;">
    				<div class="uk-progress-bar" style="width: 0%;">...</div>
				</div>
			</div>
		</div>
		<br>
		<div class="uk-width-1-1 uk-text-right">
			<button id="add" class="uk-button uk-button-primary" disabled>
			<i class="uk-icon-upload uk-icon-small"></i><b>　追加</b></button>
		</div>
	</form>
	</div>
	<%} %>
	</div>
	<br><br>
</div>
</body>
</html>