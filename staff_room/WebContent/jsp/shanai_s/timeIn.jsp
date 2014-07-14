<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
	import="java.sql.* , java.util.Date , java.util.Calendar , java.io.* , java.text.* , java.util.Vector"%>
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
	// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法
	// 02-09-04 詳細画面の表示入れ替え処理を加える。リンクをクリックすると単方向に移動する。
	// 02-09-05 詳細画面の表示入れ替え処理を変更。リンクをクリックすると双方向に移動する。

	/* 追加点 */
	// 02-09-02 共有者プログラムを取り込む。
	// 02-09-03 共有者プログラムを外部ファイルとして取り込む。

	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));
	if(ID == null){
		ID = session.getAttribute("login").toString();
	}

	// パラメータの取得[共用パラメータ]
	String NO = request.getParameter("no");
	if(NO == null){
		NO = ID;
	}
	String DA = strEncode(request.getParameter("s_date"));
	String GR = request.getParameter("group");

	// パラメータの取得[pubs使用]
	String ST = strEncode(request.getParameter("s_start"));
	String BS = strEncode(request.getParameter("b_start"));
	String AC = strEncode(request.getParameter("act"));

	// 表示の種類を判別するパラメータ
	String KD = request.getParameter("kind");

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

	// Calender インスタンスを生成
	Calendar now = Calendar.getInstance();

	// 現在の時刻を取得
	Date dat = now.getTime();

	// 表示形式を設定
	SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
	if(DA == null){
		DA = sFmt.format(dat);
	}

	//変数宣言
	int i = 0;
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
body{
font-family: "ＭＳ Ｐゴシック";
}
input {
 font-family: "ＭＳ Ｐゴシック";
 }
select {
 font-family: "ＭＳ Ｐゴシック";
}
textarea {
 font-family: "ＭＳ Ｐゴシック";
}
</STYLE>
<BODY BGCOLOR="#99A5FF">
	<div id="divmenu1"
		style="position: absolute; visibility: visible; z-index: 0;">
		<table bgcolor="#99A5FF" border="1" width="235" height="604"
			cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#ffffff" width="20" rowspan="2"><center>
						<A href="#" onClick="return movemn1();"
							STYLE="text-decoration: none"><b>⇔
								<p>
									<font size="2">ス<br>ケ<br>ジ<br>ュ<br>｜<br>ル<br>登<br>録<br>画<br>面
									</font>
								<p>⇔
						</b> </A>
					</center></td>
				<td bgcolor="#99A5FF" height="604" width="215" colspan="2">
					<FORM METHOD="Post" ACTION="timeInsert.jsp" name="form0">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
							TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
							TYPE="hidden" NAME="group" VALUE="<%=GR%>"> <INPUT
							TYPE="hidden" NAME="kind" VALUE="<%=KD%>"> <SPAN
							CLASS="shadow"> <FONT COLOR="white"> ようこそ。<%=name_id%>さん。<br>
								<%
									if (group_id.equals(group_no) || group_id.equals("900")) {
								%><%=name_no%>さんの<br>ｽｹｼﾞｭｰﾙを登録できます。<%
									} else {
								%><%=name_no%>さんの<br>ｽｹｼﾞｭｰﾙは登録できません。<%
									}
								%>
						</FONT>
						</SPAN>
						<table border="1" style="width: 100%;">
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center; width: 20%;">
									<small>本日の<br>日付
								</small>
								</td>
								<%
									if (DA == null) {
								%>
								<td><INPUT TYPE="text" NAME="s_date" MAXLENGTH="10"
									VALUE="<%=sFmt.format(dat)%>"
									STYLE="width: 100%; ime-mode: disabled"></td>
								<%
									} else {
								%>
								<td><INPUT TYPE="text" NAME="s_date" MAXLENGTH="10"
									VALUE="<%=DA%>" STYLE="width: 100%; ime-mode: disabled">
								</td>
								<%
									}
								%>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" rowspan="3" style="text-align: center;">時刻</td>
								<td><center>
										<SELECT NAME="starth" STYLE="width: 28%;">
											<%
												for (i = 0; i < 24; i++) {
													if (i <= 8) {
											%>
											<OPTION VALUE=<%="0" + Integer.toString(i)%>>
												<%=i%>
											</OPTION>
											<%
												} else if (i == 9) {
											%>
											<OPTION VALUE=<%="0" + Integer.toString(i)%> SELECTED>
												<%=i%>
											</OPTION>
											<%
												} else {
											%>
											<OPTION VALUE=<%=i%>>
												<%=i%>
											</OPTION>
											<%
												}
												}
											%>
										</SELECT><small>時</small> <SELECT NAME="startm1" STYLE="width: 25%;">
											<%
												for (i = 0; i < 6; i++) {
											%>
											<option>
												<%=i%>
											</option>
											<%
												}
											%>
										</SELECT><SELECT NAME="startm2" STYLE="width: 25%;">
											<%
												for (i = 0; i < 10; i++) {
											%>
											<option>
												<%=i%>
											</option>
											<%
												}
											%>
										</SELECT><small>分</small>
									</center></td>
							</tr>
							<tr>
								<td align="center">∫</td>
							</tr>
							<tr>
								<td><center>
										<SELECT NAME="endh" STYLE="width: 28%;">
											<%
												for (i = 0; i < 24; i++) {
													if (i <= 8) {
											%>
											<OPTION VALUE=<%="0" + Integer.toString(i)%>>
												<%=i%>
											</OPTION>
											<%
												} else if (i == 9) {
											%>
											<OPTION VALUE=<%="0" + Integer.toString(i)%> SELECTED>
												<%=i%>
											</OPTION>
											<%
												} else {
											%>
											<OPTION VALUE=<%=i%>>
												<%=i%>
											</OPTION>
											<%
												}
												}
											%>
										</SELECT><small>時</small> <SELECT NAME="endm1" STYLE="width: 25%;">
											<%
												for (i = 0; i < 6; i++) {
											%>
											<option>
												<%=i%>
											</option>
											<%
												}
											%>
										</SELECT><SELECT NAME="endm2" STYLE="width: 25%;">
											<%
												for (i = 0; i < 10; i++) {
											%>
											<option>
												<%=i%>
											</option>
											<%
												}
											%>
										</SELECT><small>分</small>
									</center></td>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center;">予定</td>
								<td><SELECT NAME="plan" STYLE="width: 100%;">
										<OPTION VALUE="--">--</OPTION>
										<%
											for (i = 0; i < cntYOTEI; i++) {
										%>
										<OPTION value="<%=hitYOTEI.elementAt(i)%>">
											<%=hitYOTEI.elementAt(i)%>
										</OPTION>
										<%
											}
										%>
								</SELECT></td>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center;">予定詳細</td>
								<td><INPUT TYPE="text"
									style="ime-mode: active; width: 100%;" NAME="plan2" SIZE="20"
									MAXLENGTH="30"></td>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center;">場所</td>
								<td><SELECT NAME="place" STYLE="width: 100%;">
										<OPTION VALUE="--">--</OPTION>
										<%
											for (i = 0; i < cntBASYO; i++) {
										%>
										<OPTION value="<%=hitBASYO.elementAt(i)%>">
											<%=hitBASYO.elementAt(i)%>
										</OPTION>
										<%
											}
										%>
								</SELECT></td>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center;">場所詳細</td>
								<td><INPUT TYPE="text"
									style="ime-mode: active; width: 100%;" NAME="place2" SIZE="20"
									MAXLENGTH="30"></td>
							</tr>
							<tr>
								<td bgcolor="#D6FFFF" style="text-align: center;">メモ<BR>
								<small>(50字まで)</small></td>
								<td><TEXTAREA NAME="memo" ROWS="4" COLS="30"
										STYLE="width: 100%; ime-mode: active;"></TEXTAREA></td>
							</tr>
						</table>
						<INPUT TYPE="radio" NAME="pre" VALUE="1">在席 <INPUT
							TYPE="radio" NAME="pre" VALUE="0" CHECKED>不在
						<P>
							<%
								if (group_id.equals(group_no) || group_id.equals("900")) {
							%>
						
						<center>
							<INPUT TYPE="submit" NAME="act" VALUE="登録" style="width: 45%;">
							<INPUT TYPE="reset" VALUE="元に戻す" style="width: 45%;">
						</center>
					</FORM>
					<FORM ACTION="dayIn.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
							TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
							TYPE="hidden" NAME="s_date" VALUE="<%=DA%>"> <INPUT
							TYPE="hidden" NAME="s_start" VALUE=""> <INPUT
							TYPE="hidden" NAME="b_start" VALUE="<%=DA%>"> <INPUT
							TYPE="hidden" NAME="group" VALUE="<%=GR%>"> <INPUT
							TYPE="hidden" NAME="kind" VALUE="<%=KD%>"> <INPUT
							TYPE="hidden" NAME="act" VALUE="">
						<center>
							<INPUT TYPE="submit" VALUE="ﾊﾞﾅｰｽｹｼﾞｭｰﾙ登録画面へ移動"
								STYLE="width: 93%">
						</center>
					</FORM> <%
 	} else {
 %>
					</FORM>
					<BR> <%
 	}
 %>
				</td>
			</tr>
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
