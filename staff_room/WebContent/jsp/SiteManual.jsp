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
div#panel {
	position: fixed;
	left:2%;
	max-width: 100%;
	max-height: 100%;
}
div#con {
	position: fixed;
	left:2%;
	max-width: 98%;
	max-height: 100%;
	overflow-y: scroll;
	height:93.5%;

}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<br><br>
<div id="con" class="uk-width-1-1 uk-container-center ">
<br><br><br><br>
<div id="panel" class="uk-panel uk-panel-box uk-align-left" style="width:200px;">
  			<ul class="uk-list uk-list-line">
  					<li><a class="uk-button" href="#login">1.ログイン画面</a></li>
					<li><a class="uk-button" href="#header_menu">2.ヘッダーメニュー</a></li>
					<li><a class="uk-button" href="#top">3.TOP画面</a></li>
					<li><a class="uk-button" href="#news">4.連絡画面</a></li>
					<li><a class="uk-button" href="#shanai_s">5.社内システム</a></li>
					<li><a class="uk-button" href="#document">6.申請書類、規定・書類画面</a></li>
					<li><a class="uk-button" href="#mail">7.Mail画面</a></li>
					<li><a class="uk-button" href="#bbs_photo_etc">8.掲示板、Photo、etc</a></li>
					<li><a class="uk-button" href="#pw_change">9.ログインパスワードの変更</a></li>
			</ul>
</div>
<div class="uk-panel uk-panel-box uk-align-center" style="width:800px">
					<h1 >マニュアル一覧</h1>
					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="login">1.ログイン画面</h2>&nbsp;
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
					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="header_menu">2.ヘッダーメニュー</h2>&nbsp;
<ul>
	<li>それぞれの項目をクリックすることでそのページに移動します。</li>
	<li>一部の項目は、ポインタを合わせればリンクがリストとして表示されます。<br><br>
	<image src ="/staff_room/images/help/help_header_pulldown.png" width="100%"><br><br>
	</li>
	<li>ログアウトをクリックすると、会社ページに戻ります。</li>
	<li>ロゴをクリックするとログイン状態のまま、会社ページに戻ります。<br><br>
	<image src ="/staff_room/images/help/help_header_logout_logo.png" width="100%"><br><br>
	</li>
	<li>携帯からのアクセスなど、ページが小さく表示される場合はヘッダーの表示がサイドバー形式に切り替わります。<br>
		ヘッダーの端に表示されたボタンをクリックすると、それぞれのページへのリンクがリストとして表示されます。<br><br>
	<image src ="/staff_room/images/help/help_header_mobile.png" width="30%">
	<image src ="/staff_room/images/help/help_header_mobile_pulldown.png" width="35%">
	<image src ="/staff_room/images/help/help_header_mobile_pulldown2.png" width="24%">
	<br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="top">3.TOP画面</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の簡易的な閲覧が行えるページです。</li>
	<li>「連絡事項」下の分類別ボタンを押すことでその分類の記事のみが表示されます。</li>
	<li>まだ閲覧していない記事には、「new」というアイコンが表示されます。<br>
		また、記事の作成者が緊急と判断した記事には「緊急」というアイコンが表示されます。<br><br>
	<image src ="/staff_room/images/help/help_top_news.png" width="45%">
	<image src ="/staff_room/images/help/help_top_news_filter.png" width="45%" height="20%"><br><br>
		</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、ポップアップで記事の内容が表示されます。</li>
	<li>表示されたポップアップの左下のアイコンをクリックすると、記事の内容を印刷することができます。<br><br>
	<image src ="/staff_room/images/help/help_top_popup.png" width="50%"><br><br>
	</li>
</ul>

				<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="news">4.連絡画面</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の閲覧が行えるページです。</li>
	<li>ヘッダーにリスト表示されたリンクから全ての記事と分類別の記事を表示することができます。<br><br>
	<image src ="/staff_room/images/help/help_header_news_pulldown.png"><br><br>
	</li>
	<li>表示される記事が100件を超える場合には、ページ右下に「次へ」というリンクが表示されます。<br>
		クリックすることで、101件～、201件～と記事を100件ずつ表示することができます。<br><br>
		<image src ="/staff_room/images/help/help_news_next.png" width="100%"><br><br>
	</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、記事の内容が表示されます。<br>
		記事のタイトルを再びクリックすると、記事の内容が非表示になります。</li>
	<li>記事のタイトル横のアイコンをクリックすると、記事の内容を印刷することができます。<br><br>
		<image src ="/staff_room/images/help/help_news_text_printout.png" width="100%"><br><br>
	</li>
</ul>

				<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="shanai_s">5.社内システム</h2>&nbsp;
<ul>
	<li>ヘッダーにリスト表示されたそれぞれのリンクをクリックすることで社内システムを利用することができます。<br><br>
	<image src ="/staff_room/images/help/help_header_shanaiS.png"><br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold"id="document">6.申請書類、規定・書類画面</h2>&nbsp;
<ul>
	<li>各種書類の閲覧・ダウンロードが行えるページです。<br>
		申請書類ページでは、変更届など記入・提出の必要がある書類とその記入例を利用できます。<br>
		規定・書類ページでは個人情報保護規定など規定に関する書類を利用できます。</li>
	<li>ファイル名をクリックすることで書類の閲覧・ダウンロードが行えます。<br><br>
	<image src ="/staff_room/images/help/help_document.png" width="100%"><br><br>
	</li>
</ul>

					<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold"id="mail">7.Mail画面</h2>&nbsp;
<ul>
	<li>社員のメールアドレスの確認とメールの作成が行えるページです。</li>
	<li>メールアドレスをクリックすると、宛先にそのアドレスが入った状態でメールが作成されます（メールソフトが起動します）</li>
	<li>送りたい人が複数いる場合は、送りたい人全員の名前横のチェックボックスにチェックを入れ、<br>
		「メール作成」ボタンをクリックすれば、全員のアドレスが宛先に入った状態でメールが作成されます。</li>
	<li>「全社員にメール」ボタンをクリックすると、全社員宛のメールが作成されます。<br><br>
	<image src ="/staff_room/images/help/help_mail_checkbox.png" width="100%"><br><br>
	</li>
	<li>「メール作成」下のアカサタナそれぞれのボタンをクリックするとその文字の行まで自動的に移動します。<br><br>
	<image src ="/staff_room/images/help/help_mail_jump.png" width="100%"><br><br>
	</li>
</ul>


	<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="bbs_photo_etc">8.掲示板、Photo、etc</h2>&nbsp;
<ul>
	<li>ヘッダーからのリンクによって各ページに移動します。<br><br>
	<image src ="/staff_room/images/help/help_bbs.png" width="35%">
	<image src ="/staff_room/images/help/help_photo_pulldown.png" width="28%">
	<image src ="/staff_room/images/help/help_etc.png" width="35%"><br><br>
	</li>
</ul>
<h2 data-uk-toggle="{target:'#my-id1'}" class="uk-text-bold" id="pw_change">9.ログインパスワードの変更</h2>&nbsp;
<ul>
	<li>ログインパスワードの変更はヘッダーメニューの「etc」の中の、「パスワード変更」から行うことができます。<br><br>
	<image src ="/staff_room/images/help/help_pwChange_pulldown.png" ><br><br></li>
	<li>現在のパスワードの入力と変更したいパスワードを2回入力することで変更が完了します。</li>
	<li>パスワードは4文字以上、20文字以下で設定して下さい。<br>
		また、アカウントと同一のものはパスワードとして設定することはできません。<br><br>
	<image src ="/staff_room/images/help/help_pwChange.png" width="40%"><br><br>
	</li>
</ul>
	</div>
	</div>
</body>
</html>
