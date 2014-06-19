<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgia" %>

<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return (null);
	}
	else{
		return (new String(strVal.getBytes("8859_1"),"UTF-8"));
	}
}
%>
<%
/* 修正点 */
// 02-09-06 パラメータの修正。

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
	stmt.execute("INSERT INTO PE_TABLE(K_社員NO,PE_GRUNO,PE_START,PE_SCHEDULE) VALUES('" + ID + "','" + gno + "','" + sho + "','" + del + "')");
	
	// Statement.Connectionオブジェクトを閉じる
	stmt.close();
	con.close();
	
	%>
	<jsp:forward page="touFinish.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}%>