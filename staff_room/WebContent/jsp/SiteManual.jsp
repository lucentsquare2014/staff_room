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
<%@ page import="org.apache.commons.lang.math.NumberUtils"%>
<%
	if (session.getAttribute("login") != null) {
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
tr {
	white-space: nowrap;
}

body {
	width: 100%;
	height: 656px;
	background-attachment: fixed;
	background-image: url("/staff_room/images/input.png");
	background-size: 100% auto;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div style="position: relative; top: 90px; left: 0px; width: 100%;">
		<div class="uk-width-3-5 uk-container-center">
			<table border="5" class="uk-table  uk-width-medium-1-1">
				<tr class="uk-text-large">
					<td Background="../images/blackwhite1.png"
						class="uk-h2 uk-width-medium-8-10"><font color="#ffffff">マニュアル一覧</font></td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">1.ヘッダーメニューについて</a>&nbsp;
						<div id="my-id1" class="uk-h2  uk-hidden">
<pre>
	・それぞれの項目をクリックすることでそのページに移動します。
	・一部の項目は、ポインタを合わせればリンクがリストとして表示されます。
	・ログアウトをクリックすると、会社ページに戻ります。
	・ロゴをクリックするとログイン状態のまま、会社ページに戻ります。
	・携帯からのアクセスなど、ページが小さく表示される場合はヘッダーの表示がサイドバー形式に切り替わります。
	　ヘッダーの端に表示されたボタンをクリックすると、それぞれのページへのリンクがリストとして表示されます。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id2'}" class="uk-text-bold">2.TOP画面について</a>&nbsp;
						<div id="my-id2" class="uk-h2  uk-hidden">
<pre>
	・連絡事項として作成された記事の簡易的な閲覧が行えるページです。
	・「連絡事項」横のボタンを押すことでその分類の記事のみが表示されます。
	・記事の内容をまだ閲覧していない記事には、「new」というアイコンが表示されます。
	　また、記事の作成者が緊急と判断した記事には「緊急」というアイコンが表示されます。
	・表示されているそれぞれの記事のタイトルをクリックすると、ポップアップで記事の内容が表示されます。
	・表示されたポップアップの左下のアイコンをクリックすると、記事の内容を印刷することができます。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id3'}" class="uk-text-bold">3.連絡画面について</a>&nbsp;
						<div id="my-id3" class="uk-h2  uk-hidden">
<pre>
	・連絡事項として作成された記事の閲覧が行えるページです。
	・ヘッダーにリスト表示されたリンクから分類別の記事のみを表示することができます。
	・表示される記事が100件を超える場合には、ページ右上に「次へ」というリンクが表示されます。
	　クリックすることで、101件～、201件～と記事を100件ずつ表示することができます。
	・表示されているそれぞれの記事のタイトルをクリックすると、記事の内容が表示されます。
	　記事のタイトルを再びクリックすると、記事の内容が非表示になります。
	・記事のタイトル横のアイコンをクリックすると、記事の内容を印刷することができます。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id4'}" class="uk-text-bold">4.社内システムについて</a>&nbsp;
						<div id="my-id4" class="uk-h2  uk-hidden">
<pre>
	・ヘッダーにリスト表示されたそれぞれのリンクをクリックすることで社内システムを利用することができます。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id5'}" class="uk-text-bold">5.申請書類、規定・書類画面について</a>&nbsp;
						<div id="my-id5" class="uk-h2  uk-hidden">
<pre>
	・各種書類の閲覧・ダウンロードが行えるページです。
	　申請書類ページでは、変更届など記入・提出の必要がある書類とその記入例を利用できます。
	　規定・書類ページでは個人情報保護規定など規定に関する書類を利用できます。
	・ファイル名をクリックすることで書類の閲覧・ダウンロードが行えます。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id6'}" class="uk-text-bold">6.Mail画面について</a>&nbsp;
						<div id="my-id6" class="uk-h2  uk-hidden">
<pre>
	・社員のメールアドレスの確認とメールの作成が行えるページです。
	・メールアドレスをクリックすると、宛先にそのアドレスが入った状態でメールソフトが起動します。
	・送りたい人が複数いる場合は、名前横のチェックボックスから一度に送りたい人全員にチェックを入れ、
	　「メール作成」ボタンをクリックすれば、全員のアドレスが宛先に入った状態でメールソフトが起動されます。
	・「メール作成」下のボタンをクリックするとその文字の行まで自動的に移動します。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id7'}" class="uk-text-bold">7.掲示板、Photo、etcについて</a>&nbsp;
						<div id="my-id7" class="uk-h2  uk-hidden">
<pre>
	ヘッダーからのリンクによって各ページに移動します。
	使い方については今まで通りとなります。（パスワード変更を除く）
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id8'}" class="uk-text-bold">8.ログインパスワードの変更について</a>&nbsp;
						<div id="my-id8" class="uk-h2  uk-hidden">
<pre>
	・ログインパスワードの変更はヘッダーメニューの「etc」の中の、「パスワード変更」から行うことができます。
	・現在のパスワードの入力と変更したいパスワードを2回入力することで変更が完了します。
	・パスワードは4文字以上、20文字以下で設定して下さい。
	　また、アカウントと同一のものはパスワードとして設定することはできません。
</pre>
						</div>
				<tr>
					<td bgcolor="#FFFFFF"class="uk-h3 uk-width-medium-8-10 "><a
						data-uk-toggle="{target:'#my-id9'}" class="uk-text-bold">9.ログイン画面について</a>&nbsp;
						<div id="my-id9" class="uk-h2  uk-hidden">
<pre>
	・「ログイン状態を保持する」にチェックを入れてログインした場合、ログアウトを行う、cookieeを削除する、
	　ブラウザの変更などの動作を行わない限り、ログイン状態が保持されます。（Staff_Roomへのアクセス時、ログインが省略されます）
	・ログインが保持される期間は二週間です。この期間は新たに「ログイン状態を保持する」にチェックを入れてログインすることで
	　更新されます。（その時点から二週間ログインが保持されます。ログインを省略してStaff_Roomにアクセスしても更新はされません）
</pre>
						</div>
			</table>
		</div>
	</div>
</body>
</html>
