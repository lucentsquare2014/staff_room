<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgir" %>

<%!// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"UTF-8"));
		}
}%>
<%
	long o_start = 0;
long o_stop = 0;
long i_start = 0;
long i_stop = 0;
long diff = 0;
long diff2 = 0;
long diff3 = 0;

/* // JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// データベースへ接続
String user = "georgir";     // データベースにアクセスするためのユーザ名
String password = "georgir"; // データベースにアクセスするためのパスワード

o_start = System.currentTimeMillis();
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
 */
 C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
 Connection con = georgiaDB.createConnection();
 o_stop = System.currentTimeMillis();

Statement stmt = con.createStatement();

i_start = System.currentTimeMillis();
ResultSet rs = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = 'yuk-suzuki' AND K_PASS = 'yuk-suzuki'");
i_stop = System.currentTimeMillis();

DatabaseMetaData meta = con.getMetaData();
System.out.println("JDBC Driver Version = " + meta.getDriverVersion());
%>
	<html>
		<body>
			<div>aaa</div>
	<%
// 接続解除
rs.close();
stmt.close();
con.close();

diff = o_stop - o_start;
diff2 = i_stop - i_start;
diff3 = i_stop - o_start;
%>
<div>connection _ time : <%= diff %></div>
<div>sql _ time : <%= diff2 %></div>
<div>all _ time : <%= diff3 %></div>

		</body>
	</html>
