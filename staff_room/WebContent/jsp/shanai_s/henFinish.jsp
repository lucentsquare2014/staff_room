<%@ page contentType = "text/html; charset=Shift_JIS" import="java.sql.*,java.io.*,java.util.*" %>
<%!
// �����G���R�[�h���s���܂��B
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"JISAutoDetect"));
		}
}
%>
<%
// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));
%>
<HTML>
<HEAD>
<TITLE>�ύX�������</TITLE>
<STYLE TYPE="text/css">
.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
</style>
</HEAD>
<BODY BGCOLOR="#99A5FF">
<CENTER>
<FONT COLOR="#ffffff">
<SPAN CLASS="shadow">
<H1>�ύX���܂����B</H1>
</FONT>
</SPAN>
<FORM ACTION="menu.jsp" METHOD="Post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
<INPUT TYPE="submit" VALUE="���C�����j���[�֖߂�">
</FORM>
</CENTER>
</BODY>
</HTML>