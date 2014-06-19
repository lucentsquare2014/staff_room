<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgir" %>

<%!public String strEncode(String strVal)
throws UnsupportedEncodingException{
	if(strVal==null){
		return(null);
	}else{
		return(new String(strVal.getBytes("8859_1"),"UTF-8"));
	}
}%>
<%
	/* 修正点 */
// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法
// 02-08-15 余計なプログラムを省く
// 02-09-03 登録処理終了後、再読み込みするためのプログラムを修正。
// 02-09-24 バグ発見…  180行目 SQL文で使用していたユーザID変数が間違っていた。
// 02-10-10 バグ発見…  132行目/169行目 重複チェック処理を修正。終了時刻を省く。

/* 追加点 */
// 02-08-13 共有者画面で選択されたメンバーに登録者と同じスケジュールを一括登録する処理

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// [timeIn]で入力された各項目をパラメータとして取得
String NO = request.getParameter("no");
String DA = request.getParameter("s_date");
String GR = request.getParameter("group");


//日付チェック用変数
//年月日に分割
int DAy=2000;	//とりあえず
int DAm=11;		//エラーを通過する
int DAd=11;		//値を変数に入れておく
boolean Uru = false;//うるう年ならtrueへ
if(DA != ""){
	DAy = Integer.parseInt(DA.substring(0,4));  // 年
	DAm = Integer.parseInt(DA.substring(5,7));  // 月
	DAd = Integer.parseInt(DA.substring(8,10)); // 日
	if((DAy % 4) == 0){
		Uru = true;
	}
}
// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

// 開始時呼び出し
String SH = request.getParameter("starth");
// 開始分の取得と結合
String SM1 = request.getParameter("startm1");
String SM2 = request.getParameter("startm2");
String SM  = SM1 + SM2;
// 開始時刻の結合 例：0900
String start = SH + SM;

// 終了時呼び出し
String EH = request.getParameter("endh");
// 終了分の取得と結合
String EM1 = request.getParameter("endm1");
String EM2 = request.getParameter("endm2");
String EM  = EM1 + EM2;
// 終了時刻の結合 例：1730
String end = EH + EM;

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
	}else if(DA.equals("")){
		out.println("日付がありません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(DAm<1 || DAm>12){
		out.println("日付入力(月)に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(DAd<1 || DAd>31){
		out.println("日付入力(日)に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((DAm == 4 && DAd == 31) || (DAm == 6 && DAd == 31) || (DAm == 9 && DAd == 31) || (DAm == 11 && DAd == 31)){
		out.println("日付入力(日)に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if((DAm == 2 && DAd > 28 && Uru == false) || (DAm == 2 && DAd > 29 && Uru == true)){
		out.println("日付入力(日)に誤りがあります。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(SH.equals("") || SM.equals("")){
		out.println("プログラムサイドエラー：開始時刻が入力されていません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(EH.equals("") || EM.equals("")){
		out.println("プログラムサイドエラー：終了時刻が入力されていません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(Integer.parseInt(SH)<0 || Integer.parseInt(SH)>23 || Integer.parseInt(SM)<0 || Integer.parseInt(SM)>59){
		out.println("プログラムサイドエラー：開始時刻入力が不正です。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(Integer.parseInt(EH)<0 || Integer.parseInt(EH)>23 || Integer.parseInt(EM)<0 || Integer.parseInt(EM)>59){
		out.println("プログラムサイドエラー：終了時刻入力が不正です。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(plan.equals("")){
		out.println("予定が選択されてません。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(memo.length() > 50){
		out.println("文字数を超えています。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(Integer.parseInt(start) > Integer.parseInt(end)){
		out.println("開始時刻が終了時刻よりも大きいです。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(Integer.parseInt(start) == Integer.parseInt(end)){
		out.println("開始時刻と終了時刻が同じです。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else{
/* 		// JDBCドライバのロード
		Class.forName("org.postgresql.Driver");
		
		// データベースにログインするための情報
		String user = "georgir";
		String password = "georgir";
		
		// データベースに接続
		Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);
 */
 C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
 Connection con = georgiaDB.createConnection();
 
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
	if(ID.equals(NO)){//ログインした人と登録者が一緒の場合
		// スケジュールの重複チェック
		ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
		
		while(CHECK.next()){
			check = true;
		}
		CHECK.close();
		
		// 共有者スケジュールの重複チェック
		ResultSet GOGOTea = stmt.executeQuery("SELECT K_社員NO FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + ID + "'");
		while(GOGOTea.next()){
			Blendy = GOGOTea.getString("K_社員NO");
			ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + Blendy + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
			while(KY_CHECK.next()){
				ky_check = true;
			}
			KY_CHECK.close();
		}
		GOGOTea.close();
		
		if(!check){
		if(!ky_check){
			stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + ID + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");
			
			// 共有者情報の日付と開始時刻を更新
			stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DA + "', S_START = '" + start + "', KY_FLAG = '1' WHERE K_社員NO2 = '" + ID + "' AND KY_FLAG = '0'");
			
			/* ここから共有者をスケジュールテーブルへと挿入します。 */
			ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DA + "' AND S_START = '" + start + "' AND K_社員NO2 = '" + ID + "'");
			
			// hitListの作成
			Vector hitKYOYU = new Vector();
			
			while(KYOYU.next()){
				String seId = KYOYU.getString("K_社員NO");
				hitKYOYU.addElement(seId);
			}
			
			int hitCnt = hitKYOYU.size();
			
			for(int i = 0; i < hitCnt; i++){
				stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
			}
			
			KYOYU.close();
			/* ここまで */
		}}
	}else{//登録者がログインした人と別の人
		ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
		
		while(CHECK.next()){
			check = true;
		}
		CHECK.close();
		
		// 共有者スケジュールの重複チェック
		ResultSet GOGOTea = stmt.executeQuery("SELECT K_社員NO FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + NO + "'");
		while(GOGOTea.next()){
			Blendy = GOGOTea.getString("K_社員NO");
			ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + Blendy + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
			while(KY_CHECK.next()){
				ky_check = true;
			}
			KY_CHECK.close();
		}
		GOGOTea.close();
		
		if(!check){
		if(!ky_check){
			stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");
			
			// 共有者情報の日付と開始時刻を更新
			stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DA + "', S_START = '" + start + "', KY_FLAG = '1' WHERE K_社員NO2 = '" + NO + "' AND KY_FLAG = '0'");
			
			/* ここから共有者をスケジュールテーブルへと挿入します。 */
			ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DA + "' AND S_START = '" + start + "' AND K_社員NO2 = '" + NO + "'");
			
			// hitListの作成
			Vector hitKYOYU = new Vector();
			
			while(KYOYU.next()){
				String seId = KYOYU.getString("K_社員NO");
				hitKYOYU.addElement(seId);
			}
			
			int hitCnt = hitKYOYU.size();
			
			for(int i = 0; i < hitCnt; i++){
				stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
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
			out.println("スケジュールが重複しています。<BR>");
			out.println("<form><input type=button value=戻る onClick=history.back()></form>");
		}else if(ky_check){
			out.println("共有者のスケジュールが重複しています。<BR>");
			out.println("<form><input type=button value=戻る onClick=history.back()></form>");
		}else{
			if(KD.equals("Month")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
				<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}else if(KD.equals("Week")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
				<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}else if(KD.equals("Day")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
				<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- 移動禁止 -->
				</SCRIPT>
				<%
			}else{
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
