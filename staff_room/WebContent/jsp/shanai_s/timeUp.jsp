<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal==null){
		return (null);
	}else{
		return (new String(strVal.getBytes("UTF-8"),"UTF-8"));
	}
}
%>
<%
/* 修正点 */
// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法
// 02-08-15 余計なプログラムを省く
// 02-09-04 詳細画面の表示入れ替え処理を加える。リンクをクリックすると単方向に移動する。
// 02-09-05 詳細画面の表示入れ替え処理を変更。リンクをクリックすると双方向に移動する。

/* 追加点 */
// 02-09-03 共有者プログラムを外部ファイルとして取り込む。

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// パラメータの取得[共用パラメータ]
String NO = strEncode(request.getParameter("no"));
String DA = strEncode(request.getParameter("s_date"));
String GR = request.getParameter("group");

// パラメータの取得[pubs使用]
String BS = strEncode(request.getParameter("b_start"));
String AC = strEncode(request.getParameter("act"));

// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

// 開始時刻の分割
String ST = strEncode(request.getParameter("s_start"));
int S_Shour  = Integer.parseInt(ST.substring(0,2));
int S_Smini1 = Integer.parseInt(ST.substring(2,3));
int S_Smini2 = Integer.parseInt(ST.substring(3,4));

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// ユーザ認証情報の設定
String user = "georgir";
String password = "georgir";

// Connectionオブジェクトの生成
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

// SQLの実行
// 選択された社員番号と一致するスケジュール情報を取り出すSQL
ResultSet SSCHEDULE = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' and S_DATE = '" + DA + "' and S_START = '" + ST + "'");

String s_end = "";
String s_plan = "";
String s_plan2 = "";
String s_place = "";
String s_place2 = "";
String s_memo = "";
String s_tou = "";
String s_zai = "";

while(SSCHEDULE.next()){
s_end = SSCHEDULE.getString("S_END");
s_plan = SSCHEDULE.getString("S_PLAN");
s_plan2 = SSCHEDULE.getString("S_PLAN2");
s_place = SSCHEDULE.getString("S_PLACE");
s_place2 = SSCHEDULE.getString("S_PLACE2");
s_memo = SSCHEDULE.getString("S_MEMO");
s_tou = SSCHEDULE.getString("S_TOUROKU");
s_zai = SSCHEDULE.getString("S_ZAISEKI");
}

// もし、PLAN2.PLACE2.MEMOに何も入っていない場合は、半角スペースを入れる処理
if(s_plan2 == null){
	s_plan2 = "";
}
if(s_place2 == null){
	s_place2 = "";
}
if(s_memo == null){
	s_memo = "";
}
// 終了時刻の分割
int S_Ehour = Integer.parseInt(s_end.substring(0,2));
int S_Emini1 = Integer.parseInt(s_end.substring(2,3));
int S_Emini2 = Integer.parseInt(s_end.substring(3,4));

SSCHEDULE.close();

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

// Calendar インスタンスを生成
Calendar now = Calendar.getInstance();

// 現在の時刻を取得
Date dat = now.getTime();

// 表示形式を設定
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");

// 変数宣言
int i=0;

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
			var bwtype = (document.all) ? 0 : (document.layers) ? 1 : 2;
			var move1 = 0;
			var move2 = 235;
			var ckck1 = 0;
			var ckck2 = 1;
			var divobj1;
			var divobj2;
			
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
			function movemn2(){
				if(!ckck2){
					tid = setTimeout('realmnm1()', 10);
					ckck1 = 0;
					tid = setTimeout('realmnp2()', 10);
					ckck2 = 1;
				}else{
					tid = setTimeout('realmnp1()', 10);
					ckck1 = 1;
					tid = setTimeout('realmnm2()', 10);
					ckck2 = 0;
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
			function realmnp2(){
				divobj2.left = move2;
				if(move2 < 235){
					setTimeout('realmnp2()', 10);
				}
				move2 = move2 + 5;
			}
			function realmnm1(){
				divobj1.left = move1;
				if(move1 > 0){
					setTimeout('realmnm1()', 10);
				}
				move1 = move1 - 5;
			}
			function realmnm2(){
				divobj2.left = move2;
				if(move2 > 0){
					setTimeout('realmnm2()', 10);
				}
				move2 = move2 - 5;
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
						<a href="#" onClick="return movemn1();" STYLE="text-decoration:none">
							<b>⇔<p><font size="2">ス<br>ケ<br>ジ<br>ュ<br>｜<br>ル<br>変<br>更<br>画<br>面</font></p>⇔</b>
						</a>
					</center>
					</td>
					<td bgcolor="#99A5FF" height="604" width="100%" colspan="2">
						<FORM METHOD="Post" ACTION="timeUpdate.jsp" target="_self">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date1" VALUE="<%= DA %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<SPAN CLASS="shadow">
								<FONT COLOR="white">
									ようこそ。<%= name_id %>さん。<br><%= name_no %>さんの<br>詳細ｽｹｼﾞｭｰﾙを見ています。<br>
									<%
									if(group_id.equals(group_no) || group_id.equals("900")){
										%>・ｽｹｼﾞｭｰﾙを変更できます。<%
									}else{
										%>・ｽｹｼﾞｭｰﾙは変更できません。<%
									}
									%>
								</FONT>
							</SPAN>
							<table border="1" style="width: 100%;">
								<tr>
									<td bgcolor="#D6FFFF" align="center" style="width:20%;">
										<small>本日の<br>日付</small>
									</td>
									<%
									if(DA == null){%>
										<td>
											<INPUT TYPE="text" NAME="s_date1" MAXLENGTH="10" VALUE="<%= sFmt.format(dat) %>" STYLE="width:100%; ime-mode:disabled">
										</td><%
									}else{%>
										<td>
											<INPUT TYPE="text" NAME="s_date2" MAXLENGTH="10" VALUE="<%= DA %>" STYLE="width:100%; ime-mode:disabled">
										</td><%
									}%>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" rowspan="3" align="center">時刻</td>
									<td>
										<SELECT NAME="starth" STYLE="width:28%;"><%
											for(i = 0; i < 24; i++){
												if(S_Shour == i){
													if(i <= 9){%>
														<OPTION VALUE="<%= 0 + Integer.toString(S_Shour) %>" SELECTED>
															<%= S_Shour %>
														</OPTION><%
													}else{%>
														<OPTION VALUE="<%= S_Shour %>" SELECTED>
															<%= S_Shour %>
														</OPTION><%
													}
												}else{
													if(i <= 9){%>
														<OPTION VALUE="<%= 0 + Integer.toString(i) %>">
															<%= i %>
														</OPTION><%
													}else{%>
														<OPTION VALUE="<%= i %>">
															<%= i %>
														</OPTION><%
													}
												}
											}%>
										</SELECT><small>時</small>
										<SELECT NAME="startm1" STYLE="width:25%;"><%
											for(i = 0; i<6; i++){
												if(S_Smini1 == i){%>
													<option VALUE="<%= S_Smini1 %>" SELECTED>
														<%=i%>
													</option><%
												}else{%>
													<option>
														<%=i%>
													</option><%
												}
											}%>
										</SELECT><SELECT NAME="startm2" STYLE="width:25%;"><%
											for(i = 0; i<10; i++){
												if(S_Smini2 == i){%>
													<option VALUE="<%= S_Smini2 %>" SELECTED>
														<%=i%>
													</option><%
												}else{%>
													<option>
														<%=i%>
													</option><%
												}
											}%>
										</SELECT><small>分</small>
									</td>
								</tr>
								<tr>
									<td align="center">∫</td>
								</tr>
								<tr>
									<td>
										<SELECT NAME="endh" STYLE="width:28%;"><%
											for(i = 0; i < 24; i++){
												if(S_Ehour == i){
													if(i <= 9){%>
														<OPTION VALUE="<%= 0 + Integer.toString(S_Ehour) %>" SELECTED>
															<%= S_Ehour %>
														</OPTION><%
													}else{%>
														<OPTION VALUE="<%= S_Ehour %>" SELECTED>
															<%= S_Ehour %>
														</OPTION><%
													}
												}else{
													if(i <= 9){%>
														<OPTION VALUE="<%= 0 + Integer.toString(i) %>">
															<%= i %>
														</OPTION><%
													}else{%>
														<OPTION VALUE="<%= i %>">
															<%= i %>
														</OPTION><%
													}
												}
											}%>
										</SELECT><small>時</small>
										<SELECT NAME="endm1" STYLE="width:25%;"><%
											for(i = 0; i<6; i++){
												if(S_Emini1 == i){%>
													<option VALUE="<%= S_Emini1 %>" SELECTED>
														<%=i%>
													</option><%
												}else{%>
													<option>
														<%=i%>
													</option><%
												}
											}%>
										</SELECT><SELECT NAME="endm2" STYLE="width:25%;"><%
											for(i = 0; i<10; i++){
												if(S_Emini2 == i){%>
													<option VALUE="<%= S_Emini2 %>" SELECTED>
														<%=i%>
													</option><%
												}else{%>
													<option>
														<%=i%>
													</option><%
												}
											}%>
										</SELECT><small>分</small>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" align="center">予定</td>
									<td>
										<SELECT NAME="plan" STYLE="width:100%">
											<OPTION VALUE="--">--</OPTION>
											<%
											for(i = 0; i < cntYOTEI; i++){
												if(s_plan.trim().equals(hitYOTEI.elementAt(i))){%>
													<OPTION value="<%= hitYOTEI.elementAt(i) %>" SELECTED>
														<%= hitYOTEI.elementAt(i) %>
													</OPTION><%
												}else{%>
													<OPTION value="<%= hitYOTEI.elementAt(i) %>">
														<%= hitYOTEI.elementAt(i) %>
													</OPTION><%
												}
											}%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" align="center">予定詳細</td>
									<td><%
										if(s_plan2.equals("")){%>
											<INPUT TYPE="text" style="ime-mode:active; width: 100%;" NAME="plan2" SIZE="20" MAXLENGTH="30"><%
										}else{%>
											<INPUT TYPE="text" style="ime-mode:active; width: 100%;" NAME="plan2" VALUE="<%= s_plan2 %>" SIZE="20" MAXLENGTH="30"><%
										}%>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" align="center">場所</td>
									<td>
										<SELECT NAME="place" STYLE="width:100%;">
											<OPTION VALUE="--">--</OPTION><%
											for(i = 0; i < cntBASYO; i++){
												if(s_place.trim().equals(hitBASYO.elementAt(i))){%>
													<OPTION value="<%= hitBASYO.elementAt(i) %>" SELECTED>
														<%= hitBASYO.elementAt(i) %>
													</OPTION><%
												}else{%>
													<OPTION value="<%= hitBASYO.elementAt(i) %>">
														<%= hitBASYO.elementAt(i) %>
													</OPTION><%
												}
											}%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" align="center">場所詳細</td>
									<td><%
										if(s_place2.equals("")){%>
											<INPUT TYPE="text" NAME="place2" SIZE="20" MAXLENGTH="30" style="width: 100%;"><%
										}else{%>
											<INPUT TYPE="text" NAME="place2" VALUE="<%= s_place2 %>" SIZE="20" MAXLENGTH="30" style="width: 100%;"><%
										}%>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" align="center">メモ<BR><small>(50字まで)</small></td>
									<td><%
										if(s_memo.equals("")){%>
											<TEXTAREA NAME="memo" ROWS="4" COLS="30" MAXLENGTH="50" STYLE="width:100%;"></TEXTAREA><%
										}else{%>
											<TEXTAREA NAME="memo" ROWS="4" COLS="30" MAXLENGTH="50" STYLE="width:100%;"><%= s_memo %></TEXTAREA><%
										}%>
									</td>
								</tr>
							</table><%
							if(s_zai.equals("1")){%>
								<INPUT TYPE="radio" NAME="pre" VALUE="1" CHECKED>在席<%
							}else{%>
								<INPUT TYPE="radio" NAME="pre" VALUE="1">在席<%
							}
							if(s_zai.equals("0")){%>
								<INPUT TYPE="radio" NAME="pre" VALUE="0" CHECKED>不在<%
							}else{%>
								<INPUT TYPE="radio" NAME="pre" VALUE="0">不在<%
							}%>
							<P><%
							if(group_id.equals(group_no) || group_id.equals("900")){%>
							<center>
								<INPUT TYPE="submit" NAME="act" VALUE="変更" style="width: 30%;">
								<INPUT TYPE="reset" VALUE="元に戻す" style="width: 30%;">
								<INPUT TYPE="submit" NAME="act" VALUE="削除" style="width: 30%;">
							</center>
						</FORM><%
							}else{%>
						</FORM><BR><%
							}%>
					</td>
				</tr>
			</table>
		</div>
		<script language="JavaScript">
		<!--
		if(bwtype == 0){
			divobj1 = document.all.divmenu1.style;
		}
		if(bwtype == 1){
			divobj1 = document.divmenu1;
		}
		if(bwtype == 2){
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
con.close();
stmt.close();
%>