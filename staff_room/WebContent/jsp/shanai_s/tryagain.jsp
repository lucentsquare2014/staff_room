<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.util.*,java.sql.*,java.util.Date,java.io.*,java.text.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return (null);
	}
	else{
		return (new String(strVal.getBytes("8859_1"),"Shift_JIS"));
	}
}
%>
<%
/* 修正点 */
// 02-08-12 パラメータの送り先を変更[各フレームへ送信 sub01,sub02]
// 02-08-15 誰も所属していないグループコードを選択した時に、全社員が個人名コンボボックスに表示されてしまう現象を修正。
// 02-08-16 パラメータを修正
// 02-09-02 パラメータの送り先の変更[２画面に変更したので、sub02にのみ送る]
// 13-06-18 バナーを未記入で入力すると変更、削除ができない現象を修正。
		
/* 追加点 */
// 02-08-15 休み関連の予定を選択した時に、バナースケジュールの色を変更する。
// 02-08-30 本日の日付を点滅する。

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// パラメータの受け取り
String reqNo = strEncode(request.getParameter("no"));
String name = strEncode(request.getParameter("kojin"));
String konohito = strEncode(request.getParameter("slkname"));
String post = request.getParameter("group");
String strReturn = request.getParameter("s_date");

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// データベースへ接続
String user = "georgir";
String password = "georgir";

Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);

Statement stmt = con.createStatement();

if(reqNo == null){
	reqNo = ID;
}

// SQL実行：ユーザの名前の取得
ResultSet NAME = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + reqNo +"'");

// 社員番号を社員名に変換
if( name == null ){
	while(NAME.next()){
		name = NAME.getString("K_氏名");
	}

	NAME.close();
}else if( konohito != null ){
	name = konohito;
}

// スケジュール用変数
String s_date = "";
String s_start = "";
String s_end = "";
String memo = "";

%>
<html>
	<head>
		<title></title>
		<STYLE TYPE="text/css">
			.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
		</STYLE>
	</head>
	<BODY BGCOLOR="#99A5FF">
		<TABLE BORDER="0">
			<TR>
				<TD>
					<FORM ACTION="tryagain.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="月表示" title="月表示に移動します。">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="TestExample34.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="週表示" title="週表示に移動します。">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="h_hyoji.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="日表示" title="日表示に移動します。">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="menu.jsp" METHOD="POST" TARGET="_top">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="submit" VALUE="メインメニューへ戻る" title="メインメニューに戻ります。">
					</FORM>
				</TD>
			</TR>
		</TABLE>
		<%
		// ＤＢグループ名.コンボ
		ResultSet rs2 = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

		Vector hitList1 = new Vector();
		Vector hitList2 = new Vector();

		String grname = "";
		String gruno = "";

		while(rs2.next()){
			grname = rs2.getString("G_GRNAME");
			gruno = rs2.getString("G_GRUNO");
			hitList1.addElement(grname);
			hitList2.addElement(gruno);
		}

		int hitCnt1 = hitList1.size();

		rs2.close();

		int i = 0;
		int j = -1;

		// スケジュールカウント用変数
		int mincnt = 0;
		int xxx = 0;

		// カレンダー呼び出し
		GregorianCalendar cal = new GregorianCalendar();
		int calYear = Integer.parseInt(""+ cal.get(Calendar.YEAR)); // 今年:calYear
		int calMonth = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));

		// 点滅用：本日の日付を読み出します。
		Date kyo = cal.getTime();

		String strTuki = request.getParameter("count");
		String strYear = request.getParameter("countY");

		int intTuki = 0;
		int intYear = 0;

		if(strYear != null){
			intYear = Integer.parseInt(strYear);
		}else{
			intYear = calYear;
		}

		// 月をまたいだ時に
		if(strTuki != null){
			intTuki = Integer.parseInt(strTuki);
		}else{
			intTuki = calMonth;
		}

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
			intYear = Integer.parseInt(reYear);
			intTuki = Integer.parseInt(reMonth);
		}

		cal.set( intYear, intTuki - 1, 1);
		int sWeek = cal.get( Calendar.DAY_OF_WEEK ); // 月初の曜日:sWeek

		cal.set( intYear, intTuki, 0 );
		int eWeek = cal.get( Calendar.DAY_OF_WEEK ); // 月末の曜日:eWeek
		int eDay = cal.get( Calendar.DATE );         // 月末の日  :eDay

		cal.set( intYear, intTuki - 1, 0 );
		int zengetu = cal.get( Calendar.DATE );      // 前月の最終日:zengetu
		zengetu = zengetu + 1;

		%>

		<%--  グループ名のコンボボックス  --%>
		<table>
			<tr>
				<form action="tryagain.jsp" method="post">
					<td>
						<FONT COLOR="white">
							<SPAN CLASS="shadow">
								グループ名
							</SPAN>
						</FONT>
					</td>
					<td valign="top">
						<select name=group style=width:200>
							<option value="all">全社員</option>
							<%
							if(post == null){
								post = post;
							}
							for(i = 0;i < hitCnt1;i++){
								if(hitList2.elementAt(i).equals(post)){
									%><option selected value="<%= hitList2.elementAt(i) %>"><%= hitList1.elementAt(i) %></option><%
								}else{
									%><option value="<%= hitList2.elementAt(i) %>"><%= hitList1.elementAt(i) %></option><%
								}
							}
							%>
						</select>
					</td>
					<td valign="top">
						<input type="hidden" name="group" value="<%= post %>">
						<input type="hidden" name="id" value="<%= ID %>">
						<input type="hidden" name="kojin" value="<%= name %>">
						<input type="hidden" name="count" value="<%= intTuki %>">
						<input type="hidden" name="countY" value="<%= intYear %>">
						<input type="submit" value="選択" title="左記のグループを右に表示します。">
					</td>
				</form>
				<%
				ResultSet rs4 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_GRUNO = '"+ post +"' ORDER BY K_PASS2 , K_社員NO");

				Vector hitList3 = new Vector();

				String kname = "";

				while(rs4.next()){
					kname = rs4.getString("K_氏名");
					hitList3.addElement(kname);
				}

				int hitCnt2 = hitList3.size();

				rs4.close();

				ResultSet rs8 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN ORDER BY K_PASS2 , K_社員NO");

				Vector hitList5 = new Vector();

				String minname = "";

				while(rs8.next()){
					minname = rs8.getString("K_氏名");
					hitList5.addElement(minname);
				}

				int hitCnt3 = hitList5.size();

				rs8.close();

				%>
				<form action="tryagain.jsp" method="post">
					<td>
						<FONT COLOR="white">
							<SPAN CLASS="shadow">
								個人名
							</SPAN>
						</FONT>
					</td>
					<td valign="top">
						<select name="slkname" style="width:200">
							<option selected value=""></option>
							<%
							if(post.equals("all")){
								for(i = 0;i < hitCnt3;i++){
									if(hitList5.elementAt(i).equals(name)){
										%><option selected value="<%= hitList5.elementAt(i) %>"><%= hitList5.elementAt(i) %></option><%
									}else{
										%><option value="<%= hitList5.elementAt(i) %>"><%= hitList5.elementAt(i) %></option><%
									}
								}
							}else{
								for(i = 0;i < hitCnt2;i++){
									if(hitList3.elementAt(i).equals(name)){
										%><option selected value="<%= hitList3.elementAt(i) %>"><%= hitList3.elementAt(i) %></option><%
									}else{
										%><option value="<%= hitList3.elementAt(i) %>"><%= hitList3.elementAt(i) %></option><%
									}
								}
							}
							%>
						</select>
					</td>
					<td valign="top">
						<input type="hidden" name="group" value="<%= post %>">
						<input type="hidden" name="id" value="<%= ID %>">
						<input type="hidden" name="kojin" value="<%= name %>">
						<input type="hidden" name="count" value="<%= intTuki %>">
						<input type="hidden" name="countY" value="<%= intYear %>">
						<input type="submit" value="表示" title="左記の人のスケジュールを表示します。">
					</td>
				</form>
			</tr>
		</table>
		<center>
			<table>
				<tr>
					<%--  前月に移動するコマンドボタン  --%>
					<form action="tryagain.jsp" method="post">
						<td>
							<input type="hidden" name="group" value="<%= post %>">
							<input type="hidden" name="id" value="<%= ID %>">
							<input type="hidden" name="kojin" value="<%= name %>">
							<input type="hidden" name="count" value="<%= intTuki - 1 %>">
							<input type="hidden" name="countY" value="<%= intYear %>">
							<input type="submit" name="zengetu" value="前月" title="前の月に移動します。">
						</td>
					</form>
					<td>
						<SPAN CLASS="shadow">
							<font size="6" color="white">
								<b><i>
								<%
								// 今日の年と月表示ラベル
								out.print(intYear + "年" + intTuki + "月");
								%>
								</i></b>
							</font>
						</SPAN>
					</td>
					<%--  次月に移動するコマンドボタン  --%>
					<form action="tryagain.jsp" method="post">
						<td>
							<input type="hidden" name="group" value="<%= post %>">
							<input type="hidden" name="id" value="<%= ID %>">
							<input type="hidden" name="kojin" value="<%= name %>">
							<input type="hidden" name="count" value="<%= intTuki + 1 %>">
							<input type="hidden" name="countY" value="<%= intYear %>">
							<input type="submit" name="jigetu" value="翌月" title="次の月に移動します。">
						</td>
					</form>
				</tr>
			</table>
		</center>

		<%--  カレンダー作成  --%>
		<table width="100%" border="1" cellspacing="0" cellpadding="1"><br>
			<tr bgcolor="black">
				<td width="13%" bgcolor="pink">
					<center>
						<font color="red">日</font>
					</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>月</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>火</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>水</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>木</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>金</center>
				</td>
				<td width="13%" bgcolor="skyblue">
					<center>
						<font color="blue">土</font>
					</center>
				</td>
			</tr>
			<%
			// テーブル項目取り込み用変数の初期化
			String bana = "";
			String b_plan = "";
			String b_plan2 = "";
			String b_place = "";
			String b_place2 = "";
			String b_start = "";
			String bmemo = "";
			String iro = "";
			// スケジュールの呼び出し
			// 社員名を社員番号に変換
			ResultSet rs5 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_氏名 = '"+ name +"'");

			String no = "";
			while(rs5.next()){
				no = rs5.getString("K_ID");
			}
			rs5.close();

			Date today = cal.getTime();
			int tuki = 0;
			int nen = 0;
			i = 0;
			SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
			String kyo2 = sFmt.format(kyo);
			// 月初めを空白に
			nen = intYear;
			tuki = intTuki - 2;

			if(sWeek != 1){
				if(tuki == -1){
					tuki = 11;
					nen = nen - 1;
				}
				for( i = 1; i < sWeek; i++ ){
					zengetu = zengetu - 1;
				}
				sFmt = new SimpleDateFormat("yyyy-MM-dd");
				cal.set( intYear, intTuki - 2, zengetu);
				Date thisMonth = cal.getTime();
				String hajime = sFmt.format(thisMonth);
				%>
				<tr>
				<%
				for( i = 1; i < sWeek; i++ ){
					sFmt = new SimpleDateFormat("yyyyMMdd");
					cal.set( intYear, intTuki - 2, zengetu);
					thisMonth = cal.getTime();
					int calWeek = cal.get( Calendar.DAY_OF_WEEK );
					calWeek = cal.get( Calendar.DAY_OF_WEEK );
					String yasumi = "";

					ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_年月日 = '"+ sFmt.format(thisMonth) +"'");

					while(rs7.next()){
						yasumi = rs7.getString("H_休日名");
					}

					rs7.close();
					sFmt = new SimpleDateFormat("yyyy-MM-dd");
					cal.set( nen, tuki, zengetu );
					today = cal.getTime();

					// 曜日毎にバックグランドの色を変更する
					if(sFmt.format(today).equals(kyo2)){
					// 今日
						%><td height="50" align="left" valign="top" bgcolor="lavender"><%
					}else if(calWeek == 1){
						%><td bgcolor="pink" height="50" align="left" valign="top"><%
					}else if(yasumi != null){
						%><td bgcolor="pink" height="50" align="left" valign="top"><%
					}else{
						%><td bgcolor="white" height="50" align="left" valign="top"><%
					}
					%>
					<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="新規登録できます。" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
						<%= zengetu %>
					</A>
					<font color="red"><%= yasumi %></font><br>
					<%
					ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
					while(rs3.next()){
						b_start = rs3.getString("B_START");
						b_start = b_start.substring(0,10);
						b_plan = rs3.getString("B_PLAN").trim();
						if(b_plan.equals("休み") || b_plan.equals("夏休")){
							iro = "orange";
						}else{
							iro = "yellow";
						}
						%>
						<table bgcolor="<%= iro %>" width="100%">
							<td>
								<%
								if(b_start.equals(sFmt.format(thisMonth)) || hajime.equals(sFmt.format(thisMonth))){
									b_plan2 = rs3.getString("B_PLAN2");
									b_place = rs3.getString("B_PLACE").trim();
									b_place2 = rs3.getString("B_PLACE2");
									bmemo = rs3.getString("B_MEMO");
									if(b_plan.equals("--")){
										b_plan = "";
									}
									if(b_place.equals("--")){
										b_place = "";
									}
                                    
								
									
									if(b_plan != "" && b_plan2 != null){
										bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
									}else if(b_plan != "" && b_plan2 == null){
										bana = b_plan + "<BR>";
									}else if(b_plan == "" && b_plan2 != null){
										bana = b_plan2 + "<BR>";
									}else{
										bana = "<BR>";
									}
									if(b_place != "" && b_place2 != null){
										bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
									}else if(b_place != "" && b_place2 == null){
										bana = bana + b_place + "<BR>";
									}else if(b_place == "" && b_place2 != null){
										bana = bana + b_place2 + "<BR>";
									}else{
										bana = bana + "<BR>";
									}
									
									
								    // 2013-06-18 変更者:鈴木亮子 21304
									//if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
										bana = "バナー<BR>詳細情報なし";
									}
									if( bmemo == null || bmemo.equals("") ){
										bmemo = "";
									}else{
										bmemo = "<b><メモ></b><BR>"+ bmemo +"";
									}
									
									
									
									
									/*
									if( bmemo != null ){
										bmemo = "<b><メモ></b><BR>"+ bmemo +"";

									}else{
										bmemo = "";
									}

									/*      20130111  上記修正
									if(bmemo == null){
										bmemo = "";
									}else{
										bmemo = "メモ内容<BR>"+ bmemo +"";
									}
									*/
									%>
									<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02" title="<%= bmemo %>">
										<font size=2>
											<%= bana + bmemo %>
										</font>
									</A>
									<%
								}else{%>　<%}
								%>
								</td>
							</tr>
						</table>
						<%
					}
					rs3.close();
					sFmt = new SimpleDateFormat("yyyyMMdd");
					// スケジュールの呼び出し
					ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_社員NO = '"+ no +"'");
					while(rs6.next()){
						String s_place = rs6.getString("S_PLACE").trim();		//場所取得
						String s_place2 = rs6.getString("S_PLACE2");			//場所詳細取得
						String s_plan = rs6.getString("S_PLAN").trim();			//予定取得
						String s_plan2 = rs6.getString("S_PLAN2");				//予定詳細取得

						s_date = rs6.getString("S_DATE").substring(0,10);
						s_start = rs6.getString("S_START");
						s_end = rs6.getString("S_END");
						memo = rs6.getString("S_MEMO");
						String S_sTimeM = s_start.substring(2,4);				//開始時刻を「分」と
						String S_sTimeH = s_start.substring(0,2);				//          「時」に分割
						String S_eTimeM = s_end.substring(2,4);					//終了時刻を「分」と
						String S_eTimeH = s_end.substring(0,2);					//          「時」に分割

						String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "～" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != ""  && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != ""  && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == ""  && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
						s_date = rs6.getString("S_DATE");
						s_start = rs6.getString("S_START");
						memo = rs6.getString("S_MEMO");
						if( memo == null || memo.equals("")){
							memo = "";
						}else{
							memo = "<b><メモ></b><BR>"+ memo +"";
						}
						/*
						if( memo != null ){
							memo = "<b><メモ></b><BR>"+ memo +"";

						}else{
							memo = "";
						}
						/*      20130111  上記修正
						if(memo == null){
							memo = "";
						}else{
							memo = "<b><メモ></b><BR>"+ memo +"";
						}
						*/
						%>
						<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
							<font size="2">
								<%= sche + memo %>
							</font>
						</A>
						<%
					}
					rs6.close();
					%>
					<script language="JavaScript1.2">
					<!--
						function deleteCookie(theName){
							document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
							return true;
						}
						function send<%= mincnt %>(id,no,date,start){
							alert("スケジュールをコピーします。");
							var charid = id;
							var charno = no;
							var charde = date;
							var charst = start;
							deleteCookie(charid,charno,charde,charst);
							document.cookie = "id="+charid+";";
							document.cookie = "no="+charno+";";
							document.cookie = "s_date="+charde+";";
							document.cookie = "s_start="+charst+";";
							// リダイレクト処理
							parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
						}
						function miseru<%= xxx %>(no,date,kd){
							alert("スケジュールを貼りつけします。");
							var charno = no;
							var charde = date;
							var charkd = kd;
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
							parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
						}
					//-->
					</script>
					<%
					mincnt = mincnt + 1;
					xxx = xxx + 1;
					zengetu = zengetu + 1;
				}
			}
			tuki = intTuki - 1;
			if(tuki == 0){
				nen = intYear;
			}
			for(i = 1;i <= eDay;i++){
				cal.set(intYear, intTuki - 1, i);
				int calWeek = cal.get(Calendar.DAY_OF_WEEK);
				// 指定した日を比較できるように
				sFmt = new SimpleDateFormat("yyyyMMdd");
				cal.set(intYear,intTuki - 1,i);
				Date thisMonth = cal.getTime();

				String yasumi = "";
				String kyujitu = sFmt.format(thisMonth);

				ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_年月日 = '"+ sFmt.format(thisMonth) +"'");

				while(rs7.next()){
					yasumi = rs7.getString("H_休日名");
				}
				rs7.close();
				// 日曜日が最初なので行の先頭をあらわす<tr>タグを設定
				if(calWeek == 1){
					%>
					<tr>
					<%
				}
				sFmt = new SimpleDateFormat("yyyy-MM-dd");
				cal.set(nen,tuki,i);
				today = cal.getTime();
				// 曜日毎にバックグランドの色を変更する
				if(sFmt.format(today).equals(kyo2)){
					// 今日
					%>
					<td height="50" align="left" valign="top" bgcolor="lavender">
					<%
				}else if(calWeek == 1){
					// 日曜日
					%>
					<td height="50" align="left" valign="top" bgcolor="pink">
					<%
				}else if(yasumi != ""){
					// 祝日
					%>
					<td height="50" align="left" valign="top" bgcolor="pink">
					<%
				}else if(calWeek == 7){
					// 土曜日
					%>
					<td height="50" align="left" valign="top" bgcolor="skyblue">
					<%
				}else{
					// 平日
					%>
					<td height="50" align="left" valign="top" bgcolor="white">
					<%
				}
				%>
				<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="新規登録できます。" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
					<%= i %>
				</A>
				<font color=red>
					<%= yasumi %>
				</font><br>
				<%
				ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
				while(rs3.next()){
					b_start = rs3.getString("B_START");
					b_start = b_start.substring(0,10);
					b_plan = rs3.getString("B_PLAN").trim();
					if(b_plan.equals("休み") || b_plan.equals("夏休")){
						iro = "orange";
					}else{
						iro = "yellow";
					}
					%>
					<table bgcolor="<%= iro %>" width="100%">
						<TR>
							<td>
							<%
							
								if(b_start.equals(sFmt.format(thisMonth)) || (i == 1 && calWeek == 1)){
								b_plan2 = rs3.getString("B_PLAN2");
								b_place = rs3.getString("B_PLACE").trim();
								b_place2 = rs3.getString("B_PLACE2");
								bmemo = rs3.getString("B_MEMO");
								if(b_plan.equals("--")){
									b_plan = "";
								}
								if(b_place.equals("--")){
									b_place = "";
								}
								///// 2013-06-18 変更者:鈴木亮子 21304
								/*//// 2013-06-18 左記の日時におけるオリジナルコード 開始
								if(b_plan != "" && b_plan2 != null){
									bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
								}else if(b_plan != "" && b_plan2 == null){
									bana = b_plan + "<BR>";
								}else if(b_plan == "" && b_plan2 != null){
									bana = b_plan2 + "<BR>";
								}else{
									bana = "<BR>";
								}
								if(b_place != "" && b_place2 != null){
									bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
								}else if(b_place != "" && b_place2 == null){
									bana = bana + b_place + "<BR>";
								}else if(b_place == "" && b_place2 != null){
									bana = bana + b_place2 + "<BR>";
								}else{
									bana = bana + "<BR>";
								}
								if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									bana = "バナー<BR>詳細情報なし";
								}
								if( bmemo == null || bmemo.equals("")){
									bmemo = "";
								}else{
									bmemo = "<b><メモ></b><BR>"+ bmemo +"";
								}
								//*/// 2013-06-18 左記の日時におけるオリジナルコード 終了
								
								if(b_plan.length() > 0 && b_plan2 != null){
									bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
								}else if(b_plan.length() > 0 && b_plan2 == null){
									bana = b_plan + "<BR>";
								}else if(b_plan.length() == 0 && b_plan2 != null){
									bana = b_plan2 + "<BR>";
								}else{
									bana = "<BR>";
								}
								if(b_place.length() > 0 && b_place2 != null){
									bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
								}else if(b_place.length() > 0 && b_place2 == null){
									bana = bana + b_place + "<BR>";
								}else if(b_place.length() == 0 && b_place2 != null){
									bana = bana + b_place2 + "<BR>";
								}else{
									bana = bana + "<BR>";
								}
								
								if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
									bana = "バナー<BR>詳細情報なし";
								}
								if( bmemo == null || bmemo.equals("")){
									bmemo = "";
								}else{
									bmemo = "<b><メモ></b><BR>"+ bmemo +"";
								}
								
								/*
								if( bmemo != null ){
									bmemo = "<b><メモ></b><BR>"+ bmemo +"";

								}else{
									bmemo = "";
								}
								/*      20130111  上記修正
								if(bmemo == null){
									bmemo = "";
								}else{
									bmemo = "<b><メモ></b><BR>"+ bmemo +"";
								}
								*/
								%>
								<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02" title="<%= bmemo %>">
									<font size="2">
										<%= bana + bmemo %>
									</font>
								</A>
								<%
							}else{%>　<%}
							%>
							</TD>
						</TR>
					</table>
					<%
				}
				rs3.close();
				sFmt = new SimpleDateFormat("yyyyMMdd");

				// スケジュールの呼び出し
				ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_社員NO = '"+ no +"'");
				while(rs6.next()){
					String s_place = rs6.getString("S_PLACE").trim();		//場所取得
					String s_place2 = rs6.getString("S_PLACE2");			//場所詳細取得
					String s_plan = rs6.getString("S_PLAN").trim();			//予定取得
					String s_plan2 = rs6.getString("S_PLAN2");				//予定詳細取得
					s_date = rs6.getString("S_DATE").substring(0,10);
					s_start = rs6.getString("S_START");
					s_end = rs6.getString("S_END");
					memo = rs6.getString("S_MEMO");
					String S_sTimeM = s_start.substring(2,4);				//開始時刻を「分」と
					String S_sTimeH = s_start.substring(0,2);				//          「時」に分割
					String S_eTimeM = s_end.substring(2,4);					//終了時刻を「分」と
					String S_eTimeH = s_end.substring(0,2);					//          「時」に分割

					String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "～" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != "" && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != "" && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == "" && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
					s_date = rs6.getString("S_DATE");
					s_start = rs6.getString("S_START");
					memo = rs6.getString("S_MEMO");

					if( memo == null || memo.equals("")){
						memo = "";
					}else{
						memo = "<b><メモ></b><BR>"+ memo +"";
					}
					/*
					if( memo != null ){
						memo = "<b><メモ></b><BR>"+ memo +"";

					}else{
						memo = "";
					}
					/*      20121228  上記修正
					if(memo == null){
						memo = "";
					}else{
						memo = "<b><メモ></b><BR>"+ memo +"";
					}
					*/
					%>
					<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
						<font size="2">
							<%= sche + memo %>
						</font>
					</A>
					<%
				}
				rs6.close();
				%>
				<script language="JavaScript1.2">
				<!--
					function deleteCookie(theName){
						document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
						return true;
					}
					function send<%= mincnt %>(id,no,date,start){
						alert("スケジュールをコピーします。");
						var charid = id;
						var charno = no;
						var charde = date;
						var charst = start;
						deleteCookie(charid,charno,charde,charst);
						document.cookie = "id="+charid+";";
						document.cookie = "no="+charno+";";
						document.cookie = "s_date="+charde+";";
						document.cookie = "s_start="+charst+";";
						// リダイレクト処理
						parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
					}
					function miseru<%= xxx %>(no,date,kd){
						alert("スケジュールを貼りつけします。");
						var charno = no;
						var charde = date;
						var charkd = kd;
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
						parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
					}
				//-->
				</script>
				<%
				mincnt = mincnt + 1;
				xxx = xxx + 1;
				calWeek++;
				// 日付用カラムの終了タグを設定
				%>
				</td>
				<%

				// 土曜日の場合:1行を</tr>タグで閉じて
				// 一週間分の表示データをクライアントに送信する
				if(calWeek > 7){
				%>
				</tr>
				<%
				}
				// 曜日を一つ増やす
				calWeek = ++calWeek % 8;
			}
			j = 1;
			// 月末空欄部分の表示
			nen = intYear;
			tuki = intTuki;
			if(eWeek != 7){
				if(tuki == 12){
					tuki = 0;
				nen = nen + 1;
				}
			for(i = eWeek;i < 7;i++){
				sFmt = new SimpleDateFormat("yyyyMMdd");
				cal.set(intYear,intTuki,j);
				Date thisMonth = cal.getTime();
				int calWeek = cal.get(Calendar.DAY_OF_WEEK);
					calWeek = cal.get(Calendar.DAY_OF_WEEK);
					String yasumi = "";
					ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_年月日 = '"+ sFmt.format(thisMonth) +"'");

					while(rs7.next()){
						yasumi = rs7.getString("H_休日名");
					}
					rs7.close();
					sFmt = new SimpleDateFormat("yyyy-MM-dd");
					cal.set(nen,tuki,j);
					today = cal.getTime();
					// 曜日毎にバックグランドの色を変更する
					if(sFmt.format(today).equals(kyo2)){
						// 今日
						%>
						<td height="50" align="left" valign="top" bgcolor="lavender">
						<%
					}else if(yasumi != null){
						%>
						<td height="50" align="left" valign="top" bgcolor="pink">
						<%
					}else if(calWeek == 7){
						%>
						<td height="50" align="left" valign="top" bgcolor="skyblue">
						<%
					}else{
						%>
						<td height="50" align="left" valign="top" bgcolor="white">
						<%
					}
					%>
					<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="新規登録できます。" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
						<%= j %>
					</A>
					<font color="red">
						<%= yasumi %>
					</font><br>
					<%
					ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
					while(rs3.next()){
						b_start = rs3.getString("B_START");
						// データベースから取得した日付の余分な部分を除く
						b_start = b_start.substring(0,10);
						b_plan = rs3.getString("B_PLAN").trim();
						if(b_plan.equals("休み") || b_plan.equals("夏休")){
							iro = "orange";
						}else{
							iro = "yellow";
						}
						%>
						<table bgcolor="<%= iro %>" width="100%">
							<tr>
								<td>
								<%
								if(b_start.equals(sFmt.format(thisMonth)) || (i == 1 && calWeek == 1)){
									b_plan2 = rs3.getString("B_PLAN2");
									b_place = rs3.getString("B_PLACE").trim();
									b_place2 = rs3.getString("B_PLACE2");
									bmemo = rs3.getString("B_MEMO");
									if(b_plan.equals("--")){
										b_plan = "";
									}
									if(b_place.equals("--")){
										b_place = "";
									}

									if(b_plan != "" && b_plan2 != null){
										bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
									}else if(b_plan != "" && b_plan2 == null){
										bana = b_plan + "<BR>";
									}else if(b_plan == "" && b_plan2 != null){
										bana = b_plan2 + "<BR>";
									}else{
										bana = "<BR>";
									}
									if(b_place != "" && b_place2 != null){
										bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
									}else if(b_place != "" && b_place2 == null){
										bana = bana + b_place + "<BR>";
									}else if(b_place == "" && b_place2 != null){
										bana = bana + b_place2 + "<BR>";
									}else{
										bana = bana + "<BR>";
									}
									
								    // 2013-06-18 変更者:鈴木亮子 21304
									//if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
									
										bana = "バナー<BR>詳細情報なし";
									}
									if( bmemo == null || bmemo.equals("")){
										bmemo = "";
									}else{
										bmemo = "<b><メモ></b><BR>"+ bmemo +"";
									}
									/*
									if( bmemo != null ){
										bmemo = "<b><メモ></b><BR>"+ bmemo +"";
									}else{
										bmemo = "";
									}
									/*      20130111  上記修正
									if(bmemo == null){
										bmemo = "";
									}else{
										bmemo = "<b><メモ></b><BR>"+ bmemo +"";
									}
									*/
									%>
									<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02"">
										<font size="2">
											<%= bana + bmemo %>
										</font>
									</A>
									<%
								}else{%>　<%}
								%>
								</td>
							</tr>
						</table>
						<%
					}
					rs3.close();
					sFmt = new SimpleDateFormat("yyyyMMdd");
					// スケジュールの呼び出し
					ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_社員NO = '"+ no +"'");
					while(rs6.next()){
						String s_place = rs6.getString("S_PLACE").trim();		//場所取得
						String s_place2 = rs6.getString("S_PLACE2");			//場所詳細取得
						String s_plan = rs6.getString("S_PLAN").trim();			//予定取得
						String s_plan2 = rs6.getString("S_PLAN2");				//予定詳細取得
						s_date = rs6.getString("S_DATE").substring(0,10);
						s_start = rs6.getString("S_START");
						s_end = rs6.getString("S_END");
						memo = rs6.getString("S_MEMO");
						String S_sTimeM = s_start.substring(2,4);				//開始時刻を「分」と
						String S_sTimeH = s_start.substring(0,2);				//          「時」に分割
						String S_eTimeM = s_end.substring(2,4);					//終了時刻を「分」と
						String S_eTimeH = s_end.substring(0,2);					//          「時」に分割

						String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "～" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != "" && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != "" && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == "" && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
						s_date = rs6.getString("S_DATE");
						s_start = rs6.getString("S_START");
						memo = rs6.getString("S_MEMO");
						if( memo == null || memo.equals("")){
							memo = "";
						}else{
							memo = "<b><メモ></b><BR>"+ memo +"";
						}
						/*
						if( memo != null ){
							memo = "<b><メモ></b><BR>"+ memo +"";

						}else{
							memo = "";
						}
						/*      20130111  上記修正
						if(memo == null){
							memo = "";
						}else{
							memo = "<b><メモ></b><BR>"+ memo +"";
						}
						*/
						%>
						<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
							<font size="2">
								<%= sche + memo %>
							</font>
						</A>
						<%
						}
					rs6.close();
					%>
					<script language="JavaScript1.2">
					<!--
						function deleteCookie(theName){
							document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
							return true;
						}
						function send<%= mincnt %>(id,no,date,start){
							alert("スケジュールをコピーします。");
							var charid = id;
							var charno = no;
							var charde = date;
							var charst = start;
							deleteCookie(charid,charno,charde,charst);
							document.cookie = "id="+charid+";";
							document.cookie = "no="+charno+";";
							document.cookie = "s_date="+charde+";";
							document.cookie = "s_start="+charst+";";
							// リダイレクト処理
							parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
						}
						function miseru<%= xxx %>(no,date,kd){
							alert("スケジュールを貼りつけします。");
							var charno = no;
							var charde = date;
							var charkd = kd;
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
							parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
						}
					//-->
					</script>
					<%
					mincnt = mincnt + 1;
					xxx = xxx + 1;
					j = j + 1;
				}
			}
			%>
			</td>
			</tr>
		</table>
		<%
		stmt.close();
		con.close();
		%>
	</body>
</html>
