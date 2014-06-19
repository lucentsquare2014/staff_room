<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,java.sql.*,java.util.Date,java.io.*,java.text.*" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgia" %>

<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal==null){
		return (null);
	}else{
		return (new String(strVal.getBytes("8859_1"),"UTF-8"));
	}
}

%>
<%

/* 修正点 */
// 02-08-12 パラメータの送り先を変更[各フレームへ送信 sub01,sub02]
// 02-08-16 パラメータを修正
// 02-09-02 パラメータの送り先の変更[２画面に変更したので、sub02にのみ送る]

/* 追加点 */
// 02-08-15 休み関連の予定を選択した時に、バナースケジュールの色を変更する。
// 02-08-30 本日の日付を点滅する。

try{
	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));

	// パラメータの受け取り・日付
	String strReturn = request.getParameter("s_date");

	// パラメータの受け取り・グループコード
	String post = request.getParameter("group");

	//カレンダーの呼び出し
	GregorianCalendar cal = new GregorianCalendar();
	GregorianCalendar cal2 = new GregorianCalendar();
	GregorianCalendar cal3 = new GregorianCalendar();

	int y = Integer.parseInt(""+ (cal.get(Calendar.YEAR)));
	int m = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));
	int d = Integer.parseInt(""+ (cal.get(Calendar.DATE)));

	String strTuki = request.getParameter("count");
	String strYear = request.getParameter("countY");
	String strDay  = request.getParameter("countD");

	int intTuki = 0;
	int intYear = 0;
	int intDay = 0;
	int intYoubi = 0;

	// スケジュールカウント用変数
	int mincnt = 0;
	int xxx = 0;

	// 年
	if(strYear != null){
		intYear = Integer.parseInt(strYear);
	}else{
		intYear = y;
	}
	//月
	if(strTuki != null){
		intTuki = Integer.parseInt(strTuki);
	}else{
		intTuki = m;
	}
	// 日
	if(strDay != null){
		intDay = Integer.parseInt(strDay);
	}else{
		intDay = d;
	}

	// 月末の日:eDay
	cal.set( intYear, intTuki, 0 );
	int eDay = cal.get( Calendar.DATE );

	// 日に関して月をまたいだ時
	if(intDay == 0){
		intTuki = intTuki - 1;

		// 月末の日:eDay
		cal.set( intYear, intTuki, 0 );
		eDay = cal.get( Calendar.DATE );
		intDay = eDay;
	}

	if(intDay > eDay ){
		intTuki = intTuki + 1;
		intDay = 1;
	}

	// 年をまたいだ時

	if(intTuki == 0){
		intTuki = 12;
		intYear = intYear - 1;
	}
	if(intTuki == 13){
		intTuki = 1;
		intYear = intYear + 1;
	}

	if(strReturn != null){
		String reYear = strReturn.substring(0,4);
		String reMonth = strReturn.substring(5,7);
		String reDay = strReturn.substring(8,10);
		intYear = Integer.parseInt(reYear);
		intTuki = Integer.parseInt(reMonth);
		intDay = Integer.parseInt(reDay);
	}

	// 曜日の取得
	cal.set( intYear, intTuki-1, intDay );
	int w = cal.get(Calendar.DAY_OF_WEEK);

	String strYoubi = "";

	if(w == 1){
		strYoubi = "日";
	}else if(w == 2){
		strYoubi = "月";
	}else if(w == 3){
		strYoubi = "火";
	}else if(w == 4){
		strYoubi = "水";
	}else if(w == 5){
		strYoubi = "木";
	}else if(w == 6){
		strYoubi = "金";
	}else{
		strYoubi = "土";
	}

	// 日付の表示形式を設定する
	SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");

	// 今日の日付
	cal.set( intYear, intTuki-1, intDay);
	Date today = cal.getTime();

	// 前日の日付
	cal2.set( intYear, intTuki-1, intDay-1);
	Date zenday = cal2.getTime();

	// 翌日の日付
	cal3.set( intYear, intTuki-1, intDay+1);
	Date yokuday = cal3.getTime();

	// 各日付の幅を設定
	int[] scheduleWidth = new int[48];

	// JDBCドライバのロード
	Class.forName("org.postgresql.Driver");

	// ユーザ情報
	String user = "georgir";
	String password = "georgir";

	// データベース接続
	Connection dbConn = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

	// Statementオブジェクトの生成
	Statement stmt = dbConn.createStatement();

	Vector hitList  = new Vector();
	Vector hitList2 = new Vector();
	Vector hitList3 = new Vector();
	Vector hitList4 = new Vector();
	Vector hitList5 = new Vector();
	Vector hitList6 = new Vector();
	Vector hitList7 = new Vector();
	Vector hitList8 = new Vector();
	Vector hitList9 = new Vector();
	Vector hitLista = new Vector();
	Vector hitListb = new Vector();
	Vector hitListc = new Vector();
	Vector hitLists = new Vector();

	int P = 0;
	int P1 = 0;
	int P2 = 0;
	int PL = 0;
	int PL2 = 0;
	int SP = 0;
	int SP2 = 0;
	int ME = 0;
	int ST = 0;
	int NO = 0;
	int B = 0;
	int tm = 0;

	// バックカラーの色を格納
	String colorbg = "";

	ResultSet GRU = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

	while(GRU.next()){
		String gname = GRU.getString("G_GRNAME");
		String gnum = GRU.getString("G_GRUNO");
		hitList.addElement(gname);
		hitList2.addElement(gnum);
	}

	GRU.close();

	ResultSet KOJIN = stmt.executeQuery("SELECT K_氏名, K_GRUNO, K_ID FROM KINMU.KOJIN ORDER BY K_PASS2 , K_社員NO");

	while(KOJIN.next()){
		String name = KOJIN.getString("K_氏名");
		String num = KOJIN.getString("K_GRUNO");
		String id = KOJIN.getString("K_ID");
		hitList3.addElement(name);
		hitList4.addElement(num);
		hitList5.addElement(id);
	}

	KOJIN.close();
%>
	<HTML>
		<HEAD>
			<TITLE>スケジュール日表示</TITLE>
		<STYLE TYPE="text/css">
			.shadow{filter:shadow(color=#000000,direction=135);position:relative;height:50;width:100%;}
		</STYLE>
		<SCRIPT>
		<!--
		function jump() {
			window.parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&group=<%= post %>&countY=<%= intYear %>&count=<%= intTuki %>&countD=<%= intDay - 1 %>';
			return false;
		}
		function jump2(){
			window.parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&group=<%= post %>&countY=<%= intYear %>&count=<%= intTuki %>&countD=<%= intDay + 1 %>';
			return false;
		}
		// -->
		</SCRIPT>
		</HEAD>
		<BODY BGCOLOR="#99A5FF">
			<TABLE BORDER="0">
				<TR>
					<TD>
						<FORM ACTION="tryagain.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
							<INPUT TYPE="submit" VALUE="月表示">
						</FORM>
					</TD>
					<TD>
						<FORM ACTION="TestExample34.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
							<INPUT TYPE="submit" VALUE="週表示">
						</FORM>
					</TD>
					<TD>
						<FORM ACTION="h_hyoji.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
							<INPUT TYPE="submit" VALUE="日表示">
						</FORM>
					</TD>
                    <TD>
                       <FORM ACTION="personal.jsp" METHOD="POST" TARGET="_parent">
                            <INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
                            <INPUT TYPE="submit" VALUE="個人設定" title="個人設定ページに移動します。">
                       </FORM>
                    </TD>
                    <TD>
                      <FORM ACTION="/staff_room" METHOD="POST" TARGET="_top">
                        <INPUT TYPE="submit" VALUE="スタッフルームに戻る" title="スタッフルームトップへ移動します。">
                      </FORM>
                    </TD>
				</TR>
			</TABLE>
			<TABLE border="0">
				<TR>
					<TD>
						<NOBR><FONT COLOR=white><SPAN CLASS="shadow">
						<FORM action="h_hyoji.jsp" >グループ名</font>
						<SELECT NAME="group" STYLE=WIDTH:200>
							<%
							int hitCnt = hitList.size();
							int j = -1;
							int i = 0;;
							for(i = 0; i < hitCnt; i++){
								if(hitList2.elementAt(i).equals(post)){
									j = i;
								}
							}
							for(i = 0; i < hitCnt; i++){
								if(i == j){
								%><OPTION SELECTED VALUE=<%=hitList2.elementAt(i) %>><%= hitList.elementAt(i) %></OPTION><%
							}else{
								%><OPTION VALUE=<%=hitList2.elementAt(i) %>><%= hitList.elementAt(i) %></OPTION><%
							}
						}
						%>
						</SELECT>
					</TD></span>

					<td valign="top">
						<FONT COLOR="#ffffff"><SPAN CLASS="shadow"><NOBR>　　日付</span></font>
					</td>

					<td valign="top">
						<INPUT TYPE="TEXT" NAME="countY" VALUE="<%= intYear %>" STYLE=WIDTH:50 MAXLENGTH="4">
					</td>
					<td valign="top">
						<FONT COLOR="#ffffff"><SPAN CLASS="shadow">年</SPAN></font>
					</td>

					<TD VALIGN="top">
						<SELECT NAME="count" STYLE=WIDTH:50>
							<%
							for(i = 1; i <= 12; i++ ){
								%>
								<option value=<%= i %>
								<%
								if(i == intTuki){
									%>
									SELECTED
									<%
								}
								%>/><%= i %><%
							}
							%>
						</SELECT>
					</TD>
					<td VALIGN="top">
						<FONT COLOR="#ffffff"><SPAN CLASS="shadow">月</SPAN></FONT>
					</td>

					<TD VALIGN="top">
						<SELECT NAME="countD" STYLE=WIDTH:50>
							<%
							for(i = 1; i <= 31; i++ ){
								%>
								<option value=<%= i %>
								<%
								if(i == intDay){
									%>
									SELECTED
									<%
								}
								%>/><%= i %>
								<%
							}
							%>
						</SELECT>
					</TD>
					<TD VALIGN="top">
						<FONT COLOR="#ffffff"><SPAN CLASS="shadow">日</SPAN></FONT>
					</TD>

					<TD valign="top">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" NAME="hyoji" VALUE="表示" >
					</TD>
					</FORM>
				</TR>
			</TABLE>

			<CENTER>

			<TABLE>
				<TR>
					<%-- 前日に移動するボタン --%>
					<TD VALIGN="bottom">
						<FORM METHOD="POST" ACTION="h_hyoji.jsp"><INPUT TYPE="button" NAME="zenjitu" VALUE="前日" OnClick="jump()"></FORM>
					</TD>

					<TD >
						<% String kyo ="";
						if(intYear==y && intTuki==m && intDay==d){
							%><%--
							<script type="text/javascript">
								<!--
								if(document.all){
									setInterval('bli.style.visibility=bli.style.visibility=="visible"?"hidden":"visible"',1000);
								}
								//-->
							</script>
							--%>
							<% kyo = "lavender";
						}
						else{
							kyo = "white";
						}
						%>
						<FONT size="6" color="<%= kyo %>"><B><I><SPAN CLASS="shadow"><%= intYear %>年 <%= intTuki %>月<%= intDay %>日(<%=strYoubi%>)</SPAN></I></B></FONT>
					</TD>

					<%-- 翌日に移動するボタン --%>
					<TD VALIGN="bottom">
						<FORM METHOD="POST" ACTION="h_hyoji.jsp"><INPUT TYPE="button" NAME="yokujitu" VALUE="翌日" OnClick="jump2()"></FORM>
					</TD>
				</TR>
			</TABLE>

			</CENTER>

			<%
			//グループに所属している人全員を表示のループの開始。一番下のあたりまで、かなりでかいループ
			int hitCnt2 = hitList3.size();
			int k = 0;
			i = 0;
			String S_sTimeH = "";
			String S_sTimeM = "";
			String S_eTimeH = "";
			String S_eTimeM = "";
			int sTime,eTime;
			int I_sTimeM,I_sTimeH,I_eTimeM,I_eTimeH;
			int chkTimeS,chkTimeE;
			int[] Inyotei;
			int count00=0;
			int count30=0;
			int cc = 0;
			int zz = 0;
			int starti = 0;
			int endi = 0;
			int cellstart = 1;
			int cellend = -1;
			int joint = 0;
			Inyotei = new int[1500];									//1日を分に直すと1440分 足りなくなるのでさらに60個ほど余分にとっておく
			for( k = 0; k < hitCnt2; k++){
				if(hitList4.elementAt(k).equals(post)){
					Arrays.fill(Inyotei,0);								//配列のすべての要素を0に初期化
					String start = "";
					String end = "";
					String plan = "";
					String plan2 = "";
					String date1 = "";
					String s_place = "";
					String s_place2 = "";
					String memo ="";
					String time = "";
					ResultSet rs4 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE  K_氏名 ='"+ hitList3.elementAt(k)+"'");

					String sno = "";
					while(rs4.next()){
						sno = rs4.getString("K_ID");
					}
					rs4.close();

					ResultSet rs3 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO='"+sno+"' AND S_DATE='"+sFmt.format(today)+"' AND S_START > '0' ");

					while(rs3.next()){
						start = rs3.getString("S_START");
						end = rs3.getString("S_END");
						S_sTimeM = start.substring(2,4);				//開始時刻を分に分割
						S_sTimeH = start.substring(0,2);				//開始時刻を時に分割
						S_eTimeM = end.substring(2,4);					//終了時刻を分に分割
						S_eTimeH = end.substring(0,2);					//終了時刻を時に分割
						I_sTimeM = Integer.parseInt(S_sTimeM);			//上記をint型へ
						I_sTimeH = Integer.parseInt(S_sTimeH);			//上記をint型へ
						I_eTimeM = Integer.parseInt(S_eTimeM);			//上記をint型へ
						I_eTimeH = Integer.parseInt(S_eTimeH);			//上記をint型へ
						chkTimeS = (I_sTimeH*60) + I_sTimeM;			//開始時刻を分数のみへ変換 例1230→750
						chkTimeE = (I_eTimeH*60) + I_eTimeM;			//終了時刻を分数のみへ変換 例1230→750

						i=0;											//1440分と同じ数の配列に、予定数を入れる処理
						while(i<1440){
							if((chkTimeS == i) || (chkTimeE == i)){		//開始または終了時刻があるなら配列に1
								Inyotei[i]=Inyotei[i]+1;				//                    ないなら配列に0
							}											//終了時刻と次の予定の開始時刻が一緒なら2
							i = i+1;
						}
					}rs3.close();
				%>

				<TABLE BORDER="3" BORDERCOLORLIGHT="#99CCFF" BORDERCOLORDARK="#3366CC" WIDTH="730" BORER-COLLAPSE:COLLAPSE CELLSPACING="0" CELLPADDING="0">
					<TR>
						<TD BGCOLOR="D3D3D3" WIDTH="75" ROWSPAN="2">名前</TD>
							<%
							count00=0;
							count30=0;
							cc = 0;
							String BGCOLOR = "";
							i=0;
							while(i<1440){											//表の時間部分
							if(i < 540){											//0時から9時未満までの色を指定
								BGCOLOR="#87CEFA";
							}else if(i > 1139){										//9時から19時未満までの色を指定
								BGCOLOR="#9370DB";
							}else{													//それ以外のときの色を指定
								BGCOLOR="#FFDEAD";
							}
								count00=0;count30=0;
								while(cc < i+60){									//1時間の中に予定があるかどうか調べる
									if((cc < i+30) && (Inyotei[cc] >= 1)){			//0分から29分の中か、
										count00 = count00 + 1;
									}else if((cc >= i+30) && (Inyotei[cc] >= 1)){	//30分から59分の中か
										count30 = count30 + 1;
									}
								cc = cc + 1;
								}
								if((count00 >= 1) && (count30 >= 1)){				//0分から29分に1以上、30分から59分に1以上
									%><td COLSPAN=60 BGCOLOR=<%= BGCOLOR %>><%= i/60 %></td><%
								}else if(((count00 >= 1) && (count30 == 0)) || ((count00 == 0) && (count30 >= 1))){//片方だけ1以上
									%><td COLSPAN=31 BGCOLOR=<%= BGCOLOR %>><%= i/60 %></td><%
								}else{
									%><td COLSPAN=2 BGCOLOR=<%= BGCOLOR %>><%= i/60 %></td><%
								}
							i = i+60;
							}
							%>

						<TR>
							<%
							i = 0;
							cc = 0;
							count00 = 0;
							while(i < 1440){											//表の00と30の部分
							if(i < 540){												//0時から9時未満までの色を指定
								BGCOLOR="#87CEFA";
							}else if(i > 1139){											//9時から19時未満までの色を指定
								BGCOLOR="#9370DB";
							}else{														//それ以外のときの色を指定
								BGCOLOR="#FFDEAD";
							}
								count00 = 0;
								while(cc < i+30){										//0分から29分の中に予定があるかどうか調べる
									if(Inyotei[cc] >= 1){
										count00 = count00 + 1;
									}
								cc = cc + 1;
								}

								if(count00 >= 1){
									if((i % 60) == 0){
										%><TD BGCOLOR=<%= BGCOLOR %> colspan=30><font style=font-size:9>00</font></TD><%
									}
									else{
										%><TD BGCOLOR=<%= BGCOLOR %> colspan=30><font style=font-size:9>30</font></TD><%
									}
								}else{
									if((i % 60) == 0){
										%><TD BGCOLOR=<%= BGCOLOR %>><font style=font-size:9>00</font></TD><%
									}
									else{
										%><TD BGCOLOR=<%= BGCOLOR %>><font style=font-size:9>30</font></TD><%
									}
								}
								i=i+30;
							}
							%>
						</TR>
					<TR height="40">
						<TD BGCOLOR="#FFFFFF" WIDTH="60" VALIGN="top">
							<NOBR>
							<A href="timeIn.jsp?id=<%= ID %>&no=<%= sno %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Day&act=" target="sub02" oncontextmenu="if(!event.ctrlKey){ no='<%= sno %>';date='<%= sFmt.format(today) %>'; miseru<%=xxx%>(no,date);return false}">
								<acronym title="クリックすると新規登録ができます">
								<FONT SIZE = -1><%= hitList3.elementAt(k) %></FONT>
							</A>
						</TD>
						<%
							i = 0;
							cc = 0;
							count30 = 0;
							zz=0;

							rs3 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO='"+sno+"' AND S_DATE='"+sFmt.format(today)+"' AND S_START > '0' ");


							while(i < 1440){						//最後のほうまでのループ
								cc = i;
								count30 = 0;
								while(cc < i+30){					//30分のセルの中に予定があるかどうかを探す
									if(Inyotei[cc] >= 1){
										count30 = count30 + 1;
									}
								cc = cc + 1;
								}

								if(count30 == 0){					//30分刻みで見て、予定が入っていないなら
									%><TD ROWSPAN="2" BGCOLOR="#FFFFFF"<%
									if((i % 60) == 0){
									 	%>style="BORDER-right:1px none " style="BORDER-left:1px solid #0033FF"<%
									 	i = i + 30;
									}else{
										%>style="BORDER-right:1px none " style="BORDER-left:1px dotted " <%
										i = i + 30;
									}%>><BR></TD>
								<%
								}else if(count30 >= 1){			//30分刻みで見て、予定開始（終了）時刻が１つ以上入っているなら
									starti = 0;					//結合部分付近、基本は↓↓こんな感じ↓↓予定の入り方により変化する
									endi = 0;					//cellstart	→→→→starti→→→→→joint→	→→→→endi→→→→→→cellend
									cellstart = 1;				//セルの開始		結合の開始		結合数			結合の終了		セルの終了
									cellend = -1;				//30の倍数か														30の倍数か
									joint = 0;					//1つ前の予定の														次の予定の
									zz = i;						//cellendのこと														cellstartのこと

									rs3.next();
									start = rs3.getString("S_START");
									end = rs3.getString("S_END");
									date1 = rs3.getString("S_DATE");
									plan = rs3.getString("S_PLAN").trim();
									plan2 = rs3.getString("S_PLAN2");
									s_place = rs3.getString("S_PLACE").trim();
									s_place2 = rs3.getString("S_PLACE2");
									memo = rs3.getString("S_MEMO");
									S_sTimeM = start.substring(2,4);							//開始時刻を「分」と
									S_sTimeH = start.substring(0,2);							//          「時」に分割
									S_eTimeM = end.substring(2,4);								//終了時刻を「分」と
									S_eTimeH = end.substring(0,2);								//          「時」に分割
									I_sTimeM = Integer.parseInt(S_sTimeM);						//開始時刻「分」をint型へ
									I_sTimeH = Integer.parseInt(S_sTimeH);						//開始時刻「時」をint型へ
									I_eTimeM = Integer.parseInt(S_eTimeM);						//終了時刻「分」をint型へ
									I_eTimeH = Integer.parseInt(S_eTimeH);						//終了時刻「時」をint型へ

									time = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "〜" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

									if(plan.equals("--")){
										plan = "";
									}
									if(s_place.equals("--")){
										s_place = "";
									}

									if(plan.length() != 0 && plan2.length() != 0){
										plan2 = "<b>" + " : " + "</b>" + plan2;					//予定詳細がnullではなかったら"："を表示
									}else{
										plan2 = "";
									}

									if(s_place.length() != 0 && s_place2.length() != 0){
										s_place2 = "<b>" + " : " + "</b>" + s_place2;			//場所詳細がnullではなかったら"："を表示
									}else{
										s_place2 = "";
									}

									if( memo == null || memo.equals("")){
										memo = "";
									}else{
										memo = "<b>" + "<メモ>" + "</b>" + "<br>" + memo;			//memoがnullではなかったら"＜メモ＞"を表示
									}

									/*      20130113  上記修正
									if(memo != null){
										memo = "<b>" + "<メモ>" + "</b>" + "<br>" + memo;		//memoがnullではなかったら"＜メモ＞"を表示
									}
									*/
									hitList6.addElement(plan);
									hitList9.addElement(plan2);
									hitList7.addElement(s_place);
									hitLista.addElement(s_place2);
									hitList8.addElement(memo);
									hitListb.addElement(start);
									hitListc.addElement(time);


									if(i == cellend){											//キリのいい数(30分刻み)まで前の予定を表示しているなら
										count30 = 0;
										while(cc < i+30){										//30分のセルの中に予定があるかどうかを探す
											if(Inyotei[cc] >= 1){
												count30 = count30 + 1;
											}
										cc = cc + 1;
										}
										if(count30 == 0){										//30分刻みで見て、予定が入っていないなら
											%><TD ROWSPAN="2" BGCOLOR="#FFFFFF"<%
											if((i % 60) == 0){
												%>style="BORDER-left:1px solid  #0033FF"style="BORDER-right:1px none "<%
												i = i + 30;
											}else{
												%>style="BORDER-left:1px dotted #0033FF"style="BORDER-right:1px none " <%
												i = i + 30;
											}%>><BR></TD>
										<%}
									}
									if(cellstart != cellend){									//２つ目の予定からは行わない、1つ前の予定のcellendがcellstartになっている
										cellstart = zz;

										while(Inyotei[zz] == 0){								//配列Inyoteiを使って
											zz = zz+1;											//
										}														//
										starti = zz;											//開始時刻をstartiへ代入
									}

									zz = zz+1;
									while(Inyotei[zz] == 0){									//配列Inyoteiを使って
										zz = zz+1;												//
									}															//
									endi = zz;													//終了時刻をendiへ代入

									joint = (I_eTimeH - I_sTimeH - 1)*2;						//結合数を計算(セルを30個に分けていないところ)

									if((I_sTimeM >= 0) && (I_sTimeM < 30)){						//開始時刻「分」が0〜29の場合の
										joint = joint+(31 - I_sTimeM);							//予定の入るセルの結合数の計算
									}else if((I_sTimeM >= 30) && (I_sTimeM < 60)){				//開始時刻「分」が30〜59の場合の
										joint = joint+(60 - I_sTimeM);							//予定の入るセルの結合数の計算
									}
									if((I_eTimeM >= 0) && (I_eTimeM < 30)){						//終了時刻「分」が0〜29の場合の
										joint = joint+(I_eTimeM);								//予定の入るセルの結合数の計算
									}else if((I_eTimeM >= 30) && (I_eTimeM < 60)){				//終了時刻「分」が30〜59の場合の
											joint = joint+(I_eTimeM - 29);						//予定の入るセルの結合数の計算
									}
									if((I_eTimeH == I_sTimeH) && ((I_eTimeM - I_sTimeM) <= 30)){//30分以下の予定の場合の
										joint = (I_eTimeM - I_sTimeM);							//予定の入るセルの結合数の計算
									}
									cellend = endi+1;
									while(Inyotei[cellend] == 0){								//次の予定があれば、cellendをそこまで移動、
										if(cellend % 30 == 0){									//その前にキリのいいところがあればそこまで移動
											break;
										}
									cellend = cellend+1;
									}
									if(Inyotei[endi] == 2){										//予定終了時刻と、次の予定開始時刻が一緒の場合
										cellend = endi;
									}
									zz = 0;
									while((starti - cellstart) > zz){							//結合セル前(cellstartからstartiまで)の、セル(白)を表示
										if(zz == 0){											//最初の1つ目のセルだけに、左側に線を表示
											if(cellstart % 60 == 0){
												%><td ROWSPAN="2" bgcolor=white style="BORDER-left:1px solid #0033FF"style="BORDER-right:1px none "><BR></td><%
											}else{
												%><td ROWSPAN="2" bgcolor=white style="BORDER-left:1px dotted "style="BORDER-right:1px none "><BR></td><%
											}
										}else{													//２つ目以降のセル(白)を表示
											%><td ROWSPAN="2"bgcolor=white style="BORDER-top:1px solid #0033FF"
												style="BORDER-left:1px none "style="BORDER-right:1px none " ><BR></td><%
										}
										zz = zz+1;
										i = i+1;

									}%>
									<td ROWSPAN="2" colspan=<%= joint %> HEIGHT="50" bgcolor="#ffffcb" VALIGN="top"
										 style="BORDER-left:1px solid #0033FF" style="BORDER-right:1px none">
									<A href="timeUp.jsp?id=<%= ID %>&no=<%= sno %>&s_date=<%= date1.substring(0,10) %>&s_start=<%= hitListb.elementAt(ST) %>&b_start=&group=<%= post %>&kind=Day-u&act=" target="sub02" oncontextmenu="if(!event.ctrlKey){id='<%= ID %>';no='<%= sno %>';date='<%= date1.substring(0,10) %>';start='<%= start %>'; send<%=mincnt%>(id,no,date,start);return false;}"><nobr>
									<font size="2">
									<%															//ここから結合セル(startiからendi)の中身の処理
									ST++;
									//スケジュールの表示
									out.print(hitListc.elementAt(tm++));						//予定の時間を表示

									if(hitList9.elementAt(P++)==null){							//予定詳細が入力されていなければ
										out.print(hitList6.elementAt(PL));						//予定のみを表示
										PL++;
										PL2++;
									}else{														//予定、予定詳細共に入力されていたら
										out.print(hitList6.elementAt(PL));						//予定を表示
										out.print(hitList9.elementAt(PL2));						//予定詳細を表示
										PL++;
										PL2++;
									}%>
									<BR><%
									if(hitLista.elementAt(P1++)==null){							//場所詳細が入力されていなければ
										out.print(hitList7.elementAt(SP));						//場所のみを表示
										SP++;
										SP2++;
									}else{														//場所、場所詳細共に入力されていたら
										out.print(hitList7.elementAt(SP));						//場所を表示
										out.print(hitLista.elementAt(SP2));						//場所詳細を表示
										SP++;
										SP2++;
									}%>
									<BR></NOBR><%
									if(hitList8.elementAt(P2++)==null){
										ME++;
									}else{
										out.print(hitList8.elementAt(ME++));
									}
									%>
									</font>
									</A></TD><%

									i = i+(endi - starti);										//結合数をiへ加算

									zz = 0;
									while(cellend - endi > zz){									//結合セル後(endiからcellendまで)の、セル(白)を表示
										if(zz == 0){											//最初の1つ目のセルだけに、左側に線を表示
											%><td ROWSPAN="2" bgcolor="white" style="BORDER-left:1px solid #0033FF; BORDER-right:1px none #FFFFFF; BORDER-top:1px solid #3399FF"><BR></td><%
										}else{													//２つ目以降のセル(白)を表示
											%><td ROWSPAN="2" bgcolor="white" style="BORDER-left:1px none ; BORDER-right:1px none ; BORDER-top:1px solid #3399FF"><BR></td><%
										}
										zz = zz+1;
										i = i+1;
									}
									if(Inyotei[cellend] >= 1){									//次の予定が結合セルの
										cellstart = cellend;									//すぐ後(30分区切りのセルの中)にある場合
										starti = cellstart;
										zz = starti;
									}else{
										i = cellend;											//キリのいい数（30分ごとのセルの区切り）になっている場合
									}
								}
							}rs3.close();
							%>
							<%
					//バナーの呼び出し、表示
					sFmt = new SimpleDateFormat("yyyy-MM-dd");
					cal.set( intYear, intTuki - 1, intDay);
					today = cal.getTime();

					ResultSet rs5 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE B_START <= '" + sFmt.format(today) + "' AND  '" + sFmt.format(today) + "' <= B_END AND K_社員NO = '"+ sno +"'");

					String b_plan = "";
					String b_plan2 = "";
					String b_place = "";
					String b_place2 = "";
					String b_start = "";
					colorbg = "white";

					while(rs5.next()){
						b_start =rs5.getString("B_START");
						b_start = b_start.substring(0,10);
						b_plan = rs5.getString("B_PLAN").trim();
						b_plan2 = rs5.getString("B_PLAN2");
						b_place = rs5.getString("B_PLACE").trim();
						b_place2 = rs5.getString("B_PLACE2");
						colorbg = "yellow";
					}
					rs5.close();

					//予定詳細があるときはそれを表示それ以外は予定を表示。予定が「休み」のときは色を変える。
					if(b_plan.equals("休み")||b_plan.equals("夏休")||b_plan.equals("午前休")||b_plan.equals("午後休")){
						colorbg = "orange";
					}
					%>

					<TR>
						<TD bgcolor="<%= colorbg %>" height="30" WIDTH="60" VALIGN="top">
							<FONT SIZE=-1>バナー<BR><%
							if(colorbg == "yellow"){%>
								<A href="dayUp.jsp?id=<%= ID %>&no=<%= sno %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Day-b&act=" TARGET="sub02">
								<%
								//予定が--ならnullへ
								if(b_plan.equals("--")){
									b_plan = "";
								}
								//場所が--ならnullへ
								if(b_place.equals("--")){
									b_place = "";
								}

								//予定がないなら、改行付加
								if(b_plan.length() == 0){
									b_plan = "";
								}else{
									b_plan = b_plan + "<BR>";
								}
								//予定詳細がないなら、改行付加
								if(b_plan2.length() == 0 || b_plan2.length() == 0){
									b_plan2 = "";
								}else{
									b_plan2 = b_plan2 + "<BR>";
								}
								//場所がないなら、改行付加
								if(b_place.length() == 0){
									b_place = "";
								}else{
									b_place = b_place + "<BR>";
								}
								//場所詳細がないなら、改行付加
								if(b_place2.length() == 0 || b_place2.length() == 0){
									b_place2 = "";
								}else{
									b_place2 = b_place2 + "<BR>";
								}
								if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
									b_plan = "詳細情報なし";
								}else{
									b_plan = b_plan + b_plan2 + b_place + b_place2;
								}
								%>
								<%=b_plan%>
							</A><%
							}%>
							</FONT>
						</TD>
					</TR>
						<script language="JavaScript1.2">
							<!--
							function deleteCookie(theName){
								document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
								return true;
							}

							function send<%= mincnt %>(a,b,c,d){
								alert("スケジュールをコピーします。");
								var charid = a;
								var charno = b;
								var charde = c;
								var charst = d;
								deleteCookie(charid,charno,charde,charst);
								document.cookie = "id="+charid+";";
								document.cookie = "no="+charno+";";
								document.cookie = "s_date="+charde+";";
								document.cookie = "s_start="+charst+";";
								// リダイレクト処理
								parent.main.location.href = "h_hyoji.jsp?id=<%= ID %>&no=<%= sno %>&s_date=<%= sFmt.format(today) %>&s_start=<%= start %>&group=<%= post %>&kind=Week";
							}
							function miseru<%= xxx %>(no,date){
								alert("スケジュールを貼りつけします。");
								var charno = no;
								var charde = date;
								// JavaScriptによるCookieからの抜き出し
								theCookie = document.cookie + ";";
								Sid = theCookie.indexOf("id");
								Sno = theCookie.indexOf("no");
								Ss_date = theCookie.indexOf("s_date");
								Ss_start = theCookie.indexOf("s_start");
								if(Sid != -1){
									Eid = theCookie.indexOf(";",Sid);
									Eid = theCookie.substring(Sid + 3,Eid);
								}
								if(Sno != -1){
									Eno = theCookie.indexOf(";",Sno);
									Eno = theCookie.substring(Sno + 3,Eno);
								}
								if(Ss_date != -1){
									Es_date = theCookie.indexOf(";",Ss_date);
									Es_date = theCookie.substring(Ss_date + 7,Es_date);
								}
								if(Ss_start != -1){
									Es_start = theCookie.indexOf(";",Ss_start);
									Es_start = theCookie.substring(Ss_start + 8,Es_start);
								}
								parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind=Day";
							}
							//-->
						</script>
				</TABLE>
				<%
		}
		mincnt = mincnt + 1;
		xxx = xxx + 1;
	}
	//グループに所属している人全員を表示のループの終了
	%>
	</BODY>
	<%
	stmt.close();
	dbConn.close();

}
catch(Exception e){
	e.printStackTrace();
}
%>
</HTML>
