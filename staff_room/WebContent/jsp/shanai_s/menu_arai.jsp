<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.util.*,java.io.*" %>

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
/* �ύX�_ */
// 02-08-26 �]�v�ȃv���O�����̔r��

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
Statement stmt_koj = con.createStatement();

// SQL���s�E�l���
ResultSet rs_koj = stmt_koj.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name= "";

while(rs_koj.next()){
	name = rs_koj.getString("K_����");
}

%>
<HTML>
	<HEAD>
		<TITLE>MSJ �` MainMenu �`</TITLE>
		<STYLE TYPE="text/css">
			.shadow {
				filter: shadow(color=black,direction=135);
				position: relative;
				height: 50;
				width: 100%;
			}
			
			td.a {
				width: 100%;
				height: 50px;
				padding: none;
				border-style: none;
				background-color: #D6FFFF;
				text-align: center;
				vertical-align: middle;
			}
		</STYLE>
	</HEAD> 
	<BODY BGCOLOR="#99A5FF">
		<CENTER>
			<SPAN CLASS="shadow">
				<FONT COLOR="white">
					<H1>
					<FONT COLOR="GOLD">M</FONT>anagement 
					<FONT COLOR="GOLD">S</FONT>chedule 
					<FONT COLOR="GOLD">J</FONT>ava ver 2.0<BR>�` MainMenu �`
					</H1><P>
					�����O�F<%= name %><p>
				</FONT>
			</SPAN>
			<Table border="5" cellpadding="0" cellspacing="5" width=300 style="border-style: solid; border-color:#D6FFFF">
				<TR>
					<TD class="a" BGCOLOR="#D6FFFF">
						<FORM ACTION="Schedule.jsp" method="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="submit" VALUE="�X�P�W���[��" STYLE="width:150px">
						</FORM>
					</TD>
				</TR>
				<TR>
					<TD class="a" valign="middle">
						<FORM ACTION="personal.jsp" method="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="submit" VALUE="�l�ݒ�" STYLE="width:150px">
						</FORM>
					</TD>
				</TR>
			</TABLE>
			<FORM>
				<%--
				<INPUT TYPE="button" VALUE="���O�A�E�g" STYLE="width:150" onClick="window.location.replace('login.html')">
				 --%>
				<INPUT TYPE="button" VALUE="���O�A�E�g" STYLE="width:150px" onClick="window.location.replace('ID_PW_Nyuryoku.jsp')">
				 
			</FORM>
			<HR WIDTH="50%" SIZE="5" COLOR="GOLD">
			<SPAN CLASS="shadow">
				<FONT COLOR="white">
					���m�点
				</FONT>
			</SPAN>
			<BR>

			<FONT COLOR="red">2013-01-17</FONT><P>
			<FONT COLOR="red">��Q�̂��m�点</FONT><BR>
			<FONT COLOR="white">
				���݁A���͍ς݂̃X�P�W���[�����N���b�N����ƉE�̓��͉�ʂ�<BR>
				�G���[���\�������ꍇ������܂��B���̏ꍇ�A���̓��̓��e��<BR>
				�ύX�A�폜���邱�Ƃ��ł��܂���B<BR>
				�G���[���\������Ȃ��ꍇ�́A���́A�ύX�A�폜���\�ł��B<BR>
				�����𒲍����ł��B���΂炭���҂��������B<BR>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2006-06-28</FONT><P>
			<FONT COLOR="red">�o�[�W�����A�b�v�̂��m�点</FONT><BR>
			<FONT COLOR="white">
				�\��o�^�̍ۂ̎������͂��P���P�ʂŏo����悤�ɂ������܂����B<BR>
				���̑��A���L�҃X�P�W���[���̏d���`�F�b�N�A<BR>
				�\��\����ʂ̕\���`���̕ύX�����s���܂����B<br>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2003-09-06</FONT><P>
			<FONT COLOR="red">�C���̂��m�点</FONT><BR>
			<FONT COLOR="white">
				�X�����ߍ���蔭�����Ă��܂����T�\���̃G���[�̏C���������������܂����B<BR>
				��ς����f���������������܂����B<br>
			</FONT>

			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			<FONT COLOR="red">2003-09-01</FONT><P>
			<FONT COLOR="red">�G���[�̂��m�点</FONT><BR>
			<FONT COLOR="white">
				���݁A"�T�\��"���g���Ȃ��Ȃ��Ă���܂��B�l�ݒ�ŕ\���`����"�T�\��"<BR>
				�ɑI�����Ă�����́A"���\��"��������"���\��"�ɂ��؂�ւ����������܂��悤<BR>
				���肢�������܂��B�C�����s���܂��̂ŁA���΂炭���҂��������B<P>
			</FONT>

			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			<!--
				<FONT COLOR="red">2002-12-24</FONT><P>
				<FONT COLOR="white">
				<FONT COLOR="red">�C���̂��m�点</FONT><BR>
					���\���ɂāA�R�s�[�@�\�����܂���������Ȃ��Ƃ����G���[���������Ă��܂������A<BR>
					�C�����s���܂����B<P>
				</FONT>
				<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">
			// -->

			<FONT COLOR="red">2002-12-16</FONT><P>
			<FONT COLOR="red">�G���[�̂��m�点</FONT><BR>
			<FONT COLOR="white">
				���\���ɂāA�R�s�[�@�\�����܂���������Ȃ��Ƃ����G���[���������Ă��܂��B<BR>
				�C�����s���܂��̂ŁA���΂炭���҂��������B<P>
			</FONT>
			<HR WIDTH="50%" SIZE="2" COLOR="#E0FF40">

			<FONT COLOR="red">2002-09-24</FONT><BR>
			<FONT COLOR="white">
					���L�̓��e��ǉ��v���܂����B<P>
				<FONT COLOR="RED">�o�i�[�X�P�W���[���o�^�E�ύX�E�폜</FONT><BR>
					ver1.00�̏������C���������̂ł��B<BR>
					�d���o�^�́A�o���܂���B<P>
				<FONT COLOR="RED">�ߋ��X�P�W���[���폜�@�\</FONT><BR>
					����́A�l�ݒ�����Ă������������[�U�Ɋ֌W������܂��B<BR>
					ver1.01����́A���O�C�����鎞�ɏ��������s����܂��̂Őݒ�ɂ͒��ӂ��ĉ������B<P>
				<FONT COLOR="RED">�R�s�[�@�\</FONT><BR>
					�o�^���ꂽ�X�P�W���[���̏�ŁA�E�N���b�N�����܂��ƃR�s�[�����s����܂��B<BR>
					�����āA�e�\��[���E�T�E��]�̐V�K�o�^���s�����߂Ɏg���Ă���[���t�����N]�̏�ŉE�N���b�N�����Ă��������Ɠ\��������s����܂��B<BR>
					�Ȃ��A�R�s�[�@�\��[Cookie]���g�p���Ă��܂��̂ŁA[off]�ɂ���Ă������[on]�ɂ��ĉ������B<P>
				<FONT COLOR="RED">���L�ҋ@�\</FONT><BR>
					���̃��[�U�ƃX�P�W���[���������̓o�i�[�X�P�W���[�������L���������ɁA�g�p���ĉ������B<BR>
					�菇�Ƃ��ẮA�E�̏ڍ׉�ʂ̒[�ɂ���u���L�ғo�^��ʁv�Ƃ��������N���N���b�N���Ă��������܂��B<BR>
					��ʂ��o�Ă��܂�����A�X�P�W���[�������L����������I���i�����I���j���A�ǉ��{�^���������ĉ������B<BR>
					��������ƁA�����o�[���X�g�ɑI�����ꂽ�����\������܂��B<BR>
					��́A�X�P�W���[���������̓o�i�[�X�P�W���[���̓o�^���s���ĉ������B<BR>
					�Ȃ��A�X�P�W���[����ύX����ۂɂ��A�����o�[�̒ǉ��A�폜���\�ł��B<P>
			</FONT>
		</CENTER>
	</BODY>
</HTML>