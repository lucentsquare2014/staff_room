<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%!
public String strEncode(String strVal)
        throws UnsupportedEncodingException{
        if(strVal==null){
                 return(null);
         }
         else{
                 return(new String(strVal.getBytes("8859_1"),"Shift_JIS"));
         }
}
%>
<%
/* �C���_ */
// 02-08-05 ���E�T�E���ƃt�@�C���𕪂��Ă������̂����������A�t���O�ɂ���ď����𕪂�����@
// 02-08-13 �폜�����́A���L���ꂽ�X�P�W���[���ł��ʂɍs����
// 02-08-15 �X�P�W���[���ύX���s�����ۂɁA���L�҂𑝂₷�ƋN����o�O���C�����܂���
// 02-08-15 �]�v�ȃv���O�������Ȃ�
// 02-09-03 �o�^�����I����A�ēǂݍ��݂��邽�߂̃v���O�������C���B
// 02-09-18 ����e�X�g���ԁc�o�O����            33�s��/34�s�� ���t�ϐ��̋L�q�ԈႢ�B�ǂ��炪����������̂Ȃ̂��A�͂�����Ƌ�ʂ��Ȃ������B
// 02-09-18 ����e�X�g���ԁc�o�O����  433�s��/459�s��/485�s�� �폜���s�����ۂ̃��_�C���N�g�����ŁA�\���`���̋�ʂ�����ϐ��̕�����ԈႢ�B
// 02-09-18 ����e�X�g���ԁc�o�O����         355�s��?395�s�� �o�^�҂����L�X�P�W���[���̍폜���s�����ۂɁA���L�҃e�[�u���̏����폜����悤�C���B
// 02-09-18 ����e�X�g���ԁc�o�O����  238�s��/283�s��/336�s�� ���L�X�P�W���[���̃����o�[���A�V���Ƀ����o�[�𑝂₵���ۂɁA���f����Ȃ��B
// 02-09-24 �o�O�����c      377�s��?378�s��/400�s��?401�s�� ���L�҂��X�P�W���[���̍폜���s�������ɁA���L�ҏ��[KY_TABLE]�̏����폜���Ă��Ȃ������B
// 02-10-10 �o�O�����c  160�s��/259�s�� �d���`�F�b�N�������C���B�I���������Ȃ��B

/* �ǉ��_ */
// 02-08-13 ���L�҉�ʂőI�����ꂽ�����o�[�ɓo�^�҂Ɠ����X�P�W���[�����ꊇ�ύX���鏈��

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// [timeUp]�œ��͂��ꂽ�e���ڂ��p�����[�^�Ƃ��Ď擾
String NO = request.getParameter("no");

// ����͂ɂ��ύX�̋��ꂪ����̂ŁA���t�ϐ����擾����B
String DAold = request.getParameter("s_date1");
String DAnew = request.getParameter("s_date2");

//���t�`�F�b�N�p�ϐ�
//�N�����ɕ���
int DAy=2000;	//�Ƃ肠����
int DAm=11;		//�G���[��ʉ߂���
int DAd=11;		//�l��ϐ��ɓ���Ă���
boolean Uru = false;//���邤�N�Ȃ�true��
if(DAold != ""){
	DAy = Integer.parseInt(DAold.substring(0,4));  // �N
	DAm = Integer.parseInt(DAold.substring(5,7));  // ��
	DAd = Integer.parseInt(DAold.substring(8,10)); // ��
	if((DAy % 4) == 0){
		Uru = true;
	}
}

String ST = request.getParameter("s_start");
String GR = request.getParameter("group");

// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = request.getParameter("kind");

// �폜���s�����ۂɁA��ʂ�V�K�ɐݒ肷�邽�߁B
int KDend = KD.indexOf("-");
String KDs = KD.substring(0,KDend);

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
<head><title></title></head>
<body BGCOLOR="#99A5FF">
<%
if(ID.equals("")){
	out.println("���[�U�h�c������܂���B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(NO.equals("")){
	out.println("�I�����ꂽ���[�U�h�c������܂���B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(DAold.equals("")){
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
}else if(DAnew.equals("")){
	out.println("�v���O�����T�C�h�G���[�F���t������܂���B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(ST.equals("")){
	out.println("�v���O�����T�C�h�G���[�F�J�n����������܂���B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(Integer.parseInt(SH)<0 || Integer.parseInt(SH)>23){
	out.println("�J�n�������͂��s���ł��B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(Integer.parseInt(SM)<0 || Integer.parseInt(SM)>59){
	out.println("�J�n�������͂��s���ł��B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(Integer.parseInt(EH)<0 || Integer.parseInt(EH)>23){
	out.println("�I���������͂��s���ł��B");
	out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
}else if(Integer.parseInt(EM)<0 || Integer.parseInt(EM)>59){
	out.println("�I���������͂��s���ł��B");
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

	// �ύX�����ƍ폜��������ʂ���flag
	boolean UorD = false;

	String Blendy = "";

	if(act.equals("�ύX") && (group_id.equals(group_no) || group_id.equals("900"))){
		// SQL���s�E�X�V
		// �v���C�}���L�[�ɑI�΂�Ă��鍀�ڂɍX�V�����鎖�͏o���Ȃ��̂ŁA
		// ���̂悤�ȏ������Ƃ�܂����B�u�I�����R�[�h�v���u�폜�v���u�}���v
		if(ID.equals(NO)){
			// �d���X�P�W���[���̃`�F�b�N
			ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_END = '" + end + "'  AND S_PLAN = '" + plan + "' AND S_PLAN2 = '" + plan2 + "' AND S_PLACE = '" + place + "' AND S_PLACE2 = '" + place2 + "' AND S_MEMO = '" + memo + "' AND S_ZAISEKI = '" + pre + "' ");

			while(CHECK.next()){
				check = true;
			}

			CHECK.close();

			// ���L�҃X�P�W���[���̏d���`�F�b�N
			ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + ID + "'");
			while(GOGOTea.next()){
				Blendy = GOGOTea.getString("K_�Ј�NO");
				ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + Blendy + "' AND S_DATE = '" + DAold + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				while(KY_CHECK.next()){
					ky_check = true;
				}
				KY_CHECK.close();
			}
			GOGOTea.close();

			// �o�^�҂����L�҂��`�F�b�N
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(!check && !ky_check){
				if(FG.equals("0")){
					// �o�^�҂ł��B

					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + ID + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					//stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + ID + "') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + ID + "')");

					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					// ���L�҂�ID���擾���܂��B
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAnew + "' AND S_START = '" + start + "' AND K_�Ј�NO2 = '" + ID + "'");

					// hitList�̍쐬
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					for(int i = 0; i < cntKYOYU; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* �����܂� */
				}else{
					// ���L�҂ł��B

					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					// �o�^�҂�ID���擾���܂��B
					ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");

					String toId = "";

					while(TOUROKU.next()){
						toId = TOUROKU.getString("K_�Ј�NO2");
					}

					TOUROKU.close();

					// ���L�҂�ID���擾���܂��B
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_�Ј�NO2 = '" + toId + "'");

					// hitList�̍쐬
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + toId + "') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + toId + "')");

					// �o�^�҂̏����X�V
					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + toId + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + toId + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					for(int i = 0; i < cntKYOYU; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* �����܂� */
				}
			}
		}else{
			// �d���X�P�W���[���̃`�F�b�N
			ResultSet CHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_END = '" + end + "'  AND S_PLAN = '" + plan + "' AND S_PLAN2 = '" + plan2 + "' AND S_PLACE = '" + place + "' AND S_PLACE2 = '" + place2 + "' AND S_MEMO = '" + memo + "' AND S_ZAISEKI = '" + pre + "' ");

			while(CHECK.next()){
				check = true;
			}

			CHECK.close();

			// ���L�҃X�P�W���[���̏d���`�F�b�N
			ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + NO + "'");
			while(GOGOTea.next()){
				Blendy = GOGOTea.getString("K_�Ј�NO");
				ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + Blendy + "' AND S_DATE = '" + DAold + "' AND (('" + start + "' <= S_START AND '" + end + "' > S_START) OR ('" + start + "' < S_END AND '" + end + "' >= S_END) OR (S_START <= '"+ start +"' and '"+ end +"' <= S_END ))");
				while(KY_CHECK.next()){
					ky_check = true;
				}
			KY_CHECK.close();
			}
			GOGOTea.close();

			// �o�^�҂����L�҂��`�F�b�N
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(!check && !ky_check){
				if(FG.equals("0")){
					// �{�l�ł͂Ȃ��ł����A�o�^�҂ł��B

					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + NO + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + NO + "') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + NO + "')");

					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAnew + "' AND S_START = '" + start + "' AND K_�Ј�NO2 = '" + NO + "'");

					// hitList�̍쐬
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
					hitKYOYU.addElement(seId);
					}

					int hitCnt = hitKYOYU.size();

					for(int i = 0; i < hitCnt; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* �����܂� */

				}else{
					// �{�l�ł͂Ȃ��ł����A���L�҂ł��B

					/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
					// �o�^�҂�ID���擾���܂��B
					ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");

					String toId = "";

					while(TOUROKU.next()){
						toId = TOUROKU.getString("K_�Ј�NO2");
					}

					TOUROKU.close();

					// ���L�҂�ID���擾���܂��B
					ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_�Ј�NO2 = '" + toId + "'");

					// hitList�̍쐬
					Vector hitKYOYU = new Vector();

					while(KYOYU.next()){
						String seId = KYOYU.getString("K_�Ј�NO");
						hitKYOYU.addElement(seId);
					}

					int cntKYOYU = hitKYOYU.size();

					// ���L�ҏ��̓��t�ƊJ�n�������X�V
					stmt.execute("UPDATE KY_TABLE SET S_DATE = '" + DAnew + "', S_START = '" + start + "', KY_FLAG = '1' WHERE (S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + toId + "') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + toId + "')");

					// �o�^�҂̏����X�V
					stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + toId + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
					stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + toId + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

					for(int i = 0; i < cntKYOYU; i++){
						stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
						stmt.execute("INSERT INTO S_TABLE(GO_�Ј�NO,S_DATE,S_START,S_END,S_PLAN,S_PLAN2,S_PLACE,S_PLACE2,S_MEMO,S_TOUROKU,S_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + DAnew + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
					}

					KYOYU.close();
					/* �����܂� */
				}
			}
		}
	UorD = true;
	}else if(act.equals("�폜") && (group_id.equals(group_no) || group_id.equals("900"))){
		if(ID.equals(NO)){
			// �o�^�҂����L�҂��`�F�b�N
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(FG.equals("0")){
				// �o�^�҂ł��B
				stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_�Ј�NO2 = '" + ID + "'");
			}else{
				// ���L�҂ł��B
				stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_�Ј�NO = '" + ID + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
			}
		}else{
			// �o�^�҂����L�҂��`�F�b�N
			ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND S_TOUROKU = '1'");

			String FG = "";

			if(TKCHECK.next()){
				FG = "0";
			}

			TKCHECK.close();

			if(FG.equals("0")){
				// �{�l�ł͂Ȃ����ǂ��o�^�҂ł��B
				stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE S_DATE = '" + DAold + "' AND S_START = '" + ST + "' AND K_�Ј�NO2 = '" + NO + "'");
			}else{
			// �{�l�ł͂Ȃ����ǂ����L�҂ł��B
				stmt.execute("DELETE FROM S_TABLE WHERE GO_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_�Ј�NO = '" + NO + "' AND S_DATE = '" + DAold + "' AND S_START = '" + ST + "'");
			}
		}
	UorD = false;
	}else{
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
		out.println("�X�P�W���[�����d�����Ă��܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(ky_check){
		out.println("���L�҂̃X�P�W���[�����d�����Ă��܂��B<BR>");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else{
		if(KD.equals("Month-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
				<%
			}
		}else if(KD.equals("Week-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
				<%
			}
		}else if(KD.equals("Day-u")){
			if(UorD){
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&group=<%= GR %>';
				parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAnew %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KD %>&act=';
// -->

				</SCRIPT>
				<%
			}else{
				%>
				<SCRIPT LANGUAGE="JAVASCRIPT">

<!--
				parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&group=<%= GR %>';
				parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DAold %>&s_start=<%= start %>&b_start=&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->

				</SCRIPT>
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
%>
</body>
</html>
