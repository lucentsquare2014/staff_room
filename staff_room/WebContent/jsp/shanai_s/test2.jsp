<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"Shift_JIS"));
		}
}
%>
<%
long o_start = 0;
long o_stop = 0;
long i_start = 0;
long i_stop = 0;
long diff = 0;
long diff2 = 0;
long diff3 = 0;

o_start = System.currentTimeMillis();
// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// データベースへ接続
String user = "georgir";     // データベースにアクセスするためのユーザ名
String password = "georgir"; // データベースにアクセスするためのパスワード
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);

Statement stmt = con.createStatement();
o_stop = System.currentTimeMillis();
System.out.println("test");
i_start = System.currentTimeMillis();

ResultSet rs = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = 'yuk-suzuki' AND K_PASS = 'yuk-suzuki'");

String myname = "";
String myid = "";

while(rs.next()){
		myid = strEncode(rs.getString("K_ID"));
		myname = strEncode(rs.getString("K_社員NO"));
	}


	%>
	<html>
		<body>
			<div>ID : <%= myid %></div>
			<div>NO : <%= myname %></div><br>
	<%
// 接続解除
rs.close();
stmt.close();
con.close();

i_stop = System.currentTimeMillis();
diff = o_stop - o_start;
diff2 = i_stop - i_start;
diff3 = i_stop - o_start;
%>
<div>setsuzoku _ time : <%= diff %></div>
<div>sql _ time : <%= diff2 %></div>
<div>all _ time : <%= diff3 %></div>

		</body>
	</html>
