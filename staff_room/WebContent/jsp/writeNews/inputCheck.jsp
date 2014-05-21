<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!-- ほとんどhtmlだけど文字化けが激しいのでjspに -->

<%@ include file="code.jsp" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<h1>入力確認</h1>

	<!-- 入力フォーム データ→確認画面-->


		<table border="1">
			<tr>
				<th>分類</th>
				<td>
				<%String [] POST = new String []{"総務","人事","行事","開発","その他"};%>
				<%=POST[Integer.parseInt(jpn2unicode(request.getParameter("inputPost"),"UTF-8"))-1]%>
				</td>
			</tr>
			<tr>
				<th>タイトル</th>
				<td><%= jpn2unicode(request.getParameter("inputTitle"),"UTF-8") %></td>
			</tr>
			<tr>
				<th>本文</th>
				<td>
				<pre><%= jpn2unicode(request.getParameter("inputText"),"UTF-8") %></pre>
				</td>
			</tr>

			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" disabled>
				<%= jpn2unicode(request.getParameter("inputFile"),"UTF-8") %>
				</td>
		</tr>
		-->

			<tr>
				<th>保存者</th>
				<td><%= jpn2unicode(request.getParameter("inputWriter"),"UTF-8") %></td>
			</tr>



			<!-- ついでに入力フォームか編集フォームかを判断する値を渡したらいいと思う
			name="formType" valueは"input"だとか"update"だとか-->
			</table>


			<!-- 入力・編集フォームから渡されたデータ→newsWrite.jsp-->
			<form method="POST" action="	write_finish.jsp">

			<!-- 管理編集画面→編集フォーム→確認画面と渡されたnews_idを渡すnewsWrite.jsp-->

				<input type="hidden" name="inputNewsid"
				value="<%=jpn2unicode(request.getParameter("inputNewsid"),"UTF-8")%>" >


				<input type="hidden" name="inputPost"
				value="<%=jpn2unicode(request.getParameter("inputPost"),"UTF-8")%>" >


				<input type="hidden" name="inputTitle"
				value="<%= jpn2unicode(request.getParameter("inputTitle"),"UTF-8") %>" >


				<input type="hidden" name="inputText"
				value="<%= jpn2unicode(request.getParameter("inputText"),"UTF-8") %>" >


			<!-- 添付ファイル いったん保留
		<tr>
			<th>添付ファイル</th>
				<td><input type="file" name="inputFile" size="30" disabled>
				<%= jpn2unicode(request.getParameter("inputFile"),"UTF-8") %>
				</td>
		</tr>
		-->



				<input type="hidden" name="inputWriter"
				value="<%= jpn2unicode(request.getParameter("inputWriter"),"UTF-8") %>" >



		<input type="submit" value="決定">
		<!--  戻るボタン。リンク先をifで入力フォームと編集ホームに判断
		<a onclick="submit(href="if(jpn2unicode(request.getParameter("formType"),"UTF-8").equals("input")){
							入力フォームのリンクＵＲＬ
				}else if(jpn2unicode(request.getParameter("formType"),"UTF-8").equals("input")){
							編集ホームのリンク先
				}
								)"></a>
										戻るボタン。リンク先をifで入力フォームと編集ホームに判断-->
	</form>

	<!-- /入力フォーム -->

</body>
</html>