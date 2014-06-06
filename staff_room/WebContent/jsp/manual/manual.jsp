<%@ page contentType="text/html; charset=UTF-8"%>
<% String user = String.valueOf(session.getAttribute("login")); %>
<html style="overflow-x:auto; white-space:nowrap;">
<head>
<jsp:include page="/html/head.html" />
<style>
body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/manyuaru5-2.jpg");
	background-size: 100% auto;
}
</style>
<title>規定・書類</title>
</head>
<body>

<jsp:include page="/jsp/header/header.jsp" />
<div class="changelog" style="padding-top: 40px;">
<!-- <img src="/staff_room/images/manyuaru6.jpg" style="margin-bottom:20px;"> -->
<!-- <span style="position:absolute;top:40em;left:1100px"><font size="7" color="red" face="ＭＳ 明朝,平成明朝">マニュアル</font></span>   -->
<div class="uk-width-3-5 uk-container-center">
<br><br><br><br>
<% if(user.equals("admin")){ //-----------管理者の申請書類ページ-----------%>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-width-1-1" >
		<tr class="uk-text-large">
		<th Background="../../images/blackwhite1.png" class="uk-text-center">　　</th>
			<th Background="../../images/blackwhite1.png" class="uk-width-3-10 uk-text-center"><font color="#ffffff">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class="uk-width-7-10 uk-text-center"><font color="#ffffff">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"manual_source.jsp"ファイルを埋め込む -->
		<%@ include file="manual_source.jsp"%>
		</table>
<%}else{ %>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-width-1-1" >
		<tr class="uk-text-large">
			<th Background="../../images/blackwhite1.png" class=" uk-width-3-10 uk-text-center"><font color="#ffffff">更新日時</font></th>
			<th Background="../../images/blackwhite1.png" class=" uk-width-7-10 uk-text-center"><font color="#ffffff">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"manual_source.jsp"ファイルを埋め込む -->
		<%@ include file="manual_source.jsp"%>

	</table>
<%} %>
	<!--------------  管理者用　 ----------------->　
	<% if(user.equals("admin")){ %>
	<form class="uk-form" action="/staff_room/document" enctype="multipart/form-data" method="post">
	<div class="uk-grid">
		<div class="uk-width-1-2 uk-text-left">
			<button id="delete_button" class="uk-button uk-button-danger">
			<i class="uk-icon-trash-o uk-icon-small"></i><b>　削除</b></button>
		</div>
		<div class="uk-width-1-2 uk-text-right">
			<input class ="uk-container-right" type="text" placeholder="">
			<div class="uk-form-file">
				<button class="uk-button uk-button-success">
				<i class="uk-icon-file-text uk-icon-small"></i><b>　添付</b></button>
				<input type="file" name="inputFile" id="upload-select" multiple>
				<div id="progressbar" class="uk-progress uk-hidden" style="width: 500px;">
    				<div class="uk-progress-bar" style="width: 0%;">...</div>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class="uk-grid">
		<div class="uk-width-1-1 uk-text-right">
		<button id="delete_button" class="uk-button uk-button-primary">
		<i class="uk-icon-upload uk-icon-small"></i><b>　追加</b></button>
		</div>
	</div>
	<input type="hidden" name="page" value="manual">
	</form>
	<%} %>
</div>
</div>
<br><br>
</body>
</html>

