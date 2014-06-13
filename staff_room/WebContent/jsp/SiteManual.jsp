<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html" />
<script src="/staff_room/script/read_check.js"></script>
<title>このサイトの使い方</title>

<style type="text/css">
body {
	width: 100%;
	background-attachment: fixed;
	background-image: url("/staff_room/images/input.png");
	background-size: 100% auto;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />

<div class="uk-panel uk-panel-box uk-align-center" style="width:800px;">
					<h1 ><font color="#ffffff">マニュアル一覧</font></h1>
					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">1.ヘッダーメニューについて</h2>&nbsp;
<ul>
	<li>それぞれの項目をクリックすることでそのページに移動します。</li>
	<li>一部の項目は、ポインタを合わせればリンクがリストとして表示されます。<br><br>
	<image src ="/staff_room/images/help/help_header_pulldown.png" width="80%"><br><br>
	</li>
	<li>ログアウトをクリックすると、会社ページに戻ります。</li>
	<li>ロゴをクリックするとログイン状態のまま、会社ページに戻ります。<br><br>
	<image src ="/staff_room/images/help/help_header_logout_logo.png" width="80%"><br><br>
	</li>
	<li>携帯からのアクセスなど、ページが小さく表示される場合はヘッダーの表示がサイドバー形式に切り替わります。<br>
		ヘッダーの端に表示されたボタンをクリックすると、それぞれのページへのリンクがリストとして表示されます。<br><br>
	<image src ="/staff_room/images/help/help_header_mobile.png" width="30%">
	<image src ="/staff_room/images/help/help_header_mobile_pulldown.png" width="30%">
	<image src ="/staff_room/images/help/help_header_mobile_pulldown2.png" width="25%">
	<br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">2.TOP画面について</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の簡易的な閲覧が行えるページです。</li>
	<li>「連絡事項」横の分類別ボタンを押すことでその分類の記事のみが表示されます。</li>
	<li>まだ閲覧していない記事には、「new」というアイコンが表示されます。<br>
		また、記事の作成者が緊急と判断した記事には「緊急」というアイコンが表示されます。</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、ポップアップで記事の内容が表示されます。</li>
	<li>表示されたポップアップの左下のアイコンをクリックすると、記事の内容を印刷することができます。</li>
</ul>

				<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">3.連絡画面について</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の閲覧が行えるページです。</li>
	<li>ヘッダーにリスト表示されたリンクから全ての記事と分類別の記事を表示することができます。<br><br>
	<image src ="/staff_room/images/help/help_header_news_pulldown.png"><br><br>
	</li>
	<li>表示される記事が100件を超える場合には、ページ右下に「次へ」というリンクが表示されます。<br>
		クリックすることで、101件～、201件～と記事を100件ずつ表示することができます。<br><br>
		<image src ="/staff_room/images/help/help_news_next.png" width="80%"><br><br>
	</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、記事の内容が表示されます。<br>
		記事のタイトルを再びクリックすると、記事の内容が非表示になります。</li>
	<li>記事のタイトル横のアイコンをクリックすると、記事の内容を印刷することができます。<br><br>
		<image src ="/staff_room/images/help/help_news_text_printout.png" width="80%"><br><br>
	</li>
</ul>

				<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">4.社内システムについて</h2>&nbsp;
<ul>
	<li>ヘッダーにリスト表示されたそれぞれのリンクをクリックすることで社内システムを利用することができます。<br><br>
	<image src ="/staff_room/images/help/help_header_shanaiS.png"><br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">5.申請書類、規定・書類画面について</h2>&nbsp;
<ul>
	<li>各種書類の閲覧・ダウンロードが行えるページです。<br>
		申請書類ページでは、変更届など記入・提出の必要がある書類とその記入例を利用できます。<br>
		規定・書類ページでは個人情報保護規定など規定に関する書類を利用できます。</li>
	<li>ファイル名をクリックすることで書類の閲覧・ダウンロードが行えます。<br><br>
	<image src ="/staff_room/images/help/help_document.png" width="80%"><br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">6.Mail画面について</h2>&nbsp;
<ul>
	<li>社員のメールアドレスの確認とメールの作成が行えるページです。</li>
	<li>メールアドレスをクリックすると、宛先にそのアドレスが入った状態でメールが作成されます（メールソフトが起動します）</li>
	<li>送りたい人が複数いる場合は、送りたい人全員の名前横のチェックボックスにチェックを入れ、<br>
		「メール作成」ボタンをクリックすれば、全員のアドレスが宛先に入った状態でメールが作成されます。</li>
	<li>「全社員にメール」ボタンをクリックすると、全社員宛のメールが作成されます。</li>
	<li>「メール作成」下のアカサタナそれぞれのボタンをクリックするとその文字の行まで自動的に移動します。</li>
</ul>


	<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">7.掲示板、Photo、etcについて</h2>&nbsp;
<ul>
	<li>ヘッダーからのリンクによって各ページに移動します。</li>
</ul>
<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">8.ログインパスワードの変更について</h2>&nbsp;
<ul>
	<li>ログインパスワードの変更はヘッダーメニューの「etc」の中の、「パスワード変更」から行うことができます。</li>
	<li>現在のパスワードの入力と変更したいパスワードを2回入力することで変更が完了します。</li>
	<li>パスワードは4文字以上、20文字以下で設定して下さい。<br>
		また、アカウントと同一のものはパスワードとして設定することはできません。<br><br>
	<image src ="/staff_room/images/help/help_pwChange.png" width="40%"><br><br>
	</li>
</ul>

<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold">9.ログイン画面について</h2>&nbsp;
<ul>
	<li>「ログイン状態を保持する」にチェックを入れてログインした場合、ログアウトを行う、cookieを削除する、<br>
		ブラウザの変更などの動作を行わない限り、ログイン状態が保持されます。<br>
		（Staff_Roomへのアクセス時、ログインが省略されます）</li>
	<li>ログインが保持される期間は二週間です。この期間は新たに「ログイン状態を保持する」にチェックを入れてログインすることで<br>
		更新されます。<br>
		（その時点から二週間ログインが保持されます。ログインを省略してStaff_Roomにアクセスしても更新はされません）<br><br>
	<image src ="/staff_room/images/help/help_login.png" width="70%"><br><br>
	</li>
</ul>
	</div>
</body>
</html>
