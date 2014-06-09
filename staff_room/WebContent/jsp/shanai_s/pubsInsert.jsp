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
/* �C���_ */
// 06-06-14 �폜�{�^�����������ۂɁA���L�҂���Ȃ��l�̗\����A�폜���Ă��܂����Ƃ�����̂��C��
// 02-09-20 ���L�҂̒ǉ��E�폜���s���t�@�C���Ƃ��č쐬

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

%>
<html>
<head><title>�G���[</title></head>
<body BGCOLOR="#99A5FF">
<%

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

/* �ǉ����X�g���� �������� */

// �d���`�F�b�N�pflag
boolean check = false;

// ���L�҂̍폜�ƃX�P�W���[���̍폜���s��ꂽ���ɐ؂�ւ��flag
boolean MWD = false;

if(AC.equals("�ǉ�") && (group_id.equals(group_no) || group_id.equals("900"))){
	String[] addlist = request.getParameterValues("add");
	if(ID.equals(NO)){
		if((addlist != null) && (addlist[0].length() != 0)){
			for(int i = 0; i < addlist.length; i++){
				// �I�����ꂽ���ڂɖ{�l���܂܂�Ă�����A�G���[�Ƃ���B
				if(addlist[i].equals(ID)){
					%>
					<jsp:forward page="error.jsp">
					<jsp:param name="flag" value="2" />
					</jsp:forward>
					<%
				}else{
					// �d���`�F�b�N�pSQL�̎��s
					ResultSet CHECK = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + addlist[i] + "' AND K_�Ј�NO2 = '" + ID + "' AND KY_FLAG = '0'");
					
					while(CHECK.next()){
						check = true;
					}
					
					CHECK.close();
					
					if(!check){
						stmt.execute("INSERT INTO KY_TABLE(K_�Ј�NO,K_�Ј�NO2,KY_FLAG) VALUES('" + addlist[i] + "','" + ID + "','0')");
					}
				}
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}else{
		if((addlist != null) && (addlist[0].length() != 0)){
			for(int i = 0; i < addlist.length; i++){
				// �I�����ꂽ���ڂɖ{�l���܂܂�Ă�����A�G���[�Ƃ���B
				if(addlist[i].equals(NO)){
					%>
					<jsp:forward page="error.jsp">
					<jsp:param name="flag" value="2" />
					</jsp:forward>
					<%
				}else{
					// �d���`�F�b�N�pSQL�̎��s
					ResultSet CHECK = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + addlist[i] + "' AND K_�Ј�NO2 = '" + NO + "' AND KY_FLAG = '0'");
					
					while(CHECK.next()){
						check = true;
					}
					
					CHECK.close();
					
					if(!check){
						stmt.execute("INSERT INTO KY_TABLE(K_�Ј�NO,K_�Ј�NO2,KY_FLAG) VALUES('" + addlist[i] + "','" + NO + "','0')");
					}
				}
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}
	if(KD.equals("Month")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Month-u")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Month-b")){
		%>
		<script>
		<!--
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week-u")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week-b")){
		%>
		<script>
		<!--
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day-u")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day-b")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}
}
/* �ǉ����X�g���� �����܂� */

/* �폜���X�g���� �������� */
else if(AC.equals("�폜") && (group_id.equals(group_no) || group_id.equals("900"))){
	String[] dellist = request.getParameterValues("del");
	if(ID.equals(NO)){
		if((dellist != null) && (dellist[0].length() != 0)){
			for(int i = 0; i < dellist.length; i++){
				stmt.execute("DELETE FROM KY_TABLE WHERE (K_�Ј�NO = '" + dellist[i] + "' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "')) AND KY_FLAG = '1') OR (K_�Ј�NO = '" + dellist[i] + "' AND KY_FLAG = '0')");
				if(!ST.equals("")){
					MWD = true;
					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + dellist[i] + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "' AND S_TOUROKU = '0' ");
				}else if(!BS.equals("")){
					MWD = true;
					stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + dellist[i] + "' AND B_START = '" + BS + "' AND B_TOUROKU = '0' ");
				}
			}
			if(MWD && KD.equals("Month")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-u")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-b")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-u")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-b")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-u")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-b")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}else{
		if((dellist != null) && (dellist[0].length() != 0)){
			for(int i = 0; i < dellist.length; i++){
				stmt.execute("DELETE FROM KY_TABLE WHERE (K_�Ј�NO = '" + dellist[i] + "' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "')) AND KY_FLAG = '1') OR (K_�Ј�NO = '" + dellist[i] + "' AND KY_FLAG = '0')");
				if(!ST.equals("")){
					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + dellist[i] + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "' AND S_TOUROKU = '0' ");
				}else if(!BS.equals("")){
					stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + dellist[i] + "' AND B_START = '" + BS + "' AND B_TOUROKU = '0' ");
				}
			}
			if(MWD && KD.equals("Month")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-u")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-b")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-u")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-b")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-u")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-b")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}
}
/* �폜���X�g���� �����܂� */

else{
	%>
	<jsp:forward page="error.jsp">
	<jsp:param name="flag" value="5" />
	</jsp:forward>
	<%
}

if(check){
	%>
	<jsp:forward page="error.jsp">
	<jsp:param name="flag" value="1" />
	</jsp:forward>
	<%
}

if(KD.equals("Month")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Month-u")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Month-b")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week-u")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week-b")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day-u")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day-b")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}
%>
</body>
</html>