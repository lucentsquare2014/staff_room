<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja" class="uk-height-1-1">
<head>
<jsp:include page="/html/head.html"></jsp:include>
<title>管理者権限編集画面</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp"></jsp:include>

	<br>
	<br>
	<br>
	<br>
	<div class="uk-h1 uk-text-center">管理者権限の追加 ・ 削除</div>
	<div class="uk-panel uk-panel-box uk-align-center uk-width-1-2">
		<div class="uk-text-center">
			<ul class="uk-subnav uk-subnav-pill"
				data-uk-switcher="{connect:'#subnav-pill-content'}">
				<li class="uk-active"><a href="#">追加</a></li>
				<li class=""><a href="#">削除</a></li>
			</ul>
			<ul id="subnav-pill-content" class="uk-switcher">
				<li class="uk-active">
				    <div id="out_Div">
						<div id="in_Div">
							<form class="uk-form" action="" method="POST">
								<select>
									<%
										// 一般的アカウントの人を表示
									%>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<option value="">玉城 亨文</option>
									<%
										
									%>
								</select> <input class="uk-button uk-button-primary" type="submit"
									value="追加" />
							</form>
						</div>
					</div>
				</li>
                <li class="uk-active">
                    <div id="out_Div">
                        <div id="in_Div">
                            <form class="uk-form" action="" method="POST">
                                <select>
                                    <%
                                        // 管理者の一覧を表示
                                    %>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <option value="">玉城 亨文</option>
                                    <%
                                        
                                    %>
                                </select> <input class="uk-button uk-button-danger" type="submit"
                                    value="削除" />
                            </form>
                        </div>
                    </div>
                </li>
				
			</ul>
			<div class="uk-h2 uk-text-center" style="padding-top: 30px;">
				管理者一覧</div>
			<div class="uk-panel-box uk-panel uk-width-1-3 uk-align-center"
				style="background-color: white;">
				<div class="uk-text-large">
				玉城亨文
				</div>
                <div class="uk-text-large">
                                           玉城亨文
                </div>
				<%// ここに管理者の一覧を表示
				%>
			</div>
		</div>
	</div>

</body>
</html>