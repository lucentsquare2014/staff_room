<%@ page contentType="text/html; charset=UTF-8"%>
<% String user = String.valueOf(session.getAttribute("login")); %>
<html style="overflow-x:auto; white-space:nowrap;">
<head>
<jsp:include page="/html/head.html" />
<title>test</title>
</head>
<body>

<jsp:include page="/jsp/header/header.jsp" />
<div class="changelog" style="padding-top: 70px;">
<img src="/staff_room/images/sinseisyorui5.jpg" style="margin-bottom:20px;">
<!-- <span style="position:absolute;top:40em;left:1100px"><font size="7" color="red" face="ＭＳ 明朝,平成明朝">申請書類</font></span>   -->
<div class="uk-width-2-3 uk-container-center">
<% if(user.equals("admin")){ //-----------管理者の申請書類ページ-----------%>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-table-striped uk-width-1-1">
		<tr class="uk-text-large">
			<th class=" uk-width-1-6 uk-text-center"><font color="#000000">種別</font></th>
			<th class=" uk-width-1-6 uk-text-center"><font color="#000000"></font></th>
			<th class=" uk-width-2-6 uk-text-center"><font color="#000000">更新日時</font></th>
			<th class=" uk-width-2-6 uk-text-center"><font color="#000000">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
<%}else{ //-----------一般利用者の申請書類ページ----------%>
	<table border="5" bordercolorlight="#000000"bordercolordark="#696969" class="uk-table uk-table-hover uk-table-striped uk-width-1-1">
		<tr class="uk-text-large">
			<th class=" uk-width-1-6 uk-text-center"><font color="#000000">種別</font></th>
			<th class=" uk-width-2-6 uk-text-center"><font color="#000000">更新日時</font></th>
			<th class=" uk-width-2-6 uk-text-center"><font color="#000000">ファイル名</font></th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
	　<%} %>　　　　　　
	<!--------------  管理者用　 ----------------->　
	<% if(user.equals("admin")){ %>　　　　　　　　　　　 　
	<button id="delete_button" class="uk-button"><b> 　削除　 </b></button>
	<%for(int i = 0;i<90;i++){
		%>&nbsp;<%
		}%>
			<input class ="uk-container-right" type="text" placeholder="">
			<div class="uk-form-file">
				<button class="uk-button"><b>　 添付 　</b></button>
				<input type="file" name="inputFile" id="upload-select" multiple>
				<div id="progressbar" class="uk-progress uk-hidden" style="width: 500px;">
    				<div class="uk-progress-bar" style="width: 0%;">...</div>
				</div>
			</div>
			<br><br>
			<%for(int i = 0;i<197;i++){
		%>&nbsp;<%
		}%>
			<button id="delete_button" class="uk-button"><b>  　  追加 　   </b></button>
			<%} %>
		<!------------------------->
		
		
		</div>
</div>
</div>
<br>
</body>
</html>
