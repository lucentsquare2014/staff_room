<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.*,java.io.*" %>

<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"UTF-8"));
		}
}
%>
<%
/* 変更点 */
// 02-08-26 余計なプログラムの排除

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");


// ユーザ認証情報の設定
String user = "georgir";
String password = "georgir";

// Connectionオブジェクトの生成
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statementオブジェクトの生成
Statement stmt_koj = con.createStatement();

// SQL実行・個人情報
ResultSet rs_koj = stmt_koj.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name= "";

while(rs_koj.next()){
	name = rs_koj.getString("K_氏名");
}

%>
<HTML>
	<HEAD>
		<TITLE>MSJ 〜 MainMenu 〜</TITLE>
		<STYLE TYPE="text/css">
			.shadow {
				filter: shadow(color=black,direction=135);
				position: relative;
				height: 50;
				width: 100%;
			}
			
			td.a {
				width: 100%;
				height: 50px;
				padding: none;
				border-style: none;
				background-color: #D6FFFF;
				text-align: center;
				vertical-align: middle;
			}
		</STYLE>
	</HEAD> 
	<BODY BGCOLOR="#99A5FF">
		<CENTER>
			<SPAN CLASS="shadow">
				<FONT COLOR="white">
					<H1>
					<FONT COLOR="GOLD">M</FONT>anagement 
					<FONT COLOR="GOLD">S</FONT>chedule 
					<FONT COLOR="GOLD">J</FONT>ava ver 2.0<BR>〜 MainMenu 〜
					</H1><P>
					お名前：<%= name %><p>
				</FONT>
			</SPAN>
			<Table border="5" cellpadding="0" cellspacing="5" width=300 style="border-style: solid; border-color:#D6FFFF">
				<TR>
					<TD class="a" BGCOLOR="#D6FFFF">
						<FORM ACTION="Schedule.jsp" method="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="submit" VALUE="スケジュール" STYLE="width:150px">
						</FORM>
					</TD>
				</TR>
				<TR>
					<TD class="a" valign="middle">
						<FORM ACTION="personal.jsp" method="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="submit" VALUE="個人設定" STYLE="width:150px">
						</FORM>
					</TD>
				</TR>
			</TABLE>
			<FORM>
				<%--
				<INPUT TYPE="button" VALUE="ログアウト" STYLE="width:150" onClick="window.location.replace('login.html')">
				 --%>
				<INPUT TYPE="button" VALUE="ログアウト" STYLE="width:150px" onClick="window.location.replace('ID_PW_Nyuryoku.jsp')">
				 
			</FORM>
			<HR WIDTH="50%" SIZE="5" COLOR="GOLD">
			<SPAN CLASS="shadow">
				<FONT COLOR="white">
					お知らせ
				</FONT>
			</SPAN>
			<BR>

			<FONT COLOR="red">2013-01-17</FONT><P>
			<FONT COLOR="red">障害のお知らせ</FONT><BR>
			<FONT COLOR="white">
				現在、入力済みのスケジュールをクリックすると右の入力画面に<BR>
				エラーが表示される場合があります。この場合、この日の内容を<BR>
				変更、削除することができません。<BR>
				エラーが表示されない場合は、入力、変更、削除が可能です。<BR>
				原因を調査中です。しばらくお待ち下さい。<BR>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2006-06-28</FONT><P>
			<FONT COLOR="red">バージョンアップのお知らせ</FONT><BR>
			<FONT COLOR="white">
				予定登録の際の時刻入力が１分単位で出来るようにいたしました。<BR>
				その他、共有者スケジュールの重複チェック、<BR>
				予定表示画面の表示形式の変更等を行いました。<br>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2003-09-06</FONT><P>
			<FONT COLOR="red">修正のお知らせ</FONT><BR>
			<FONT COLOR="white">
				９月初め頃より発生していました週表示のエラーの修正が完了いたしました。<BR>
				大変ご迷惑をおかけいたしました。<br>
			</FONT>

			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			<FONT COLOR="red">2003-09-01</FONT><P>
			<FONT COLOR="red">エラーのお知らせ</FONT><BR>
			<FONT COLOR="white">
				現在、"週表示"が使えなくなっております。個人設定で表示形式を"週表示"<BR>
				に選択している方は、"月表示"もしくは"日表示"にお切り替えくださいますよう<BR>
				お願いいたします。修正を行いますので、しばらくお待ち下さい。<P>
			</FONT>

			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			<!--
				<FONT COLOR="red">2002-12-24</FONT><P>
				<FONT COLOR="white">
				<FONT COLOR="red">修正のお知らせ</FONT><BR>
					月表示にて、コピー機能がうまく処理されないというエラーが発生していましたが、<BR>
					修正を行いました。<P>
				</FONT>
				<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			// -->

			<FONT COLOR="red">2002-12-16</FONT><P>
			<FONT COLOR="red">エラーのお知らせ</FONT><BR>
			<FONT COLOR="white">
				月表示にて、コピー機能がうまく処理されないというエラーが発生しています。<BR>
				修正を行いますので、しばらくお待ち下さい。<P>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2002-09-24</FONT><BR>
			<FONT COLOR="white">
					下記の内容を追加致しました。<P>
				<FONT COLOR="RED">バナースケジュール登録・変更・削除</FONT><BR>
					ver1.00の処理を修正したものです。<BR>
					重複登録は、出来ません。<P>
				<FONT COLOR="RED">過去スケジュール削除機能</FONT><BR>
					これは、個人設定をしていただいたユーザに関係があります。<BR>
					ver1.01からは、ログインする時に処理が実行されますので設定には注意して下さい。<P>
				<FONT COLOR="RED">コピー機能</FONT><BR>
					登録されたスケジュールの上で、右クリックをしますとコピーが実行されます。<BR>
					そして、各表示[月・週・日]の新規登録を行うために使っている[日付リンク]の上で右クリックをしていただくと貼りつけが実行されます。<BR>
					なお、コピー機能は[Cookie]を使用していますので、[off]にされている方は[on]にして下さい。<P>
				<FONT COLOR="RED">共有者機能</FONT><BR>
					他のユーザとスケジュールもしくはバナースケジュールを共有したい時に、使用して下さい。<BR>
					手順としては、右の詳細画面の端にある「共有者登録画面」というリンクをクリックしていただきます。<BR>
					画面が出てきましたら、スケジュールを共有したい方を選択（複数選択可）し、追加ボタンを押して下さい。<BR>
					そうすると、メンバーリストに選択された方が表示されます。<BR>
					後は、スケジュールもしくはバナースケジュールの登録を行って下さい。<BR>
					なお、スケジュールを変更する際にも、メンバーの追加、削除が可能です。<P>
			</FONT>
		</CENTER>
	</BODY>
</HTML>