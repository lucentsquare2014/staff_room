<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
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
// 02-08-16 余計なプログラムの排除

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// チェック用フラグ
boolean flag = false;

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// ユーザ認証情報の設定
String user = "georgir";
String password = "georgir";

// Connectionオブジェクトの生成
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statementオブジェクトの生成
Statement stmt = con.createStatement();

// SQLの実行
ResultSet CHECK = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_社員NO='" + ID + "'");

if(CHECK.next()){
	flag = true;
}

CHECK.close();

if(flag){
	%>
	<jsp:forward page="personalUp.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}
else{
	%>
	<jsp:forward page="personalIn.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}

// Statement.Connectionオブジェクトを閉じる
stmt.close();
con.close();

%>