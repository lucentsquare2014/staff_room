<%@ page contentType="text/html; charset=UTF-8"%>
<html style="overflow-x:auto; white-space:nowrap;">
<head>
<jsp:include page="/html/head.html" />
<title>test</title>
</head>
<body>

<jsp:include page="/jsp/header/header.jsp" />
<div class="changelog" style="padding-top: 50px;">
<img src="/staff_room/images/sinseisyorui4.jpg" style="margin-bottom:20px;">
<!-- <span style="position:absolute;top:40em;left:1100px"><font size="7" color="red" face="ＭＳ 明朝,平成明朝">申請書類</font></span>   -->
<div class="uk-width-2-3 uk-container-center">
	<table class="uk-table uk-table-striped uk-width-1-1 ">
		<tr class="uk-text-large">
			<th class=" uk-width-1-4 uk-text-center">種別</th>
			<th class=" uk-width-1-4 uk-text-center">更新日時</th>
			<th class=" uk-width-1-2 uk-text-center">ファイル名</th>
		</tr>
		<!-- includeディレクトリを使い、"syorui_source.jsp"ファイルを埋め込む -->
		<%@ include file="syorui_source.jsp"%>

	</table>
</div>
</div>
<br>
</body>
</html>
