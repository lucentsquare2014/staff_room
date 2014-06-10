<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector" %>

<%!
// 文字エンコードを行う
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return(null);
	}
	else{
		return(new String(strVal.getBytes("UTF-8"),"UTF-8"));
	}
}
%>
<%
/* 修正点 */
// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を月・週・日へと切り替わる方法に移行
// 02-08-15 余計なプログラムを省く
// 02-08-26 選択された日付から一週間進めた日付を終了日に代入していたのをなくす。
// 02-09-04 詳細画面の表示入れ替え処理を加える。リンクをクリックすると単方向に移動する。
// 02-09-05 詳細画面の表示入れ替え処理を変更。リンクをクリックすると双方向に移動する。

/* 追加点 */
// 02-09-03 共有者プログラムを外部ファイルとして取り込む。

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// パラメータの取得[共用パラメータ]
String NO = request.getParameter("no");
String GR = request.getParameter("group");

// パラメータの取得[pubs使用]
String DA = strEncode(request.getParameter("s_date"));
String ST = strEncode(request.getParameter("s_start"));
String AC = strEncode(request.getParameter("act"));

// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

// 選択された日付の分割
String BS = request.getParameter("b_start");
int BSy = Integer.parseInt(BS.substring(0,4));  // 年
int BSm = Integer.parseInt(BS.substring(5,7));  // 月
int BSd = Integer.parseInt(BS.substring(8,10)); // 日

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// データベースへのログイン情報
String user = "georgir";
String password = "georgir";

// Connection オブジェクトを生成
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statementオブジェクトの生成
Statement stmt = con.createStatement();

// SQL実行・予定情報を読み出す
ResultSet YOTEI = stmt.executeQuery("SELECT * FROM KINMU.YOTEI WHERE 区分 = '1'");

// hitListの生成
Vector hitYOTEI = new Vector();

// 結果セットを処理します。
while(YOTEI.next()){
	String basyo = YOTEI.getString("場所");
	hitYOTEI.addElement(basyo.trim());
}

// hitListに入っている個数を代入
int cntYOTEI = hitYOTEI.size();

// ResultSetを閉じる
YOTEI.close();

// SQL実行・場所情報を読み出す
ResultSet BASYO = stmt.executeQuery("SELECT * FROM KINMU.YOTEI WHERE 区分 = '2'");

Vector hitBASYO = new Vector();

while(BASYO.next()){
	String basyo = BASYO.getString("場所");
	hitBASYO.addElement(basyo.trim());
}

int cntBASYO = hitBASYO.size();

BASYO.close();

/* 同グループであるかを比較するために使用する */
// SQL実行・グループ情報[本人]
ResultSet GROUPID = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

// 初期化を行っている
String group_id = "";

while(GROUPID.next()){
	group_id = GROUPID.getString("K_GRUNO");
}

GROUPID.close();

// SQL実行・グループ情報[他のユーザ]
ResultSet GROUPNO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

String group_no = "";

while(GROUPNO.next()){
	group_no = GROUPNO.getString("K_GRUNO");
}

GROUPNO.close();

/* [ID]と[NO]の氏名を読み出します。 */
// SQLの実行・個人情報[本人]
ResultSet NAMEID = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name_id = "";

while(NAMEID.next()){
	name_id = NAMEID.getString("K_氏名");
}

NAMEID.close();

// SQLの実行・個人情報NO[他のユーザ]
ResultSet NAMENO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

String name_no = "";

while(NAMENO.next()){
	name_no = NAMENO.getString("K_氏名");
}

NAMENO.close();

/* グループコード・グループ名をコンボボックスに表示するための処理 */
// SQLの実行・グループ情報
ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.GRU");

// hitListの作成
Vector hitGRUNUM = new Vector();
Vector hitGRUNUAM = new Vector();

// グループテーブルにアクセス
while(GROUP.next()){
	String gnum = strEncode(GROUP.getString("G_GRUNO"));
	String gnam = GROUP.getString("G_GRNAME");
	hitGRUNUM.addElement(gnum);
	hitGRUNUAM.addElement(gnam.trim());
}

int cntGRU = hitGRUNUM.size();

// ResultSetを閉じる
GROUP.close();

%>
<HTML>
	<HEAD>
		<TITLE>詳細画面</TITLE>
		<meta http-equiv="content-language" content="ja">
		<meta http-equiv="pragma" content="no-cache">
		<meta name="author" content="roq">
		<meta name="googlebot" content="noarchive">
		<meta name="robots" content="noindex">
		<script language="JavaScript">
		<!--
			var bwtype1 = (document.all) ? 0 : (document.layers) ? 1 : 2;
			var move1 = 0;
			var ckck1 = 0;
			var divobj1;
			
			function movemn1(){
				if(!ckck1){
					tid = setTimeout('realmnp1()', 10);
					ckck1 = 1;
					tid = setTimeout('realmnm2()', 10);
					ckck2 = 0;
				}else{
					tid = setTimeout('realmnm1()', 10);
					ckck1 = 0;
					tid = setTimeout('realmnp2()', 10);
					ckck2 = 1;
				}
				return false;
			}
			function realmnp1(){
				divobj1.left = move1;
				if(move1 < 235){
					setTimeout('realmnp1()', 10);
				}
				move1 = move1 + 5;
			}
			function realmnm1(){
				divobj1.left = move1;
				if(move1 > 0){
					setTimeout('realmnm1()', 10);
				}
				move1 = move1 - 5;
			}
		//-->
		</script>
	</HEAD>
	<STYLE TYPE="text/css">
		.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
	</STYLE>
	<BODY BGCOLOR="#99A5FF">
		<div id="divmenu1" style="position:absolute;visibility:visible;z-index:0;">
			<table bgcolor="#99A5FF" border="1" width="235" height="604" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#ffffff" width="20" rowspan="2">
					<center>
						<a href="#" onClick="return movemn1();" STYLE="text-decoration:none"><b>⇔<p><font size="2">バ<br>ナ<br>｜<br>ス<br>ケ<br>ジ<br>ュ<br>｜<br>ル<br>登<br>録<br>画<br>面</font></p>⇔</b></a>
					</center>
					</td>
					<td bgcolor="#99A5FF" height="604" width="100%" colspan="2">
						<FORM ACTION="dayInsert.jsp" METHOD="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
							<INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<SPAN CLASS="shadow">
								<FONT COLOR="white">
									ようこそ。<%= name_id %>さん。<br>
									<%
									if(group_id.equals(group_no) || group_id.equals("900")){
										%><%= name_no %>さんの<br>ﾊﾞﾅｰｽｹｼﾞｭｰﾙを登録できます。<%
									}else{
										%><%= name_no %>さんの<br>ﾊﾞﾅｰｽｹｼﾞｭｰﾙは登録できません。<%
									}
									%>
								</FONT>
							</SPAN>
							<TABLE BORDER="1" style="width:100%;">
								<TR>
									<TD bgcolor="#D6FFFF" rowspan="3" align="center" style="width:20%;">日付</TD>
									<TD>
										<SELECT NAME="syear" STYLE="width:80%">
										<%
										// 現在の年から五年後まで出力するようにしています。
										for(int i = 0; i < 5;i++){
											%><OPTION VALUE="<%= BSy + i %>"><%= BSy + i %></OPTION><%
										}
										%>
										</SELECT> 年<BR>
										<SELECT NAME="smonth" STYLE="width:80%">
										<%
										for(int i = 1; i <= 12;i++){
											if(i <= 9){
												if(BSm == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSm == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> 月<BR>
										<SELECT NAME="sday" STYLE="width:80%">
										<%
										for(int i = 1; i <= 31;i++){
											if(i <= 9){
												if(BSd == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSd == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> 日<BR>
									</TD>
								</TR>
								<TR>
									<TD align="center" valign="middle">∫</TD>
								</TR>
								<TR>
									<TD>
										<SELECT NAME="eyear" STYLE="width:80%">
										<%
										for(int i = 0; i < 5;i++){
											%><OPTION VALUE="<%= BSy + i%>"><%= BSy + i%></OPTION><%
										}
										%>
										</SELECT> 年<BR>
										<SELECT NAME="emonth" STYLE="width:80%">
										<%
										for(int i = 1; i <= 12;i++){
											if(i <= 9){
												if(BSm == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSm == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> 月<BR>
										<SELECT NAME="eday" STYLE="width:80%">
										<%
										for(int i = 1; i <= 31;i++){
											if(i <= 9){
												if(BSd == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSd == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> 日<BR>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">予定</TD>
									<TD>
										<SELECT NAME="plan" STYLE="width:100%">
											<OPTION value="--" SELECTED>--</OPTION>
											<%
											for(int i = 0; i < cntYOTEI; i++){
												%><OPTION value="<%= hitYOTEI.elementAt(i) %>"><%= hitYOTEI.elementAt(i) %></OPTION><%
											}
											%>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" align="center">予定詳細</TD>
									<TD>
										<INPUT TYPE="text" NAME="plan2" SIZE="23" MAXLENGTH="30" style="width:100%">
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">場所</TD>
									<TD>
										<SELECT NAME="place" STYLE="width:100%">
											<OPTION value="--" SELECTED>--</OPTION>
											<%
											for(int i = 0; i < cntBASYO; i++){
												%><OPTION value="<%= hitBASYO.elementAt(i) %>"><%= hitBASYO.elementAt(i) %></OPTION><%
											}
											%>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" align="center">場所詳細</TD>
									<TD>
										<INPUT TYPE="text" NAME="place2" SIZE="23" MAXLENGTH="30" style="width:100%">
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">メモ</TD>
									<TD>
										<TEXTAREA NAME="memo" ROWS="3" COLS="30" MAXLENGTH="50" STYLE="width:100%; ime-mode:active;"></TEXTAREA>
									</TD>
								</TR>
							</TABLE>
							<INPUT TYPE="radio" NAME="pre" VALUE="1">在席
							<INPUT TYPE="radio" NAME="pre" VALUE="0" CHECKED>不在<P>
							<%
							if(group_id.equals(group_no) || group_id.equals("900")){
							%>
							<center>
							<INPUT TYPE="submit" NAME="act" VALUE="登録" style="width:45%">
							<INPUT TYPE="reset" VALUE="元に戻す" style="width:45%">
							</center>
						</FORM>
						<P>
						<FORM ACTION="timeIn.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="">
							<INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<INPUT TYPE="hidden" NAME="act" VALUE="">
							<center>
							<INPUT TYPE="submit" VALUE="スケジュール登録へ移動" STYLE="width:95%">
							</center>
						</FORM>
						<%
						}else{
							%>
							</FORM><BR>
							<%
						}
						%>
					</TD>
				</TR>
			</table>
		</div>
			<script language="JavaScript">
				<!--
				if(bwtype1 == 0){
					divobj1 = document.all.divmenu1.style;
				}
				if(bwtype1 == 1){
					divobj1 = document.divmenu1;
				}
				if(bwtype1 == 2){
					divobj1 = document.getElementById("divmenu1").style;
				}
				divobj1.left = 0;
				divobj1.top  = 0;
				//-->
			</script>
		<jsp:include page="pubs.jsp" flush="true" />		
	</BODY>
</HTML>
<%
stmt.close();
con.close();
%>