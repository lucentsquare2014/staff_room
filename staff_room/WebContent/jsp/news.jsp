<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="java.sql.Connection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<jsp:include page="/html/head.html" />

<title>連絡事項</title>

<style type="text/css">
 	tr{white-space:nowrap;}
</style>
<!-- クリックされた記事のnews_idをメソッドに送信するJavascript -->
<script type=“text/javascript”>
function news_id( value ){
    var form = document.createElement( ‘form’ );
    document.body.appendChild( form );
    var input = document.createElement( ‘input’ );
    input.setAttribute( ‘type’ , ‘hidden’ );
    input.setAttribute( ‘name’ , ‘name’ );
    input.setAttribute( ‘value’ , value );
    form.appendChild( input );
    form.setAttribute( ‘action’ , ‘送信したいメソッド名’ );
    form.setAttribute( ‘method’ , ‘post or get’ );
    form.submit();
}
</script>

</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" /><br><br>
	<img src="/staff_room/images/renraku5.jpg">
	<div style="position:relative; top:-80px; left:0px; width: 100%;">

	<div align="center">
<%-- 保留 後ろにNEWSの画像入れるなら
<img src="/staff_room/images/newswall.png" style="position:relative;height: 600; width:100%">
--%>

	<div style="position:relative; top:60px; left:0px; width:100%">

	<%
		String value = null,value2 = null,value3 = null;
		value = request.getParameter("news");
		value2 = request.getParameter("news_id");
		//未読記事のnews_idを受け取る
		if(request.getAttribute("unread") !=""){
			 value3 = String.valueOf(request.getAttribute("unread"));	
		}
		
		//String news_id[] = request.getParameterValues("read_change");
		
		
		if(value == null){
			value = "1";
		}
		int flag = Integer.parseInt(value);

		if(!(flag == 1 || flag == 2 ||flag == 3 ||flag == 4 || flag == 5)){
			value = "1";
		}

		//配列
		ArrayList<Integer> x = new ArrayList<Integer>();
		NewsDAO dao = new NewsDAO();
		ArrayList<HashMap<String, String>> list = null;
		String page_num = request.getParameter("page");
		if (page_num == null || !NumberUtils.isNumber(page_num)) {
			page_num = "1";
		}
		// offsetにゲットパラメータで取得したページ数を代入
					String limit = "10";
					String offset = String.valueOf((Integer.parseInt(page_num) * Integer
							.parseInt(limit)) - 10);
		list = dao
		.getNews("select TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,news_id,title,filename,text,writer from news where post_id = "
		+ value + " order by update desc " +" limit " + limit +" offset " + offset );
		ArrayList<HashMap<String, String>> name = null;
		name = dao.getNews("select postname from post where post_id =" + value);
		System.out.print(name);
		HashMap<String, String> raw = name.get(0);
			%>
			<div align="left">
			<font face="ＭＳ Ｐゴシック">
			<font size ="7">
			<br><br><br>　　　　　
			<nonbr><%=raw.get("postname")%></nonbr><br>
			</font>
			</font>
			</div>

		<br><br>
		<%System.out.print(list);%>
		<div class="uk-width-3-4 uk-container-center">
		<table class="uk-table  uk-table-striped uk-text-center uk-width-medium-1-1">
		<tr class="uk-text-large">
		<td class="uk-h2 uk-width-medium-3-10">日付</td>
		<td class="uk-h2 uk-width-medium-7-10">件名</td>
		</tr>
		<%
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, String> row = list.get(i);
				%>
				<tr>
				<td class="uk-h3 uk-width-medium-3-10 uk-text-center"><%=row.get("created")%>&nbsp;</td>
				<td class="uk-h3 uk-width-medium-7-10 uk-text-left">
				<%
				//更新履歴から選択された記事を表示状態で連絡画面へ飛ぶ処理
				if(row.get("news_id").equals(value2)){
					if(value3.indexOf(row.get("news_id")+",") != -1){%>
						<a href="javascript:news_id('<%= row.get("news_id")%>')" data-uk-toggle="{target:'#my-id'}"><font size="4" color="red"><b><%= row.get("title") %><right>new</right></b></font></a>
					<%}else{
					    %><a data-uk-toggle="{target:'#my-id'}"><%= row.get("title") %></a>
					<%}%>
					<div id="my-id" class="uk-text-left">
                    <%if (!row.get("filename").equals("")){ %>
						<div class="uk-h3 uk-text-left"><pre><%= row.get("text") %><br><br>添付ファイル：
							<br><%String arr[] = row.get("filename").split( "," );for (int f = 0; f<arr.length; f++){%>
								<a href=""><%out.println(arr[f]);%></a><%}%></pre></div>
                    <%} else{ %>
                    	<div class="uk-h3 uk-text-left"><pre><%= row.get("text") %></pre></div>
                    <%} %>
					</div>
				<%}else{%>
					<%if(value3.indexOf(row.get("news_id")+",") != -1){%>
						<a href="javascript:news_id('<%= row.get("news_id")%>')" data-uk-toggle="{target:'#my-id<%=i%>'}"><font size="4" color="red"><b><%= row.get("title") %><right>new</right></b></font></a>
					<%}else{%>
						<a data-uk-toggle="{target:'#my-id<%=i%>'}"><%= row.get("title") %></a>
					<%}%>
					<div id="my-id" class="uk-text-left">
					<%if (!row.get("filename").equals("")){ %>
                    <div id="my-id<%=i%>" class="uk-h3 uk-text-left uk-hidden">
                    	<pre><%= row.get("text") %><br><br>添付ファイル：
                    		<br><%String arr[] = row.get("filename").split( "," );for (int f = 0; f<arr.length; f++){%>
                    			<a href=""><%out.println(arr[f]);%></a><%}%></pre></div>
					<%}else{ %>
					<div id="my-id<%=i%>" class="uk-h3 uk-text-left uk-hidden"><pre><%= row.get("text") %></pre></div>
					<%} %>
				<%} %>
				<!--
				<a href="#<%= row.get("news_id") %>" data-uk-modal class="uk-h4"><%= row.get("title") %></a>
				<div id="<%= row.get("news_id") %>" class="uk-modal">
    				<div class="uk-modal-dialog">
        				<a class="uk-modal-close uk-close"></a>
        				<div class="uk-h3"><%= row.get("text") %></div>
    				</div>
				</div>
				-->


				</tr>

			<%}%>		
</table>
<%=request.getAttribute("unread") %>
<!-- 次へボタン、戻るボタンの処理　 -->
<div class="uk-grid" style="padding-bottom: 50px;">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left"
				style="<%if (page_num.equals("1")) {
				out.print("display: none;");
			}%>">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) - 1%>&news_id=<%=value2%>">&lt;&lt;前へ</a></span>
			</div>
			<div class="uk-width-1-2 page-next uk-text-large uk-text-right"
				style="<%if (list.size() < 10) {
				out.print("display: none;");
			}%>">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) + 1%>&news_id=<%=value2%>">次へ&gt;&gt;</a></span>
			</div>
		</div>
</div></div></div></div>
</body>
</html>