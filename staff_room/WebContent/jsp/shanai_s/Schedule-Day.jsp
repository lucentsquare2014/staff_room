<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.*" %>
<%!
// �����G���R�[�h���s���܂��B
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
/* �C���_ */
// 02-08-13 �V�K�X�P�W���[���o�^�E�X�P�W���[���ύX�E�o�i�[�X�P�W���[���ύX�ƃt���O�ɂ��؂�ւ���
// 02-09-04 �p�����|�^�̒ǉ�

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));
String GR = request.getParameter("group");

// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = strEncode(request.getParameter("kind"));

// Calender �C���X�^���X�𐶐�
Calendar now = Calendar.getInstance();

// ���݂̎������擾
Date dat = now.getTime();

// �\���`����ݒ�
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");

%>
<HTML>
	<HEAD>
		<TITLE>�X�P�W���[���Ǘ�</TITLE>
	</HEAD>
	<FRAMESET COLS="75%,25%" FRAMEBORDER="0">
		<FRAME SRC="h_hyoji.jsp?id=<%= ID %>&s_date=<%= sFmt.format(dat) %>&group=<%= GR %>" NAME="main" noresize>
		<FRAME SRC="timeIn.jsp?id=<%= ID %>&no=<%= ID %>&s_date=<%= sFmt.format(dat) %>&s_start=&b_start=&group=<%= GR %>&kind=<%= KD %>&act=" NAME="sub02" scrolling="no" noresize>
	</FRAMESET>
</HTML>
