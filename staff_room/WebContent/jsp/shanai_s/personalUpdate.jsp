<%@ page contentType="text/html; charset=Shift_JIS"%>
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
// 0-09-06 �p�����[�^�̏C���B

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
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
	
	// ���[�U�F�؏��̐ݒ�
	String user = "georgir";
	String password = "georgir";
	
	// JDBC�h���C�o�̃��[�h
	Class.forName("org.postgresql.Driver");
	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
	
	// Statement�I�u�W�F�N�g�𐶐����܂��B
	Statement stmt = con.createStatement();
	
	// SQL���s
	stmt.execute("UPDATE PE_TABLE SET K_�Ј�NO = '" + ID + "',PE_GRUNO = '" + gno + "',PE_START = '" + sho + "',PE_SCHEDULE = '" + del + "' WHERE K_�Ј�NO = '" + ID + "'");
	
	// Statement.Connection�I�u�W�F�N�g�����
	stmt.close();
	con.close();
	
	%>
	<jsp:forward page="henFinish.jsp">
		<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}%>