<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector"%>
<%@ page import="kkweb.common.C_DBConnectionGeorgir"%>

<%!// 文字エンコードを行います。
	public String strEncode(String strVal) throws UnsupportedEncodingException {
		if (strVal == null) {
			return (null);
		} else {
			return (new String(strVal.getBytes("8859_1"), "UTF-8"));
		}
	}%>
<%
	/* 修正点 */
	// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法へ修正
	// 02-08-15 余計なプログラムを省く
	// 02-09-04 詳細画面の表示入れ替え処理を加える。リンクをクリックすると単方向に移動する。
	// 02-09-05 詳細画面の表示入れ替え処理を変更。リンクをクリックすると双方向に移動する。
	// 02-09-18 動作テスト期間…バグ発見  275行目 日付のパラメータの記述もれ。

	/* 追加点 */
	// 02-09-03 共有者プログラムを外部ファイルとして取り込む。

	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));

	// パラメータの取得[共用パラメータ]
	String NO = strEncode(request.getParameter("no"));
	String GR = request.getParameter("group");

	// パラメータの取得[pubs使用]
	String DA = strEncode(request.getParameter("s_date"));
	String ST = strEncode(request.getParameter("s_start"));
	String AC = strEncode(request.getParameter("act"));

	// 表示の種類を判別するパラメータ
	String KD = strEncode(request.getParameter("kind"));

	// 選択された日付(開始日)の分割
	String BS = request.getParameter("b_start");
	int BSy = Integer.parseInt(BS.substring(0, 4)); // 年
	int BSm = Integer.parseInt(BS.substring(5, 7)); // 月
	int BSd = Integer.parseInt(BS.substring(8, 10)); // 日

	// b_startで取得した日付に「-」を付ける
	BS = BS.substring(0, 4) + "-" + BS.substring(5, 7) + "-"
			+ BS.substring(8, 10);

	//データベース接続
	C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
	Connection con = georgiaDB.createConnection();

	// Statementオブジェクトの生成
	Statement stmt = con.createStatement();

	// SQL実行・予定情報を読み出す
	ResultSet YOTEI = stmt
			.executeQuery("SELECT * FROM KINMU.YOTEI WHERE 区分 = '1'");

	// hitListの生成
	Vector hitYOTEI = new Vector();

	// 結果セットを処理します。
	while (YOTEI.next()) {
		String basyo = YOTEI.getString("場所");
		hitYOTEI.addElement(basyo.trim());
	}

	// hitListに入っている個数を代入
	int cntYOTEI = hitYOTEI.size();

	// ResultSetを閉じる
	YOTEI.close();

	// SQL実行・場所情報を読み出す
	ResultSet BASYO = stmt
			.executeQuery("SELECT * FROM KINMU.YOTEI WHERE 区分 = '2'");

	Vector hitBASYO = new Vector();

	while (BASYO.next()) {
		String basyo = BASYO.getString("場所");
		hitBASYO.addElement(basyo.trim());
	}

	int cntBASYO = hitBASYO.size();

	BASYO.close();

	/* 同グループであるかを比較するために使用する */
	// SQL実行・グループ情報[本人]
	ResultSet GROUPID = stmt
			.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '"
					+ ID + "'");

	// 初期化を行っている
	String group_id = "";

	while (GROUPID.next()) {
		group_id = GROUPID.getString("K_GRUNO");
	}

	GROUPID.close();

	// SQL実行・グループ情報[他のユーザ]
	ResultSet GROUPNO = stmt
			.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '"
					+ NO + "'");

	String group_no = "";

	while (GROUPNO.next()) {
		group_no = GROUPNO.getString("K_GRUNO");
	}

	GROUPNO.close();

	// SQLの実行
	// 選択された社員番号と一致するスケジュール情報を取り出すSQL
	ResultSet BSCHEDULE = stmt
			.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '" + NO
					+ "' and B_START = '" + BS + "'");

	String b_end = "";
	String b_plan = "";
	String b_plan2 = "";
	String b_place = "";
	String b_place2 = "";
	String b_memo = "";
	String b_tou = "";
	String b_zai = "";

	while (BSCHEDULE.next()) {
		b_end = BSCHEDULE.getString("B_END");
		b_plan = BSCHEDULE.getString("B_PLAN");
		b_plan2 = BSCHEDULE.getString("B_PLAN2");
		b_place = BSCHEDULE.getString("B_PLACE");
		b_place2 = BSCHEDULE.getString("B_PLACE2");
		b_memo = BSCHEDULE.getString("B_MEMO");
		b_tou = BSCHEDULE.getString("B_TOUROKU");
		b_zai = BSCHEDULE.getString("B_ZAISEKI");
	}

	// もし、PLAN2.PLACE2.MEMOに何も入っていない場合は、空白を入れる処理
	if (b_plan2 == null) {
		b_plan2 = "";
	}
	if (b_place2 == null) {
		b_place2 = "";
	}
	if (b_memo == null) {
		b_memo = "";
	}

	BSCHEDULE.close();

	/* 終了日を分割する */
	int eBSy = Integer.parseInt(b_end.substring(0, 4)); // 年
	int eBSm = Integer.parseInt(b_end.substring(5, 7)); // 月
	int eBSd = Integer.parseInt(b_end.substring(8, 10)); // 日

	/* [ID]と[NO]の氏名を読み出します。 */
	// SQLの実行・個人情報[本人]
	ResultSet NAMEID = stmt
			.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '"
					+ ID + "'");

	String name_id = "";

	while (NAMEID.next()) {
		name_id = NAMEID.getString("K_氏名");
	}

	NAMEID.close();

	// SQLの実行・個人情報NO[他のユーザ]
	ResultSet NAMENO = stmt
			.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '"
					+ NO + "'");

	String name_no = "";

	while (NAMENO.next()) {
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
	while (GROUP.next()) {
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

	function movemn1() {
		if (!ckck1) {
			tid = setTimeout('realmnp1()', 10);
			ckck1 = 1;
			tid = setTimeout('realmnm2()', 10);
			ckck2 = 0;
		} else {
			tid = setTimeout('realmnm1()', 10);
			ckck1 = 0;
			tid = setTimeout('realmnp2()', 10);
			ckck2 = 1;
		}
		return false;
	}
	function realmnp1() {
		divobj1.left = move1;
		if (move1 < 235) {
			setTimeout('realmnp1()', 10);
		}
		move1 = move1 + 5;
	}
	function realmnm1() {
		divobj1.left = move1;
		if (move1 > 0) {
			setTimeout('realmnm1()', 10);
		}
		move1 = move1 - 5;
	}
//-->
</script>
</HEAD>
<STYLE TYPE="text/css">
.shadow {
	filter: shadow(color = black, direction = 135);
	position: relative;
	height: 50;
	width: 100%;
}
</STYLE>
<BODY BGCOLOR="#99A5FF">
	<div id="divmenu1"
		style="position: absolute; visibility: visible; z-index: 0;">
		<table bgcolor="#99A5FF" border="1" width="235" height="604"
			cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#ffffff" width="20" rowspan="2">
					<center>
						<a href="#" onClick="return movemn1();"
							STYLE="text-decoration: none"><b>⇔
								<p>
									<font size="2">バ<br>ナ<br>｜<br>ス<br>ケ<br>ジ<br>ュ<br>｜<br>ル<br>変<br>更<br>画<br>面
									</font>
								</p>⇔
						</b></a>
					</center>
				</td>
				<td bgcolor="#99A5FF" height="604" width="215" colspan="2">
					<FORM METHOD="Post" ACTION="dayUpdate.jsp" target="_self">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
							TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
							TYPE="hidden" NAME="s_date" VALUE="<%=DA%>"> <INPUT
							TYPE="hidden" NAME="s_start" VALUE="<%=ST%>"> <INPUT
							TYPE="hidden" NAME="b_start" VALUE="<%=BS%>"> <INPUT
							TYPE="hidden" NAME="group" VALUE="<%=GR%>"> <INPUT
							TYPE="hidden" NAME="kind" VALUE="<%=KD%>"> <SPAN
							CLASS="shadow"> <FONT COLOR="white"> ようこそ。<%=name_id%>さん。<br><%=name_no%>さんの<br>詳細ｽｹｼﾞｭｰﾙを見ています。<br>
								<%
									if (group_id.equals(group_no) || group_id.equals("900")) {
								%>・ｽｹｼﾞｭｰﾙを変更できます。<%
									} else {
								%>・ｽｹｼﾞｭｰﾙは変更できません。<%
									}
								%>
						</FONT>
						</SPAN>
						<table border="1" style="width: 100%;">
							<TR>
								<TD bgcolor="#D6FFFF" rowspan="3" align="center"
									style="width: 20%;">日付</TD>
								<TD><SELECT NAME="syear" STYLE="width: 80%">
										<%
											for (int i = 0; i < 5; i++) {
										%><OPTION VALUE="<%=BSy + i%>"><%=BSy + i%></OPTION>
										<%
											}
										%>
								</SELECT> 年<BR> <SELECT NAME="smonth" STYLE="width: 80%">
										<%
											for (int i = 1; i <= 12; i++) {
												if (i <= 9) {
													if (BSm == i) {
										%><OPTION VALUE=<%="0" + i%> SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE=<%="0" + i%>><%=i%></OPTION>
										<%
											}
												} else {
													if (BSm == i) {
										%><OPTION VALUE="<%=i%>" SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE="<%=i%>"><%=i%></OPTION>
										<%
											}
												}
											}
										%>
								</SELECT> 月<BR> <SELECT NAME="sday" STYLE="width: 80%">
										<%
											for (int i = 1; i <= 31; i++) {
												if (i <= 9) {
													if (BSd == i) {
										%><OPTION VALUE=<%="0" + i%> SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE=<%="0" + i%>><%=i%></OPTION>
										<%
											}
												} else {
													if (BSd == i) {
										%><OPTION VALUE="<%=i%>" SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE="<%=i%>"><%=i%></OPTION>
										<%
											}
												}
											}
										%>
								</SELECT> 日<BR></TD>
							</TR>
							<TR>
								<TD align="center" valign="middle">∫</TD>
							</TR>
							<TR>
								<TD><SELECT NAME="eyear" STYLE="width: 80%">
										<%
											for (int i = 0; i < 5; i++) {
										%><OPTION VALUE="<%=eBSy + i%>"><%=eBSy + i%></OPTION>
										<%
											}
										%>
								</SELECT> 年<BR> <SELECT NAME="emonth" STYLE="width: 80%">
										<%
											for (int i = 1; i <= 12; i++) {
												if (i <= 9) {
													if (eBSm == i) {
										%><OPTION VALUE=<%="0" + i%> SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE=<%="0" + i%>><%=i%></OPTION>
										<%
											}
												} else {
													if (eBSm == i) {
										%><OPTION VALUE="<%=i%>" SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE="<%=i%>"><%=i%></OPTION>
										<%
											}
												}
											}
										%>
								</SELECT> 月<BR> <SELECT NAME="eday" STYLE="width: 80%">
										<%
											for (int i = 1; i <= 31; i++) {
												if (i <= 9) {
													if (eBSd == i) {
										%><OPTION VALUE=<%="0" + i%> SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE=<%="0" + i%>><%=i%></OPTION>
										<%
											}
												} else {
													if (eBSd == i) {
										%><OPTION VALUE="<%=i%>" SELECTED><%=i%></OPTION>
										<%
											} else {
										%><OPTION VALUE="<%=i%>"><%=i%></OPTION>
										<%
											}
												}
											}
										%>
								</SELECT> 日<BR></TD>
							</TR>
							<TR>
								<TD bgcolor="#D6FFFF" align="center">予定</TD>
								<TD><SELECT NAME="plan" STYLE="width: 100%">
										<OPTION value="--" SELECTED>--</OPTION>
										<%
											for (int i = 0; i < cntYOTEI; i++) {
												if (b_plan.trim().equals(hitYOTEI.elementAt(i))) {
										%><OPTION value="<%=hitYOTEI.elementAt(i)%>" SELECTED><%=hitYOTEI.elementAt(i)%></OPTION>
										<%
											} else {
										%><OPTION value="<%=hitYOTEI.elementAt(i)%>"><%=hitYOTEI.elementAt(i)%></OPTION>
										<%
											}
											}
										%>
								</SELECT></TD>
							</TR>
							<TR>
								<TD bgcolor="#D6FFFF" align="center">予定詳細</TD>
								<TD>
									<%
										if (b_plan2.equals("")) {
									%><INPUT TYPE="text" NAME="plan2" SIZE="20" MAXLENGTH="30"
									style="width: 100%;">
									<%
										} else {
									%><INPUT TYPE="text" NAME="plan2" VALUE="<%=b_plan2%>"
									SIZE="20" MAXLENGTH="30" style="width: 100%">
									<%
										}
									%>
								</TD>
							</TR>
							<TR>
								<TD bgcolor="#D6FFFF" align="center">場所</TD>
								<TD><SELECT NAME="place" STYLE="width: 100%">
										<OPTION VALUE="--">--</OPTION>
										<%
											for (int i = 0; i < cntBASYO; i++) {
												if (b_place.trim().equals(hitBASYO.elementAt(i))) {
										%><OPTION value="<%=hitBASYO.elementAt(i)%>" SELECTED><%=hitBASYO.elementAt(i)%></OPTION>
										<%
											} else {
										%><OPTION value="<%=hitBASYO.elementAt(i)%>"><%=hitBASYO.elementAt(i)%></OPTION>
										<%
											}
											}
										%>
								</SELECT></TD>
							</TR>
							<TR>
								<TD bgcolor="#D6FFFF" align="center">場所詳細</TD>
								<TD>
									<%
										if (b_place2.equals("")) {
									%><INPUT TYPE="text" NAME="place2" SIZE="20" MAXLENGTH="30"
									style="width: 100%;">
									<%
										} else {
									%><INPUT TYPE="text" NAME="place2" VALUE="<%=b_place2%>"
									SIZE="20" MAXLENGTH="30" style="width: 100%;">
									<%
										}
									%>
								</TD>
							</TR>
							<TR>
								<TD bgcolor="#D6FFFF" align="center">メモ</TD>
								<TD>
									<%
										if (b_memo.equals("")) {
									%><TEXTAREA NAME="memo" ROWS="4" COLS="30" MAXLENGTH="50"
										STYLE="width: 100%;"></TEXTAREA>
									<%
										} else {
									%><TEXTAREA NAME="memo" ROWS="4" COLS="30" MAXLENGTH="50"
										STYLE="width: 100%;"><%=b_memo%></TEXTAREA>
									<%
										}
									%>
								</TD>
							</TR>
						</table>
						<%
							if (b_zai.equals("1")) {
						%><INPUT TYPE="radio" NAME="pre" VALUE="1" CHECKED>在席<%
							} else {
						%><INPUT TYPE="radio" NAME="pre" VALUE="1">在席<%
							}
							if (b_zai.equals("0")) {
						%><INPUT TYPE="radio" NAME="pre" VALUE="0" CHECKED>不在<%
							} else {
						%><INPUT TYPE="radio" NAME="pre" VALUE="0">不在<%
							}
						%>
						<P>
							<%
								if (group_id.equals(group_no) || group_id.equals("900")) {
							%>
						
						<center>
							<INPUT TYPE="submit" NAME="act" VALUE="変更" style="width: 30%;">
							<INPUT TYPE="reset" VALUE="元に戻す" style="width: 30%;"> <INPUT
								TYPE="submit" NAME="act" VALUE="削除" style="width: 30%;">
						</center>
					</FORM> <%
 	} else {
 %></FORM>
					<BR>
					<%
						}
					%>
				
		</table>
	</div>
	<script language="JavaScript">
	<!--
		if (bwtype1 == 0) {
			divobj1 = document.all.divmenu1.style;
		}
		if (bwtype1 == 1) {
			divobj1 = document.divmenu1;
		}
		if (bwtype1 == 2) {
			divobj1 = document.getElementById("divmenu1").style;
		}
		divobj1.left = 0;
		divobj1.top = 0;
	//-->
	</script>
	<jsp:include page="pubs.jsp" flush="true" />
</BODY>
</HTML>
<%
	con.close();
	stmt.close();
%>