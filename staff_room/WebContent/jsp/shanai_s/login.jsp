<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*" %>
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
	// 入力されたユーザIDをString変数[ID]に格納
String ID = strEncode(request.getParameter("id"));
// 入力されたパスワードをString変数[PASS]に格納
String PASS = strEncode(request.getParameter("pass"));
// 分岐
boolean flag = false;

/* // JDBCドライバのロードorg.postgresql.Driver
Class.forName("org.postgresql.Driver");

// データベースへ接続
String user = "georgir";     // データベースにアクセスするためのユーザ名
String password = "georgir"; // データベースにアクセスするためのパスワード
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
 */
 C_DBConnectionGeorgir georgiaDB = new C_DBConnectionGeorgir();
 Connection con = georgiaDB.createConnection();

// SQL実行
Statement stmt = con.createStatement();
Statement upDate = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "' AND K_PASS = '" + PASS + "'");

// 結果取得
if(rs.next()){
	flag = true;
}
int pe_sche = 0;
String strSche = "";
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
GregorianCalendar cal = new GregorianCalendar();

if(flag){
	//スケジュールの削除
	ResultSet rs2 = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_社員NO = '"+ ID +"'");
	while(rs2.next()){
		strSche = strEncode(rs2.getString("PE_SCHEDULE"));
		if(strSche != null){
	pe_sche = Integer.parseInt(strSche);
		if(pe_sche == 1){
			pe_sche = 3;
		}else if(pe_sche == 2){
			pe_sche = 6;
		}else if(pe_sche == 3){
			pe_sche = 12;
		}else if(pe_sche == 4){
			pe_sche = 24;
		}else if(pe_sche == 5){
			pe_sche = 36;
		}else if(pe_sche == 0){
			pe_sche = 1;
		}
	cal.add(Calendar.MONTH, - pe_sche);
	Date today = cal.getTime();
	upDate.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '"+ ID +"' AND S_DATE <= '"+ sFmt.format(today) +"'");
	upDate.execute("DELETE FROM B_TABLE WHERE K_社員NO = '"+ ID +"' AND B_END <= '"+ sFmt.format(today) +"'");
		}
	}
	rs2.close();
%>
	<jsp:forward page="menu.jsp">
	<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}
else{
	%>
	<jsp:forward page="error.jsp">
	 <jsp:param name="flag" value="0" />
	</jsp:forward>
	<%
}
// 接続解除
rs.close();
stmt.close();
con.close();
%>
