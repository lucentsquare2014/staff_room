<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
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
	String Msg_error = "";
	String Cd_error = request.getParameter("error");
	int num_error = Integer.parseInt(Cd_error);
	
	switch(num_error){
	case 1:
		Msg_error = "�p�X���[�h���Ⴂ�܂�";
		break;
	case 2:
		Msg_error = "���͂��ꂪ����܂�";
		break;
	case 3:
		Msg_error = "���̎Ј��ԍ��͊��ɓo�^����Ă��܂�";
		break;
	case 4:
		Msg_error = "���̎����͊��ɓo�^����Ă��܂�";
		break;
	case 5:
		Msg_error = "���̂h�c�͊��ɓo�^����Ă��܂�";
		break;
	case 6:
		Msg_error = "���̃p�X���[�h�͊��ɓo�^����Ă��܂�";
		break;
	case 7:
		Msg_error = "�h�c�����͂���Ă��܂���";
		break;
	case 8:
		Msg_error = "�p�X���[�h�����͂���Ă��܂���";
		break;
	case 9:
		Msg_error = "���[���A�h���X�����͂���Ă��܂���";
		break;
	case 10:
		Msg_error = "���������͂���Ă��܂���";
		break;
	case 11:
		Msg_error = "���̃O���[�v�R�[�h�͊��ɓo�^����Ă��܂�";
		break;
	case 12:
		Msg_error = "���̃O���[�v���͊��ɓo�^����Ă��܂�";
		break;
	case 13:
		Msg_error = "�O���[�v�������͂���Ă��܂���";
		break;
	case 14:
		Msg_error = "�O���[�v�R�[�h�����͂���Ă��܂���";
		break;
	default:
		Msg_error = "�\�����ʃG���[���������܂����B�Ǘ��҂ɕ񍐂��Ă�������";
		break;	
	}
%>
	<html>
		<HEAD>
			<META HTTP-EQUIV=Content-Type CONTENT=text/html;Charset=Shift_Jis>
			<TITLE></TITLE>
		</HEAD>
		<BODY bgcolor=#F5F5F5 text=#000000 link=#008080 alink=#00CCCC vlink=#008080>
			<CENTER>
				<HR WIDTH=400><H3>ERROR !</H3>
				<P><FONT color=#AA0000><%= Msg_error %></FONT>
				<P><HR WIDTH=400>
			</CENTER>
		</body>
	</html>