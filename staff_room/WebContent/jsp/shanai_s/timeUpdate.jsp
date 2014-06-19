<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgia" %>
<%!
public String strEncode(String strVal)
        throws UnsupportedEncodingException{
        if(strVal==null){
                 return(null);
         }
         else{
                 return(new String(strVal.getBytes("8859_1"),"UTF-8"));
         }
}
%>
<%
/* 修正点 */
// 02-08-05 月・週・日とファイルを分けていたものを結合させ、フラグによって処理を分ける方法
// 02-08-13 削除処理は、共有されたスケジュールでも個別に行える
// 02-08-15 スケジュール変更を行った際に、共有者を増やすと起きるバグを修正しました
// 02-08-15 余計なプログラムを省く
// 02-09-03 登録処理終了後、再読み込みするためのプログラムを修正。
// 02-09-18 動作テスト期間…バグ発見            33行目/34行目 日付変数の記述間違い。どちらが何をするものなのか、はっきりと区別しなかった。
// 02-09-18 動作テスト期間…バグ発見  433行目/459行目/485行目 削除を行った際のリダイレクト処理で、表示形式の区別をする変数の文字列間違い。
// 02-09-18 動作テスト期間…バグ発見         355行目?395行目 登録者が共有スケジュールの削除を行った際に、共有者テーブルの情報を削除するよう修正。
// 02-09-18 動作テスト期間…バグ発見  238行目/283行目/336行目 共有スケジュールのメンバーが、新たにメンバーを増やした際に、反映されない。
// 02-09-24 バグ発見…      377行目?378行目/400行目?401行目 共有者がスケジュールの削除を行った時に、共有者情報[KY_TABLE]の情報を削除していなかった。
// 02-10-10 バグ発見…  160行目/259行目 重複チェック処理を修正。終了時刻を省く。

/* 追加点 */
// 02-08-13 共有者画面で選択されたメンバーに登録者と同じスケジュールを一括変更する処理

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// [timeUp]で入力された各項目をパラメータとして取得
String NO = request.getParameter("no");

// 手入力により変更の恐れがあるので、日付変数を二つ取得する。
String DAold = request.getParameter("s_date1");
String DAnew = request.getParameter("s_date2");

//日付チェック用変数
//年月日に分割
int DAy=2000;	//とりあえず
int DAm=11;		//エラーを通過する
int DAd=11;		//値を変数に入れておく
boolean Uru = false;//うるう年ならtrueへ
if(DAold != ""){
	DAy = Integer.parseInt(DAold.substring(0,4));  // 年
	DAm = Integer.parseInt(DAold.substring(5,7));  // 月
	DAd = Integer.parseInt(DAold.substring(8,10)); // 日
	if((DAy % 4) == 0){
		Uru = true;
	}
}

String ST = request.getParameter("s_start");
String GR = request.getParameter("group");

// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

// 削除を行った際に、種別を新規に設定するため。
int KDend = KD.indexOf("-");
String KDs = KD.substring(0,KDend);

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
<head><title></title></head>
<body BGCOLOR="#99A5FF">
<%
if(ID.equals("")){
	out.println("ユーザＩＤがありません。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(NO.equals("")){
	out.println("選択されたユーザＩＤがありません。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(DAold.equals("")){
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
}else if(DAnew.equals("")){
	out.println("プログラムサイドエラー：日付がありません。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(ST.equals("")){
	out.println("プログラムサイドエラー：開始時刻がありません。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(Integer.parseInt(SH)<0 || Integer.parseInt(SH)>23){
	out.println("開始時刻入力が不正です。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(Integer.parseInt(SM)<0 || Integer.parseInt(SM)>59){
	out.println("開始時刻入力が不正です。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(Integer.parseInt(EH)<0 || Integer.parseInt(EH)>23){
	out.println("終了時刻入力が不正です。");
	out.println("<form><input type=button value=戻る onClick=history.back()></form>");
}else if(Integer.parseInt(EM)<0 || Integer.parseInt(EM)>59){
	out.println("終了時刻入力が不正です。");
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

/* 	// JDBCドライバのロード
	Class.forName("org.postgresql.Driver");

	// データベースにログインするための情報
	String user = "georgir";
	String password = "georgir";
 */
	// データベースに接続
	//Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);
	C_DBConnectionGeorgia georgiaDB = new C_DBConnectionGeorgia();
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

	// 変更処理と削除処理を区別するflag
	boolean UorD = false;

	String Blendy = "";

	if(act.equals("変更") && (group_id.equals(group_no) || group_id.equals("900"))){
		// SQL実行・更新
		// プライマリキーに選ばれている項目に更新かける事は出来ないので、
		// このような処理をとりました。「選択レコード」→「削除」→「挿入」
		if(ID.equals(NO)){
			// 重複スケジュールのチェック
/* 			
            ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_END = '" + end + "'  AND S_PLAN = '" + plan + "' AND S_PLAN2 = '" + plan2 + "' AND S_PLACE = '" + place + "' AND S_PLACE2 = '" + place2 + "' AND S_MEMO = '" + memo + "' AND S_ZAISEKI = '" + pre + "' ");

			while(CHECK.next()){
				check = true;
			}

			CHECK.close();
*/
            // スケジュール上にある予定の開始時間を変えられないのでそれを"既存のコードの書き方に合わせて"修正
            // 2014-06-19
            ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + start + "'");

            while(CHECK.next()){
                check = true;
            }

            CHECK.close();

			// 共有者スケジュールの重複チェック
			ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + ID + "'");
			while(GOGOTea.next()){
				Blendy = GOGOTea.getString("K_社員NO");
				ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + Blendy + "' AND S_DATE = '" + DAold + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				while(KY_CHECK.next()){
					ky_check = true;
				}
				KY_CHECK.close();
			}
			GOGOTea.close();

			// 登録者か共有者かチェック
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(!check && !ky_check){
				if(FG.equals("0")){
					// 登録者です。
                        stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
                        stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + ID + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");
                    try{
                    }catch(Exception e){
                    }

					// 共有者情報の日付と開始時刻を更新
					//stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_社員NO2 = '" + ID + "') OR (KY_FLAG = '0' AND K_社員NO2 = '" + ID + "')");

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					// 共有者のIDを取得します。
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAnew + "' AND S_START = '" + start + "' AND K_社員NO2 = '" + ID + "'");

					// hitListの作成
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					for(int i = 0; i < cntKYOYU; i++){
                        stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
                        stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */
				}else{
					// 共有者です。

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					// 登録者のIDを取得します。
					ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");

					String toId = "";

					while(TOUROKU.next()){
						toId = TOUROKU.getString("K_社員NO2");
					}

					TOUROKU.close();

					// 共有者のIDを取得します。
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_社員NO2 = '" + toId + "'");

					// hitListの作成
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					// 共有者情報の日付と開始時刻を更新
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_社員NO2 = '" + toId + "') OR (KY_FLAG = '0' AND K_社員NO2 = '" + toId + "')");

					// 登録者の情報を更新
					stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + toId + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + toId + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					for(int i = 0; i < cntKYOYU; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */
				}
			}
		}else{
			// 重複スケジュールのチェック
/* 			ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_END = '" + end + "'  AND S_PLAN = '" + plan + "' AND S_PLAN2 = '" + plan2 + "' AND S_PLACE = '" + place + "' AND S_PLACE2 = '" + place2 + "' AND S_MEMO = '" + memo + "' AND S_ZAISEKI = '" + pre + "' ");

			while(CHECK.next()){
				check = true;
			}

			CHECK.close();
			
 */

            //ここも同じような処理
            ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + start + "'");

            while(CHECK.next()){
                check = true;
            }
 
			// 共有者スケジュールの重複チェック
			ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_社員NO2 = '" + NO + "'");
			while(GOGOTea.next()){
				Blendy = GOGOTea.getString("K_社員NO");
				ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + Blendy + "' AND S_DATE = '" + DAold + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				while(KY_CHECK.next()){
					ky_check = true;
				}
			KY_CHECK.close();
			}
			GOGOTea.close();

			// 登録者か共有者かチェック
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(!check && !ky_check){
				if(FG.equals("0")){
					// 本人ではないですが、登録者です。

					stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					// 共有者情報の日付と開始時刻を更新
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_社員NO2 = '" + NO + "') OR (KY_FLAG = '0' AND K_社員NO2 = '" + NO + "')");

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAnew + "' AND S_START = '" + start + "' AND K_社員NO2 = '" + NO + "'");

					// hitListの作成
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
					hitKYOYU.addElement(seId);
					}

					int hitCnt = hitKYOYU.size();

					for(int i = 0; i < hitCnt; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */

				}else{
					// 本人ではないですが、共有者です。

					/* ここから共有者をスケジュールテーブルへと挿入します。 */
					// 登録者のIDを取得します。
					ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");

					String toId = "";

					while(TOUROKU.next()){
						toId = TOUROKU.getString("K_社員NO2");
					}

					TOUROKU.close();

					// 共有者のIDを取得します。
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_社員NO2 = '" + toId + "'");

					// hitListの作成
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_社員NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					// 共有者情報の日付と開始時刻を更新
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_社員NO2 = '" + toId + "') OR (KY_FLAG = '0' AND K_社員NO2 = '" + toId + "')");

					// 登録者の情報を更新
					stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + toId + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + toId + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					for(int i = 0; i < cntKYOYU; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* ここまで */
				}
			}
		}
	UorD = true;
	}else if(act.equals("削除") && (group_id.equals(group_no) || group_id.equals("900"))){
		if(ID.equals(NO)){
			// 登録者か共有者かチェック
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(FG.equals("0")){
				// 登録者です。
				stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_社員NO2 = '" + ID + "'");
			}else{
				// 共有者です。
				stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_社員NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
			}
		}else{
			// 登録者か共有者かチェック
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(FG.equals("0")){
				// 本人ではないけども登録者です。
				stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_社員NO2 = '" + NO + "'");
			}else{
			// 本人ではないけども共有者です。
				stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_社員NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
			}
		}
	UorD = false;
	}else{
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
		out.println("スケジュールが重複しています。");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else if(ky_check){
		out.println("共有者のスケジュールが重複しています。<BR>");
		out.println("<form><input type=button value=戻る onClick=history.back()></form>");
	}else{
		if(KD.equals("Month-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- 移動禁止 -->
<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
				<%
			}
		}else if(KD.equals("Week-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
				<%
			}
		}else if(KD.equals("Day-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
				<%
			}
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
