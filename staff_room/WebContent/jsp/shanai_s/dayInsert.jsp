<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%!
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal==null){
		return(null);
	}
	else{
		return(new String(strVal.getBytes("8859_1"),"Shift_JIS"));
	}
}
%>
<%
/* 修正点 */
// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法
// 02-08-15 余計なプログラムを省く
// 02-09-03 登録処理終了後、再読み込みするためのプログラムを修正。
// 02-09-18 動作テスト期間…バグ発見   43行目 日付のパラメータの誤差修正。
//                    231行目/243行目/255行目 リダイレクト処理で送信するパラメータの文字列修正。
// 02-09-24 バグ発見…  180行目 SQL文で使用していたユーザID変数が間違っていた。

/* 追加点 */
// 02-08-13 共有者画面で選択されたメンバーに登録者と同じスケジュールを一括登録する処理

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// [timeIn]で入力された各項目をパラメータとして取得
String NO = request.getParameter("no");
String DA = request.getParameter("s_date");
String GR = request.getParameter("group");

// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

// 開始日の取得
String SY = request.getParameter("syear");			// 年
String SM = request.getParameter("smonth");			// 月
String SD = request.getParameter("sday");			// 日
%>
<%

int BSDAy = Integer.parseInt(SY);				// 年
int BSDAm = Integer.parseInt(SM);				// 月
int BSDAd = Integer.parseInt(SD);				// 日
boolean BSUru = false;//うるう年ならtrueへ
if((BSDAy % 4) == 0){
	BSUru = true;
}


// 開始日の結合 例：20020815
String start = SY + SM + SD;

// 開始日のコピ－(パラメータとして、正確に受け取れるようハイフンを文字列連結させる)
// 例：2002-08-15
String start_cpy = SY +"-"+ SM +"-"+ SD;

// 終了日の取得
String EY = request.getParameter("eyear");			// 年
String EM = request.getParameter("emonth");			// 月
String ED = request.getParameter("eday");			// 日

int BEDAy = Integer.parseInt(EY);				// 年
int BEDAm = Integer.parseInt(EM);				// 月
int BEDAd = Integer.parseInt(ED);				// 日
boolean BEUru = false;//うるう年ならtrueへ
if((BEDAy % 4) == 0){
	BEUru = true;
}


// 終了日の結合 例：20020815
String end = EY + EM + ED;

String plan = strEncode(request.getParameter("plan"));
String plan2 = strEncode(request.getParameter("plan2"));
String place = strEncode(request.getParameter("place"));
String place2 = strEncode(request.getParameter("place2"));
String memo = strEncode(request.getParameter("memo"));
String pre = request.getParameter("pre");
String act = strEncode(request.getParameter("act"));
%>
<html>
<head><title>エラー</title></head>
<body BGCOLOR="#99A5FF">
<%
	if(ID.equals("")){
		out.println("ユーザＩＤがありません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(NO.equals("")){
		out.println("選択されたユーザＩＤがありません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(Integer.parseInt(SY) > Integer.parseInt(EY)){
		out.println("開始日・年が終了日・年よりも大きいです。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(BSDAm<1 || BSDAm>12){
		out.println("バナー開始日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(BSDAd<1 || BSDAd>31){
		out.println("バナー開始日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((BSDAm == 4 && BSDAd == 31) || (BSDAm == 6 && BSDAd == 31) || (BSDAm == 9 && BSDAd == 31) || (BSDAm == 11 && BSDAd == 31)){
		out.println("バナー開始日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((BSDAm == 2 && BSDAd > 28 && BSUru == false) || (BSDAm == 2 && BSDAd > 29 && BSUru == true)){
		out.println("バナー開始日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(BEDAm<1 || BEDAm>12){
		out.println("バナー終了日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(BEDAd<1 || BEDAd>31){
		out.println("バナー終了日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((BEDAm == 4 && BEDAd == 31) || (BEDAm == 6 && BEDAd == 31) || (BEDAm == 9 && BEDAd == 31) || (BEDAm == 11 && BEDAd == 31)){
		out.println("バナー終了日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((BEDAm == 2 && BEDAd > 28 && BEUru == false) || (BEDAm == 2 && BEDAd > 29 && BEUru == true)){
		out.println("バナー終了日に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(plan.equals("")){
		out.println("予定が選択されてません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(memo.length() >= 50){
		out.println("文字数を超えています。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else{

		// JDBCドライバのロード
		Class.forName("org.postgresql.Driver");

		// データベースにログインするための情報
		String user = "georgir";
		String password = "georgir";

		// データベースに接続
		Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

		// ステートメントの生成
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		
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

		// 重複チェック用flag
		boolean check = false;
		// 共有者重複チェック用flag
		boolean ky_check = false;
		
		String Blendy = "";
		
		// SQL実行
		if(act.equals("登録") && (group_id.equals(group_no) || group_id.equals("900"))){
			if(ID.equals(NO)){
				// 新規登録する際に、他のバナースケジュールと重複していないか調べます
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '" + ID + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' and '"+ end +"' <= B_END ))");

				while(CHECK.next()){
					check = true;
				}

				CHECK.close();
				
				// 共有者バナースケジュールの重複チェック
				ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + ID + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_社員NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '" + Blendy + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' and '"+ end +"' <= B_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
					KY_CHECK.close();
				}
				GOGOTea.close();

				if(!check){
				if(!ky_check){
					stmt.execute("INSERT INTO B_TABLE(K_社員NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + ID + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					// 共有者情報の日付と開始時刻を更新
					stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE K_社員NO2 = '" + ID + "' AND KY_FLAG = '0'");

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + start_cpy + "' AND K_社員NO2 = '" + ID + "'");

					// hitListの作成
					Vector hitCHECK = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
						hitCHECK.addElement(seId);
					}

					int cntCHECK = hitCHECK.size();

					for(int i = 0; i < cntCHECK; i++){
						stmt.execute("INSERT INTO B_TABLE(K_社員NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitCHECK.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */

				}}
			}
			else{
				// 他のユーザのバナースケジュールを登録処理
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '" + NO + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' and '"+ end +"' <= B_END ))");
				while(CHECK.next()){
					check = true;
				}
				CHECK.close();
				
				// 共有者バナースケジュールの重複チェック
				ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + NO + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_社員NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM B_TABLE WHERE K_社員NO = '" + Blendy + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' and '"+ end +"' <= B_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
				KY_CHECK.close();
				}
				GOGOTea.close();

				if(!check){
				if(!ky_check){
					stmt.execute("INSERT INTO B_TABLE(K_社員NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + NO + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					// 共有者情報の日付と開始時刻を更新
					stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE K_社員NO2 = '" + NO + "' AND KY_FLAG = '0'");

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + start_cpy + "' AND K_社員NO2 = '" + NO + "'");

					// hitListの作成
					Vector hitCHECK = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
						hitCHECK.addElement(seId);
					}

					int cntCHECK = hitCHECK.size();

					for(int i = 0; i < cntCHECK; i++){
						stmt.execute("INSERT INTO B_TABLE(K_社員NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitCHECK.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */

				}}
			}
		}
		else{
			%>
			<jsp:forward page="error.jsp">
			 <jsp:param name="id" value="<%= ID %>" />
			 <jsp:param name="no" value="<%= NO %>" />
			 <jsp:param name="flag" value="3" />
			</jsp:forward>
			<%
		}

		// 接続解除
		stmt.close();
		con.close();

		if(check){
			out.println("バナースケジュールが重複しています。");
			out.println("<form><input type=button value=戻る onClick=history.back()></form>");
		}else if(ky_check){
			out.println("共有者のバナースケジュールが重複しています。<BR>");
			out.println("<form><input type=button value=戻る onClick=history.back()></form>");
		}else{
			if(KD.equals("Month")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start_cpy %>&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD + "-b" %>&act=';
// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}
			else if(KD.equals("Week")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start_cpy %>&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD + "-b" %>&act=';
// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}
			else if(KD.equals("Day")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start_cpy %>&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD + "-b" %>&act=';
// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}
			else{
				%>
				<jsp:forward page="error.jsp">
				 <jsp:param name="flag" value="0" />
				</jsp:forward>
				<%
			}
		}
	}
%>
</body>
</html>