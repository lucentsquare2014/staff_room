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

// �`�F�b�N�p�t���O
boolean flag = false;

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// ���[�U�F�؏��̐ݒ�
String user = "georgir";
String password = "georgir";

// Connection�I�u�W�F�N�g�̐���
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statement�I�u�W�F�N�g�̐���
Statement stmt = con.createStatement();

// SQL�̎��s
ResultSet CHECK = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_�Ј�NO='" + ID + "'");

if(CHECK.next()){
	flag = true;
}

CHECK.close();

if(flag){
	%>
	<jsp:forward page="personalUp.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}
else{
	%>
	<jsp:forward page="personalIn.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}

// Statement.Connection�I�u�W�F�N�g�����
stmt.close();
con.close();

%>