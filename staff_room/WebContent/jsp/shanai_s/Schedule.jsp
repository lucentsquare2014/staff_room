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
// 02-08-12 �\���`�����l�ݒ�őI���������[�U�́A���̏���ǂݏo���ŗD��Ƃ���
// 02-09-04 �p�����[�^�̒ǉ�
// 02-09-18 ����e�X�g���ԁc�o�O����   48�s�ځ`58�s�� �O���[�v�R�[�h�̒��o����e�[�u�������L�q�ԈႢ�B
// 02-10-01 �o�O����  
	
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
	Statement stmt = con.createStatement();
	
	// SQL�̎��s
	// �I�����ꂽ�Ј��ԍ��ƈ�v����l�ݒ�������o��SQL
	ResultSet rs_pe = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_�Ј�NO = '" + ID + "'");
	
	String pe_st = "";
	
	while(rs_pe.next()){
		pe_st = rs_pe.getString("PE_START");
	}
	
	rs_pe.close();
	
	boolean flag = false;
	
	// SQL���s�E�O���[�v���[�l�ݒ�ōs�����O���[�v�𒊏o]
	ResultSet GROUPID = stmt.executeQuery("SELECT * FROM PE_TABLE WHERE K_�Ј�NO = '" + ID + "'");
	
	// ���������s���Ă���
	String group_id = "";
	
	while(GROUPID.next()){
		flag = true;
		group_id = GROUPID.getString("PE_GRUNO");
	}
	
	GROUPID.close();
	
	if(!flag){
		ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");
		
		while(GROUP.next()){
			group_id = GROUP.getString("K_GRUNO");
		}
		
		GROUP.close();
	}
	
	if(pe_st.equals("1")){
		%>
		<jsp:forward page="Schedule-Month.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Month" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("2")){
		%>
		<jsp:forward page="Schedule-Week.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Week" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("3")){
		%>
		<jsp:forward page="Schedule-Day.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Day" />
		</jsp:forward>
		<%
	}
	else if(pe_st.equals("")){
	// �I������Ă��Ȃ��ꍇ�́A���\�����s���B
		%>
		<jsp:forward page="Schedule-Month.jsp">
			<jsp:param name="id" value="<%= ID %>" />
			<jsp:param name="group" value="<%= group_id %>" />
			<jsp:param name="kind" value="Month" />
		</jsp:forward>
		<%
	}

con.close();
stmt.close();
%>
