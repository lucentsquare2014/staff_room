<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 	nav#header {
 		width: 100%;
 		position: fixed;
 		opacity: 0.8;
 	}
</style>
<nav id="header" class="uk-navbar">
	<a href="http://www.lucentsquare.co.jp/" class="uk-navbar-brand">
		<img src="Logo.png" alt="会社のページに戻る" width="30" height="30"></img>
	</a>
	<ul class="uk-navbar-nav">
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">連絡<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="">総務</a></li>
					<li><a href="">人事</a></li>
					<li><a href="">行事</a></li>
					<li><a href="">開発企画</a></li>
					<li><a href="">その他</a></li>
					<li class="uk-nav-divider"></li>
					<li><a href="">管理-連絡</a></li>
			</ul>
			</div>
		</li>
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">社内システム<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="">社内スケジュール</a></li>
					<li><a href="">社内勤怠システム</a></li>
					<li><a href="">社内文書システム</a></li>
					<li><a href="">社内システム操作説明</a></li>
					<li class="uk-nav-divider"></li>
					<li><a href="">管理-社内システム</a></li>
				</ul>
			</div>
		</li>
		<li class="header"><a href="">申請書類</a></li>
		<li class="header"><a href="">マニュアル</a></li>
		<li class="header"><a href="">Mail</a></li>
		<li class="header"><a href="">掲示板</a></li>
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">Photo<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="">BBQ写真館</a></li>
					<li><a href="">創立２５周年記念</a></li>
					<li class="uk-nav-divider"></li>
					<li><a href="">管理-Photo</a></li>
			</ul>
			</div>
		</li>
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">etc<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="">GPS</a></li>
					<li><a href="">e-talent</a></li>
					<li><a href="">Advance meeting</a></li>
				</ul>
			</div>
		</li>
	</ul>
	<div class="uk-navbar-flip">
		<ul class="uk-navbar-nav">
			<li><a href="">ログアウト</a></li>
		</ul>                            
    </div>
</nav>