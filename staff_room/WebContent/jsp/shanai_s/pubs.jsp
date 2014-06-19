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
	/* 修正点*/
	// 02-08-07 共有者情報テーブルの「K_社員NO」のデータ型を変更したことにより、正常にデータを読み出せるようした。
	// 02-08-27 登録者と共有者の表示が、共有者のスケジュールからは表示出来なかったものを修正。
	// 02-09-18 動作テスト期間…バグ発見  314行目 メンバーリストに、共有者テーブルへ登録したユーザが必ず出ている。
	// 02-09-20 動作テスト期間…バグ発見  ファイル全体 一つのファイルで、表示・追加・削除を行うと
	//                                    一度行われたレスポンスを何度も繰り返してしまっているので
	//                                    表示ファイルと追加・削除ファイルに分ける。

	/* 追加点 */
	// 02-08-13 登録者がスケジュール変更を行ったら、共有者のスケジュールも変更する。
	// 02-08-14 共有者がスケジュール変更を行った場合も、その他の共有者と登録者のスケジュールを変更する。
	// 02-08-15 共有者をメンバーリストから選択し削除を行うと、スケジュール（時間単位・日単位）も削除する。
	// 02-08-15 登録者が共有者として選ばれた場合、エラーとする。
	// 02-09-03 includeディレクティブにより外部ファイルとして扱われる。
	// 02-09-18 includeアクションタグに変更し、外部ファイルとして扱う。

	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));

	// パラメータの取得[共用パラメータ]
	String NO = request.getParameter("no");
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

	/* グループコード・グループ名をコンボボックスに表示するための処理 */
	// SQLの実行・グループ情報
	ResultSet GROUP = stmt
			.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

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

	/* 追加リスト表示 ここから */
	// SQLの実行・メンバーリスト[追加]
	ResultSet ADD = stmt
			.executeQuery("SELECT * FROM KINMU.KOJIN ORDER BY K_PASS2, K_社員NO");

	// hitListの作成
	Vector hitKOID = new Vector();
	Vector hitKONAME = new Vector();
	Vector hitKOGRUNO = new Vector();

	while (ADD.next()) {
		String id = strEncode(ADD.getString("K_ID"));
		String name = ADD.getString("K_氏名");
		String gco = strEncode(ADD.getString("K_GRUNO"));
		hitKOID.addElement(id.trim());
		hitKONAME.addElement(name.trim());
		hitKOGRUNO.addElement(gco);
	}

	int cntADD = hitKOID.size();

	ADD.close();
	/* 追加リスト表示 ここまで */

	/* 削除リスト表示 ここから */
	// SQLの実行・メンバーリスト[削除]
	//ResultSet DEL = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND KY_TABLE.S_DATE = '" + DA + "' AND KY_TABLE.S_START = '" + ST + "' AND (K_社員NO2 = '" + ID + "' OR K_社員NO2 = '" + NO + "' )) OR (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND (K_社員NO2 = '" + ID + "' OR K_社員NO2 = '" + NO + "' ) AND KY_TABLE.KY_FLAG = '0') OR (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND KY_TABLE.B_START = '" + BS + "' AND (K_社員NO2 = '" + ID + "' OR K_社員NO2 = '" + NO + "' ))");
	ResultSet DEL = stmt
			.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND to_char(KY_TABLE.S_DATE,'YYMMDD') =  '"
					+ DA
					+ "'  AND KY_TABLE.S_START = '"
					+ ST
					+ "' AND (K_社員NO2 = '"
					+ ID
					+ "' OR K_社員NO2 = '"
					+ NO
					+ "' )) OR (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND (K_社員NO2 = '"
					+ ID
					+ "' OR K_社員NO2 = '"
					+ NO
					+ "' ) AND KY_TABLE.KY_FLAG = '0') OR (KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND to_char(KY_TABLE.B_START,'YYMMDD') = '"
					+ BS
					+ "' AND (K_社員NO2 = '"
					+ ID
					+ "' OR K_社員NO2 = '" + NO + "' ))");

	Vector hitKYID = new Vector();
	Vector hitKYNAME = new Vector();

	while (DEL.next()) {
		String id = strEncode(DEL.getString("K_社員NO"));
		String name = DEL.getString("K_氏名");
		hitKYID.addElement(id);
		hitKYNAME.addElement(name);
	}

	int cntDEL = hitKYID.size();

	DEL.close();
	/* 削除リスト表示 ここまで */

	/* 登録者表示 ここから */
	// SQLの実行・登録者表示
	//ResultSet KOJIN = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_社員NO2 = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "'))");
	ResultSet KOJIN = stmt
			.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_社員NO2 = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((to_char(S_DATE,'YYMMDD') = '"
					+ DA
					+ "' AND S_START = '"
					+ ST
					+ "') OR (to_char(KY_TABLE.B_START,'YYMMDD') = '"
					+ BS + "'))");

	// 登録者の社員番号と名前を格納します
	String koName = "";

	// 個人情報テーブルにアクセス
	while (KOJIN.next()) {
		koName = KOJIN.getString("K_氏名");
	}

	KOJIN.close();
	/* 登録者表示 ここまで */

	/* 共有者表示 ここから */
	// SQLの実行・共有者表示
	//ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((KY_TABLE.S_DATE = '" + DA + "' AND KY_TABLE.S_START = '" + ST + "') OR (KY_TABLE.B_START = '" + BS + "'))");
	ResultSet KYOYU = stmt
			.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_社員NO = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((to_char(KY_TABLE.S_DATE,'YYMMDD') = '"
					+ DA
					+ "' AND KY_TABLE.S_START = '"
					+ ST
					+ "') OR (to_char(KY_TABLE.B_START,'YYMMDD') = '"
					+ BS + "'))");

	Vector hitKYOYU = new Vector();

	// 共有者テーブルにアクセス
	while (KYOYU.next()) {
		String name = KYOYU.getString("K_氏名");
		hitKYOYU.addElement(name.trim());
	}

	int cntKYOYU = hitKYOYU.size();

	KYOYU.close();
	/* 共有者表示 ここまで */
%>
<script language="JavaScript">
<!--
	var bwtype2 = (document.all) ? 0 : (document.layers) ? 1 : 2;
	var move2 = 235;
	var ckck2 = 1;
	var divobj2;

	function movemn2() {
		if (!ckck2) {
			tid = setTimeout('realmnm1()', 10);
			ckck1 = 0;
			tid = setTimeout('realmnp2()', 10);
			ckck2 = 1;
		} else {
			tid = setTimeout('realmnp1()', 10);
			ckck1 = 1;
			tid = setTimeout('realmnm2()', 10);
			ckck2 = 0;
		}
		return false;
	}
	function realmnp2() {
		divobj2.left = move2;
		if (move2 < 235) {
			setTimeout('realmnp2()', 10);
		}
		move2 = move2 + 5;
	}
	function realmnm2() {
		divobj2.left = move2;
		if (move2 > 0) {
			setTimeout('realmnm2()', 10);
		}
		move2 = move2 - 5;
	}
//-->
</script>

<div id="divmenu2"
	style="position: absolute; visibility: visible; z-index: 1;">
	<table bgcolor="#99A5FF" border="1" width="235" height="604"
		cellpadding="0" cellspacing="0">
		<tr>
			<td bgcolor="#ffffff" width="20" rowspan="2">
				<center>
					<a href="#" onClick="return movemn2();"
						STYLE="text-decoration: none"><b>⇔
							<p>
								<font size="2">共<br>有<br>者<br>登<br>録<br>画<br>面
								</font>
							</p>⇔
					</b></a>
				</center>
			</td>
			<td bgcolor="#99A5FF" height="604" width="90%" colspan="2"><br>
				<br>
				<TABLE BORDER="1" WIDTH="100%">
					<TR>
						<TD BGCOLOR="#D6FFFF" WIDTH="30%">登録者</TD>
						<%
							if (koName.equals("")) {
						%><TD><BR></TD>
						<%
							} else {
						%><TD COLSPAN="<%=cntKYOYU%>"><font size="2"><%=koName%></font></TD>
						<%
							}
						%>
					</TR>
					<TR>
						<TD BGCOLOR="#D6FFFF" ROWSPAN="<%=cntKYOYU%>">共有者</TD>
						<%
							if (cntKYOYU != 0) {
								for (int i = 0; i < cntKYOYU; i++) {
						%><TD><font size="2"><%=hitKYOYU.elementAt(i)%></font></TD>
					</TR>
					<%
						}
						} else {
					%>
					<TD><BR></TD>
					<%
						}
					%>

				</TABLE>
				<P>
				<TABLE BORDER="1" width="100%">
					<TR>
						<FORM ACTION="pubsInsert.jsp" METHOD="get">
							<TD BGCOLOR="#D6FFFF" style="width: 70%;">グループコード</TD>
							<TD ALIGN="center"><INPUT TYPE="submit" VALUE="表示"></TD>
					</TR>
					<TR>
						<TD colspan="2"><SELECT NAME="group" STYLE="width: 100%;"><OPTION VALUE=""></OPTION>
<%int j = -1;
			for (int i = 0; i < cntGRU; i++) {
				if (hitGRUNUM.elementAt(i).equals(GR)) {
					j = i;
				}
			}
			for (int i = 0; i < cntGRU; i++) {
				if (i == j) {%><OPTION VALUE="<%=hitGRUNUM.elementAt(i)%>" SELECTED><%=hitGRUNUAM.elementAt(i)%></OPTION><%} else {%><OPTION VALUE="<%=hitGRUNUM.elementAt(i)%>"><%=hitGRUNUAM.elementAt(i)%></OPTION><%}
			}%>
   
   </SELECT>
							<INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
							TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
							TYPE="hidden" NAME="s_date" VALUE="<%=DA%>"> <INPUT
							TYPE="hidden" NAME="s_start" VALUE="<%=ST%>"> <INPUT
							TYPE="hidden" NAME="b_start" VALUE="<%=BS%>"> <INPUT
							TYPE="hidden" NAME="kind" VALUE="<%=KD%>"> <INPUT
							TYPE="hidden" NAME="act" VALUE="<%=AC%>"></TD>

					</TR>
					<TR>

						<TD valign="top"><SELECT SIZE="5" NAME="add" MULTIPLE
							STYLE="WIDTH: 100%; height: 120;">
								<%
									if (GR != null) {
										for (int i = 0; i < cntADD; i++) {
											if (hitKOGRUNO.elementAt(i).equals(GR)) {
								%><OPTION VALUE="<%=hitKOID.elementAt(i)%>"><%=hitKONAME.elementAt(i)%></OPTION>
								<%
									}
										}
									} else {
								%><OPTION VALUE=""></OPTION>
								<%
									}
								%>
						</SELECT> <INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
							TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
							TYPE="hidden" NAME="s_date" VALUE="<%=DA%>"> <INPUT
							TYPE="hidden" NAME="s_start" VALUE="<%=ST%>"> <INPUT
							TYPE="hidden" NAME="b_start" VALUE="<%=BS%>"> <INPUT
							TYPE="hidden" NAME="group" VALUE="<%=GR%>"> <INPUT
							TYPE="hidden" NAME="kind" VALUE="<%=KD%>"></TD>
						<TD ALIGN="center" VALIGN="middle"><INPUT TYPE="submit"
							NAME="act" VALUE="追加"></TD>
						</FORM>
					</TR>
				</TABLE>
				<p>
				<TABLE BORDER="1" WIDTH="100%">
					<TR>
						<TD BGCOLOR="#D6FFFF" COLSPAN="2">メンバーリスト</TD>
					</TR>
					<TR>
						<FORM ACTION="pubsInsert.jsp" METHOD="get">
							<TD valign="top" STYLE="WIDTH: 70%";><SELECT SIZE="5"
								NAME="del" MULTIPLE STYLE="WIDTH: 100%; HEIGHT: 120;">
									<%
										for (int i = 0; i < cntDEL; i++) {
									%><OPTION VALUE="<%=hitKYID.elementAt(i)%>"><%=hitKYNAME.elementAt(i)%></OPTION>
									<%
										}
									%>
							</SELECT> <INPUT TYPE="hidden" NAME="id" VALUE="<%=ID%>"> <INPUT
								TYPE="hidden" NAME="no" VALUE="<%=NO%>"> <INPUT
								TYPE="hidden" NAME="s_date" VALUE="<%=DA%>"> <INPUT
								TYPE="hidden" NAME="s_start" VALUE="<%=ST%>"> <INPUT
								TYPE="hidden" NAME="b_start" VALUE="<%=BS%>"> <INPUT
								TYPE="hidden" NAME="group" VALUE="<%=GR%>"> <INPUT
								TYPE="hidden" NAME="kind" VALUE="<%=KD%>"></TD>
							<TD ALIGN="center"><INPUT TYPE="submit" NAME="act"
								VALUE="削除"></TD>
						</FORM>
					</TR>
				</TABLE>
				</div> <script language="JavaScript">
				<!--
					if (bwtype2 == 0) {
						divobj2 = document.all.divmenu2.style;
					}
					if (bwtype2 == 1) {
						divobj2 = document.divmenu2;
					}
					if (bwtype2 == 2) {
						divobj2 = document.getElementById("divmenu2").style;
					}
					divobj2.left = 235;
					divobj2.top = 0;
				//-->
				</script>