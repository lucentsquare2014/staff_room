<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgir" %>

<%!
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return(null);
	}
	else{
		return(new String(strVal.getBytes("8859_1"),"UTF-8"));
	}
}
%>
<%
/* 追加点 */
// 02-09-13 コピー機能のスケジュール登録を行う

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

/* 入力された各項目をパラメータとして取得 */
// コピー処理の時に取得した「no」には、コピー対象となるユーザIDが入っている
String NO = strEncode(request.getParameter("no"));

// 貼り付け処理の時に取得した「no2」には、貼り付け対象となるユーザIDが入っている
String NO2 = strEncode(request.getParameter("no2"));
String DA = strEncode(request.getParameter("s_date"));
String DA2 = strEncode(request.getParameter("s_date2"));
String ST = strEncode(request.getParameter("s_start"));
String GR = strEncode(request.getParameter("group"));

String KD = strEncode(request.getParameter("kind"));

%>
<html>
<head><title>エラー</title></head>
<body BGCOLOR="#99A5FF">
<%

 //データベース接続
 C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
 Connection con = georgiaDB.createConnection();

// ステートメントの生成
Statement stmt = con.createStatement();

// SQL実行・コピー機能
ResultSet SCOPY = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "'");

String cpyEND = "";
String cpyPLAN = "";
String cpyPLAN2 = "";
String cpyPLACE = "";
String cpyPLACE2 = "";
String cpyMEMO = "";
String cpyTOUROKU = "";
String cpyZAISEKI = "";

while(SCOPY.next()){
	cpyEND = SCOPY.getString("S_END");
	cpyPLAN = SCOPY.getString("S_PLAN").trim();
	if(SCOPY.getString("S_PLAN2") == null){
		cpyPLAN2 = "";
	}
	else{
		cpyPLAN2 = SCOPY.getString("S_PLAN2");
	}
	cpyPLACE = SCOPY.getString("S_PLACE").trim();
	if(SCOPY.getString("S_PLACE2") == null){
		cpyPLACE2 = "";
	}
	else{
		cpyPLACE2 = SCOPY.getString("S_PLACE2");
	}
	if(SCOPY.getString("S_MEMO") == null){
		cpyMEMO = "";
	}
	else{
		cpyMEMO = SCOPY.getString("S_MEMO");
	}
	cpyTOUROKU = Integer.toString(SCOPY.getInt("S_TOUROKU"));
	cpyZAISEKI = Integer.toString(SCOPY.getInt("S_ZAISEKI"));
}

SCOPY.close();

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
ResultSet GROUPNO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO2 + "'");

String group_no = "";

while(GROUPNO.next()){
	group_no = GROUPNO.getString("K_GRUNO");
}

GROUPNO.close();

// 重複チェック用flag
boolean check = false;

// SQL実行
if(group_id.equals(group_no) || group_id.equals("900")){
	// 重複スケジュールのチェック
	ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_社員NO = '" + NO2 + "' AND S_DATE = '" + DA2 + "' AND (('" + ST + "' < S_START AND '" + cpyEND + "' > S_START) OR ('" + ST + "' < S_END AND '" + cpyEND + "' > S_END) OR (S_START < '"+ ST +"' and '"+ cpyEND +"' < S_END ) OR (S_START = '"+ ST +"' and S_END = '"+ cpyEND +"'))");

	while(CHECK.next()){
		check = true;
	}

	CHECK.close();

	if(!check){
		stmt.execute("INSERT INTO S_TABLE(GO_社員NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO2 + "','" + DA2 + "','" + ST + "','" + cpyEND + "','" + cpyPLAN + "','" + cpyPLAN2 + "','" + cpyPLACE + "','" + cpyPLACE2 + "','" + cpyMEMO + "','" + cpyTOUROKU + "','" + cpyZAISEKI + "')");
	}
	else{
	%>
	<jsp:forward page="error.jsp">
	 <jsp:param name="flag" value="4" />
	</jsp:forward>
	<%
	}
}

stmt.close();
con.close();
%>
<html>
<head>
<%
	if(KD.equals("Month")){
%>
<script>
<!--
	parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
	if(KD.equals("Week")){
%>
<script>
<!--
	parent.main.location.href = "TestExample34.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
	if(KD.equals("Day")){
%>
<script>
<!--
	parent.main.location.href = "h_hyoji.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
%>
</body>
</html>