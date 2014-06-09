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
<%@ page import="dao.NewsDAO, news.ReadCheck"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%
	if(session.getAttribute("login") != null){
		String id = String.valueOf(session.getAttribute("login"));
		ReadCheck rc = new ReadCheck(); 
		String unread = rc.getUnread(id);
		session.setAttribute("unread", unread);
	}
%>
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/read_check.js"></script>
<title>このサイトの使い方</title>

<style type="text/css">
 	tr{white-space:nowrap;}
  	body {
		width: 100%;
		height: 656px;
		background-attachment: fixed;
		background-image: url("/staff_room/images/renraku01.jpg");
		background-size: 100% auto;
	}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" /><br><br>
<!--	<img src="/staff_room/images/renraku5.jpg"> -->
	<div style="position:relative; top:-80px; left:0px; width: 100%;">

	<div align="center">
<%-- 保留 後ろにNEWSの画像入れるなら
<img src="/staff_room/images/newswall.png" style="position:relative;height: 600; width:100%">
--%>

	<div style="position:relative; top:60px; left:0px; width:100%">

	<%
		String value = null,value2 = null,value3 = null;
		List<String> read_check = null;
		value = request.getParameter("news");
		value2 = request.getParameter("news_id");
		//未読記事のnews_idを受け取る
		if(session.getAttribute("unread") !=""){
			 value3 = String.valueOf(session.getAttribute("unread"));
			 read_check = Arrays.asList(value3.split(","));

		}


		
		
		
		
		
			%>
			<div style="position:fixed; top:220px; left:80px;">
			<div class="uk-grid">
			<div class="uk-width-1-4 uk-pull-1-6 uk-text-center">
			<font face="ＭＳ Ｐゴシック">
			
			
			</font>
			</div></div></div>

		<br><br><br><br><br><br>
		
		<div class="uk-width-2-3 uk-container-center">
		<table border="5" class="uk-table uk-text-center uk-width-medium-1-1">
		<tr class="uk-text-large">
		<td Background="../images/blackwhite1.png" class="uk-h2 uk-width-medium-8-10"><font color="#ffffff">マニュアル一覧</font></td>
		</tr>
		<tr>
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">1.ヘッダーについて</a>&nbsp;
			    <div id="my-id1" class="uk-h2 uk-text-center uk-hidden"><pre>項目をクリックすると、それぞれのページに遷移します。一部の項目はプルダウン式になっています。
	ロゴをクリックするとログイン状態を保持したまま、会社ページに戻ります。
	ログアウトを押すと、セッションを切断して会社ページに戻ります。
	
	ページが一定の幅以下まで小さくなると、項目がなくなります。
	その場合はロゴ横にあるボタンを押すと、サイドバーとしてメニューが表示されます。</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id2'}" class="uk-text-bold">2.TOP画面について</a>&nbsp;
			    <div id="my-id2" class="uk-h2 uk-text-center uk-hidden"><pre>「連絡事項」横の種別ごとのボタンを押すことでその種別の記事のみが表示されます。
	記事のタイトルをクリックすることで本文が表示されます。
	
	自分が本文を見ていない記事には、「new」との表示がされます。
	また、管理者が緊急と判断した記事には「緊急」という表示が出ます。
	「new」に関してはタイトルをクリックすると表示が消えますが、「緊急」に関しては消えません</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id3'}" class="uk-text-bold">3.連絡画面について</a>&nbsp;
			    <div id="my-id3" class="uk-h2 uk-text-center uk-hidden"><pre>連絡には記事が1つのページにつき100件まで表示されます。
	その他の機能についてはTOP画面と同じです。</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id4'}" class="uk-text-bold">4.社内システムについて</a>&nbsp;
			    <div id="my-id4" class="uk-h2 uk-text-center uk-hidden"><pre>ヘッダーの項目をクリックすることで遷移できます。
	使い方については今まで通りとなります。（詳しくは「社内システム操作説明」に記述）</pre></div><tr>
						
			<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id5'}" class="uk-text-bold">5.申請書類、規定・書類画面について</a>&nbsp;
			    <div id="my-id5" class="uk-h2 uk-text-center uk-hidden"><pre>ファイル名をクリックするとそのHTMLにリンクする、もしくはダウンロードが開始されます。
	申請書類には各種、申請や届けのための書類とそのフォーマットが掲載されています。
	規定・書類には、会社の規定やそのほか会社にかかわる書類が掲載されています。</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id6'}" class="uk-text-bold">6.Mail画面について</a>&nbsp;
			    <div id="my-id6" class="uk-h2 uk-text-center uk-hidden"><pre>メールアドレスをクリックすると、宛先にそのメールアドレスが入った状態でメールソフトが起動します。
送りたい人が複数いる場合、名前横のチェックボックスから一度に送りたい人全員にチェックを入れ、「メール作成」ボタンを押します。
そうした場合、全員のメールアドレスが宛先に入った状態でメールソフトが起動されます。
「メール作成」下のボタンを押すことで、その文字から始まるの人の名前まで移動します。</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id7'}" class="uk-text-bold">7.掲示板、Photo、etcについて</a>&nbsp;
			    <div id="my-id7" class="uk-h2 uk-text-center uk-hidden"><pre>ヘッダーからのリンクによって各ページに移動します。
使い方については今まで通りとなります。（パスワード変更を除く）</pre></div><tr>
						
			<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id8'}" class="uk-text-bold">8.パスワード変更について</a>&nbsp;
			    <div id="my-id8" class="uk-h2 uk-text-center uk-hidden"><pre>準備中</pre></div><tr>
						
				<td bgcolor="#FFFFFF" class="uk-h3 uk-width-medium-8-10 uk-text-center">
			    <a data-uk-toggle="{target:'#my-id9'}" class="uk-text-bold">9.ログイン画面について</a>&nbsp;
			    <div id="my-id9" class="uk-h2 uk-text-center uk-hidden"><pre>「ログイン状態を保持する」にチェックを入れてログインした場合、ログアウトを行う、cookieeを削除する、
もしくは2週間たない限りログイン状態が保持されます。</pre></div><tr>
					

		</table>
		
</div></div></div></div>
</body>
</html>
