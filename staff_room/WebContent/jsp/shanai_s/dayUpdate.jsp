<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.* , java.util.Vector" %>
<%!
public String strEncode(String strVal) throws UnsupportedEncodingException{
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
// 02-08-15 �]�v�ȃv���O�������Ȃ�
// 02-09-03 �o�^�����I����A�ēǂݍ��݂��邽�߂̃v���O�������C���B
// 02-09-18 ����e�X�g���ԁc�o�O����  416�s��/442�s��/468�s�� �폜���s�����ۂ̃��_�C���N�g�����ŁA���t�̕ϐ����L�q�ԈႢ�B
// 02-09-18 ����e�X�g���ԁc�o�O����  417�s��/443�s��/469�s�� �폜���s�����ۂ̃��_�C���N�g�����ŁA���t�̕ϐ����L�q�ԈႢ�B
// 02-09-18 ����e�X�g���ԁc�o�O����  417�s��/443�s��/469�s�� �폜���s�����ۂ̃��_�C���N�g�����ŁA�\���`���̋�ʂ�����ϐ��̕�����ԈႢ�B
// 02-09-24 �o�O�����c      377�s�ځ`378�s��/400�s�ځ`401�s�� ���L�҂��o�i�[�X�P�W���[���̍폜���s�������ɁA���L�ҏ��[KY_TABLE]�̏����폜���Ă��Ȃ������B

/* �ǉ��_ */
// 02-08-13 ���L�҉�ʂőI�����ꂽ�����o�[�ɓo�^�҂Ɠ����X�P�W���[�����ꊇ�ύX���鏈��

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// [dayIn]�œ��͂��ꂽ�e���ڂ��p�����[�^�Ƃ��Ď擾
String NO = request.getParameter("no");
String GR = request.getParameter("group");

// �Â��X�P�W���[���̍폜�p�Ɏ擾
String DA = request.getParameter("s_date");
String sBS = request.getParameter("b_start");

// �\���̎�ނ𔻕ʂ���p�����[�^
String KD = request.getParameter("kind");

// �폜���s�����ۂɁA��ʂ�V�K�ɐݒ肷�邽�߁B
int KDend = KD.indexOf("-");
String KDs = KD.substring(0,KDend);

// �J�n���̎擾
String SY = request.getParameter("syear");
String SM = request.getParameter("smonth");
String SD = request.getParameter("sday");

int BSDAy = Integer.parseInt(SY);				// �N
int BSDAm = Integer.parseInt(SM);				// ��
int BSDAd = Integer.parseInt(SD);				// ��
boolean BSUru = false;//���邤�N�Ȃ�true��
if((BSDAy % 4) == 0){
	BSUru = true;
}

// �J�n���̌��� ��F20020815
String start = SY + SM + SD;

// �J�n���̃R�s�|(�p�����[�^�Ƃ��āA���m�Ɏ󂯎���悤�n�C�t���𕶎���A��������)
// ��F2002-08-15
String start_cpy = SY +"-"+ SM +"-"+ SD;

// �I�����̎擾
String EY = request.getParameter("eyear");
String EM = request.getParameter("emonth");
String ED = request.getParameter("eday");

int BEDAy = Integer.parseInt(EY);				// �N
int BEDAm = Integer.parseInt(EM);				// ��
int BEDAd = Integer.parseInt(ED);				// ��
boolean BEUru = false;//���邤�N�Ȃ�true��
if((BEDAy % 4) == 0){
	BEUru = true;
}

// �I�����̌��� ��F20020815
String end = EY +"-"+ EM +"-"+ ED;

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
<body BGCOLOR=#99A5FF>
<%
	if(ID.equals("")){
		out.println("���[�U�h�c������܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(NO.equals("")){
		out.println("�I�����ꂽ���[�U�h�c������܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(Integer.parseInt(SY) > Integer.parseInt(EY)){
		out.println("�J�n���E�N���I�����E�N�����傫���ł��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(BSDAm<1 || BSDAm>12){
		out.println("�o�i�[�J�n���Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(BSDAd<1 || BSDAd>31){
		out.println("�o�i�[�J�n���Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((BSDAm == 4 && BSDAd == 31) || (BSDAm == 6 && BSDAd == 31) || (BSDAm == 9 && BSDAd == 31) || (BSDAm == 11 && BSDAd == 31)){
		out.println("�o�i�[�J�n���Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((BSDAm == 2 && BSDAd > 28 && BSUru == false) || (BSDAm == 2 && BSDAd > 29 && BSUru == true)){
		out.println("�o�i�[�J�n���Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(BEDAm<1 || BEDAm>12){
		out.println("�o�i�[�I�����Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(BEDAd<1 || BEDAd>31){
		out.println("�o�i�[�I�����Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((BEDAm == 4 && BEDAd == 31) || (BEDAm == 6 && BEDAd == 31) || (BEDAm == 9 && BEDAd == 31) || (BEDAm == 11 && BEDAd == 31)){
		out.println("�o�i�[�I�����Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if((BEDAm == 2 && BEDAd > 28 && BEUru == false) || (BEDAm == 2 && BEDAd > 29 && BEUru == true)){
		out.println("�o�i�[�I�����Ɍ�肪����܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(plan.equals("")){
		out.println("�\�肪�I������Ă܂���B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else if(memo.length() >= 50){
		out.println("�������𒴂��Ă��܂��B");
		out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
	}else{

		// JDBC�h���C�o�̃��[�h
		Class.forName("org.postgresql.Driver");

		// �f�[�^�x�[�X�Ƀ��O�C�����邽�߂̏��
		String user = "georgir";
		String password = "georgir";

		// �f�[�^�x�[�X�ɐڑ�
		Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

		// Statement�I�u�W�F�N�g�̐���
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

		// �ύX�����ƍ폜��������ʂ���flag
		boolean UorD = false;

		// SQL���s
		if(act.equals("�ύX") && (group_id.equals(group_no) || group_id.equals("900"))){
			// SQL���s�E�X�V
			// �v���C�}���L�[�ɑI�΂�Ă��鍀�ڂɍX�V�����鎖�͏o���Ȃ��̂ŁA
			// ���̂悤�ȏ������Ƃ�܂����B�u�I�����R�[�h�v���u�폜�v���u�}���v
			if(ID.equals(NO)){
				// �ύX�ΏۂƂȂ�o�i�[�X�P�W���[���ȊO�Əd�������ꍇ�A�͂����B
				//ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START NOT IN '" + sBS + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' AND '"+ end +"' <= B_END ))");
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + start + "' AND B_END = '" + end + "'  AND B_PLAN = '" + plan + "' AND B_PLAN2 = '" + plan2 + "' AND B_PLACE = '" + place + "' AND B_PLACE2 = '" + place2 + "' AND B_MEMO = '" + memo + "' AND B_ZAISEKI = '" + pre + "' ");
				while(CHECK.next()){
					check = true;
				}
				CHECK.close();
				
				// ���L�҃o�i�[�X�P�W���[���̏d���`�F�b�N
				ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + ID + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_�Ј�NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + Blendy + "' AND B_START NOT IN '" + sBS + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' AND '"+ end +"' <= B_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
					KY_CHECK.close();
				}
				GOGOTea.close();

				// �o�^�҂����L�҂��`�F�b�N
				ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + sBS + "' AND B_TOUROKU = '1'");

				String FG = "";

				if(TKCHECK.next()){
					FG = "0";
				}

				TKCHECK.close();

				if(!check){
				if(!ky_check){
					if(FG.equals("0")){
						// �o�^�҂ł��B

						stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + sBS + "'");
						stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + ID + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

						// ���L�ҏ��̓��t�ƊJ�n�������X�V
						stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE (B_START = '" + sBS + "' AND K_�Ј�NO2 = '" + ID + "' AND KY_FLAG = '1') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + ID + "')");

						/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
						ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + start_cpy + "' AND K_�Ј�NO2 = '" + ID + "'");

						// hitList�̍쐬
						Vector hitKYOYU = new Vector();

						while(KYOYU.next()){
							String seId = KYOYU.getString("K_�Ј�NO");
							hitKYOYU.addElement(seId);
						}

						int cntKYOYU = hitKYOYU.size();

						for(int i = 0; i < cntKYOYU; i++){
							stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND B_START = '" + sBS + "'");
							stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
						}

						KYOYU.close();
						/* �����܂� */

					}
					else{
						// ���L�҂ł��B

						/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
						// �o�^�҂�ID���擾���܂��B
						ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + sBS + "'");

						String toId = "";

						while(TOUROKU.next()){
							toId = TOUROKU.getString("K_�Ј�NO2");
						}

						TOUROKU.close();

						// ���L�҂�ID���擾���܂��B
						ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + sBS + "' AND K_�Ј�NO2 = '" + toId + "'");

						// hitList�̍쐬
						Vector hitKYOYU = new Vector();

						while(KYOYU.next()){
							String seId = KYOYU.getString("K_�Ј�NO");
							hitKYOYU.addElement(seId);
						}

						int cntKYOYU = hitKYOYU.size();

						// ���L�ҏ��̓��t�ƊJ�n�������X�V
						stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE B_START = '" + sBS + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + toId + "'");

						// �폜�pSQL
						stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + toId + "' AND B_START = '" + sBS + "'");
						stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + toId + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

						for(int i = 0; i < cntKYOYU; i++){
							stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND B_START = '" + sBS + "'");
							stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
						}

						KYOYU.close();
						/* �����܂� */
					}
				}}
			}
			else{
				// �ύX�ΏۂƂȂ�o�i�[�X�P�W���[���ȊO�Əd�������ꍇ�A�͂����B
				//ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START NOT IN '" + sBS + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' AND '"+ end +"' <= B_END ))");
				ResultSet CHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + start + "' AND B_END = '" + end + "'  AND B_PLAN = '" + plan + "' AND B_PLAN2 = '" + plan2 + "' AND B_PLACE = '" + place + "' AND B_PLACE2 = '" + place2 + "' AND B_MEMO = '" + memo + "' AND B_ZAISEKI = '" + pre + "' ");
				while(CHECK.next()){
					check = true;
				}
				CHECK.close();
				
				// ���L�҃o�i�[�X�P�W���[���̏d���`�F�b�N
				ResultSet GOGOTea = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE KY_FLAG = '0' AND K_�Ј�NO2 = '" + NO + "'");
				while(GOGOTea.next()){
					Blendy = GOGOTea.getString("K_�Ј�NO");
					ResultSet KY_CHECK = stmt2.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + Blendy + "' AND B_START NOT IN '" + sBS + "' AND (('" + start + "' <= B_START AND '" + end + "' >= B_START) OR ('" + start + "' <= B_END AND '" + end + "' >= B_END) OR (B_START <= '"+ start +"' AND '"+ end +"' <= B_END ))");
					while(KY_CHECK.next()){
						ky_check = true;
					}
				KY_CHECK.close();
				}
				GOGOTea.close();

				// �o�^�҂����L�҂��`�F�b�N
				ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + sBS + "' AND B_TOUROKU = '1'");

				String FG = "";

				if(TKCHECK.next()){
					FG = "0";
				}

				TKCHECK.close();

				if(!check){
				if(!ky_check){
					if(FG.equals("0")){
						// �{�l�ł͂Ȃ��ł����A�o�^�҂ł��B

						stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + sBS + "'");
						stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + NO + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

						// ���L�ҏ��̓��t�ƊJ�n�������X�V
						stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE (B_START = '" + sBS + "' AND K_�Ј�NO2 = '" + NO + "' AND KY_FLAG = '1') OR (KY_FLAG = '0' AND K_�Ј�NO2 = '" + NO + "')");

						/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
						ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + start_cpy + "' AND K_�Ј�NO2 = '" + NO + "'");

						// hitList�̍쐬
						Vector hitKYOYU = new Vector();

						while(KYOYU.next()){
							String seId = KYOYU.getString("K_�Ј�NO");
							hitKYOYU.addElement(seId);
						}

						int cntKYOYU = hitKYOYU.size();

						for(int i = 0; i < cntKYOYU; i++){
							stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND B_START = '" + sBS + "'");
							stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
						}

						KYOYU.close();
						/* �����܂� */
					}
					else{
						// �{�l�ł͂Ȃ��ł����A���L�҂ł��B

						/* �������狤�L�҂��X�P�W���[���e�[�u���ւƑ}�����܂��B */
						// �o�^�҂�ID���擾���܂��B
						ResultSet TOUROKU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + sBS + "'");

						String toId = "";

						while(TOUROKU.next()){
							toId = TOUROKU.getString("K_�Ј�NO2");
						}

						TOUROKU.close();

						// ���L�҂�ID���擾���܂��B
						ResultSet KYOYU = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE B_START = '" + sBS + "' AND K_�Ј�NO2 = '" + toId + "'");

						// hitList�̍쐬
						Vector hitKYOYU = new Vector();

						while(KYOYU.next()){
							String seId = KYOYU.getString("K_�Ј�NO");
							hitKYOYU.addElement(seId);
						}

						int cntKYOYU = hitKYOYU.size();

						// ���L�ҏ��̓��t�ƊJ�n�������X�V
						stmt.execute("UPDATE KY_TABLE SET B_START = '" + start_cpy + "', KY_FLAG = '1' WHERE B_START = '" + sBS + "' AND KY_FLAG = '1' AND K_�Ј�NO2 = '" + toId + "'");

						// �폜�pSQL
						stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + toId + "' AND B_START = '" + sBS + "'");
						stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + toId + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '1', '" + pre + "')");

						for(int i = 0; i < cntKYOYU; i++){
							stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + hitKYOYU.elementAt(i) + "' AND B_START = '" + sBS + "'");
							stmt.execute("INSERT INTO B_TABLE(K_�Ј�NO,B_START,B_END,B_PLAN,B_PLAN2,B_PLACE,B_PLACE2,B_MEMO,B_TOUROKU,B_ZAISEKI) VALUES('" + hitKYOYU.elementAt(i) + "','" + start + "', '" + end + "', '" + plan + "', '" + plan2 + "', '" + place + "', '" + place2 + "', '" + memo + "', '0', '" + pre + "')");
						}

						KYOYU.close();
						/* �����܂� */
					}
				}}

			}
		UorD = true;
		}
		else if(act.equals("�폜") && (group_id.equals(group_no) || group_id.equals("900"))){
			if(ID.equals(NO)){
				// �o�^�҂����L�҂��`�F�b�N
				ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + sBS + "' AND B_TOUROKU = '1'");

				String FG = "";

				if(TKCHECK.next()){
					FG = "0";
				}

				TKCHECK.close();

				stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + sBS + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_�Ј�NO = '" + ID + "' AND B_START = '" + start_cpy + "'");
			}
			else{
				// �o�^�҂����L�҂��`�F�b�N
				ResultSet TKCHECK = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + sBS + "' AND B_TOUROKU = '1'");

				String FG = "";

				if(TKCHECK.next()){
					FG = "0";
				}

				TKCHECK.close();

				stmt.execute("DELETE FROM B_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + sBS + "'");
				stmt.execute("DELETE FROM KY_TABLE WHERE K_�Ј�NO = '" + NO + "' AND B_START = '" + start_cpy + "'");
			}
		UorD = false;
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
			out.println("�d�����Ă���o�i�[�X�P�W���[��������܂��B");
			out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
		}else if(ky_check){
			out.println("���L�҂̃o�i�[�X�P�W���[�����d�����Ă��܂��B<BR>");
			out.println("<form><input type=button value=�߂� onClick=history.back()></form>");
		}else{
			if(KD.equals("Month-b")){
				if(UorD){
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
				else{
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
			}
			else if(KD.equals("Week-b")){
				if(UorD){
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
				else{
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
			}
			else if(KD.equals("Day-b")){
				if(UorD){
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KD %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
				else{
					%>
					<SCRIPT LANGUAGE="JAVASCRIPT">
<!-- �ړ��֎~ -->
<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&group=<%= GR %>';
					parent.sub02.location.href='dayIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= start_cpy %>&s_start=&b_start=<%= start_cpy %>&group=<%= GR %>&kind=<%= KDs %>&act=';
// -->
<!-- �ړ��֎~ -->
					</SCRIPT>
					<%
				}
			}
			else{
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