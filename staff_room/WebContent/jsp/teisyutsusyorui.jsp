<%@ page contentType="text/html; charset=UTF-8"%>

<head>
<jsp:include page="/html/head.html" />
<title>test</title>
</head>
<body>
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
</body>
