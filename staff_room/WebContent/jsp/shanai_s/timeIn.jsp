<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.* , java.util.Date , java.util.Calendar , java.io.* , java.text.* , java.util.Vector" %>
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
// 02-08-05 ���E�T�E���ƃt�@�C���𕪂��Ă������̂����������A�t���O�ɂ���ď����𕪂�����@
// 02-09-04 �ڍ׉�ʂ̕\������ւ�������������B�����N���N���b�N����ƒP�����Ɉړ�����B
// 02-09-05 �ڍ׉�ʂ̕\������ւ�������ύX�B�����N���N���b�N����Ƒo�����Ɉړ�����B

/* �ǉ��_ */
// 02-09-02 ���L�҃v���O��������荞�ށB
// 02-09-03 ���L�҃v���O�������O���t�@�C���Ƃ��Ď�荞�ށB

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// �p�����[�^�̎擾[���p�p�����[�^]
String NO = request.getParameter("no");
String DA = strEncode(request.getParameter("s_date"));
String GR = request.getParameter("group");

// �p�����[�^�̎擾[pubs�g�p]
String ST = strEncode(request.getParameter("s_start"));
String BS = strEncode(request.getParameter("b_start"));
String AC = strEncode(request.getParameter("act"));

// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = request.getParameter("kind");

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// ���[�U�F�؏��̐ݒ�
String user = "georgir";
String password = "georgir";

// Connection�I�u�W�F�N�g�̐���
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

// Calender �C���X�^���X�𐶐�
Calendar now = Calendar.getInstance();

// ���݂̎������擾
Date dat = now.getTime();

// �\���`����ݒ�
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");

//�ϐ��錾
int i=0;

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
					<td bgcolor="#ffffff" width="20" rowspan="2"><center>
						<A href="#" onClick="return movemn1();" STYLE="text-decoration:none"><b>��<p>
							<font size="2">�X<br>�P<br>�W<br>��<br>�b<br>��<br>�o<br>�^<br>��<br>��</font><p>��</b>
						</A></center>
					</td>
					<td bgcolor="#99A5FF" height="604" width="215" colspan="2">
						<FORM METHOD="Post" ACTION="timeInsert.jsp" name="form0">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<SPAN CLASS="shadow">
								<FONT COLOR="white">
									�悤�����B<%= name_id %>����B<br>
									<%
									if(group_id.equals(group_no) || group_id.equals("900")){
										%><%= name_no %>�����<br>���ޭ�ق�o�^�ł��܂��B<%
									}else{
										%><%= name_no %>�����<br>���ޭ�ق͓o�^�ł��܂���B<%
									}
									%>
								</FONT>
							</SPAN>
							<table border="1" style="width:100%;">
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center; width: 20%;">
									<small>�{����<br>���t</small></td>
									<%
									if(DA == null){
									%>
									<td>
										<INPUT TYPE="text" NAME="s_date" MAXLENGTH="10" VALUE="<%= sFmt.format(dat) %>" STYLE="width:100%; ime-mode:disabled">
									</td>
									<%
									}else{
									%>
									<td>
										<INPUT TYPE="text" NAME="s_date" MAXLENGTH="10" VALUE="<%= DA %>" STYLE="width:100%;ime-mode:disabled">
									</td>
									<%
									}
									%>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" rowspan="3" style="text-align: center;">����</td>
									<td><center>
										<SELECT NAME="starth" STYLE="width:28%;"><%
											for(i = 0; i < 24; i++){
												if(i <= 8){%>
													<OPTION VALUE=<%= "0" + Integer.toString(i) %>>
														<%= i %>
													</OPTION><%
												}else if(i == 9){%>
													<OPTION VALUE=<%= "0" + Integer.toString(i) %> SELECTED>
														<%= i %>
													</OPTION><%
												}else{%>
													<OPTION VALUE=<%= i %>>
														<%= i %>
													</OPTION><%
												}
											}%>
										</SELECT><small>��</small>
										<SELECT NAME="startm1" STYLE="width:25%;"><%
											for(i = 0; i<6; i++){%>
												<option>
													<%=i%>
												</option><%
											}%>
										</SELECT><SELECT NAME="startm2" STYLE="width:25%;"><%
											for(i = 0; i<10; i++){%>
												<option>
													<%=i%>
												</option><%
											}%>
										</SELECT><small>��</small>
									</center></td>
								</tr>
								<tr>
									<td align="center">��</td>
								</tr>
								<tr>
									<td><center>
										<SELECT NAME="endh" STYLE="width:28%;"><%
											for(i = 0; i < 24; i++){
												if(i <= 8){%>
													<OPTION VALUE=<%= "0" + Integer.toString(i) %>>
														<%= i %>
													</OPTION><%
												}else if(i == 9){%>
													<OPTION VALUE=<%= "0" + Integer.toString(i) %> SELECTED>
														<%= i %>
													</OPTION><%
												}else{%>
													<OPTION VALUE=<%= i %>>
														<%= i %>
													</OPTION><%
												}
											}%>
										</SELECT><small>��</small>
										<SELECT NAME="endm1" STYLE="width:25%;"><%
											for(i = 0; i<6; i++){%>
											<option>
												<%=i%>
											</option><%
											}%>
										</SELECT><SELECT NAME="endm2" STYLE="width:25%;"><%
											for(i = 0; i<10; i++){%>
											<option>
												<%=i%>
											</option><%
											}%>
										</SELECT><small>��</small>
									</center></td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center;">�\��</td>
									<td>
										<SELECT NAME="plan" STYLE="width:100%;">
											<OPTION VALUE="--">--</OPTION>
											<%
											for(i = 0; i < cntYOTEI; i++){
												%>
												<OPTION value="<%= hitYOTEI.elementAt(i) %>">
													<%= hitYOTEI.elementAt(i) %>
												</OPTION>
												<%
											}
											%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center;">�\��ڍ�</td>
									<td>
										<INPUT TYPE="text" style="ime-mode:active;  width:100%;" NAME="plan2" SIZE="20" MAXLENGTH="30">
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center;">�ꏊ</td>
									<td>
										<SELECT NAME="place" STYLE="width:100%;">
											<OPTION VALUE="--">--</OPTION>
											<%
											for(i = 0; i < cntBASYO; i++){
												%>
												<OPTION value="<%= hitBASYO.elementAt(i) %>">
													<%= hitBASYO.elementAt(i) %>
												</OPTION>
												<%
											}
											%>
										</SELECT>
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center;">�ꏊ�ڍ�</td>
									<td>
										<INPUT TYPE="text" style="ime-mode:active; width:100%;" NAME="place2" SIZE="20" MAXLENGTH="30">
									</td>
								</tr>
								<tr>
									<td bgcolor="#D6FFFF" style="text-align: center;">����<BR><small>(50���܂�)</small></td>
									<td>
										<TEXTAREA NAME="memo" ROWS="4" COLS="30" STYLE="width:100%; ime-mode:active;"></TEXTAREA>
									</td>
								</tr>
							</table>
							<INPUT TYPE="radio" NAME="pre" VALUE="1">�ݐ�
							<INPUT TYPE="radio" NAME="pre" VALUE="0" CHECKED>�s��<P>
							<%
							if(group_id.equals(group_no) || group_id.equals("900")){
							%>
							<center>
							<INPUT TYPE="submit" NAME="act" VALUE="�o�^" style="width:45%;">
							<INPUT TYPE="reset" VALUE="���ɖ߂�" style="width:45%;">
							</center>
						</FORM>
						<FORM ACTION="dayIn.jsp" METHOD="POST">
							<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
							<INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
							<INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
							<INPUT TYPE="hidden" NAME="s_start" VALUE="">
							<INPUT TYPE="hidden" NAME="b_start" VALUE="<%= DA %>">
							<INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
							<INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
							<INPUT TYPE="hidden" NAME="act" VALUE="">
							<center>
							<INPUT TYPE="submit" VALUE="��Ű���ޭ�ٓo�^��ʂֈړ�" STYLE="width:93%">
							</center>
						</FORM>
						<%
						}else{
						%>
						</FORM><BR>
						<%
						}
						%>
					</td>
				</tr>
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
