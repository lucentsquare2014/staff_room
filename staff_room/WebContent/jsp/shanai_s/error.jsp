<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
public String strEncode(String strVal)
        throws UnsupportedEncodingException{
        if(strVal==null){
                 return(null);
         }
         else{
                 return(new String(strVal.getBytes("8859_1"),"Shift_JIS"));
         }
}
%>
<%
/* �C���_ */
// 02-08-13 �󂯎�����p�����[�^�Ə����̈�v����G���[���b�Z�[�W��\��
// 02-09-21 �G���[�̎�ނ𑝂₷

	// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
	String ID = strEncode(request.getParameter("id"));
	String NO = request.getParameter("no");
	String FG = request.getParameter("flag");

	// JDBC�h���C�o�̃��[�h
	Class.forName("org.postgresql.Driver");

	// ���[�U�F�؏��̐ݒ�
	String user = "georgir";
	String password = "georgir";

	// Connection�I�u�W�F�N�g�̐���
	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

	// Statement�I�u�W�F�N�g�̐���
	Statement stmt = con.createStatement();

	// SQL���s�E�l���
	ResultSet rs_ko = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

	String name_ko = "";

	while(rs_ko.next()){
		name_ko = rs_ko.getString("K_����");
	}

	// SQL���s�E�l���
	ResultSet rs_no = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

	String name_no = "";

	while(rs_no.next()){
		name_no = rs_no.getString("K_����");
	}
%>
<html>
<head><title>error</title>
</head>
<body BGCOLOR="#99A5FF">
<%
	if(FG.equals("0")){
	%>
	�����ȏ������s��ꂽ�\��������܂��B<br>
	<form>
	 <input type="button" value="�߂�" onClick="history.back()">
	</form>
	<%
	}
	else if(FG.equals("1")){
	%>
	���ɑI������Ă��܂��B<br>
	<form><input type='button' value='�߂�' onClick='history.back()'></form>
	<%
	}
	else if(FG.equals("2")){
	%>
	�o�^�҂ƂȂ���́A�I�����鎖���o���܂���B<br>
	<form><input type='button' value='�߂�' onClick='history.back()'></form>
	<%
	}
	else if(FG.equals("3")){
	%>
	<B><%= name_ko %></B>����́A
	<B><%= name_no %></B>����̃X�P�W���[����o�^�E�ύX�E�폜�͍s���܂���B<br>
	�����炩��߂�܂��B<br>
	<form>
	<input type="button" value="�߂�" onClick="history.back()">
	</form>
	<%
	}
	else if(FG.equals("4")){
	%>
	�d�����Ă���X�P�W���[��������܂��B<BR>
	<form><input type="button" value="�߂�" onClick="history.back()"></form>
	<%
	}
	else if(FG.equals("5")){
	%>
	���L�҂��܂߂��X�P�W���[���̓o�^�́A�o���܂���B<BR>
	<form><input type="button" value="�߂�" onClick="history.back()"></form>
	<%
	}
rs_no.close();
rs_ko.close();
stmt.close();
con.close();
%>
</body>
</html>