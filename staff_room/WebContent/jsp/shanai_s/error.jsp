<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
public String strEncode(String strVal)
        throws UnsupportedEncodingException{
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
// 02-08-13 受け取ったパラメータと条件の一致するエラーメッセージを表示
// 02-09-21 エラーの種類を増やす

	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));
	String NO = request.getParameter("no");
	String FG = request.getParameter("flag");

	// JDBCドライバのロード
	Class.forName("org.postgresql.Driver");

	// ユーザ認証情報の設定
	String user = "georgir";
	String password = "georgir";

	// Connectionオブジェクトの生成
	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

	// Statementオブジェクトの生成
	Statement stmt = con.createStatement();

	// SQL実行・個人情報
	ResultSet rs_ko = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

	String name_ko = "";

	while(rs_ko.next()){
		name_ko = rs_ko.getString("K_氏名");
	}

	// SQL実行・個人情報
	ResultSet rs_no = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

	String name_no = "";

	while(rs_no.next()){
		name_no = rs_no.getString("K_氏名");
	}
%>
<html>
<head><title>error</title>
</head>
<body BGCOLOR="#99A5FF">
<%
	if(FG.equals("0")){
	%>
	無効な処理が行われた可能性があります。<br>
	<form>
	 <input type="button" value="戻る" onClick="history.back()">
	</form>
	<%
	}
	else if(FG.equals("1")){
	%>
	既に選択されています。<br>
	<form><input type='button' value='戻る' onClick='history.back()'></form>
	<%
	}
	else if(FG.equals("2")){
	%>
	登録者となる方は、選択する事が出来ません。<br>
	<form><input type='button' value='戻る' onClick='history.back()'></form>
	<%
	}
	else if(FG.equals("3")){
	%>
	<B><%= name_ko %></B>さんは、
	<B><%= name_no %></B>さんのスケジュールを登録・変更・削除は行えません。<br>
	こちらから戻れます。<br>
	<form>
	<input type="button" value="戻る" onClick="history.back()">
	</form>
	<%
	}
	else if(FG.equals("4")){
	%>
	重複しているスケジュールがあります。<BR>
	<form><input type="button" value="戻る" onClick="history.back()"></form>
	<%
	}
	else if(FG.equals("5")){
	%>
	共有者を含めたスケジュールの登録は、出来ません。<BR>
	<form><input type="button" value="戻る" onClick="history.back()"></form>
	<%
	}
rs_no.close();
rs_ko.close();
stmt.close();
con.close();
%>
</body>
</html>