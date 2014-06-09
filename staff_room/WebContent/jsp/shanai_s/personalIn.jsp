<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
// �����G���R�[�h���s���܂��B
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
/* �C���_ */
// 02-08-16 �]�v�ȃv���O�����̔r��

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// ���[�U�F�؏��̐ݒ�
String user = "georgir";
String password = "georgir";

// Connection�I�u�W�F�N�g�̐���
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statement�I�u�W�F�N�g�̐���
Statement stmt = con.createStatement();

// SQL���s�E�O���[�v���
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

// SQL���s�E�l���
ResultSet KOJIN = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name= "";

while(KOJIN.next()){
	name = KOJIN.getString("K_����");
}

KOJIN.close();

%>
<HTML>
	<HEAD>
		<TITLE>�l�ݒ�</TITLE>
		<STYLE TYPE="text/css">
			.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
		</STYLE>
	</HEAD>
	<BODY BGCOLOR="#99A5FF">
		<CENTER>
			<SPAN CLASS="shadow">
				<FONT COLOR="#FFFFFF">
					<H1>�l�ݒ�</H1>
					�����O�F<%= name %><BR>
				</FONT>
			</SPAN>
		<FONT SIZE="2">���o�^�ォ��I�����ꂽ���e���ŗD�悳��܂��B</FONT>
		<TABLE BORDER="5" CELLPADDING="0" CELLSPACING="5" WIDTH="600" BORDERCOLOR="#D6FFFF">
			<TR>
				<TD>
					<TABLE BORDER="1" WIDTH="100%">
						<TR>
							<FORM ACTION="./personalInsert.jsp" METHOD="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<TD COLSPAN="4" BGCOLOR="#FFFFFF">- ������ʐݒ� -</TD>
						</TR>
						<TR>
							<TD BGCOLOR="#D6FFFF">�\���`��</TD>
							<TD>
								<SELECT NAME="show">
									<OPTION VALUE="1" SELECTED>���\��</OPTION>
									<OPTION VALUE="2">�T�\��</OPTION>
									<OPTION VALUE="3">���\��</OPTION>
								</SELECT>
							</TD>
							<TD BGCOLOR="#D6FFFF">����</td>
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
							<TD COLSPAN="4" BGCOLOR="#FFFFFF">- �ߋ��X�P�W���[���ێ����� -</TD>
						</TR>
						<TR>
							<TD COLSPAN="4">
								<INPUT TYPE="radio" NAME="delsch" VALUE="0" CHECKED>�P����
								<INPUT TYPE="radio" NAME="delsch" VALUE="1">�R����
								<INPUT TYPE="radio" NAME="delsch" VALUE="2">�U����
								<INPUT TYPE="radio" NAME="delsch" VALUE="3">�P�N
								<INPUT TYPE="radio" NAME="delsch" VALUE="4">�Q�N
								<INPUT TYPE="radio" NAME="delsch" VALUE="5">�R�N
							</TD>
						</TR>
						<TR>
							<TD COLSPAN="3" ALIGN="right" VALIGN="middle">
								<INPUT TYPE="submit" VALUE="�o�^" STYLE="width:70">
								<INPUT TYPE="reset" VALUE="������" STYLE="width:70">
							</TD>
							</FORM>
							<FORM ACTION="menu.jsp" METHOD="Post">
								<TD ALIGN="center" VALIGN="middle">
									<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
									<INPUT TYPE="submit" VALUE="���C�����j���[�֖߂�">
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