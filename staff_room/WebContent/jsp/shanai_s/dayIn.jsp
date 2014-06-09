<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector" %>

<%!
// �����G���R�[�h���s��
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return(null);
	}
	else{
		return(new String(strVal.getBytes("8859_1"),"Shift_JIS"));
	}
}
%>
<%
/* �C���_ */
// 02-08-05 ���E�T�E���ƃt�@�C���𕪂��Ă������̂����������A�t���O�ɂ���ď��������E�T�E���ւƐ؂�ւ����@�Ɉڍs
// 02-08-15 �]�v�ȃv���O�������Ȃ�
// 02-08-26 �I�����ꂽ���t�����T�Ԑi�߂����t���I�����ɑ�����Ă����̂��Ȃ����B
// 02-09-04 �ڍ׉�ʂ̕\������ւ�������������B�����N���N���b�N����ƒP�����Ɉړ�����B
// 02-09-05 �ڍ׉�ʂ̕\������ւ�������ύX�B�����N���N���b�N����Ƒo�����Ɉړ�����B

/* �ǉ��_ */
// 02-09-03 ���L�҃v���O�������O���t�@�C���Ƃ��Ď�荞�ށB

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// �p�����[�^�̎擾[���p�p�����[�^]
String NO = request.getParameter("no");
String GR = request.getParameter("group");

// �p�����[�^�̎擾[pubs�g�p]
String DA = strEncode(request.getParameter("s_date"));
String ST = strEncode(request.getParameter("s_start"));
String AC = strEncode(request.getParameter("act"));

// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = request.getParameter("kind");

// �I�����ꂽ���t�̕���
String BS = request.getParameter("b_start");
int BSy = Integer.parseInt(BS.substring(0,4));  // �N
int BSm = Integer.parseInt(BS.substring(5,7));  // ��
int BSd = Integer.parseInt(BS.substring(8,10)); // ��

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// �f�[�^�x�[�X�ւ̃��O�C�����
String user = "georgir";
String password = "georgir";

// Connection �I�u�W�F�N�g�𐶐�
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statement�I�u�W�F�N�g�̐���
Statement stmt = con.createStatement();

// SQL���s�E�\�����ǂݏo��
ResultSet YOTEI = stmt.executeQuery("SELECT * FROM KINMU.YOTEI WHERE �敪 = '1'");

// hitList�̐���
Vector hitYOTEI = new Vector();

// ���ʃZ�b�g���������܂��B
while(YOTEI.next()){
	String basyo = YOTEI.getString("�ꏊ");
	hitYOTEI.addElement(basyo.trim());
}

// hitList�ɓ����Ă��������
int cntYOTEI = hitYOTEI.size();

// ResultSet�����
YOTEI.close();

// SQL���s�E�ꏊ����ǂݏo��
ResultSet BASYO = stmt.executeQuery("SELECT * FROM KINMU.YOTEI WHERE �敪 = '2'");

Vector hitBASYO = new Vector();

while(BASYO.next()){
	String basyo = BASYO.getString("�ꏊ");
	hitBASYO.addElement(basyo.trim());
}

int cntBASYO = hitBASYO.size();

BASYO.close();

/* ���O���[�v�ł��邩���r���邽�߂Ɏg�p���� */
// SQL���s�E�O���[�v���[�{�l]
ResultSet GROUPID = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

// ���������s���Ă���
String group_id = "";

while(GROUPID.next()){
	group_id = GROUPID.getString("K_GRUNO");
}

GROUPID.close();

// SQL���s�E�O���[�v���[���̃��[�U]
ResultSet GROUPNO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

String group_no = "";

while(GROUPNO.next()){
	group_no = GROUPNO.getString("K_GRUNO");
}

GROUPNO.close();

/* [ID]��[NO]�̎�����ǂݏo���܂��B */
// SQL�̎��s�E�l���[�{�l]
ResultSet NAMEID = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

String name_id = "";

while(NAMEID.next()){
	name_id = NAMEID.getString("K_����");
}

NAMEID.close();

// SQL�̎��s�E�l���NO[���̃��[�U]
ResultSet NAMENO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

String name_no = "";

while(NAMENO.next()){
	name_no = NAMENO.getString("K_����");
}

NAMENO.close();

/* �O���[�v�R�[�h�E�O���[�v�����R���{�{�b�N�X�ɕ\�����邽�߂̏��� */
// SQL�̎��s�E�O���[�v���
ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.GRU");

// hitList�̍쐬
Vector hitGRUNUM = new Vector();
Vector hitGRUNUAM = new Vector();

// �O���[�v�e�[�u���ɃA�N�Z�X
while(GROUP.next()){
	String gnum = strEncode(GROUP.getString("G_GRUNO"));
	String gnam = GROUP.getString("G_GRNAME");
	hitGRUNUM.addElement(gnum);
	hitGRUNUAM.addElement(gnam.trim());
}

int cntGRU = hitGRUNUM.size();

// ResultSet�����
GROUP.close();

%>
<HTML>
	<HEAD>
		<TITLE>�ڍ׉��</TITLE>
		<meta http-equiv="content-language" content="ja">
		<meta http-equiv="pragma" content="no-cache">
		<meta name="author" content="roq">
		<meta name="googlebot" content="noarchive">
		<meta name="robots" content="noindex">
		<script language="JavaScript">
		<!--
			var bwtype1 = (document.all) ? 0 : (document.layers) ? 1 : 2;
			var move1 = 0;
			var ckck1 = 0;
			var divobj1;
			
			function movemn1(){
				if(!ckck1){
					tid = setTimeout('realmnp1()', 10);
					ckck1 = 1;
					tid = setTimeout('realmnm2()', 10);
					ckck2 = 0;
				}else{
					tid = setTimeout('realmnm1()', 10);
					ckck1 = 0;
					tid = setTimeout('realmnp2()', 10);
					ckck2 = 1;
				}
				return false;
			}
			function realmnp1(){
				divobj1.left = move1;
				if(move1 < 235){
					setTimeout('realmnp1()', 10);
				}
				move1 = move1 + 5;
			}
			function realmnm1(){
				divobj1.left = move1;
				if(move1 > 0){
					setTimeout('realmnm1()', 10);
				}
				move1 = move1 - 5;
			}
		//-->
		</script>
	</HEAD>
	<STYLE TYPE="text/css">
		.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
	</STYLE>
	<BODY BGCOLOR="#99A5FF">
		<div id="divmenu1" style="position:absolute;visibility:visible;z-index:0;">
			<table bgcolor="#99A5FF" border="1" width="235" height="604" cellpadding="0" cellspacing="0">
				<tr>
					<td bgcolor="#ffffff" width="20" rowspan="2">
					<center>
						<a href="#" onClick="return movemn1();" STYLE="text-decoration:none"><b>��<p><font size="2">�o<br>�i<br>�b<br>�X<br>�P<br>�W<br>��<br>�b<br>��<br>�o<br>�^<br>��<br>��</font></p>��</b></a>
					</center>
					</td>
					<td bgcolor="#99A5FF" height="604" width="100%" colspan="2">
						<FORM ACTION="dayInsert.jsp" METHOD="Post">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
							<INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<SPAN CLASS="shadow">
								<FONT COLOR="white">
									�悤�����B<%= name_id %>����B<br>
									<%
									if(group_id.equals(group_no) || group_id.equals("900")){
										%><%= name_no %>�����<br>��Ű���ޭ�ق�o�^�ł��܂��B<%
									}else{
										%><%= name_no %>�����<br>��Ű���ޭ�ق͓o�^�ł��܂���B<%
									}
									%>
								</FONT>
							</SPAN>
							<TABLE BORDER="1" style="width:100%;">
								<TR>
									<TD bgcolor="#D6FFFF" rowspan="3" align="center" style="width:20%;">���t</TD>
									<TD>
										<SELECT NAME="syear" STYLE="width:80%">
										<%
										// ���݂̔N����ܔN��܂ŏo�͂���悤�ɂ��Ă��܂��B
										for(int i = 0; i < 5;i++){
											%><OPTION VALUE="<%= BSy + i %>"><%= BSy + i %></OPTION><%
										}
										%>
										</SELECT> �N<BR>
										<SELECT NAME="smonth" STYLE="width:80%">
										<%
										for(int i = 1; i <= 12;i++){
											if(i <= 9){
												if(BSm == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSm == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> ��<BR>
										<SELECT NAME="sday" STYLE="width:80%">
										<%
										for(int i = 1; i <= 31;i++){
											if(i <= 9){
												if(BSd == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSd == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> ��<BR>
									</TD>
								</TR>
								<TR>
									<TD align="center" valign="middle">��</TD>
								</TR>
								<TR>
									<TD>
										<SELECT NAME="eyear" STYLE="width:80%">
										<%
										for(int i = 0; i < 5;i++){
											%><OPTION VALUE="<%= BSy + i%>"><%= BSy + i%></OPTION><%
										}
										%>
										</SELECT> �N<BR>
										<SELECT NAME="emonth" STYLE="width:80%">
										<%
										for(int i = 1; i <= 12;i++){
											if(i <= 9){
												if(BSm == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSm == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> ��<BR>
										<SELECT NAME="eday" STYLE="width:80%">
										<%
										for(int i = 1; i <= 31;i++){
											if(i <= 9){
												if(BSd == i){
													%><OPTION VALUE=<%= "0"+ i %> SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE=<%= "0" + i %>><%= i %></OPTION><%
												}
											}else{
												if(BSd == i){
													%><OPTION VALUE="<%= i %>" SELECTED><%= i %></OPTION><%
												}else{
													%><OPTION VALUE="<%= i %>"><%= i %></OPTION><%
												}
											}
										}
										%>
										</SELECT> ��<BR>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">�\��</TD>
									<TD>
										<SELECT NAME="plan" STYLE="width:100%">
											<OPTION value="--" SELECTED>--</OPTION>
											<%
											for(int i = 0; i < cntYOTEI; i++){
												%><OPTION value="<%= hitYOTEI.elementAt(i) %>"><%= hitYOTEI.elementAt(i) %></OPTION><%
											}
											%>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" align="center">�\��ڍ�</TD>
									<TD>
										<INPUT TYPE="text" NAME="plan2" SIZE="23" MAXLENGTH="30" style="width:100%">
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">�ꏊ</TD>
									<TD>
										<SELECT NAME="place" STYLE="width:100%">
											<OPTION value="--" SELECTED>--</OPTION>
											<%
											for(int i = 0; i < cntBASYO; i++){
												%><OPTION value="<%= hitBASYO.elementAt(i) %>"><%= hitBASYO.elementAt(i) %></OPTION><%
											}
											%>
										</SELECT>
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" align="center">�ꏊ�ڍ�</TD>
									<TD>
										<INPUT TYPE="text" NAME="place2" SIZE="23" MAXLENGTH="30" style="width:100%">
									</TD>
								</TR>
								<TR>
									<TD bgcolor="#D6FFFF" style="text-align:center;">����</TD>
									<TD>
										<TEXTAREA NAME="memo" ROWS="3" COLS="30" MAXLENGTH="50" STYLE="width:100%; ime-mode:active;"></TEXTAREA>
									</TD>
								</TR>
							</TABLE>
							<INPUT TYPE="radio" NAME="pre" VALUE="1">�ݐ�
							<INPUT TYPE="radio" NAME="pre" VALUE="0" CHECKED>�s��<P>
							<%
							if(group_id.equals(group_no) || group_id.equals("900")){
							%>
							<center>
							<INPUT TYPE="submit" NAME="act" VALUE="�o�^" style="width:45%">
							<INPUT TYPE="reset" VALUE="���ɖ߂�" style="width:45%">
							</center>
						</FORM>
						<P>
						<FORM ACTION="timeIn.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="">
							<INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<INPUT TYPE="hidden" NAME="act" VALUE="">
							<center>
							<INPUT TYPE="submit" VALUE="�X�P�W���[���o�^�ֈړ�" STYLE="width:95%">
							</center>
						</FORM>
						<%
						}else{
							%>
							</FORM><BR>
							<%
						}
						%>
					</TD>
				</TR>
			</table>
		</div>
			<script language="JavaScript">
				<!--
				if(bwtype1 == 0){
					divobj1 = document.all.divmenu1.style;
				}
				if(bwtype1 == 1){
					divobj1 = document.divmenu1;
				}
				if(bwtype1 == 2){
					divobj1 = document.getElementById("divmenu1").style;
				}
				divobj1.left = 0;
				divobj1.top  = 0;
				//-->
			</script>
		<jsp:include page="pubs.jsp" flush="true" />		
	</BODY>
</HTML>
<%
stmt.close();
con.close();
%>