<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 	nav#header {
 		width: 100%;
 		position: fixed;
 		opacity: 1;
 	}
 
</style>
<nav id="header" class="uk-navbar">
	<a href="http://www.lucentsquare.co.jp/" class="uk-navbar-brand">
		<img src="./Logo.png" alt="会社のページに戻る" width="30" height="30"></img>
	</a>
	<ul class="uk-navbar-nav">
	<li class="header"><a href="./top.jsp">TOP</a></li>
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
					<li><a href="schedule.jsp">社内スケジュール</a></li>
					<li><a href="attendance.jsp">社内勤怠システム</a></li>
					<li><a href="document.jsp">社内文書システム</a></li>
					<li><a href="setsumei.jsp">社内システム操作説明</a></li>
					<li class="uk-nav-divider"></li>
					<li><a href="administer.jsp">管理-社内システム</a></li>
				</ul>
			</div>
		</li>
		<li class="header"><a href="teisyutsusyorui.jsp">申請書類</a></li>
		<li class="header"><a href="manual.jsp">マニュアル</a></li>
		<li class="header"><a href="http://www.lucentsquare.co.jp/staff/mail_link.html">Mail</a></li>
		<li class="header"><a href="http://www.lucentsquare.co.jp/staff/members/joyful/joyful.cgi">掲示板</a></li>
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">Photo<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="http://www.lucentsquare.co.jp/staff/bbq_index.html">BBQ写真館</a></li>
					<li><a href="http://www.lucentsquare.co.jp/staff/25%E5%91%A8%E5%B9%B4%E8%A8%98%E5%BF%B5%E8%A1%8C%E4%BA%8B%E6%A1%88%E5%86%85/25year_index.html">創立２５周年記念</a></li>
			</ul>
			</div>
		</li>
		<li class="uk-parent header" data-uk-dropdown>
			<a href="">etc<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="http://www.lucentsquare.co.jp/gps/pc/">GPS</a></li>
					<li><a href="http://www.lucentsquare.co.jp:8080/etalent5_27/main.jsp">e-talent</a></li>
					<li><a href="http://www.lucentsquare.co.jp/staff/WorkingGroup/Advance_WorkingGroup.html">Advance meeting</a></li>
				</ul>
			</div>
		</li>
	</ul>
	<div class="uk-navbar-flip">
		<ul class="uk-navbar-nav">
			<li><a href="../Logout">ログアウト</a></li>
		</ul>                            
    </div>
</nav>
