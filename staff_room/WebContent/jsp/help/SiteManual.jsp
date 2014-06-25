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

a#jump:link { color:#000; text-decoration:none }
a#jump:visited { color:#000; text-decoration:none }
a#jump:hover { color:#0000ff; text-decoration:none }
a#jump:active { color:#0000ff; text-decoration:none }

div#panel {
	max-height: 100%;
	width:200px;
	float:left;
}
div#con {
	position: relative;
	margin-top:82px;
	width: 1080px;
	max-height: 100%;
	height:93.5%;
	margin-right:auto;
	margin-left:2%;
}
div#manual{
	overflow-y:scroll;
	width:800px;
	height:500px;
	float:left;
}
#con img{
	border:3px solid;
}
</style>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
<div id="con" class="uk-container-center ">
<div id="panel" class="uk-panel uk-panel-box uk-align-left">
  			<ul class="uk-list uk-list-line">
  					<li><a href="#login" id="jump">1.ログイン画面</a></li>
					<li><a href="#header_menu" id="jump">2.ヘッダーメニュー</a></li>
					<li><a href="#top" id="jump">3.TOP画面</a></li>
					<li><a href="#news" id="jump">4.連絡画面</a></li>
					<li><a href="#shanai_s" id="jump">5.社内システム</a></li>
					<li><a href="#document" id="jump">6.組織表/規程、申請書類画面</a></li>
					<li><a href="#mail" id="jump">7.Mail画面</a></li>
					<li><a href="#bbs_photo_etc" id="jump">8.掲示板、Photo、etc</a></li>
					<li><a href="#pw_change" id="jump">9.ログインパスワードの変更</a></li>
					<li><a href="#admin" id="jump">10.管理者側の操作について</a></li>
					<li><a href="#information" id="jump">11.お問い合わせ・バージョン情報</a></li>
			</ul>
</div>
<div id="manual"class="uk-panel uk-panel-box uk-align-center" >
					<h1 >マニュアル一覧</h1>
					<h2 class="uk-text-bold" id="login">1.ログイン画面</h2>&nbsp;
<ul>
	<li>「ログイン状態を保持する」にチェックを入れてログインした場合、ログアウトを行う、cookieを削除する、<br>
		ブラウザの変更などの動作を行わない限り、ログイン状態が保持されます。<br>
		（Staff_Roomへのアクセス時、ログインが省略されます）</li>
	<li>ログインが保持される期間は二週間です。この期間は新たに「ログイン状態を保持する」にチェックを入れてログインすることで<br>
		更新されます。<br>
		（その時点から二週間ログインが保持されます。ログインを省略してStaff_Roomにアクセスしても更新はされません）<br><br>
	<img src ="/staff_room/images/help/help_login.png" width="70%"><br><br>
	</li>
</ul>
					<h2 class="uk-text-bold" id="header_menu">2.ヘッダーメニュー</h2>&nbsp;
<ul>
	<li>それぞれの項目をクリックすることでそのページに移動します。</li>
	<li>一部の項目は、ポインタを合わせればリンクがリストとして表示されます。<br><br>
	<img src ="/staff_room/images/help/help_header_pulldown.png" width="100%"><br><br>
	</li>
	<li>ログアウトをクリックすると、会社ページに戻ります。</li>
	<li>ロゴをクリックするとログイン状態のまま、会社ページに戻ります。<br><br>
	<img src ="/staff_room/images/help/help_header_logout_logo.png" width="100%"><br><br>
	</li>
	<li>携帯からのアクセスなど、ページが小さく表示される場合はヘッダーの表示がサイドバー形式に切り替わります。<br>
		ヘッダーの端に表示されたボタンをクリックすると、それぞれのページへのリンクがリストとして表示されます。<br><br>
	<img src ="/staff_room/images/help/help_header_mobile.png" width="30%">
	<img src ="/staff_room/images/help/help_header_mobile_pulldown.png" width="35%">
	<img src ="/staff_room/images/help/help_header_mobile_pulldown2.png" width="24%">
	<br><br>
	</li>
</ul>

					<h2 class="uk-text-bold" id="top">3.TOP画面</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の簡易的な閲覧が行えるページです。</li>
	<li>「連絡事項」下の分類別ボタンを押すことでその分類の記事のみが表示されます。</li>
	<li>まだ閲覧していない記事には、「new」というアイコンが表示されます。<br>
		また、記事の作成者が緊急と判断した記事には「緊急」というアイコンが表示されます。<br><br>
	<img src ="/staff_room/images/help/help_top_news.png" width="45%">
	<img src ="/staff_room/images/help/help_top_news_filter.png" width="45%" height="20%"><br><br>
		</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、ポップアップで記事の内容が表示されます。</li>
	<li>表示されたポップアップの左下のアイコンをクリックすると、記事の内容を印刷することができます。<br><br>
	<img src ="/staff_room/images/help/help_top_popup.png" width="50%"><br><br>
	</li>
</ul>

				<h2 class="uk-text-bold" id="news">4.連絡画面</h2>&nbsp;
<ul>
	<li>連絡事項として作成された記事の閲覧が行えるページです。</li>
	<li>ヘッダーにリスト表示されたリンクから全ての記事と分類別の記事を表示することができます。<br><br>
	<img src ="/staff_room/images/help/help_header_news_pulldown.png"><br><br>
	</li>
	<li>表示される記事が100件を超える場合には、ページ右下に「次へ」というリンクが表示されます。<br>
		クリックすることで、101件～、201件～と記事を100件ずつ表示することができます。<br><br>
		<img src ="/staff_room/images/help/help_news_next.png" width="100%"><br><br>
	</li>
	<li>表示されているそれぞれの記事のタイトルをクリックすると、記事の内容が表示されます。<br>
		記事のタイトルを再びクリックすると、記事の内容が非表示になります。</li>
	<li>記事のタイトル横のアイコンをクリックすると、記事の内容を印刷することができます。<br><br>
		<img src ="/staff_room/images/help/help_news_text_printout.png" width="100%"><br><br>
	</li>
</ul>

				<h2 class="uk-text-bold" id="shanai_s">5.社内システム</h2>&nbsp;
<ul>
	<li>ヘッダーにリスト表示されたそれぞれのリンクをクリックすることで社内システムを利用することができます。<br><br>
	<img src ="/staff_room/images/help/help_header_shanaiS.png"><br><br>
	</li>
</ul>

					<h2 class="uk-text-bold"id="document">6.組織表/規程、申請書類画面</h2>&nbsp;
<ul>
	<li>各種書類の閲覧・ダウンロードが行えるページです。<br>
		組織表/規程ページでは個人情報保護規定など規定に関する書類を利用できます。<br>
		申請書類ページでは、変更届など記入・提出の必要がある書類とその記入例を利用できます。
		</li>
	<li>ファイル名をクリックすることで書類の閲覧・ダウンロードが行えます。<br><br>
	<img src ="/staff_room/images/help/help_document.png" width="100%"><br><br>
	</li>
</ul>

					<h2 class="uk-text-bold"id="mail">7.Mail画面</h2>&nbsp;
<ul>
	<li>社員のメールアドレスの確認とメールの作成が行えるページです。</li>
	<li>メールアドレスをクリックすると、宛先にそのアドレスが入った状態でメールが作成されます（メールソフトが起動します）</li>
	<li>送りたい人が複数いる場合は、送りたい人全員の名前横のチェックボックスにチェックを入れ、<br>
		「メール作成」ボタンをクリックすれば、全員のアドレスが宛先に入った状態でメールが作成されます。<br>
		<div class="uk-text-danger">
		※一度にメールを作成できるのは70名までです。例外として全社員宛のメールならば作成することができます。<br><br>
		</div>
		<img src ="/staff_room/images/help/help_mail_checkbox.png" width="100%"><br><br>
	</li>
	<li>「全選択」ボタンをクリックすると、全てのチェックボックスにチェックが入ります。<br>
		「選択解除」ボタンをクリックすると、全てのチェックがリセットされます。<br><br>
		<img src ="/staff_room/images/help/help_mail_checkbotton.png" width="100%"><br><br>
	</li>
	<li>各ボタン下のアカサタナそれぞれのボタンをクリックするとその文字の行まで自動的に移動します。<br><br>
		<img src ="/staff_room/images/help/help_mail_jump.png" width="100%"><br><br>
	</li>
</ul>


	<h2 class="uk-text-bold" id="bbs_photo_etc">8.掲示板、Photo、etc</h2>&nbsp;
<ul>
	<li>ヘッダーからのリンクによって各ページに移動します。<br><br>
	<img src ="/staff_room/images/help/help_bbs.png" width="35%">
	<img src ="/staff_room/images/help/help_photo_pulldown.png" width="28%">
	<img src ="/staff_room/images/help/help_etc.png" width="35%"><br><br>
	</li>
</ul>
<h2 class="uk-text-bold" id="pw_change">9.ログインパスワードの変更</h2>&nbsp;
<ul>
	<li>ログインパスワードの変更はヘッダーメニューの「etc」の中の、「パスワード変更」から行うことができます。<br><br>
	<img src ="/staff_room/images/help/help_pwChange_pulldown.png" ><br><br></li>
	<li>現在のパスワードの入力と変更したいパスワードを2回入力することで変更が完了します。</li>
	<li>パスワードは4文字以上、20文字以下で設定して下さい。<br>
		また、アカウントと同一のものはパスワードとして設定することはできません。<br><br>
	<img src ="/staff_room/images/help/help_pwChange.png" width="40%"><br><br>
	</li>
</ul>
<h2 class="uk-text-bold" id="admin">10.管理者側の操作について</h2>&nbsp;
<ul>
	<li>以下の資料をご利用ください。<br><br></li>
	<li><a href="/staff_room/jsp/help/doc/admin_help.pdf" target="_blank">管理者マニュアル</a></li>
</ul>
<ol>
	<li><a href="/staff_room/jsp/help/doc/news_help.pdf" target="_blank">記事管理ヘルプ</a></li>
	<li><a href="/staff_room/jsp/help/doc/shanai_s_help_help.pdf" target="_blank">社内システムヘルプ</a></li>
	<li><a href="/staff_room/jsp/help/doc/doc_help.pdf" target="_blank">書類アップロードヘルプ</a></li>
	<li><a href="/staff_room/jsp/help/doc/read_check_help.pdf" target="_blank">記事未読件数表示ヘルプ</a></li>
	<li><a href="/staff_room/jsp/help/doc/photo_help.pdf" target="_blank">PHOTOページ追加ヘルプ</a></li>
</ol>
<h2 class="uk-text-bold" id="information">11.問い合わせ・バージョン情報</h2>&nbsp;
<ul>
	<li>Staff_Roomのお問合せは：<a href ="mailto:lsc-admin@lucentsquare.co.jp">ビジネス推進室</a><br><br></li>
	<li>2014/06/27 ver1.00 リリース<br><br><br><br></li>
</ul>
	</div>
	</div>
</body>
</html>
