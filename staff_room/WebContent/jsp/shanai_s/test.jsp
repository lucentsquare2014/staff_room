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
long o_start = 0;
long o_stop = 0;
long i_start = 0;
long i_stop = 0;
long diff = 0;
long diff2 = 0;
long diff3 = 0;

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// �f�[�^�x�[�X�֐ڑ�
String user = "georgir";     // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃��[�U��
String password = "georgir"; // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃p�X���[�h

o_start = System.currentTimeMillis();
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
o_stop = System.currentTimeMillis();

Statement stmt = con.createStatement();

i_start = System.currentTimeMillis();
ResultSet rs = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = 'yuk-suzuki' AND K_PASS = 'yuk-suzuki'");
i_stop = System.currentTimeMillis();

DatabaseMetaData meta = con.getMetaData();
System.out.println("JDBC Driver Version = " + meta.getDriverVersion()); 
	%>
	<html>
		<body>
			<div>aaa</div>
	<%
// �ڑ�����
rs.close();
stmt.close();
con.close();

diff = o_stop - o_start;
diff2 = i_stop - i_start;
diff3 = i_stop - o_start;
%>
<div>connection _ time : <%= diff %></div>
<div>sql _ time : <%= diff2 %></div>
<div>all _ time : <%= diff3 %></div>

		</body>
	</html>
