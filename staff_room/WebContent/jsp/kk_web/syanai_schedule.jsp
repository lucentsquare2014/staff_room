<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- saved from url=(0050)http://www.lucentsquare.co.jp:8080/kk_web/menu.jsp -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MSJ ～ MainMenu ～</title>
<style type="text/css">
body {
	text-align: center;
}
span.shadow {
	filter: shadow(color = black, direction = 135);
	position: relative;
	height: 50;
	width: 100%;
	text-shadow: black;
}

table.button {
	border-style: solid; 
	border-color: #D6FFFF;
	border-width: 5px;
	width: 300px;
	margin: auto;
	border-spacing: 5px;
	border-collapse: separate;
}

td.a {
	width: 100%;
	border-style: none;
	border-width: 0px;
	background-color: #D6FFFF;
	text-align: center;
	vertical-align: middle;
	padding: 15px;
	margin: auto;
}
</style>
</head>
<body bgcolor="#99A5FF">
	<h1>
		<span class="shadow"> 
			<font color="white">
				<font color="GOLD">M</font>anagement
				<font color="GOLD">S</font>chedule
				<font color="GOLD">J</font>ava ver 2.0<br>～ MainMenu ～
			</font>
		</span>
	</h1>
	<p>
	<font color="white">お名前：玉城　亨文</font>
	</p><table border="1" class="button">
		<tbody><tr>
			<td class="a">
				<form action="http://www.lucentsquare.co.jp:8080/kk_web/Schedule.jsp" method="Post">
					<input type="hidden" name="id" value="a-tamashiro">
					<input type="submit" value="スケジュール" style="width: 150px">
				</form>
			</td>
		</tr>
		<tr>
			<td class="a">
				<form action="http://www.lucentsquare.co.jp:8080/kk_web/personal.jsp" method="Post">
					<input type="hidden" name="id" value="a-tamashiro">
					<input type="submit" value="個人設定" style="width: 150px">
				</form>
			</td>
		</tr>
	</tbody></table>
	<br>
	<form>
		
		<input type="button" value="システム選択に戻る" style="width: 150px" onclick="window.location.replace(&#39;SystemSelect.jsp&#39;)">

	</form>
	<hr width="50%" size="5" color="GOLD">
	<span class="shadow"> <font color="white"> お知らせ </font>
	</span>
	<br>
	<br>
	<font color="red">2013-06-27</font>
	<p>
		<font color="red">修正のお知らせ</font><br> <font color="white">
			バナーを未記入で登録すると、修正ができない不具合を修正いたしました。
			<br>レイアウトの調整を行いました。
			<br>
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">
	<font color="red">2013-01-17</font>
	<p>
		<font color="red">障害のお知らせ</font><br> <font color="white">
			現在、入力済みのスケジュールをクリックすると右の入力画面に<br> エラーが表示される場合があります。この場合、この日の内容を<br>
			変更、削除することができません。<br> エラーが表示されない場合は、入力、変更、削除が可能です。<br>
			原因を調査中です。しばらくお待ち下さい。<br>
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">

	<font color="red">2006-06-28</font>
	<p>
		<font color="red">バージョンアップのお知らせ</font><br> <font color="white">
			予定登録の際の時刻入力が１分単位で出来るようにいたしました。<br> その他、共有者スケジュールの重複チェック、<br>
			予定表示画面の表示形式の変更等を行いました。<br>
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">

	<font color="red">2003-09-06</font>
	<p>
		<font color="red">修正のお知らせ</font><br> <font color="white">
			９月初め頃より発生していました週表示のエラーの修正が完了いたしました。<br> 大変ご迷惑をおかけいたしました。<br>
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">
	<font color="red">2003-09-01</font>
	<p>
		<font color="red">エラーのお知らせ</font><br> <font color="white">
			現在、"週表示"が使えなくなっております。個人設定で表示形式を"週表示"<br>
			に選択している方は、"月表示"もしくは"日表示"にお切り替えくださいますよう<br>
			お願いいたします。修正を行いますので、しばらくお待ち下さい。
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">
	<!--
				<FONT COLOR="red">2002-12-24</FONT><P>
				<FONT COLOR="white">
				<FONT COLOR="red">修正のお知らせ</FONT><BR>
					月表示にて、コピー機能がうまく処理されないというエラーが発生していましたが、<BR>
					修正を行いました。<P>
				</FONT>
				<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			// -->

	<font color="red">2002-12-16</font>
	<p>
		<font color="red">エラーのお知らせ</font><br> <font color="white">
			月表示にて、コピー機能がうまく処理されないというエラーが発生しています。<br> 修正を行いますので、しばらくお待ち下さい。
		</font>
	</p><hr width="50%" size="2" color="#E0FF40">

	<font color="red">2002-09-24</font>
	<p>
	<font color="white"> 下記の内容を追加致しました。
			<font color="RED">バナースケジュール登録・変更・削除</font><br>
			ver1.00の処理を修正したものです。<br> 重複登録は、出来ません。
			<font color="RED">過去スケジュール削除機能</font><br>
			これは、個人設定をしていただいたユーザに関係があります。<br>
			ver1.01からは、ログインする時に処理が実行されますので設定には注意して下さい。
			<font color="RED">コピー機能</font><br>
			登録されたスケジュールの上で、右クリックをしますとコピーが実行されます。<br>
			そして、各表示[月・週・日]の新規登録を行うために使っている[日付リンク]の上で右クリックをしていただくと貼りつけが実行されます。<br>
			なお、コピー機能は[Cookie]を使用していますので、[off]にされている方は[on]にして下さい。
			<font color="RED">共有者機能</font><br>
			他のユーザとスケジュールもしくはバナースケジュールを共有したい時に、使用して下さい。<br>
			手順としては、右の詳細画面の端にある「共有者登録画面」というリンクをクリックしていただきます。<br>
			画面が出てきましたら、スケジュールを共有したい方を選択（複数選択可）し、追加ボタンを押して下さい。<br>
			そうすると、メンバーリストに選択された方が表示されます。<br>
			後は、スケジュールもしくはバナースケジュールの登録を行って下さい。<br>
			なお、スケジュールを変更する際にも、メンバーの追加、削除が可能です。
	</font>


</p></body></html>