<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0056)http://www.lucentsquare.co.jp:8080/kk_web/Menu_Gamen.jsp -->
<html lang="ja"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="./kintai_files/menu.css" type="text/css">
<script type="text/javascript">
	window.onunload = function() {
		document.body.style.cursor = 'auto';
		document.a.aa.disabled = false;
		document.b.bb.disabled = false;
		document.c.cc.disabled = false;
	}
	function submit1() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.a.submit()
	}
	function submit2() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.b.submit()
	}
	function submit3() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.c.submit()
	}
	function submit4() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.d.dd.disabled = true;
		document.d.submit()
	}
</script>
<title>メニュー画面</title>
</head>
<body>

	<center>
		<div class="box5"></div>
		<div class="box2">
			<big><font class="title1">Member's room</font></big>
			<hr color="#008080">
			<br>
			<form method="post" action="http://www.lucentsquare.co.jp:8080/kk_web/s_kinmuhoukoku_nyuryoku" name="a">
				<ul>
					<li><b><font class="index1">勤務報告入力</font></b> <input type="submit" value="　入力　" class="botton1" onclick="submit1()" name="aa"> <select class="year" name="year">
							
							<option value="2014" selected="2014">2014年
							</option>
							
							<option value="2013">2013年
							</option>
							
							<option value="2012">2012年
							</option>
							
							<option value="2011">2011年
							</option>
							
							<option value="2010">2010年
							</option>
							
							<option value="2009">2009年
							</option>
							
							<option value="2008">2008年
							</option>
							
							<option value="2007">2007年
							</option>
							
							<option value="2006">2006年
							</option>
							
							<option value="2005">2005年
							</option>
							
							<option value="2004">2004年
							</option>
							
							<option value="2003">2003年
							</option>
							
							<option value="2002">2002年
							</option>
							
					</select> <select class="month" name="month">
							
							<option value="1">1月
							</option>
							
							<option value="2">2月
							</option>
							
							<option value="3">3月
							</option>
							
							<option value="4">4月
							</option>
							
							<option value="5" selected="5">5月
							</option>
							
							<option value="6">6月
							</option>
							
							<option value="7">7月
							</option>
							
							<option value="8">8月
							</option>
							
							<option value="9">9月
							</option>
							
							<option value="10">10月
							</option>
							
							<option value="11">11月
							</option>
							
							<option value="12">12月
							</option>
							
					</select></li>
				</ul>
			</form>
			<br>
			<form method="post" action="http://www.lucentsquare.co.jp:8080/kk_web/Escape_NameSelect.jsp" name="b">
				<ul>
					<li><b><font class="index1" style="word-spacing: 30px;">勤務報告閲覧</font></b>
						<input type="submit" value="　閲覧　" class="botton1" onclick="submit2()" name="bb"><input type="hidden" name="escapeflg" id="escapeflg" value="0"></li>
				</ul>
			</form>
			<br>
			<form method="post" action="http://www.lucentsquare.co.jp:8080/kk_web/s_joukyou" name="c">
				<ul>
					<li><b><font class="index1" style="word-spacing: 50px;">承認状況確認</font></b>
						<input type="submit" value="　表示　" class="botton1" onclick="submit3()" name="cc"><select class="year" name="year">
							
							<option value="2014">2014年
							</option>
							
							<option value="2013">2013年
							</option>
							
							<option value="2012">2012年
							</option>
							
							<option value="2011">2011年
							</option>
							
							<option value="2010">2010年
							</option>
							
							<option value="2009">2009年
							</option>
							
							<option value="2008">2008年
							</option>
							
							<option value="2007">2007年
							</option>
							
							<option value="2006">2006年
							</option>
							
							<option value="2005">2005年
							</option>
							
							<option value="2004">2004年
							</option>
							
							<option value="2003">2003年
							</option>
							
							<option value="2002">2002年
							</option>
							
					</select><select class="month" name="month">
							
							<option value="1">1月
							</option>
							
							<option value="2">2月
							</option>
							
							<option value="3">3月
							</option>
							
							<option value="4">4月
							</option>
							
							<option value="5" selected="5">5月
							</option>
							
							<option value="6">6月
							</option>
							
							<option value="7">7月
							</option>
							
							<option value="8">8月
							</option>
							
							<option value="9">9月
							</option>
							
							<option value="10">10月
							</option>
							
							<option value="11">11月
							</option>
							
							<option value="12">12月
							</option>
							
					</select> <select class="group" name="group" style="width: 180px">
							<option value=" 全グループ ">全グループ</option>
							
							<option value="管理部">管理部</option>
							
							<option value="経営統括本部">経営統括本部</option>
							
							<option value="営業部">営業部</option>
							
							<option value="ソリューション本部">ソリューション本部</option>
							
							<option value="ソリューション第一部">ソリューション第一部</option>
							
							<option value="ソリューション第三部">ソリューション第三部</option>
							
							<option value="ビジネス推進室">ビジネス推進室</option>
							
							<option value="北海道支店管理・営業部">北海道支店管理・営業部</option>
							
							<option value="北海道支店ソリューション部">北海道支店ソリューション部</option>
							
							<option value="富山ソリューション部">富山ソリューション部</option>
							
							<option value="大阪ソリューション部">大阪ソリューション部</option>
							
					</select></li>
				</ul>
			</form>
			<br> <a href="http://www.lucentsquare.co.jp:8080/kk_web/SystemSelect.jsp" class="link"><font class="link"><small>[
						システム選択へ戻る ]</small></font></a>
		</div>
		
		
	</center>


</body></html>