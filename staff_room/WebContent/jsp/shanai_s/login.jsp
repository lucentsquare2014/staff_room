<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*" %>
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
// ���͂��ꂽ���[�UID��String�ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));
// ���͂��ꂽ�p�X���[�h��String�ϐ�[PASS]�Ɋi�[
String PASS = strEncode(request.getParameter("pass"));
// ����
boolean flag = false;

// JDBC�h���C�o�̃��[�horg.postgresql.Driver
Class.forName("org.postgresql.Driver");

// �f�[�^�x�[�X�֐ڑ�
String user = "georgir";     // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃��[�U��
String password = "georgir"; // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃p�X���[�h
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);

// SQL���s
Statement stmt = con.createStatement();
Statement upDate = con.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "' AND K_PASS = '" + PASS + "'");

// ���ʎ擾
if(rs.next()){
	flag = true;
}
int pe_sche = 0;
String strSche = "";
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
GregorianCalendar cal = new GregorianCalendar();

if(flag){
	//�X�P�W���[���̍폜
	ResultSet rs2 = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_�Ј�NO = '"+ ID +"'");
	while(rs2.next()){
		strSche = strEncode(rs2.getString("PE_SCHEDULE"));
		if(strSche != null){
			pe_sche = Integer.parseInt(strSche);
				if(pe_sche == 1){
					pe_sche = 3;
				}else if(pe_sche == 2){
					pe_sche = 6;
				}else if(pe_sche == 3){
					pe_sche = 12;
				}else if(pe_sche == 4){
					pe_sche = 24;
				}else if(pe_sche == 5){
					pe_sche = 36;
				}else if(pe_sche == 0){
					pe_sche = 1;
				}
			cal.add(Calendar.MONTH, - pe_sche);
			Date today = cal.getTime();
			upDate.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '"+ ID +"' AND S_DATE <= '"+ sFmt.format(today) +"'");
			upDate.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '"+ ID +"' AND B_END <= '"+ sFmt.format(today) +"'");
		}
	}
	rs2.close();
	%>
	<jsp:forward page="menu.jsp">
	<jsp:param name="id" value="<%= ID %>" />
	</jsp:forward>
	<%
}
else{
	%>
	<jsp:forward page="error.jsp">
	 <jsp:param name="flag" value="0" />
	</jsp:forward>
	<%
}
// �ڑ�����
rs.close();
stmt.close();
con.close();
%>
