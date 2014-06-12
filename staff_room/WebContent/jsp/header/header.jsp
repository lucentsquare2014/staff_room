<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String user = String.valueOf(session.getAttribute("login")); %>
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
</style>
<script>
function sidebar(){
	var w = $(window).width();
	if(w <= 700){
		$("#nav,#logout").hide();
		$("#logo,#side").show();
	}
	if(w > 700){
		$("#nav,#logout").show();
		$("#logo,#side").hide();
	}
}
$(function(){
	sidebar();
});
$(window).resize(function(){
	sidebar();
});
</script>

<nav id="header" class="uk-navbar">
	<ul class="uk-navbar-nav" id="nav" >
		<li class="header"><a href="//www.lucentsquare.co.jp/"
			class="uk-navbar-brand"> <img src="/staff_room/images/Logo.png"
				alt="会社のページに戻る" width="30" height="30"></img></a></li>
		<li class="header"><a href="/staff_room/jsp/top/top.jsp">TOP</a></li>
		<li id="w" class="uk-parent header" data-uk-dropdown>
			<a href="/staff_room/jsp/news.jsp?news=all">連絡
				<i class="uk-icon-caret-down"></i>
			</a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
                    <li><a href="/staff_room/jsp/news.jsp?news=all">すべて</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=1">総務</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=2">人事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=3">行事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=4">開発企画</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=5">その他</a></li>
					<% if(user.equals("admin")){ %>
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
 					<li><a href="/staff_room/jsp/shanai_s/doc/manual01.pdf">社内文書システム<br>操作説明</a></li>


					<% if(user.equals("admin")){ %>
					<li class="uk-nav-divider"></li>
                    <li><a href="/staff_room/jsp/shanai_s/administrator.jsp">管理-社内システム</a></li>
                    <% } %>
				</ul>
			</div></li>
		<li class="header"><a href="/staff_room/jsp/document/teisyutsusyorui.jsp">申請書類</a></li>
		<li class="header"><a href="/staff_room/jsp/manual/manual.jsp">規定・書類</a></li>
		<li class="header"><a href="/staff_room/jsp/mail/mail.jsp">Mail</a></li>
		<li class="header"><a href="/staff_room/jsp/bbs/bbs.jsp">掲示板</a></li>
		<li class="uk-parent header" data-uk-dropdown><a>Photo<i
				class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a
						href="//www.lucentsquare.co.jp/staff/bbq_index.html">BBQ写真館</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/25%E5%91%A8%E5%B9%B4%E8%A8%98%E5%BF%B5%E8%A1%8C%E4%BA%8B%E6%A1%88%E5%86%85/25year_index.html">創立２５周年記念</a></li>
				</ul>
			</div>
		</li>
		<li class="uk-parent header" data-uk-dropdown><a>etc<i
				class="uk-icon-caret-down"></i></a>
			<div class="uk-dropdown uk-dropdown-navbar">
				<ul class="uk-nav uk-nav-navbar">
					<li><a href="//www.lucentsquare.co.jp/gps/pc/">GPS</a></li>
					<li><a
						href="//www.lucentsquare.co.jp:8080/etalent5_27/main.jsp">e-talent</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/WorkingGroup/Advance_WorkingGroup.html">Advance
							meeting</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/newstaff_2014/newstaff_index.html">新入社員紹介</a></li>
					<li><a
						href="/staff_room/jsp/pwChange/pwChange.jsp">パスワード変更</a></li>
				</ul>
			</div>
		</li>
		<li class="uk-parent header" data-uk-dropdown><a>アカウント管理<i class="uk-icon-caret-down"></i></a>
            <div class="uk-dropdown uk-dropdown-navbar">
                <ul class="uk-nav uk-nav-navbar">
                    <% if(user.equals("admin")){ %>
                    <li class="uk-nav-divider"></li>
                        <li><a href="/staff_room/jsp/accountssettings/accountsmanage.jsp">管理者の追加・削除</a></li>
                    <% } %>
                </ul>
            </div>
        </li>
		

	</ul>
	<div class="uk-navbar-content uk-navbar-flip uk-hidden-small" id="logout">
    	<div class="uk-button-group">
 			<a class="uk-button uk-button-danger" href="/staff_room/Logout">ログアウト</a>
        </div>
 	</div>
 	<div class="header" style="float:right;" id="logout">
 		<a href="/staff_room/jsp/SiteManual.jsp"style="text-decoration:none; color:whitesmoke; font-size:1em; text-shadow:0px 0px black;line-height: 40px;">
 		ヘルプ
 		</a>
 	</div>

	<a href="" class="uk-navbar-toggle uk-visible-small" id="side" data-uk-offcanvas="{target:'#sidenav'}"></a>
	<div class="uk-navbar-content uk-navbar-center uk-align-center" id="logo">
		<a href="//www.lucentsquare.co.jp/"
			class="uk-navbar-brand"> <img src="/staff_room/images/Logo.png"
				alt="会社のページに戻る" width="30" height="30"></img></a>
	</div>
	<div id="sidenav" class="uk-offcanvas">
    <div class="uk-offcanvas-bar">
        <ul class="uk-nav uk-nav-offcanvas uk-nav-parent-icon" data-uk-nav>
        	<li><a href="/staff_room/jsp/top/top.jsp">TOP</a></li>
        	<li class="uk-parent">
        		<a href="#">連絡</a>
        		<ul class="uk-nav-sub">
        			<li><a href="/staff_room/jsp/news.jsp?news=all">全て</a></li>
        			<li><a href="/staff_room/jsp/news.jsp?news=1">総務</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=2">人事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=3">行事</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=4">開発企画</a></li>
					<li><a href="/staff_room/jsp/news.jsp?news=5">その他</a></li>
					<% if(user.equals("admin")){ %>
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
                    <li><a href="/staff_room/jsp/shanai_s/doc/manual01.pdf"> 社内文書システム操作説明</a></li>
					<% if(user.equals("admin")){ %>
					<li class="uk-nav-divider"></li>
                    <li><a href="/staff_room/jsp/shanai_s/administrator.jsp">管理-社内システム</a></li>
					<% } %>
				</ul>
        	</li>
        	<li class="header"><a href="/staff_room/jsp/document/teisyutsusyorui.jsp">申請書類</a></li>
			<li class="header"><a href="/staff_room/jsp/manual/manual.jsp">マニュアル</a></li>
			<li class="header"><a href="/staff_room/jsp/mail/mail.jsp">Mail</a></li>
			<li class="header"><a href="/staff_room/jsp/bbs/bbs.jsp">掲示板</a></li>
			<li class="uk-parent">
				<a href="#">Photo</a>
				<ul class="uk-nav-sub">
					<li><a
						href="//www.lucentsquare.co.jp/staff/bbq_index.html">BBQ写真館</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/25%E5%91%A8%E5%B9%B4%E8%A8%98%E5%BF%B5%E8%A1%8C%E4%BA%8B%E6%A1%88%E5%86%85/25year_index.html">創立２５周年記念</a></li>
				</ul>
			</li>
			<li class="uk-parent">
				<a href="#">etc</a>
				<ul class="uk-nav-sub">
					<li><a href="//www.lucentsquare.co.jp/gps/pc/">GPS</a></li>
					<li><a
						href="//www.lucentsquare.co.jp:8080/etalent5_27/main.jsp">e-talent</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/WorkingGroup/Advance_WorkingGroup.html">Advance
							meeting</a></li>
					<li><a
						href="//www.lucentsquare.co.jp/staff/newstaff_2014/newstaff_index.html">新入社員紹介</a></li>
					<li><a
						href="/staff_room/jsp/pwChange/pwChange.jsp">パスワード変更</a></li>
				</ul>
			</li>
			<li class="header"><a href="/staff_room/Logout">ログアウト</a></li>
			<li class="header"><a href="/staff_room/jsp/SiteManual.jsp">ヘルプ</a></li>
        </ul>
    </div>
</div>
</nav>
