<%@ page contentType="text/html; charset=Shift_JIS"%>
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
// 0-09-06 パラメータの修正。

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));
String sho = strEncode(request.getParameter("show"));
String gno = strEncode(request.getParameter("gruno"));
String del = strEncode(request.getParameter("delsch"));

if(gno.equals("")){
	%>
	<jsp:forward page="error.jsp">
		<jsp:param name="flag" value="0" />
	</jsp:forward>
	<%
}else if(sho.equals("")){
	%>
	<jsp:forward page="error.jsp">
		<jsp:param name="flag" value="0" />
	</jsp:forward>
	<%
}else if(del.equals("")){
	%>
	<jsp:forward page="error.jsp">
		<jsp:param name="flag" value="0" />
	</jsp:forward>
	<%
}else{
	
	// ユーザ認証情報の設定
	String user = "georgir";
	String password = "georgir";
	
	// JDBCドライバのロード
	Class.forName("org.postgresql.Driver");
	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
	
	// Statementオブジェクトを生成します。
	Statement stmt = con.createStatement();
	
	// SQL実行
	stmt.execute("UPDATE PE_TABLE SET K_社員NO = '" + ID + "',PE_GRUNO = '" + gno + "',PE_START = '" + sho + "',PE_SCHEDULE = '" + del + "' WHERE K_社員NO = '" + ID + "'");
	
	// Statement.Connectionオブジェクトを閉じる
	stmt.close();
	con.close();
	
	%>
	<jsp:forward page="henFinish.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}%>