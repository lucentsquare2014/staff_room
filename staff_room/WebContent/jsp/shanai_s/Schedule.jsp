<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.*" %>
<%@ page import="kkweb.common.C_DBConnectionGeorgia" %>

<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"UTF-8"));
		}
}
%>
<%
/* 修正点 */
// 02-08-12 表示形式を個人設定で選択したユーザは、その情報を読み出し最優先とする
// 02-09-04 パラメータの追加
// 02-09-18 動作テスト期間…バグ発見   48行目〜58行目 グループコードの抽出するテーブル名を記述間違い。
// 02-10-01 バグ発見  
	
	// ログインしたユーザの社員番号を変数[ID]に格納
	String ID = strEncode(request.getParameter("id"));
	
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
	// 選択された社員番号と一致する個人設定情報を取り出すSQL
	ResultSet rs_pe = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_社員NO = '" + ID + "'");
	
	String pe_st = "";
	
	while(rs_pe.next()){
		pe_st = rs_pe.getString("PE_START");
	}
	
	rs_pe.close();
	
	boolean flag = false;
	
	// SQL実行・グループ情報[個人設定で行ったグループを抽出]
	ResultSet GROUPID = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_社員NO = '" + ID + "'");
	
	// 初期化を行っている
	String group_id = "";
	
	while(GROUPID.next()){
		flag = true;
		group_id = GROUPID.getString("PE_GRUNO");
	}
	
	GROUPID.close();
	
	if(!flag){
		ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");
		
		while(GROUP.next()){
			group_id = GROUP.getString("K_GRUNO");
		}
		
		GROUP.close();
	}
	
	if(pe_st.equals("1")){
		%>
		<jsp:forward page="Schedule-Month.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Month" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("2")){
		%>
		<jsp:forward page="Schedule-Week.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Week" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("3")){
		%>
		<jsp:forward page="Schedule-Day.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Day" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("")){
	// 選択されていない場合は、月表示を行う。
		%>
		<jsp:forward page="Schedule-Month.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Month" />
		</jsp:forward>
		<%
	}

con.close();
stmt.close();
%>
