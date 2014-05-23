<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%@ page import="java.util.ArrayList, java.util.HashMap"%>


<!DOCTYPE html>
<html lang="ja">
<head>
<jsp:include page="/html/head.html" />
<script type="text/javascript">
	var display_tag;
	window.onload = function() {

		if (!document.getElementsByTagName)
			return;

		var change_tag = document.getElementsByTagName("h4"); // タイトルの部分のタグ
		display_tag = document.getElementsByTagName("dl"); // 非表示させたい部分のタグ

		for (var i = 0; i < change_tag.length; i++) {
			// 非表示させたいタグの処理
			display_tag.item(i).style.display = "none";

			// タイトルの文字を取得して表示切り替えのリンクに変更
			var ele = change_tag.item(i);
			var str = ele.innerText || ele.innerHTML;
			ele.innerHTML = '<a href="javascript:show(' + i + ');">' + str
					+ '<\/a>';
		}
	}
	// チェックボックスにチェックがついたかを判別する
	function del_checked(id) {
		var checkbox = $("#" + id);
		if (checkbox.attr("flag") === "0") {
			checkbox.attr("flag", "1");
			$("#" + checkbox.attr("id"))
					.attr("class", "uk-icon-check-square-o");
		} else {
			checkbox.attr("flag", "0");
			$("#" + checkbox.attr("id")).attr("class", "uk-icon-square-o");
		}
	}
	// 記事を削除するdeleteNews.jspに記事にIDを渡す関数
	function delete_news() {
		// 削除をクリックされると確認ダイヤログを表示するOKが押されるとif文の中を実行
		if (confirm('選択された記事をすべて削除してもいいですか?')) {
			var f = -1;
			var ids = [];
			// class=delete_checkのついてるタグをすべて取得
			var news = $('[name="delete_check"]');
			// 削除する記事のIDを格納した配列を生成
			for (var n = 0; n < news.length; n++) {
				// チェックボックスにチェックがついていたらIDを配列に格納
				if (news[n].getAttribute("flag") == "1") {
					ids.push(news[n].getAttribute("id"));
					f=1;
					// 削除する記事を隠す
					$("#row" + news[n].getAttribute("id")).fadeOut();
				}
			}
			
			if (f == -1) {
				window.alert("記事が選択されていません。");
			} else {
				// IDを格納した配列をdeleteNews.jspにPOST送信
				$.ajax({
					type : "POST",
					url : "deleteNews.jsp",
					data : {
						// 配列を区切り文字","の文字列に変換 例:[1,2,3,]→"1,2,3"
						"del_id" : "" + ids
					}
				}).done(function() {
				});
			}
		}

	}

	function show(a) {
		var ele = display_tag.item(a);
		ele.style.display = (ele.style.display == "none") ? "block" : "none";
	}
</script>
<style type="text/css">
body{width: 100%;
	height:656px;
	background-attachment: fixed;
	background-image: url(http://localhost:7348/staff_room/images/renraku.png);
	background-size:100% auto;
	 }
</style>
<title>管理編集</title>
</head>

<body>


    <jsp:include page="/jsp/header/header.jsp" />
    <div class="changelog" style="padding-top: 50px;"></div>
	<div  class="content">
		<p>
		<h1>管理・編集</h1>
     		<form method="POST" action="updateForm.jsp" align="right" style="margin-right:60px" style="margin-top:20px;">
			<input type="submit" value="新規作成" align="right">
		</form>
		<p>          
		</p>
		<div class="delete_button" align="right" style="margin-right:60px" style="margin-top:30px;">
			<button type="button" onclick="delete_news()"><big> 削除 </big></button>
		</div>
		<%
			//配列
			ArrayList<Integer> x = new ArrayList<Integer>();
			int j = 0, z = 0;
			NewsDAO dao = new NewsDAO();
			ArrayList<HashMap<String, String>> list = null;
			list = dao
					.getNews("select news_id,TO_CHAR(created,'yyyy\"年\"mm\"月\"dd\"日\"') as created,post.post_id,postname,title,text,writer from news, post where news.post_id = post.post_id order by created desc");
			out.println("<table  border='3' width='80%' cellspacing='20' cellpadding'0'>");
			for (int i = 0; i < list.size(); i++) {
				HashMap<String, String> row = list.get(i);
				//時刻がある記事だけの表示
				if (!row.get("created").equals("")) {
					out.println("<tr id=\"row" + row.get("news_id") + "\">");
					out.println("<td>");
					//チェックボックスの定義
					out.println("<a flag=\"0\" class=\"uk-icon-square-o\" name=\"delete_check\" id=\""
							+ row.get("news_id")
							+ "\" onclick=\"del_checked(this.id)\">");
					out.println("</a>");
					out.println("</td>");
					out.println("<td>");
					out.println(row.get("created"));
					out.println("&nbsp;</td>");
					out.println("<td>");
					out.println(row.get("postname"));
					out.println("&nbsp;</td>");
					out.println("<td>");
		%>
		<!-- title→タイトル -->
		<h4><%=row.get("title")%></h4>
		<dl>
			<dt>
			<!-- text→文章 -->
				<pre><%=row.get("text")%></pre>
			</dt>
			//クリックしたら出てくる中身の文について
			<dt style="display: none"></dt>
		</dl>
		<%
			out.println("&nbsp;</td>");

					out.println("<td>");
		%>
		<form method="POST" action="updateForm.jsp">

			<input type="hidden" name="inputNewsid"
				value="<%=row.get("news_id")%>"> <input type="hidden"
				name="inputPostid" value="<%=row.get("post_id")%>"> <input
				type="hidden" name="inputTitle" value="<%=row.get("title")%>">

			<input type="hidden" name="inputText" value="<%=row.get("text")%>">

			<input type="hidden" name="inputWriter"
				value="<%=row.get("writer")%>"> <input type="submit"
				value="編集">
		</form>
		<%
			out.println("&nbsp;</td>");
					out.println("</tr>");
				} else {
					x.add(i);
					z++;
				}
			}
			//時刻が入っていない記事の表示はここから
			for (int i = 0; i < z; i++) {
				HashMap<String, String> row = list.get(x.get(i));
				out.println("<tr id=\"row" + row.get("news_id") + "\">");
				out.println("<td>");
				out.println("<a flag=\"0\" class=\"uk-icon-square-o\" name=\"delete_check\" id=\""
						+ row.get("news_id")
						+ "\" onclick=\"del_checked(this.id)\">");
				out.println("</a>");
				out.println("</td>");
				out.println("<td>");
				out.println(row.get("created"));
				out.println("&nbsp;</td>");
				out.println("<td>");
				out.println(row.get("postname"));
				out.println("&nbsp;</td>");
				out.println("<td>");
		%>
		<h4><%=row.get("title")%></h4>
		<dl>
			<dt>
				<pre><%=row.get("text")%></pre>
			</dt>
		</dl>
		<%
			out.println("&nbsp;</td>");
				out.println("<td>");
		%>
		<form method="POST" action="updateForm.jsp">

			<input type="hidden" name="inputNewsid"
				value="<%=row.get("news_id")%>"> <input type="hidden"
				name="inputPostid" value="<%=row.get("post_id")%>"> <input
				type="hidden" name="inputTitle" value="<%=row.get("title")%>">

			<input type="hidden" name="inputText" value="<%=row.get("text")%>">

			<input type="hidden" name="inputWriter"
				value="<%=row.get("writer")%>"> <input type="submit"
				value="編集">
		</form>
		<%
			out.println("&nbsp;</td>");
				out.println("</tr>");
			}
			out.println("</table>");
		%>
	</div>

</body>
</html>