<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String user = String.valueOf(session.getAttribute("admin")); %>
<html>
<head>

<style type="text/css">
nav#header {
	width: 100%;
	height: 42px;
	position: fixed;
	opacity: 1;
	top: 0;
 	z-index: 10000000;
 	background-image:url(/staff_room/images/hcolorapple.png);
 	background-size:100% 100%;

}
nav#header >ul >li> a{text-decoration:none; color:whitesmoke; font-size:1em; text-shadow:0px 0px black;}
nav#header >ul >li  >div{background-image:url(/staff_room/images/hcolorapple.png);background-size:100% 100%; }
nav#header >ul >li  >div >ul >li >a {color:whitesmoke; font-size:1.1em; text-shadow:1px 1px black;}
nav#header >ul >li> a:active{background-color:gray; color:whitesmoke;}
nav#header >ul >li> div >ul >li >a:hover{background-color:black; color:whitesmoke;}

#side,#logo {
	display: none;
}

#help {
	text-decoration: none;
	color: whitesmoke;
	font-size: 1em;
	text-shadow: 0px 0px black;
	line-height: 40px;
}

#help:active{
background-color:gray;
}




#rare{
	display: none;
	position: relative;
	float: right;
	top: 50px;
	width: 150px;
	background-color: #444;
	text-shadow: 0 1px 0 #fff;
	z-index: 10;
}

#rare h5{
	margin-top: 5px;
	text-decoration: none;
	color: #fff;
	text-shadow: 0px 0px black;
}

#rare li>a{
	text-decoration: none;
	color: #ccc;
	font-size: 1em;
	text-shadow: 0px 0px black;
}

#rare li>a:active{
	background-color: gray;
	color: #fff;
}

#rare li>a:hover{
	color: #fff;
}
</style>
<script>
function sidebar(){
	var w = $(window).width();
	if(w <= 750){
		$("#nav,#rare").hide();
		$("#logo,#side").show();
	}else if(w > 750 && w <= 980){
		$("#nav,#rare").show();
		$("#etc,#flip").hide();
	}else{
		$("#nav").show();
		$("#etc,#flip").show();
		$("#logo,#side,#rare").hide();
	}
}
$(function(){
	sidebar();
});
$(window).resize(function(){
	sidebar();
});

if (navigator.userAgent.indexOf('iPhone') > 0 || navigator.userAgent.indexOf('iPad') > 0 || navigator.userAgent.indexOf('iPod') > 0 || navigator.userAgent.indexOf('Android') > 0) {
	function smart(){
	$("#nav").hide();
	$("#logo,#side").show();
	}
}
</script>
</head>
<nav id="header" class="uk-navbar">
	<ul class="uk-navbar-nav" id="nav" >
		<li class="header"><a href="//www.lucentsquare.co.jp/"
			class="uk-navbar-brand"> <img src="/staff_room/images/Logo.png"
				alt="会社のページに戻る" width="30" height="30"></img></a></li>
		<li class="header"><a href="/staff_room/jsp/top/top.jsp">TOP</a></li>
		<li id="wal" class="uk-parent header" data-uk-dropdown>
			<a href="/staff_room/jsp/news.jsp?news=all">連絡
				<i class="uk-icon-caret-down"></i>
			</a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
                    <li><a href="/staff_room/jsp/news.jsp?news=all">すべて</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=1">総務</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=2">人事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=3">行事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=4">ビジネス推進室</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=5">その他</a></li>
					<% if(user.equals("1")){ %>
					<li class="uk-nav-divider"></li>
					<li><a href="/staff_room/jsp/writeNews/writeNews.jsp">管理-連絡</a></li>
					<% } %>
				</ul>
			</div></li>
		<li class="uk-parent header" data-uk-dropdown><a>社内システム<i
				class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=1">社内スケジュール</a>
                    </li>
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=2">社内勤怠システム</a>
                    </li>
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=3">社内文書システム</a>
                    </li>
 					<li><a href="/staff_room/jsp/shanai_s/doc/manual01.pdf" target="_blank">社内文書システム<br>操作説明</a></li>


					<% if(user.equals("1")){ %>
					<li class="uk-nav-divider"></li>
                    <li><a href="/staff_room/jsp/shanai_s/administrator.jsp">管理-社内システム</a></li>
                    <% } %>
				</ul>
			</div></li>
		<li class="header"><a href="/staff_room/jsp/manual/manual.jsp">組織表/規程</a></li>
		<li class="header"><a href="/staff_room/jsp/document/teisyutsusyorui.jsp">申請書類</a></li>
		<li class="header"><a href="/staff_room/jsp/mail/mail.jsp">Mail</a></li>
		<li class="header"><a href="/staff_room/jsp/bbs/bbs.jsp">掲示板</a></li>
		<li class="uk-parent header" data-uk-dropdown><a>Photo<i
				class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a
						href="/staff_room/jsp/photo.jsp?ph=1">BBQ写真館</a></li>
					<li><a
						href="/staff_room/jsp/photo.jsp?ph=2">創立２５周年記念</a></li>
				</ul>
			</div>
		</li>
		<li class="uk-parent header" id="etc" data-uk-dropdown>
			<a>etc<i class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="/staff_room/jsp/pwChange/pwChange.jsp">パスワード変更</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=1">GPS</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=2">e-talent</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=3">Advance meeting</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=4">新入社員紹介</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=5">401K説明書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=6">Pマーク関係書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=7">社内報2005</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=8">社内報2006</a></li>

				</ul>
			</div>
		</li>
	</ul>
	<div class="uk-navbar-content uk-navbar-flip uk-hidden-small" id="flip">
    	<ul class="uk-navbar-nav">
    		<li><a href="/staff_room/jsp/help/SiteManual.jsp" id="help">ヘルプ</a></li>
    	</ul>
 		<a class="uk-button uk-button-danger" href="/staff_room/Logout">ログアウト</a>
 	</div>
	<a href="" class="uk-navbar-toggle uk-visible-small" id="side" data-uk-offcanvas="{target:'#sidenav'}"></a>
	<div class="uk-visible-small uk-navbar-brand uk-navbar-center" id="logo">
		<a href="//www.lucentsquare.co.jp/">
			<img src="/staff_room/images/Logo.png" alt="会社のページに戻る" style="width:35px;height:35px"></img>
		</a>
	</div>

	<!-- sidebar -->
	<div id="sidenav" class="uk-offcanvas">
    <div class="uk-offcanvas-bar">
        <ul class="uk-nav uk-nav-offcanvas uk-nav-parent-icon" data-uk-nav>
        	<li><a href="/staff_room/jsp/top/top.jsp">TOP</a></li>
        	<li class="uk-parent">
        		<a href="#">連絡</a>
        		<ul class="uk-nav-sub">
        			<li><a href="/staff_room/jsp/news.jsp?news=all">すべて</a></li>
        			<li><a href="/staff_room/jsp/news.jsp?news=1">総務</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=2">人事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=3">行事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=4">ビジネス推進室</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=5">その他</a></li>
					<% if(user.equals("1")){ %>
					<li class="uk-nav-divider"></li>
					<li><a href="/staff_room/jsp/writeNews/writeNews.jsp">管理-連絡</a></li>
					<% } %>
				</ul>
        	</li>
        	<li class="uk-parent">
        		<a href="#">社内システム</a>
        		<ul class="uk-nav-sub">
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=1">社内スケジュール</a>
                    </li>
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=2">社内勤怠システム</a>
                    </li>
                    <li>
                    <a href="/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp?mode=3">社内文書システム</a>
                    </li>
                    <li><a href="/staff_room/jsp/shanai_s/doc/manual01.pdf" target="_blank">社内文書システム<br>操作説明</a></li>
					<% if(user.equals("1")){ %>
					<li class="uk-nav-divider"></li>
                    <li><a href="/staff_room/jsp/shanai_s/administrator.jsp">管理-社内システム</a></li>
					<% } %>
				</ul>
        	</li>
			<li class="header"><a href="/staff_room/jsp/manual/manual.jsp">組織表/規程</a></li>
			<li class="header"><a href="/staff_room/jsp/document/teisyutsusyorui.jsp">申請書類</a></li>
			<li class="header"><a href="/staff_room/jsp/mail/mail.jsp">Mail</a></li>
			<li class="header"><a href="/staff_room/jsp/bbs/bbs.jsp">掲示板</a></li>
			<li class="uk-parent">
				<a href="#">Photo</a>
				<ul class="uk-nav-sub">
					<li><a href="/staff_room/jsp/photo.jsp?ph=1">BBQ写真館</a></li>
					<li><a href="/staff_room/jsp/photo.jsp?ph=2">創立２５周年記念</a></li>
				</ul>
			</li>
			<li class="uk-parent">
				<a href="#">etc</a>
				<ul class="uk-nav-sub">
					<li><a href="/staff_room/jsp/pwChange/pwChange.jsp">パスワード変更</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=1">GPS</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=2">e-talent</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=3">Advance meeting</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=4">新入社員紹介</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=5">401K説明書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=6">Pマーク関係書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=7">社内報2005</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=8">社内報2006</a></li>
				</ul>
			</li>
			<li class="header"><a href="/staff_room/Logout">ログアウト</a></li>
			<li class="header"><a href="/staff_room/jsp/help/SiteManual.jsp">ヘルプ</a></li>
        </ul>
    </div>
</div>
</nav>
<div class="uk-panel uk-panel-box" id="rare">
	<ul class="uk-nav uk-nav-side uk-nav-parent-icon" data-uk-nav>
		<li class="uk-parent data-uk-dropdown"><a href="#">etc</a>
			<ul class="uk-nav-sub">
				<li><a href="/staff_room/jsp/etc.jsp?etc=1">GPS</a></li>
					<li><a href="/staff_room/jsp/pwChange/pwChange.jsp">パスワード変更</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=2">e-talent</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=3">Advance meeting</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=4">新入社員紹介</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=5">401K説明書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=6">Pマーク関係書類</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=7">社内報2005</a></li>
					<li><a href="/staff_room/jsp/etc.jsp?etc=8">社内報2006</a></li>
			</ul>
		</li>
		<li><a href="/staff_room/jsp/help/SiteManual.jsp">ヘルプ</a></li>
		<li><a href="/staff_room/Logout">ログアウト</a></li>
	</ul>
</div>
</html>
