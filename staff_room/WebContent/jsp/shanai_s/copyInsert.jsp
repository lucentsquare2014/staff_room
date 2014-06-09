<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
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
/* �ǉ��_ */
// 02-09-13 �R�s�[�@�\�̃X�P�W���[���o�^���s��

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

/* ���͂��ꂽ�e���ڂ��p�����[�^�Ƃ��Ď擾 */
// �R�s�[�����̎��Ɏ擾�����uno�v�ɂ́A�R�s�[�ΏۂƂȂ郆�[�UID�������Ă���
String NO = strEncode(request.getParameter("no"));

// �\��t�������̎��Ɏ擾�����uno2�v�ɂ́A�\��t���ΏۂƂȂ郆�[�UID�������Ă���
String NO2 = strEncode(request.getParameter("no2"));
String DA = strEncode(request.getParameter("s_date"));
String DA2 = strEncode(request.getParameter("s_date2"));
String ST = strEncode(request.getParameter("s_start"));
String GR = strEncode(request.getParameter("group"));

String KD = strEncode(request.getParameter("kind"));

%>
<html>
<head><title>�G���[</title></head>
<body BGCOLOR="#99A5FF">
<%

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// �f�[�^�x�[�X�Ƀ��O�C�����邽�߂̏��
String user = "georgir";
String password = "georgir";

// �f�[�^�x�[�X�ɐڑ�
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// �X�e�[�g�����g�̐���
Statement stmt = con.createStatement();

// SQL���s�E�R�s�[�@�\
ResultSet SCOPY = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "'");

String cpyEND = "";
String cpyPLAN = "";
String cpyPLAN2 = "";
String cpyPLACE = "";
String cpyPLACE2 = "";
String cpyMEMO = "";
String cpyTOUROKU = "";
String cpyZAISEKI = "";

while(SCOPY.next()){
	cpyEND = SCOPY.getString("S_END");
	cpyPLAN = SCOPY.getString("S_PLAN").trim();
	if(SCOPY.getString("S_PLAN2") == null){
		cpyPLAN2 = "";
	}
	else{
		cpyPLAN2 = SCOPY.getString("S_PLAN2");
	}
	cpyPLACE = SCOPY.getString("S_PLACE").trim();
	if(SCOPY.getString("S_PLACE2") == null){
		cpyPLACE2 = "";
	}
	else{
		cpyPLACE2 = SCOPY.getString("S_PLACE2");
	}
	if(SCOPY.getString("S_MEMO") == null){
		cpyMEMO = "";
	}
	else{
		cpyMEMO = SCOPY.getString("S_MEMO");
	}
	cpyTOUROKU = Integer.toString(SCOPY.getInt("S_TOUROKU"));
	cpyZAISEKI = Integer.toString(SCOPY.getInt("S_ZAISEKI"));
}

SCOPY.close();

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
ResultSet GROUPNO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO2 + "'");

String group_no = "";

while(GROUPNO.next()){
	group_no = GROUPNO.getString("K_GRUNO");
}

GROUPNO.close();

// �d���`�F�b�N�pflag
boolean check = false;

// SQL���s
if(group_id.equals(group_no) || group_id.equals("900")){
	// �d���X�P�W���[���̃`�F�b�N
	ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + NO2 + "' AND S_DATE = '" + DA2 + "' AND (('" + ST + "' < S_START AND '" + cpyEND + "' > S_START) OR ('" + ST + "' < S_END AND '" + cpyEND + "' > S_END) OR (S_START < '"+ ST +"' and '"+ cpyEND +"' < S_END ) OR (S_START = '"+ ST +"' and S_END = '"+ cpyEND +"'))");

	while(CHECK.next()){
		check = true;
	}

	CHECK.close();

	if(!check){
		stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO2 + "','" + DA2 + "','" + ST + "','" + cpyEND + "','" + cpyPLAN + "','" + cpyPLAN2 + "','" + cpyPLACE + "','" + cpyPLACE2 + "','" + cpyMEMO + "','" + cpyTOUROKU + "','" + cpyZAISEKI + "')");
	}
	else{
	%>
	<jsp:forward page="error.jsp">
	 <jsp:param name="flag" value="4" />
	</jsp:forward>
	<%
	}
}

stmt.close();
con.close();
%>
<html>
<head>
<%
	if(KD.equals("Month")){
%>
<script>
<!--
	parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
	if(KD.equals("Week")){
%>
<script>
<!--
	parent.main.location.href = "TestExample34.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
	if(KD.equals("Day")){
%>
<script>
<!--
	parent.main.location.href = "h_hyoji.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&group=<%= GR %>";
	parent.sub02.location.href = "timeUp.jsp?id=<%= ID %>&no=<%= NO2 %>&s_date=<%= DA2 %>&s_start=<%= ST %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=";
//-->
</script>
<%
	}
%>
</body>
</html>