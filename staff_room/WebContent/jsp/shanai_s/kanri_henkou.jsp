<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
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
	String table_select = request.getParameter("table_select");
	String sql_select = request.getParameter("sql_select");
	String kn_pass = request.getParameter("pass");
	String k_no = "";
	String gr_num = "";
	String gr_name = "";
  	
  	if(table_select.equals("user")){
  	  	k_no = strEncode(request.getParameter("number"));
  	}else{
  		gr_num = strEncode(request.getParameter("gr_num"));
  		gr_name = strEncode(request.getParameter("gr_name"));
  	}
  	
	// JDBCドライバのロード
	Class.forName("org.postgresql.Driver");


	// データベースへ接続
	//String user = "kinmu";     // データベースにアクセスするためのユーザ名
	//String password = "kinmu"; // データベースにアクセスするためのパスワード
	String user = "georgir";     // データベースにアクセスするためのユーザ名
	String password = "georgir"; // データベースにアクセスするためのパスワード

	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
	Statement stmt = con.createStatement();

	//グループ
	//ResultSet rs = stmt.executeQuery("select * from GRU order by G_GRUNO");
	ResultSet rs = stmt.executeQuery("select * from kinmu.GRU order by G_GRUNO");

	String[][] group = new String[2][500];
	int group_count = 0;
	while(rs.next()){
		group[0][group_count] = rs.getString("G_GRUNO");
		group[1][group_count] = rs.getString("G_GRNAME");
		group_count++;
	}

	//個人の特定
	String k_lv = "";
	String k_id = "";
	String k_pass = "";
	String k_name = "";
	String k_group = "";
	String k_mail = "";
	if(table_select.equals("user")){
		//rs = stmt.executeQuery("select * from KOJIN where K_社員NO='" + k_no + "'");
		rs = stmt.executeQuery("select * from kinmu.KOJIN where K_社員NO='" + k_no + "'");
		if(rs.next()){
			k_lv = rs.getString("K_承認LV");
			k_id = rs.getString("K_ID");
			k_pass = rs.getString("K_PASS");
			k_name = rs.getString("K_氏名");
			k_group = rs.getString("K_GRUNO");
			k_mail = rs.getString("K_MAIL");
		}
	}
	
	// 接続解除
	rs.close();
	stmt.close();
	con.close();

	if(table_select.equals("user")){
%>
	<HTML>
		<BODY bgcolor="#F5F5F5">
			<TABLE WIDTH="100%">
				<TR>
					<TH bgcolor="#000099"><FONT color="#FFFFFF">ユーザー情報変更</FONT></TH>
				</TR>
			</TABLE>
			
			<HR SIZE="3" color="#000099">
			<CENTER>
				<FORM action="kanri_admin.jsp" method="POST">
					<INPUT TYPE="hidden" NAME="action" VALUE="kojin_change">
					<INPUT TYPE="hidden" NAME="name" VALUE="<%= k_name %>">
					<INPUT TYPE="hidden" NAME="pass" VALUE="<%= k_pass %>">
					<INPUT TYPE="hidden" NAME="new_num" VALUE="<%= k_no %>">
					<INPUT TYPE="hidden" NAME="table_select" VALUE="user">
					<INPUT TYPE="hidden" NAME="sql_select" VALUE="upd">
					<TABLE>
						<TR>
							<TD>承認者</TD>
<%
	String ex1_checked = "";
	String ex2_checked = "";
	if(k_lv.equals("1")){
		ex1_checked = "checked";
	}else if(k_lv.equals("2")){
		ex2_checked = "checked";
	}
%>
							<TD align="center" colspan="3">-１<INPUT TYPE="checkbox" NAME="ex1" <%= ex1_checked %>>-　　-２<INPUT TYPE="checkbox" NAME="ex2" <%= ex1_checked %>>-</TD>

						</TR>
						<TR>
							<TD>Ｉ　Ｄ</TD>
							<TD>
								<INPUT TYPE="text" NAME="new_id" SIZE="26" VALUE="<%= k_id %>">
							</TD>
							<TD>ﾒｰﾙｱﾄﾞﾚｽ</TD>
							<TD>
								<INPUT TYPE="text" SIZE="30" NAME="new_mail" VALUE="<%= k_mail %>">
							</TD>
						</TR>
						<TR>
							<TD>ﾊﾟｽﾜｰﾄﾞ</TD>
							<TD>
								<INPUT TYPE="password" NAME="new_pw" SIZE="20" VALUE="<%= k_pass %>">
							</TD>
							<TD>社員番号</TD>
							<TD align="left"><%= k_no %></TD>
						</TR>
						<TR>
							<TD>氏　名</TD>
							<TD>
								<INPUT TYPE="text" NAME="new_name" SIZE="26" VALUE="<%= k_name %>">
							</TD>
							<TD>所　属</TD>
							<TD align="left">
								<SELECT NAME="new_gr">
<%
  for(int n = 0;n < group_count;n++){
		if(group[0][n].equals(k_group)){
%>
									<OPTION SELECTED VALUE="<%= group[0][n] %>"><%= group[1][n] %></OPTION>
<%
		}else{
%>
									<OPTION VALUE="<%= group[0][n] %>"><%= group[1][n] %></OPTION>
<%
		}
  }
%>
								</SELECT>
							</TD>
						</TR>
					</TABLE>
					<BR>
					<TABLE>
						<TR>
							<TD>
								<INPUT TYPE="submit" VALUE="　更新　" STYLE="background-color:#FFFFFF;width:50">
							</TD>
						</FORM>
						<FORM action="kanri_admin.jsp" method="POST">
							<TD>
								<INPUT TYPE="hidden" NAME="action" VALUE="admin">
								<INPUT TYPE="hidden" NAME="pass" VALUE="<%= kn_pass %>">
								<INPUT TYPE="submit" VALUE="　戻る　" STYLE="background-color:#FFFFFF;width:50">
							</TD>
						</TR>
					</TABLE>
				</FORM>
			</BODY>
		</HTML>
<%
	}else if(table_select.equals("gru")){
  %>

	<HTML>
		<BODY bgcolor="#F5F5F5">
			<TABLE WIDTH="100%">
				<TR>
					<TH bgcolor="#000099"><FONT color="#FFFFFF">グループ変更</FONT></TH>
				</TR>
			</TABLE>
			
			<HR SIZE="3" color="#000099">
			<CENTER>

				<FORM action="kanri_admin.jsp" method="POST">
					<INPUT TYPE="hidden" NAME="action" VALUE="gr_change">
					<INPUT TYPE="hidden" NAME="pass" VALUE="<%= kn_pass %>">
					<INPUT TYPE="hidden" NAME="gr_num" VALUE="<%= gr_num %>">
					<INPUT TYPE="hidden" NAME="gr_name" VALUE="<%= gr_name %>">
					<INPUT TYPE="hidden" NAME="table_select" VALUE="gru">
					<INPUT TYPE="hidden" NAME="sql_select" VALUE="upd">
					<TABLE>
						<TR>
							<TD>グループコード</TD>
							<TD>
								<INPUT TYPE="text" NAME="n_gr_num" VALUE="<%= gr_num %>" SIZE="10">
							</TD>
						</TR>
						<TR>
							<TD>グループ名</TD>
							<TD>
								<INPUT TYPE="text" NAME="n_gr_name" VALUE="<%= gr_name %>" SIZE="30">
							</TD>
						</TR>
					</TABLE>

					<INPUT TYPE="submit" STYLE="background-color:#FFFFFF;width:50" VALUE="変更">
				</FORM>

				<BR><BR>

				<TABLE border="1">
					<TR>
						<TD align="center"><B>グループコード</B></TD>
						<TD align="center"><B>グループ名</B></TD>
					</TR>
<%
for(int n = 0;n < group_count;n++){
%>
  					<TR STYLE="font-size:12">
  						<TD align="center"><%= group[0][n] %></TD>
  						<TD align="center"><%= group[1][n] %></TD>
  					</TR>
<%
  }
%>
				</TABLE>
			</BODY>
		</HTML>
<%
}
%>


