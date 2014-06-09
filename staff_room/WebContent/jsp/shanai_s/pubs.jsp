<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector" %>

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
/* �C���_*/
// 02-08-07 ���L�ҏ��e�[�u���́uK_�Ј�NO�v�̃f�[�^�^��ύX�������Ƃɂ��A����Ƀf�[�^��ǂݏo����悤�����B
// 02-08-27 �o�^�҂Ƌ��L�҂̕\�����A���L�҂̃X�P�W���[������͕\���o���Ȃ��������̂��C���B
// 02-09-18 ����e�X�g���ԁc�o�O����  314�s�� �����o�[���X�g�ɁA���L�҃e�[�u���֓o�^�������[�U���K���o�Ă���B
// 02-09-20 ����e�X�g���ԁc�o�O����  �t�@�C���S�� ��̃t�@�C���ŁA�\���E�ǉ��E�폜���s����
//                                    ��x�s��ꂽ���X�|���X�����x���J��Ԃ��Ă��܂��Ă���̂�
//                                    �\���t�@�C���ƒǉ��E�폜�t�@�C���ɕ�����B

/* �ǉ��_ */
// 02-08-13 �o�^�҂��X�P�W���[���ύX���s������A���L�҂̃X�P�W���[�����ύX����B
// 02-08-14 ���L�҂��X�P�W���[���ύX���s�����ꍇ���A���̑��̋��L�҂Ɠo�^�҂̃X�P�W���[����ύX����B
// 02-08-15 ���L�҂������o�[���X�g����I�����폜���s���ƁA�X�P�W���[���i���ԒP�ʁE���P�ʁj���폜����B
// 02-08-15 �o�^�҂����L�҂Ƃ��đI�΂ꂽ�ꍇ�A�G���[�Ƃ���B
// 02-09-03 include�f�B���N�e�B�u�ɂ��O���t�@�C���Ƃ��Ĉ�����B
// 02-09-18 include�A�N�V�����^�O�ɕύX���A�O���t�@�C���Ƃ��Ĉ����B

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

/* �O���[�v�R�[�h�E�O���[�v�����R���{�{�b�N�X�ɕ\�����邽�߂̏��� */
// SQL�̎��s�E�O���[�v���
ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

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

/* �ǉ����X�g�\�� �������� */
// SQL�̎��s�E�����o�[���X�g[�ǉ�]
ResultSet ADD = stmt.executeQuery("SELECT * FROM KINMU.KOJIN ORDER BY K_PASS2, K_�Ј�NO");

// hitList�̍쐬
Vector hitKOID = new Vector();
Vector hitKONAME = new Vector();
Vector hitKOGRUNO = new Vector();

while(ADD.next()){
  String id = strEncode(ADD.getString("K_ID"));
  String name = ADD.getString("K_����");
  String gco = strEncode(ADD.getString("K_GRUNO"));
  hitKOID.addElement(id.trim());
  hitKONAME.addElement(name.trim());
  hitKOGRUNO.addElement(gco);
}

int cntADD = hitKOID.size();

ADD.close();
/* �ǉ����X�g�\�� �����܂� */

/* �폜���X�g�\�� �������� */
// SQL�̎��s�E�����o�[���X�g[�폜]
//ResultSet DEL = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND KY_TABLE.S_DATE = '" + DA + "' AND KY_TABLE.S_START = '" + ST + "' AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' )) OR (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' ) AND KY_TABLE.KY_FLAG = '0') OR (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND KY_TABLE.B_START = '" + BS + "' AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' ))");
ResultSet DEL = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND to_char(KY_TABLE.S_DATE,'YYMMDD') =  '" + DA + "'  AND KY_TABLE.S_START = '" + ST + "' AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' )) OR (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' ) AND KY_TABLE.KY_FLAG = '0') OR (KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND to_char(KY_TABLE.B_START,'YYMMDD') = '" + BS + "' AND (K_�Ј�NO2 = '" + ID + "' OR K_�Ј�NO2 = '" + NO + "' ))");


Vector hitKYID = new Vector();
Vector hitKYNAME = new Vector();

while(DEL.next()){
  String id = strEncode(DEL.getString("K_�Ј�NO"));
  String name = DEL.getString("K_����");
  hitKYID.addElement(id);
  hitKYNAME.addElement(name);
}

int cntDEL = hitKYID.size();

DEL.close();
/* �폜���X�g�\�� �����܂� */

/* �o�^�ҕ\�� �������� */
// SQL�̎��s�E�o�^�ҕ\��
//ResultSet KOJIN = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_�Ј�NO2 = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "'))");
ResultSet KOJIN = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_�Ј�NO2 = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((to_char(S_DATE,'YYMMDD') = '" + DA + "' AND S_START = '" + ST + "') OR (to_char(KY_TABLE.B_START,'YYMMDD') = '" + BS + "'))");

// �o�^�҂̎Ј��ԍ��Ɩ��O���i�[���܂�
String koName = "";

// �l���e�[�u���ɃA�N�Z�X
while(KOJIN.next()){
	koName = KOJIN.getString("K_����");
}

KOJIN.close();
/* �o�^�ҕ\�� �����܂� */

/* ���L�ҕ\�� �������� */
// SQL�̎��s�E���L�ҕ\��
//ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((KY_TABLE.S_DATE = '" + DA + "' AND KY_TABLE.S_START = '" + ST + "') OR (KY_TABLE.B_START = '" + BS + "'))");
ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE,KINMU.KOJIN WHERE KY_TABLE.K_�Ј�NO = KINMU.KOJIN.K_ID AND KY_FLAG = '1' AND ((to_char(KY_TABLE.S_DATE,'YYMMDD') = '" + DA + "' AND KY_TABLE.S_START = '" + ST + "') OR (to_char(KY_TABLE.B_START,'YYMMDD') = '" + BS + "'))");

Vector hitKYOYU = new Vector();

// ���L�҃e�[�u���ɃA�N�Z�X
while(KYOYU.next()){
	String name = KYOYU.getString("K_����");
	hitKYOYU.addElement(name.trim());
}

int cntKYOYU = hitKYOYU.size();

KYOYU.close();
/* ���L�ҕ\�� �����܂� */

%>
<script language="JavaScript">
<!--
var bwtype2 = (document.all) ? 0 : (document.layers) ? 1 : 2;
var move2 = 235;
var ckck2 = 1;
var divobj2;

function movemn2(){
  if(!ckck2){
	tid = setTimeout('realmnm1()', 10);
	ckck1 = 0;
	tid = setTimeout('realmnp2()', 10);
	ckck2 = 1;
  }
  else{
	tid = setTimeout('realmnp1()', 10);
	ckck1 = 1;
	tid = setTimeout('realmnm2()', 10);
	ckck2 = 0;
  }
  return false;
}
function realmnp2(){
  divobj2.left = move2;
  if(move2 < 235){
    setTimeout('realmnp2()', 10);
  }
  move2 = move2 + 5;
}
function realmnm2(){
  divobj2.left = move2;
  if(move2 > 0){
    setTimeout('realmnm2()', 10);
  }
  move2 = move2 - 5;
}
//-->
</script>

<div id="divmenu2" style="position:absolute;visibility:visible;z-index:1;">
<table bgcolor="#99A5FF" border="1" width="235" height="604" cellpadding="0" cellspacing="0">
 <tr>
  <td bgcolor="#ffffff" width="20" rowspan="2">
   <center><a href="#" onClick="return movemn2();" STYLE="text-decoration:none"><b>��<p><font size="2">��<br>�L<br>��<br>�o<br>�^<br>��<br>��</font></p>��</b></a></center>
  </td>
  <td bgcolor="#99A5FF" height="604" width="90%" colspan="2"><br><br>
  <TABLE BORDER="1" WIDTH="100%">
   <TR>
    <TD BGCOLOR="#D6FFFF" WIDTH="30%">�o�^��</TD>
<%
if(koName.equals("")){
	%><TD><BR></TD><%
}
else{
	%><TD COLSPAN="<%= cntKYOYU %>"><font size="2"><%= koName %></font></TD><%
}
%>
   </TR>
   <TR>
    <TD BGCOLOR="#D6FFFF" ROWSPAN="<%= cntKYOYU %>">���L��</TD>
<%
if(cntKYOYU != 0){
	for(int i = 0; i < cntKYOYU; i++){
		%><TD><font size="2"><%= hitKYOYU.elementAt(i) %></font></TD></TR><%
	}
}
else{
	%>
	<TD><BR></TD>
	<%
}
%>
   
  </TABLE>
  <P>
  <TABLE BORDER="1" width="100%">
   <TR>
   <FORM ACTION="pubsInsert.jsp" METHOD="get">
    <TD BGCOLOR="#D6FFFF" style="width:70%;">�O���[�v�R�[�h</TD>
    <TD ALIGN="center">
    <INPUT TYPE="submit" VALUE="�\��"></TD>
   </TR>
   <TR>
    <TD colspan="2">
     <SELECT NAME="group" STYLE= "width:100%;">
     <OPTION VALUE=""></OPTION>
<%
int j = -1;
for(int i = 0; i < cntGRU; i++){
  if(hitGRUNUM.elementAt(i).equals(GR)){
    j = i;
  }
}
for(int i = 0; i < cntGRU; i++){
  if(i == j){
    %><OPTION VALUE="<%= hitGRUNUM.elementAt(i) %>" SELECTED><%= hitGRUNUAM.elementAt(i) %></OPTION><%
  }
  else{
    %><OPTION VALUE="<%= hitGRUNUM.elementAt(i) %>"><%= hitGRUNUAM.elementAt(i) %></OPTION><%
  }
}
%>
   </SELECT>
   <INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
   <INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
   <INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
   <INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
   <INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
   <INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
   <INPUT TYPE="hidden" NAME="act" VALUE="<%= AC %>">
  </TD>
  
 </TR>
 <TR>
  
  <TD valign="top">
   <SELECT SIZE="5" NAME="add" MULTIPLE STYLE="WIDTH:100%; height:120;">
<%
if(GR != null){
  for(int i = 0; i < cntADD; i++){
    if(hitKOGRUNO.elementAt(i).equals(GR)){
      %><OPTION VALUE="<%= hitKOID.elementAt(i) %>"><%= hitKONAME.elementAt(i) %></OPTION><%
    }
  }
}
else{
  %><OPTION VALUE=""></OPTION><%
}
%>
   </SELECT>
   <INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
   <INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
   <INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
   <INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
   <INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
   <INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
   <INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
  </TD>
  <TD ALIGN="center" VALIGN="middle">
   <INPUT TYPE="submit" NAME="act" VALUE="�ǉ�">
  </TD>
  </FORM>
 </TR>
</TABLE>
<p>
<TABLE BORDER="1" WIDTH="100%">
 <TR>
  <TD BGCOLOR="#D6FFFF" COLSPAN="2">
   �����o�[���X�g
  </TD>
 </TR>
 <TR>
  <FORM ACTION="pubsInsert.jsp" METHOD="get">
  <TD valign="top" STYLE="WIDTH:70%";>
    <SELECT SIZE="5" NAME="del" MULTIPLE STYLE="WIDTH:100%; HEIGHT:120;">
<%
for(int i = 0; i < cntDEL; i++){
  %><OPTION VALUE="<%= hitKYID.elementAt(i) %>"><%= hitKYNAME.elementAt(i) %></OPTION><%
}
%>
    </SELECT>
    <INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
    <INPUT TYPE="hidden" NAME="no" VALUE="<%= NO %>">
    <INPUT TYPE="hidden" NAME="s_date" VALUE="<%= DA %>">
    <INPUT TYPE="hidden" NAME="s_start" VALUE="<%= ST %>">
    <INPUT TYPE="hidden" NAME="b_start" VALUE="<%= BS %>">
    <INPUT TYPE="hidden" NAME="group" VALUE="<%= GR %>">
    <INPUT TYPE="hidden" NAME="kind" VALUE="<%= KD %>">
   </TD>
   <TD ALIGN="center">
    <INPUT TYPE="submit" NAME="act" VALUE="�폜">
   </TD>
  </FORM>
 </TR>
</TABLE>
</div>
<script language="JavaScript">
<!--
  if(bwtype2 == 0){
    divobj2 = document.all.divmenu2.style;
  }
  if(bwtype2 == 1){
    divobj2 = document.divmenu2;
  }
  if(bwtype2 == 2){
    divobj2 = document.getElementById("divmenu2").style;
  }
  divobj2.left = 235;
  divobj2.top  = 0;
//-->
</script>
