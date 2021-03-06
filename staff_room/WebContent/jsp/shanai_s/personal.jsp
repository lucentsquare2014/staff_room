<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="kkweb.common.C_DBConnectionGeorgir"%>

<%!// 文字エンコードを行います。
	public String strEncode(String strVal) throws UnsupportedEncodingException {
		if (strVal == null) {
			return (null);
		} else {
			return (new String(strVal.getBytes("8859_1"), "UTF-8"));
		}
	}%>
<%
	/* 修正点 */
	// 02-08-16 余計なプログラムの排除

	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));
	if(ID == null){
		ID = session.getAttribute("login").toString();
	}

	// チェック用フラグ
	boolean flag = false;

	C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
	Connection con = georgiaDB.createConnection();

	// Statementオブジェクトの生成
	Statement stmt = con.createStatement();

	// SQLの実行
	ResultSet CHECK = stmt
			.executeQuery("SELECT * FROM PE_TABLE WHERE K_社員NO='" + ID
					+ "'");

	if (CHECK.next()) {
		flag = true;
	}

	CHECK.close();

	if (flag) {
%>
<jsp:forward page="personalUp.jsp">
	<jsp:param name="id" value="<%=ID%>" />
</jsp:forward>
<%
	} else {
%>
<jsp:forward page="personalIn.jsp">
	<jsp:param name="id" value="<%=ID%>" />
</jsp:forward>
<%
	}

	// Statement.Connectionオブジェクトを閉じる
	stmt.close();
	con.close();
%>