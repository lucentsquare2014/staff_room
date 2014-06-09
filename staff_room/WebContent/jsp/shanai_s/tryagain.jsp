<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.util.*,java.sql.*,java.util.Date,java.io.*,java.text.*" %>
<%!
// �����G���R�[�h���s���܂��B
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal == null){
		return (null);
	}
	else{
		return (new String(strVal.getBytes("8859_1"),"Shift_JIS"));
	}
}
%>
<%
/* �C���_ */
// 02-08-12 �p�����[�^�̑�����ύX[�e�t���[���֑��M sub01,sub02]
// 02-08-15 �N���������Ă��Ȃ��O���[�v�R�[�h��I���������ɁA�S�Ј����l���R���{�{�b�N�X�ɕ\������Ă��܂����ۂ��C���B
// 02-08-16 �p�����[�^���C��
// 02-09-02 �p�����[�^�̑����̕ύX[�Q��ʂɕύX�����̂ŁAsub02�ɂ̂ݑ���]
// 13-06-18 �o�i�[�𖢋L���œ��͂���ƕύX�A�폜���ł��Ȃ����ۂ��C���B
		
/* �ǉ��_ */
// 02-08-15 �x�݊֘A�̗\���I���������ɁA�o�i�[�X�P�W���[���̐F��ύX����B
// 02-08-30 �{���̓��t��_�ł���B

// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
String ID = strEncode(request.getParameter("id"));

// �p�����[�^�̎󂯎��
String reqNo = strEncode(request.getParameter("no"));
String name = strEncode(request.getParameter("kojin"));
String konohito = strEncode(request.getParameter("slkname"));
String post = request.getParameter("group");
String strReturn = request.getParameter("s_date");

// JDBC�h���C�o�̃��[�h
Class.forName("org.postgresql.Driver");

// �f�[�^�x�[�X�֐ڑ�
String user = "georgir";
String password = "georgir";

Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);

Statement stmt = con.createStatement();

if(reqNo == null){
	reqNo = ID;
}

// SQL���s�F���[�U�̖��O�̎擾
ResultSet NAME = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + reqNo +"'");

// �Ј��ԍ����Ј����ɕϊ�
if( name == null ){
	while(NAME.next()){
		name = NAME.getString("K_����");
	}

	NAME.close();
}else if( konohito != null ){
	name = konohito;
}

// �X�P�W���[���p�ϐ�
String s_date = "";
String s_start = "";
String s_end = "";
String memo = "";

%>
<html>
	<head>
		<title></title>
		<STYLE TYPE="text/css">
			.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
		</STYLE>
	</head>
	<BODY BGCOLOR="#99A5FF">
		<TABLE BORDER="0">
			<TR>
				<TD>
					<FORM ACTION="tryagain.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="���\��" title="���\���Ɉړ����܂��B">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="TestExample34.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="�T�\��" title="�T�\���Ɉړ����܂��B">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="h_hyoji.jsp" METHOD="POST">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>">
						<INPUT TYPE="submit" VALUE="���\��" title="���\���Ɉړ����܂��B">
					</FORM>
				</TD>
				<TD>
					<FORM ACTION="menu.jsp" METHOD="POST" TARGET="_top">
						<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
						<INPUT TYPE="submit" VALUE="���C�����j���[�֖߂�" title="���C�����j���[�ɖ߂�܂��B">
					</FORM>
				</TD>
			</TR>
		</TABLE>
		<%
		// �c�a�O���[�v��.�R���{
		ResultSet rs2 = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

		Vector hitList1 = new Vector();
		Vector hitList2 = new Vector();

		String grname = "";
		String gruno = "";

		while(rs2.next()){
			grname = rs2.getString("G_GRNAME");
			gruno = rs2.getString("G_GRUNO");
			hitList1.addElement(grname);
			hitList2.addElement(gruno);
		}

		int hitCnt1 = hitList1.size();

		rs2.close();

		int i = 0;
		int j = -1;

		// �X�P�W���[���J�E���g�p�ϐ�
		int mincnt = 0;
		int xxx = 0;

		// �J�����_�[�Ăяo��
		GregorianCalendar cal = new GregorianCalendar();
		int calYear = Integer.parseInt(""+ cal.get(Calendar.YEAR)); // ���N:calYear
		int calMonth = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));

		// �_�ŗp�F�{���̓��t��ǂݏo���܂��B
		Date kyo = cal.getTime();

		String strTuki = request.getParameter("count");
		String strYear = request.getParameter("countY");

		int intTuki = 0;
		int intYear = 0;

		if(strYear != null){
			intYear = Integer.parseInt(strYear);
		}else{
			intYear = calYear;
		}

		// �����܂���������
		if(strTuki != null){
			intTuki = Integer.parseInt(strTuki);
		}else{
			intTuki = calMonth;
		}

		if(intTuki == 0){
			intTuki = 12;
			intYear = intYear - 1;
		}
		if(intTuki == 13){
			intTuki = 1;
			intYear = intYear + 1;
		}

		if(strReturn != null){
			String reYear = strReturn.substring(0,4);
			String reMonth = strReturn.substring(5,7);
			intYear = Integer.parseInt(reYear);
			intTuki = Integer.parseInt(reMonth);
		}

		cal.set( intYear, intTuki - 1, 1);
		int sWeek = cal.get( Calendar.DAY_OF_WEEK ); // �����̗j��:sWeek

		cal.set( intYear, intTuki, 0 );
		int eWeek = cal.get( Calendar.DAY_OF_WEEK ); // �����̗j��:eWeek
		int eDay = cal.get( Calendar.DATE );         // �����̓�  :eDay

		cal.set( intYear, intTuki - 1, 0 );
		int zengetu = cal.get( Calendar.DATE );      // �O���̍ŏI��:zengetu
		zengetu = zengetu + 1;

		%>

		<%--  �O���[�v���̃R���{�{�b�N�X  --%>
		<table>
			<tr>
				<form action="tryagain.jsp" method="post">
					<td>
						<FONT COLOR="white">
							<SPAN CLASS="shadow">
								�O���[�v��
							</SPAN>
						</FONT>
					</td>
					<td valign="top">
						<select name=group style=width:200>
							<option value="all">�S�Ј�</option>
							<%
							if(post == null){
								post = post;
							}
							for(i = 0;i < hitCnt1;i++){
								if(hitList2.elementAt(i).equals(post)){
									%><option selected value="<%= hitList2.elementAt(i) %>"><%= hitList1.elementAt(i) %></option><%
								}else{
									%><option value="<%= hitList2.elementAt(i) %>"><%= hitList1.elementAt(i) %></option><%
								}
							}
							%>
						</select>
					</td>
					<td valign="top">
						<input type="hidden" name="group" value="<%= post %>">
						<input type="hidden" name="id" value="<%= ID %>">
						<input type="hidden" name="kojin" value="<%= name %>">
						<input type="hidden" name="count" value="<%= intTuki %>">
						<input type="hidden" name="countY" value="<%= intYear %>">
						<input type="submit" value="�I��" title="���L�̃O���[�v���E�ɕ\�����܂��B">
					</td>
				</form>
				<%
				ResultSet rs4 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_GRUNO = '"+ post +"' ORDER BY K_PASS2 , K_�Ј�NO");

				Vector hitList3 = new Vector();

				String kname = "";

				while(rs4.next()){
					kname = rs4.getString("K_����");
					hitList3.addElement(kname);
				}

				int hitCnt2 = hitList3.size();

				rs4.close();

				ResultSet rs8 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN ORDER BY K_PASS2 , K_�Ј�NO");

				Vector hitList5 = new Vector();

				String minname = "";

				while(rs8.next()){
					minname = rs8.getString("K_����");
					hitList5.addElement(minname);
				}

				int hitCnt3 = hitList5.size();

				rs8.close();

				%>
				<form action="tryagain.jsp" method="post">
					<td>
						<FONT COLOR="white">
							<SPAN CLASS="shadow">
								�l��
							</SPAN>
						</FONT>
					</td>
					<td valign="top">
						<select name="slkname" style="width:200">
							<option selected value=""></option>
							<%
							if(post.equals("all")){
								for(i = 0;i < hitCnt3;i++){
									if(hitList5.elementAt(i).equals(name)){
										%><option selected value="<%= hitList5.elementAt(i) %>"><%= hitList5.elementAt(i) %></option><%
									}else{
										%><option value="<%= hitList5.elementAt(i) %>"><%= hitList5.elementAt(i) %></option><%
									}
								}
							}else{
								for(i = 0;i < hitCnt2;i++){
									if(hitList3.elementAt(i).equals(name)){
										%><option selected value="<%= hitList3.elementAt(i) %>"><%= hitList3.elementAt(i) %></option><%
									}else{
										%><option value="<%= hitList3.elementAt(i) %>"><%= hitList3.elementAt(i) %></option><%
									}
								}
							}
							%>
						</select>
					</td>
					<td valign="top">
						<input type="hidden" name="group" value="<%= post %>">
						<input type="hidden" name="id" value="<%= ID %>">
						<input type="hidden" name="kojin" value="<%= name %>">
						<input type="hidden" name="count" value="<%= intTuki %>">
						<input type="hidden" name="countY" value="<%= intYear %>">
						<input type="submit" value="�\��" title="���L�̐l�̃X�P�W���[����\�����܂��B">
					</td>
				</form>
			</tr>
		</table>
		<center>
			<table>
				<tr>
					<%--  �O���Ɉړ�����R�}���h�{�^��  --%>
					<form action="tryagain.jsp" method="post">
						<td>
							<input type="hidden" name="group" value="<%= post %>">
							<input type="hidden" name="id" value="<%= ID %>">
							<input type="hidden" name="kojin" value="<%= name %>">
							<input type="hidden" name="count" value="<%= intTuki - 1 %>">
							<input type="hidden" name="countY" value="<%= intYear %>">
							<input type="submit" name="zengetu" value="�O��" title="�O�̌��Ɉړ����܂��B">
						</td>
					</form>
					<td>
						<SPAN CLASS="shadow">
							<font size="6" color="white">
								<b><i>
								<%
								// �����̔N�ƌ��\�����x��
								out.print(intYear + "�N" + intTuki + "��");
								%>
								</i></b>
							</font>
						</SPAN>
					</td>
					<%--  �����Ɉړ�����R�}���h�{�^��  --%>
					<form action="tryagain.jsp" method="post">
						<td>
							<input type="hidden" name="group" value="<%= post %>">
							<input type="hidden" name="id" value="<%= ID %>">
							<input type="hidden" name="kojin" value="<%= name %>">
							<input type="hidden" name="count" value="<%= intTuki + 1 %>">
							<input type="hidden" name="countY" value="<%= intYear %>">
							<input type="submit" name="jigetu" value="����" title="���̌��Ɉړ����܂��B">
						</td>
					</form>
				</tr>
			</table>
		</center>

		<%--  �J�����_�[�쐬  --%>
		<table width="100%" border="1" cellspacing="0" cellpadding="1"><br>
			<tr bgcolor="black">
				<td width="13%" bgcolor="pink">
					<center>
						<font color="red">��</font>
					</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>��</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>��</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>��</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>��</center>
				</td>
				<td width="13%" bgcolor="white">
					<center>��</center>
				</td>
				<td width="13%" bgcolor="skyblue">
					<center>
						<font color="blue">�y</font>
					</center>
				</td>
			</tr>
			<%
			// �e�[�u�����ڎ�荞�ݗp�ϐ��̏�����
			String bana = "";
			String b_plan = "";
			String b_plan2 = "";
			String b_place = "";
			String b_place2 = "";
			String b_start = "";
			String bmemo = "";
			String iro = "";
			// �X�P�W���[���̌Ăяo��
			// �Ј������Ј��ԍ��ɕϊ�
			ResultSet rs5 = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_���� = '"+ name +"'");

			String no = "";
			while(rs5.next()){
				no = rs5.getString("K_ID");
			}
			rs5.close();

			Date today = cal.getTime();
			int tuki = 0;
			int nen = 0;
			i = 0;
			SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
			String kyo2 = sFmt.format(kyo);
			// �����߂��󔒂�
			nen = intYear;
			tuki = intTuki - 2;

			if(sWeek != 1){
				if(tuki == -1){
					tuki = 11;
					nen = nen - 1;
				}
				for( i = 1; i < sWeek; i++ ){
					zengetu = zengetu - 1;
				}
				sFmt = new SimpleDateFormat("yyyy-MM-dd");
				cal.set( intYear, intTuki - 2, zengetu);
				Date thisMonth = cal.getTime();
				String hajime = sFmt.format(thisMonth);
				%>
				<tr>
				<%
				for( i = 1; i < sWeek; i++ ){
					sFmt = new SimpleDateFormat("yyyyMMdd");
					cal.set( intYear, intTuki - 2, zengetu);
					thisMonth = cal.getTime();
					int calWeek = cal.get( Calendar.DAY_OF_WEEK );
					calWeek = cal.get( Calendar.DAY_OF_WEEK );
					String yasumi = "";

					ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_�N���� = '"+ sFmt.format(thisMonth) +"'");

					while(rs7.next()){
						yasumi = rs7.getString("H_�x����");
					}

					rs7.close();
					sFmt = new SimpleDateFormat("yyyy-MM-dd");
					cal.set( nen, tuki, zengetu );
					today = cal.getTime();

					// �j�����Ƀo�b�N�O�����h�̐F��ύX����
					if(sFmt.format(today).equals(kyo2)){
					// ����
						%><td height="50" align="left" valign="top" bgcolor="lavender"><%
					}else if(calWeek == 1){
						%><td bgcolor="pink" height="50" align="left" valign="top"><%
					}else if(yasumi != null){
						%><td bgcolor="pink" height="50" align="left" valign="top"><%
					}else{
						%><td bgcolor="white" height="50" align="left" valign="top"><%
					}
					%>
					<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="�V�K�o�^�ł��܂��B" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
						<%= zengetu %>
					</A>
					<font color="red"><%= yasumi %></font><br>
					<%
					ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
					while(rs3.next()){
						b_start = rs3.getString("B_START");
						b_start = b_start.substring(0,10);
						b_plan = rs3.getString("B_PLAN").trim();
						if(b_plan.equals("�x��") || b_plan.equals("�ċx")){
							iro = "orange";
						}else{
							iro = "yellow";
						}
						%>
						<table bgcolor="<%= iro %>" width="100%">
							<td>
								<%
								if(b_start.equals(sFmt.format(thisMonth)) || hajime.equals(sFmt.format(thisMonth))){
									b_plan2 = rs3.getString("B_PLAN2");
									b_place = rs3.getString("B_PLACE").trim();
									b_place2 = rs3.getString("B_PLACE2");
									bmemo = rs3.getString("B_MEMO");
									if(b_plan.equals("--")){
										b_plan = "";
									}
									if(b_place.equals("--")){
										b_place = "";
									}
                                    
								
									
									if(b_plan != "" && b_plan2 != null){
										bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
									}else if(b_plan != "" && b_plan2 == null){
										bana = b_plan + "<BR>";
									}else if(b_plan == "" && b_plan2 != null){
										bana = b_plan2 + "<BR>";
									}else{
										bana = "<BR>";
									}
									if(b_place != "" && b_place2 != null){
										bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
									}else if(b_place != "" && b_place2 == null){
										bana = bana + b_place + "<BR>";
									}else if(b_place == "" && b_place2 != null){
										bana = bana + b_place2 + "<BR>";
									}else{
										bana = bana + "<BR>";
									}
									
									
								    // 2013-06-18 �ύX��:��ؗ��q 21304
									//if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
										bana = "�o�i�[<BR>�ڍ׏��Ȃ�";
									}
									if( bmemo == null || bmemo.equals("") ){
										bmemo = "";
									}else{
										bmemo = "<b><����></b><BR>"+ bmemo +"";
									}
									
									
									
									
									/*
									if( bmemo != null ){
										bmemo = "<b><����></b><BR>"+ bmemo +"";

									}else{
										bmemo = "";
									}

									/*      20130111  ��L�C��
									if(bmemo == null){
										bmemo = "";
									}else{
										bmemo = "�������e<BR>"+ bmemo +"";
									}
									*/
									%>
									<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02" title="<%= bmemo %>">
										<font size=2>
											<%= bana + bmemo %>
										</font>
									</A>
									<%
								}else{%>�@<%}
								%>
								</td>
							</tr>
						</table>
						<%
					}
					rs3.close();
					sFmt = new SimpleDateFormat("yyyyMMdd");
					// �X�P�W���[���̌Ăяo��
					ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_�Ј�NO = '"+ no +"'");
					while(rs6.next()){
						String s_place = rs6.getString("S_PLACE").trim();		//�ꏊ�擾
						String s_place2 = rs6.getString("S_PLACE2");			//�ꏊ�ڍ׎擾
						String s_plan = rs6.getString("S_PLAN").trim();			//�\��擾
						String s_plan2 = rs6.getString("S_PLAN2");				//�\��ڍ׎擾

						s_date = rs6.getString("S_DATE").substring(0,10);
						s_start = rs6.getString("S_START");
						s_end = rs6.getString("S_END");
						memo = rs6.getString("S_MEMO");
						String S_sTimeM = s_start.substring(2,4);				//�J�n�������u���v��
						String S_sTimeH = s_start.substring(0,2);				//          �u���v�ɕ���
						String S_eTimeM = s_end.substring(2,4);					//�I���������u���v��
						String S_eTimeH = s_end.substring(0,2);					//          �u���v�ɕ���

						String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "�`" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != ""  && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != ""  && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == ""  && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
						s_date = rs6.getString("S_DATE");
						s_start = rs6.getString("S_START");
						memo = rs6.getString("S_MEMO");
						if( memo == null || memo.equals("")){
							memo = "";
						}else{
							memo = "<b><����></b><BR>"+ memo +"";
						}
						/*
						if( memo != null ){
							memo = "<b><����></b><BR>"+ memo +"";

						}else{
							memo = "";
						}
						/*      20130111  ��L�C��
						if(memo == null){
							memo = "";
						}else{
							memo = "<b><����></b><BR>"+ memo +"";
						}
						*/
						%>
						<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
							<font size="2">
								<%= sche + memo %>
							</font>
						</A>
						<%
					}
					rs6.close();
					%>
					<script language="JavaScript1.2">
					<!--
						function deleteCookie(theName){
							document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
							return true;
						}
						function send<%= mincnt %>(id,no,date,start){
							alert("�X�P�W���[�����R�s�[���܂��B");
							var charid = id;
							var charno = no;
							var charde = date;
							var charst = start;
							deleteCookie(charid,charno,charde,charst);
							document.cookie = "id="+charid+";";
							document.cookie = "no="+charno+";";
							document.cookie = "s_date="+charde+";";
							document.cookie = "s_start="+charst+";";
							// ���_�C���N�g����
							parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
						}
						function miseru<%= xxx %>(no,date,kd){
							alert("�X�P�W���[����\������܂��B");
							var charno = no;
							var charde = date;
							var charkd = kd;
							// JavaScript�ɂ��Cookie����̔����o��
							theCookie = document.cookie + ";";
							Sid = theCookie.indexOf("id");
							Sno = theCookie.indexOf("no");
							Ss_date = theCookie.indexOf("s_date");
							Ss_start = theCookie.indexOf("s_start");
							if(Sid != -1){
								Eid = theCookie.indexOf(";",Sid);
								Eid = theCookie.substring(Sid + 3,Eid);
							}
							if(Sno != -1){
								Eno = theCookie.indexOf(";",Sno);
								Eno = theCookie.substring(Sno + 3,Eno);
							}
							if(Ss_date != -1){
								Es_date = theCookie.indexOf(";",Ss_date);
								Es_date = theCookie.substring(Ss_date + 7,Es_date);
							}
							if(Ss_start != -1){
								Es_start = theCookie.indexOf(";",Ss_start);
								Es_start = theCookie.substring(Ss_start + 8,Es_start);
								}
							parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
						}
					//-->
					</script>
					<%
					mincnt = mincnt + 1;
					xxx = xxx + 1;
					zengetu = zengetu + 1;
				}
			}
			tuki = intTuki - 1;
			if(tuki == 0){
				nen = intYear;
			}
			for(i = 1;i <= eDay;i++){
				cal.set(intYear, intTuki - 1, i);
				int calWeek = cal.get(Calendar.DAY_OF_WEEK);
				// �w�肵�������r�ł���悤��
				sFmt = new SimpleDateFormat("yyyyMMdd");
				cal.set(intYear,intTuki - 1,i);
				Date thisMonth = cal.getTime();

				String yasumi = "";
				String kyujitu = sFmt.format(thisMonth);

				ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_�N���� = '"+ sFmt.format(thisMonth) +"'");

				while(rs7.next()){
					yasumi = rs7.getString("H_�x����");
				}
				rs7.close();
				// ���j�����ŏ��Ȃ̂ōs�̐擪������킷<tr>�^�O��ݒ�
				if(calWeek == 1){
					%>
					<tr>
					<%
				}
				sFmt = new SimpleDateFormat("yyyy-MM-dd");
				cal.set(nen,tuki,i);
				today = cal.getTime();
				// �j�����Ƀo�b�N�O�����h�̐F��ύX����
				if(sFmt.format(today).equals(kyo2)){
					// ����
					%>
					<td height="50" align="left" valign="top" bgcolor="lavender">
					<%
				}else if(calWeek == 1){
					// ���j��
					%>
					<td height="50" align="left" valign="top" bgcolor="pink">
					<%
				}else if(yasumi != ""){
					// �j��
					%>
					<td height="50" align="left" valign="top" bgcolor="pink">
					<%
				}else if(calWeek == 7){
					// �y�j��
					%>
					<td height="50" align="left" valign="top" bgcolor="skyblue">
					<%
				}else{
					// ����
					%>
					<td height="50" align="left" valign="top" bgcolor="white">
					<%
				}
				%>
				<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="�V�K�o�^�ł��܂��B" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
					<%= i %>
				</A>
				<font color=red>
					<%= yasumi %>
				</font><br>
				<%
				ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
				while(rs3.next()){
					b_start = rs3.getString("B_START");
					b_start = b_start.substring(0,10);
					b_plan = rs3.getString("B_PLAN").trim();
					if(b_plan.equals("�x��") || b_plan.equals("�ċx")){
						iro = "orange";
					}else{
						iro = "yellow";
					}
					%>
					<table bgcolor="<%= iro %>" width="100%">
						<TR>
							<td>
							<%
							
								if(b_start.equals(sFmt.format(thisMonth)) || (i == 1 && calWeek == 1)){
								b_plan2 = rs3.getString("B_PLAN2");
								b_place = rs3.getString("B_PLACE").trim();
								b_place2 = rs3.getString("B_PLACE2");
								bmemo = rs3.getString("B_MEMO");
								if(b_plan.equals("--")){
									b_plan = "";
								}
								if(b_place.equals("--")){
									b_place = "";
								}
								///// 2013-06-18 �ύX��:��ؗ��q 21304
								/*//// 2013-06-18 ���L�̓����ɂ�����I���W�i���R�[�h �J�n
								if(b_plan != "" && b_plan2 != null){
									bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
								}else if(b_plan != "" && b_plan2 == null){
									bana = b_plan + "<BR>";
								}else if(b_plan == "" && b_plan2 != null){
									bana = b_plan2 + "<BR>";
								}else{
									bana = "<BR>";
								}
								if(b_place != "" && b_place2 != null){
									bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
								}else if(b_place != "" && b_place2 == null){
									bana = bana + b_place + "<BR>";
								}else if(b_place == "" && b_place2 != null){
									bana = bana + b_place2 + "<BR>";
								}else{
									bana = bana + "<BR>";
								}
								if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									bana = "�o�i�[<BR>�ڍ׏��Ȃ�";
								}
								if( bmemo == null || bmemo.equals("")){
									bmemo = "";
								}else{
									bmemo = "<b><����></b><BR>"+ bmemo +"";
								}
								//*/// 2013-06-18 ���L�̓����ɂ�����I���W�i���R�[�h �I��
								
								if(b_plan.length() > 0 && b_plan2 != null){
									bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
								}else if(b_plan.length() > 0 && b_plan2 == null){
									bana = b_plan + "<BR>";
								}else if(b_plan.length() == 0 && b_plan2 != null){
									bana = b_plan2 + "<BR>";
								}else{
									bana = "<BR>";
								}
								if(b_place.length() > 0 && b_place2 != null){
									bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
								}else if(b_place.length() > 0 && b_place2 == null){
									bana = bana + b_place + "<BR>";
								}else if(b_place.length() == 0 && b_place2 != null){
									bana = bana + b_place2 + "<BR>";
								}else{
									bana = bana + "<BR>";
								}
								
								if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
									bana = "�o�i�[<BR>�ڍ׏��Ȃ�";
								}
								if( bmemo == null || bmemo.equals("")){
									bmemo = "";
								}else{
									bmemo = "<b><����></b><BR>"+ bmemo +"";
								}
								
								/*
								if( bmemo != null ){
									bmemo = "<b><����></b><BR>"+ bmemo +"";

								}else{
									bmemo = "";
								}
								/*      20130111  ��L�C��
								if(bmemo == null){
									bmemo = "";
								}else{
									bmemo = "<b><����></b><BR>"+ bmemo +"";
								}
								*/
								%>
								<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02" title="<%= bmemo %>">
									<font size="2">
										<%= bana + bmemo %>
									</font>
								</A>
								<%
							}else{%>�@<%}
							%>
							</TD>
						</TR>
					</table>
					<%
				}
				rs3.close();
				sFmt = new SimpleDateFormat("yyyyMMdd");

				// �X�P�W���[���̌Ăяo��
				ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_�Ј�NO = '"+ no +"'");
				while(rs6.next()){
					String s_place = rs6.getString("S_PLACE").trim();		//�ꏊ�擾
					String s_place2 = rs6.getString("S_PLACE2");			//�ꏊ�ڍ׎擾
					String s_plan = rs6.getString("S_PLAN").trim();			//�\��擾
					String s_plan2 = rs6.getString("S_PLAN2");				//�\��ڍ׎擾
					s_date = rs6.getString("S_DATE").substring(0,10);
					s_start = rs6.getString("S_START");
					s_end = rs6.getString("S_END");
					memo = rs6.getString("S_MEMO");
					String S_sTimeM = s_start.substring(2,4);				//�J�n�������u���v��
					String S_sTimeH = s_start.substring(0,2);				//          �u���v�ɕ���
					String S_eTimeM = s_end.substring(2,4);					//�I���������u���v��
					String S_eTimeH = s_end.substring(0,2);					//          �u���v�ɕ���

					String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "�`" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != "" && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != "" && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == "" && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
					s_date = rs6.getString("S_DATE");
					s_start = rs6.getString("S_START");
					memo = rs6.getString("S_MEMO");

					if( memo == null || memo.equals("")){
						memo = "";
					}else{
						memo = "<b><����></b><BR>"+ memo +"";
					}
					/*
					if( memo != null ){
						memo = "<b><����></b><BR>"+ memo +"";

					}else{
						memo = "";
					}
					/*      20121228  ��L�C��
					if(memo == null){
						memo = "";
					}else{
						memo = "<b><����></b><BR>"+ memo +"";
					}
					*/
					%>
					<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
						<font size="2">
							<%= sche + memo %>
						</font>
					</A>
					<%
				}
				rs6.close();
				%>
				<script language="JavaScript1.2">
				<!--
					function deleteCookie(theName){
						document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
						return true;
					}
					function send<%= mincnt %>(id,no,date,start){
						alert("�X�P�W���[�����R�s�[���܂��B");
						var charid = id;
						var charno = no;
						var charde = date;
						var charst = start;
						deleteCookie(charid,charno,charde,charst);
						document.cookie = "id="+charid+";";
						document.cookie = "no="+charno+";";
						document.cookie = "s_date="+charde+";";
						document.cookie = "s_start="+charst+";";
						// ���_�C���N�g����
						parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
					}
					function miseru<%= xxx %>(no,date,kd){
						alert("�X�P�W���[����\������܂��B");
						var charno = no;
						var charde = date;
						var charkd = kd;
						// JavaScript�ɂ��Cookie����̔����o��
						theCookie = document.cookie + ";";
						Sid = theCookie.indexOf("id");
						Sno = theCookie.indexOf("no");
						Ss_date = theCookie.indexOf("s_date");
						Ss_start = theCookie.indexOf("s_start");
						if(Sid != -1){
							Eid = theCookie.indexOf(";",Sid);
							Eid = theCookie.substring(Sid + 3,Eid);
						}
						if(Sno != -1){
							Eno = theCookie.indexOf(";",Sno);
							Eno = theCookie.substring(Sno + 3,Eno);
						}
						if(Ss_date != -1){
							Es_date = theCookie.indexOf(";",Ss_date);
							Es_date = theCookie.substring(Ss_date + 7,Es_date);
						}
						if(Ss_start != -1){
							Es_start = theCookie.indexOf(";",Ss_start);
							Es_start = theCookie.substring(Ss_start + 8,Es_start);
						}
						parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
					}
				//-->
				</script>
				<%
				mincnt = mincnt + 1;
				xxx = xxx + 1;
				calWeek++;
				// ���t�p�J�����̏I���^�O��ݒ�
				%>
				</td>
				<%

				// �y�j���̏ꍇ:1�s��</tr>�^�O�ŕ���
				// ��T�ԕ��̕\���f�[�^���N���C�A���g�ɑ��M����
				if(calWeek > 7){
				%>
				</tr>
				<%
				}
				// �j��������₷
				calWeek = ++calWeek % 8;
			}
			j = 1;
			// �����󗓕����̕\��
			nen = intYear;
			tuki = intTuki;
			if(eWeek != 7){
				if(tuki == 12){
					tuki = 0;
				nen = nen + 1;
				}
			for(i = eWeek;i < 7;i++){
				sFmt = new SimpleDateFormat("yyyyMMdd");
				cal.set(intYear,intTuki,j);
				Date thisMonth = cal.getTime();
				int calWeek = cal.get(Calendar.DAY_OF_WEEK);
					calWeek = cal.get(Calendar.DAY_OF_WEEK);
					String yasumi = "";
					ResultSet rs7 = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_�N���� = '"+ sFmt.format(thisMonth) +"'");

					while(rs7.next()){
						yasumi = rs7.getString("H_�x����");
					}
					rs7.close();
					sFmt = new SimpleDateFormat("yyyy-MM-dd");
					cal.set(nen,tuki,j);
					today = cal.getTime();
					// �j�����Ƀo�b�N�O�����h�̐F��ύX����
					if(sFmt.format(today).equals(kyo2)){
						// ����
						%>
						<td height="50" align="left" valign="top" bgcolor="lavender">
						<%
					}else if(yasumi != null){
						%>
						<td height="50" align="left" valign="top" bgcolor="pink">
						<%
					}else if(calWeek == 7){
						%>
						<td height="50" align="left" valign="top" bgcolor="skyblue">
						<%
					}else{
						%>
						<td height="50" align="left" valign="top" bgcolor="white">
						<%
					}
					%>
					<A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(today) %>&s_start=&b_start=&group=<%= post %>&kind=Month&act=" TARGET="sub02" title="�V�K�o�^�ł��܂��B" oncontextmenu="if(!event.ctrlKey){ miseru<%=xxx%>('<%= no %>','<%= sFmt.format(thisMonth) %>','Month');return false}">
						<%= j %>
					</A>
					<font color="red">
						<%= yasumi %>
					</font><br>
					<%
					ResultSet rs3 = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");
					while(rs3.next()){
						b_start = rs3.getString("B_START");
						// �f�[�^�x�[�X����擾�������t�̗]���ȕ���������
						b_start = b_start.substring(0,10);
						b_plan = rs3.getString("B_PLAN").trim();
						if(b_plan.equals("�x��") || b_plan.equals("�ċx")){
							iro = "orange";
						}else{
							iro = "yellow";
						}
						%>
						<table bgcolor="<%= iro %>" width="100%">
							<tr>
								<td>
								<%
								if(b_start.equals(sFmt.format(thisMonth)) || (i == 1 && calWeek == 1)){
									b_plan2 = rs3.getString("B_PLAN2");
									b_place = rs3.getString("B_PLACE").trim();
									b_place2 = rs3.getString("B_PLACE2");
									bmemo = rs3.getString("B_MEMO");
									if(b_plan.equals("--")){
										b_plan = "";
									}
									if(b_place.equals("--")){
										b_place = "";
									}

									if(b_plan != "" && b_plan2 != null){
										bana = b_plan + "<b>" + " : " + "</b>" + b_plan2 + "<BR>";
									}else if(b_plan != "" && b_plan2 == null){
										bana = b_plan + "<BR>";
									}else if(b_plan == "" && b_plan2 != null){
										bana = b_plan2 + "<BR>";
									}else{
										bana = "<BR>";
									}
									if(b_place != "" && b_place2 != null){
										bana = bana + b_place + "<b>" + " : " + "</b>" + b_place2 + "<BR>";
									}else if(b_place != "" && b_place2 == null){
										bana = bana + b_place + "<BR>";
									}else if(b_place == "" && b_place2 != null){
										bana = bana + b_place2 + "<BR>";
									}else{
										bana = bana + "<BR>";
									}
									
								    // 2013-06-18 �ύX��:��ؗ��q 21304
									//if(b_plan == "" && b_plan2 == null && b_place == "" && b_place2 == null){
									if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
									
										bana = "�o�i�[<BR>�ڍ׏��Ȃ�";
									}
									if( bmemo == null || bmemo.equals("")){
										bmemo = "";
									}else{
										bmemo = "<b><����></b><BR>"+ bmemo +"";
									}
									/*
									if( bmemo != null ){
										bmemo = "<b><����></b><BR>"+ bmemo +"";
									}else{
										bmemo = "";
									}
									/*      20130111  ��L�C��
									if(bmemo == null){
										bmemo = "";
									}else{
										bmemo = "<b><����></b><BR>"+ bmemo +"";
									}
									*/
									%>
									<A HREF="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Month-b&act=" TARGET="sub02"">
										<font size="2">
											<%= bana + bmemo %>
										</font>
									</A>
									<%
								}else{%>�@<%}
								%>
								</td>
							</tr>
						</table>
						<%
					}
					rs3.close();
					sFmt = new SimpleDateFormat("yyyyMMdd");
					// �X�P�W���[���̌Ăяo��
					ResultSet rs6 = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) +"' AND GO_�Ј�NO = '"+ no +"'");
					while(rs6.next()){
						String s_place = rs6.getString("S_PLACE").trim();		//�ꏊ�擾
						String s_place2 = rs6.getString("S_PLACE2");			//�ꏊ�ڍ׎擾
						String s_plan = rs6.getString("S_PLAN").trim();			//�\��擾
						String s_plan2 = rs6.getString("S_PLAN2");				//�\��ڍ׎擾
						s_date = rs6.getString("S_DATE").substring(0,10);
						s_start = rs6.getString("S_START");
						s_end = rs6.getString("S_END");
						memo = rs6.getString("S_MEMO");
						String S_sTimeM = s_start.substring(2,4);				//�J�n�������u���v��
						String S_sTimeH = s_start.substring(0,2);				//          �u���v�ɕ���
						String S_eTimeM = s_end.substring(2,4);					//�I���������u���v��
						String S_eTimeH = s_end.substring(0,2);					//          �u���v�ɕ���

						String sche = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "�`" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";

						if(s_plan.equals("--")){
							s_plan = "";
						}
						if(s_place.equals("--")){
							s_place = "";
						}
						if(s_plan != "" && s_plan2 != null){
							sche = sche + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<br>";
						}else if(s_plan != "" && s_plan2 == null){
							sche = sche + s_plan + "<BR>";
						}else if(s_plan == "" && s_plan2 != null){
							sche = sche + s_plan2 + "<BR>";
						}else{
							sche = sche + "<br>";
						}
						if(s_place != "" && s_place2 != null){
							sche = sche + s_place + "<b>" + " : " + "</b>" + s_place2 + "<BR>";
						}else if(s_place != "" && s_place2 == null){
							sche = sche + s_place + "<BR>";
						}else if(s_place == "" && s_place2 != null){
							sche = sche + s_place2 + "<br>";
						}else{
							sche = sche + "<br>";
						}
						s_date = rs6.getString("S_DATE");
						s_start = rs6.getString("S_START");
						memo = rs6.getString("S_MEMO");
						if( memo == null || memo.equals("")){
							memo = "";
						}else{
							memo = "<b><����></b><BR>"+ memo +"";
						}
						/*
						if( memo != null ){
							memo = "<b><����></b><BR>"+ memo +"";

						}else{
							memo = "";
						}
						/*      20130111  ��L�C��
						if(memo == null){
							memo = "";
						}else{
							memo = "<b><����></b><BR>"+ memo +"";
						}
						*/
						%>
						<A HREF="timeUp.jsp?id=<%= ID %>&no=<%= no %>&group=<%= post %>&s_date=<%= s_date.substring(0,10) %>&s_start=<%= s_start %>&b_start=&kind=Month-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){ send<%=mincnt%>('<%= ID %>','<%= no %>','<%= s_date.substring(0,10) %>','<%= s_start %>');return false;}">
							<font size="2">
								<%= sche + memo %>
							</font>
						</A>
						<%
						}
					rs6.close();
					%>
					<script language="JavaScript1.2">
					<!--
						function deleteCookie(theName){
							document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
							return true;
						}
						function send<%= mincnt %>(id,no,date,start){
							alert("�X�P�W���[�����R�s�[���܂��B");
							var charid = id;
							var charno = no;
							var charde = date;
							var charst = start;
							deleteCookie(charid,charno,charde,charst);
							document.cookie = "id="+charid+";";
							document.cookie = "no="+charno+";";
							document.cookie = "s_date="+charde+";";
							document.cookie = "s_start="+charst+";";
							// ���_�C���N�g����
							parent.main.location.href = "tryagain.jsp?id=<%= ID %>&no=<%= no %>&s_date="+ charde +"&s_start=<%= s_start %>&group=<%= post %>&kind=Month";
						}
						function miseru<%= xxx %>(no,date,kd){
							alert("�X�P�W���[����\������܂��B");
							var charno = no;
							var charde = date;
							var charkd = kd;
							// JavaScript�ɂ��Cookie����̔����o��
							theCookie = document.cookie + ";";
							Sid = theCookie.indexOf("id");
							Sno = theCookie.indexOf("no");
							Ss_date = theCookie.indexOf("s_date");
							Ss_start = theCookie.indexOf("s_start");
							if(Sid != -1){
								Eid = theCookie.indexOf(";",Sid);
								Eid = theCookie.substring(Sid + 3,Eid);
							}
							if(Sno != -1){
								Eno = theCookie.indexOf(";",Sno);
								Eno = theCookie.substring(Sno + 3,Eno);
							}
							if(Ss_date != -1){
								Es_date = theCookie.indexOf(";",Ss_date);
								Es_date = theCookie.substring(Ss_date + 7,Es_date);
							}
							if(Ss_start != -1){
								Es_start = theCookie.indexOf(";",Ss_start);
								Es_start = theCookie.substring(Ss_start + 8,Es_start);
							}
							parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind="+ charkd +"";
						}
					//-->
					</script>
					<%
					mincnt = mincnt + 1;
					xxx = xxx + 1;
					j = j + 1;
				}
			}
			%>
			</td>
			</tr>
		</table>
		<%
		stmt.close();
		con.close();
		%>
	</body>
</html>
