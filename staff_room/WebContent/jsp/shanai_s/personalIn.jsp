<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return (null);
	}
	else{
		return (new String(strVal.getBytes("UTF-8"),"UTF-8"));
	}
}
%>
<%
/* 修正点 */
// 02-08-16 余計なプログラムの排除

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

// SQL実行・グループ情報
ResultSet GRU = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

Vector hitGRUNO = new Vector();
Vector hitGRUNOAM = new Vector();

while(GRU.next()){
	String gno = GRU.getString("G_GRUNO");
	String gnam = GRU.getString("G_GRNAME");
	hitGRUNO.addElement(gno);
	hitGRUNOAM.addElement(gno + " " + gnam);
}

int cntGRUNO = hitGRUNO.size();

GRU.close();

// SQL実行・個人情報
ResultSet KOJIN = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name= "";

while(KOJIN.next()){
	name = KOJIN.getString("K_氏名");
}

KOJIN.close();

%>
<HTML>
	<HEAD>
		<TITLE>個人設定</TITLE>
		<STYLE TYPE="text/css">
			.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
		</STYLE>
	</HEAD>
	<BODY BGCOLOR="#99A5FF">
		<CENTER>
			<SPAN CLASS="shadow">
				<FONT COLOR="#FFFFFF">
					<H1>個人設定</H1>
					お名前：<%= name %><BR>
				</FONT>
			</SPAN>
		<FONT SIZE="2">※登録後から選択された内容が最優先されます。</FONT>
		<TABLE BORDER="5" CELLPADDING="0" CELLSPACING="5" WIDTH="600" BORDERCOLOR="#D6FFFF">
			<TR>
				<TD>
					<TABLE BORDER="1" WIDTH="100%">
						<TR>
							<FORM ACTION="./personalInsert.jsp" METHOD="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<TD COLSPAN="4" BGCOLOR="#FFFFFF">- 初期画面設定 -</TD>
						</TR>
						<TR>
							<TD BGCOLOR="#D6FFFF">表示形式</TD>
							<TD>
								<SELECT NAME="show">
									<OPTION VALUE="1" SELECTED>月表示</OPTION>
									<OPTION VALUE="2">週表示</OPTION>
									<OPTION VALUE="3">日表示</OPTION>
								</SELECT>
							</TD>
							<TD BGCOLOR="#D6FFFF">所属</td>
							<TD>
								<SELECT NAME="gruno" STYLE="width:200">
								<%
									for(int i = 0; i < cntGRUNO; i++){
								%>
								<OPTION VALUE="<%= hitGRUNO.elementAt(i) %>"><%= hitGRUNOAM.elementAt(i) %></OPTION>
								<%
									}%>
								</SELECT>
							</TD>
						</TR>
						<TR>
							<TD COLSPAN="4" BGCOLOR="#FFFFFF">- 過去スケジュール保持期間 -</TD>
						</TR>
						<TR>
							<TD COLSPAN="4">
								<INPUT TYPE="radio" NAME="delsch" VALUE="0" CHECKED>１ヶ月
								<INPUT TYPE="radio" NAME="delsch" VALUE="1">３ヶ月
								<INPUT TYPE="radio" NAME="delsch" VALUE="2">６ヶ月
								<INPUT TYPE="radio" NAME="delsch" VALUE="3">１年
								<INPUT TYPE="radio" NAME="delsch" VALUE="4">２年
								<INPUT TYPE="radio" NAME="delsch" VALUE="5">３年
							</TD>
						</TR>
						<TR>
							<TD COLSPAN="3" ALIGN="right" VALIGN="middle">
								<INPUT TYPE="submit" VALUE="登録" STYLE="width:70">
								<INPUT TYPE="reset" VALUE="取り消し" STYLE="width:70">
							</TD>
							</FORM>
							<FORM ACTION="menu.jsp" METHOD="Post">
								<TD ALIGN="center" VALIGN="middle">
									<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
									<INPUT TYPE="submit" VALUE="メインメニューへ戻る">
								</TD>
							</FORM>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		</CENTER>
	</BODY>
</HTML>
<%
stmt.close();
con.close();
%>