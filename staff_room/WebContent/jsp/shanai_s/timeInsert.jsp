<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%!
public String strEncode(String strVal)
throws UnsupportedEncodingException{
	if(strVal==null){
		return(null);
	}else{
		return(new String(strVal.getBytes("8859_1"),"Shift_JIS"));
	}
}
%>
<%
/* �C���_ */
// 02-08-05 ���E�T�E���ƃt�@�C���𕪂��Ă������̂����������A�t���O�ɂ���ď����𕪂�����@
// 02-08-15 �]�v�ȃv���O�������Ȃ�
// 02-09-03 �o�^�����I����A�ēǂݍ��݂��邽�߂̃v���O�������C���B
// 02-09-24 �o�O�����c  180�s�� SQL���Ŏg�p���Ă������[�UID�ϐ����Ԉ���Ă����B
// 02-10-10 �o�O�����c  132�s��/169�s�� �d���`�F�b�N�������C���B�I���������Ȃ��B

/* �ǉ��_ */
// 02-08-13 ���L�҉�ʂőI�����ꂽ�����o�[�ɓo�^�҂Ɠ����X�P�W���[�����ꊇ�o�^���鏈��

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// [timeIn]�œ��͂��ꂽ�e���ڂ��p�����[�^�Ƃ��Ď擾
String NO = request.getParameter("no");
String DA = request.getParameter("s_date");
String GR = request.getParameter("group");


//���t�`�F�b�N�p�ϐ�
//�N�����ɕ���
int DAy=2000;	//�Ƃ肠����
int DAm=11;		//�G���[��ʉ߂���
int DAd=11;		//�l��ϐ��ɓ���Ă���
boolean Uru = false;//���邤�N�Ȃ�true��
if(DA != ""){
	DAy = Integer.parseInt(DA.substring(0,4));  // �N
	DAm = Integer.parseInt(DA.substring(5,7));  // ��
	DAd = Integer.parseInt(DA.substring(8,10)); // ��
	if((DAy % 4) == 0){
		Uru = true;
	}
}
// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = request.getParameter("kind");

// �J�n���Ăяo��
String SH = request.getParameter("starth");
// �J�n���̎擾�ƌ���
String SM1 = request.getParameter("startm1");
String SM2 = request.getParameter("startm2");
String SM  = SM1 + SM2;
// �J�n�����̌��� ��F0900
String start = SH + SM;

// �I�����Ăяo��
String EH = request.getParameter("endh");
// �I�����̎擾�ƌ���
String EM1 = request.getParameter("endm1");
String EM2 = request.getParameter("endm2");
String EM  = EM1 + EM2;
// �I�������̌��� ��F1730
String end = EH + EM;

String plan = strEncode(request.getParameter("plan"));
String plan2 = strEncode(request.getParameter("plan2"));
String place = strEncode(request.getParameter("place"));
String place2 = strEncode(request.getParameter("place2"));
String memo = strEncode(request.getParameter("memo"));
String pre = request.getParameter("pre");
String act = strEncode(request.getParameter("act"));
%>
<html>
<head><title>�G���[</title></head>
<body BGCOLOR="#99A5FF">
<%
	if(ID.equals("")){
		out.println("���[�U�h�c������܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(NO.equals("")){
		out.println("�I�����ꂽ���[�U�h�c������܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(DA.equals("")){
		out.println("���t������܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(DAm<1 || DAm>12){
		out.println("���t����(��)�Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(DAd<1 || DAd>31){
		out.println("���t����(��)�Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((DAm == 4 && DAd == 31) || (DAm == 6 && DAd == 31) || (DAm == 9 && DAd == 31) || (DAm == 11 && DAd == 31)){
		out.println("���t����(��)�Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((DAm == 2 && DAd > 28 && Uru == false) || (DAm == 2 && DAd > 29 && Uru == true)){
		out.println("���t����(��)�Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(SH.equals("") || SM.equals("")){
		out.println("�v���O�����T�C�h�G���[�F�J�n���������͂���Ă��܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(EH.equals("") || EM.equals("")){
		out.println("�v���O�����T�C�h�G���[�F�I�����������͂���Ă��܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(Integer.parseInt(SH)<0 || Integer.parseInt(SH)>23 || Integer.parseInt(SM)<0 || Integer.parseInt(SM)>59){
		out.println("�v���O�����T�C�h�G���[�F�J�n�������͂��s���ł��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(Integer.parseInt(EH)<0 || Integer.parseInt(EH)>23 || Integer.parseInt(EM)<0 || Integer.parseInt(EM)>59){
		out.println("�v���O�����T�C�h�G���[�F�I���������͂��s���ł��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(plan.equals("")){
		out.println("�\�肪�I������Ă܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(memo.length() > 50){
		out.println("�������𒴂��Ă��܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(Integer.parseInt(start) > Integer.parseInt(end)){
		out.println("�J�n�������I�����������傫���ł��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(Integer.parseInt(start) == Integer.parseInt(end)){
		out.println("�J�n�����ƏI�������������ł��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else{
		// JDBC�h���C�o�̃��[�h
		Class.forName("org.postgresql.Driver");
		
		// �f�[�^�x�[�X�Ƀ��O�C�����邽�߂̏��
		String user = "georgir";
		String password = "georgir";
		
		// �f�[�^�x�[�X�ɐڑ�
		Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);
		
		// �X�e�[�g�����g�̐���
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();
		
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
		
		// �d���`�F�b�N�pflag
		boolean check = false;
		// ���L�ҏd���`�F�b�N�pflag
		boolean ky_check = false;
		
		String Blendy = "";
		
		// SQL���s
		if(act.equals("�o�^") && (group_id.equals(group_no) || group_id.equals("900"))){
			if(ID.equals(NO)){//���O�C�������l�Ɠo�^�҂��ꏏ�̏ꍇ
				// �X�P�W���[���̏d���`�F�b�N
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				
				while(CHECK.next()){
					check = true;
				}
				CHECK.close();
				
				// ���L�҃X�P�W���[���̏d���`�F�b�N
				ResultSet GOGOTea = stmt.executeQuery("SELECT K_�Ј�NO FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + ID + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_�Ј�NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + Blendy + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
					KY_CHECK.close();
				}
				GOGOTea.close();
				
				if(!check){
				if(!ky_check){
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + ID + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");
					
					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DA + "', S_START = '" + start + "', KY_FLAG = '1' WHERE K_�Ј�NO2 = '" + ID + "' AND KY_FLAG = '0'");
					
					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DA + "' AND S_START = '" + start + "' AND K_�Ј�NO2 = '" + ID + "'");
					
					// hitList�̍쐬
					Vector hitKYOYU = new Vector();
					
					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
						hitKYOYU.addElement(seId);
					}
					
					int hitCnt = hitKYOYU.size();
					
					for(int i = 0; i < hitCnt; i++){
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}
					
					KYOYU.close();
					/* �����܂� */
				}}
			}else{//�o�^�҂����O�C�������l�ƕʂ̐l
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				
				while(CHECK.next()){
					check = true;
				}
				CHECK.close();
				
				// ���L�҃X�P�W���[���̏d���`�F�b�N
				ResultSet GOGOTea = stmt.executeQuery("SELECT K_�Ј�NO FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + NO + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_�Ј�NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + Blendy + "' AND S_DATE = '" + DA + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
					KY_CHECK.close();
				}
				GOGOTea.close();
				
				if(!check){
				if(!ky_check){
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");
					
					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DA + "', S_START = '" + start + "', KY_FLAG = '1' WHERE K_�Ј�NO2 = '" + NO + "' AND KY_FLAG = '0'");
					
					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DA + "' AND S_START = '" + start + "' AND K_�Ј�NO2 = '" + NO + "'");
					
					// hitList�̍쐬
					Vector hitKYOYU = new Vector();
					
					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
						hitKYOYU.addElement(seId);
					}
					
					int hitCnt = hitKYOYU.size();
					
					for(int i = 0; i < hitCnt; i++){
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DA + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}
					
					KYOYU.close();
					/* �����܂� */
				}}
			}
		}
		else{
			%>
			<jsp:forward page="error.jsp">
			 <jsp:param name="id" value="<%= ID %>" />
			 <jsp:param name="no" value="<%= NO %>" />
			 <jsp:param name="flag" value="3" />
			</jsp:forward>
			<%
		}
		
		// �ڑ�����
		stmt.close();
		con.close();

		if(check){
			out.println("�X�P�W���[�����d�����Ă��܂��B<BR>");
			out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
		}else if(ky_check){
			out.println("���L�҂̃X�P�W���[�����d�����Ă��܂��B<BR>");
			out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
		}else{
			if(KD.equals("Month")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
				<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- �ړ��֎~ -->
				</SCRIPT>
				<%
			}else if(KD.equals("Week")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
				<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- �ړ��֎~ -->
				</SCRIPT>
				<%
			}else if(KD.equals("Day")){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
				<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD + "-u" %>&act=';
				// -->
<!-- �ړ��֎~ -->
				</SCRIPT>
				<%
			}else{
				%>
				<jsp:forward page="error.jsp">
				 <jsp:param name="flag" value="0" />
				</jsp:forward>
				<%
			}
		}
	}
%>
</body>
</html>
