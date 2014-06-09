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
// 02-08-16 �p�����[�^���C��
// 02-09-02 �p�����[�^�̑����̕ύX[�Q��ʂɕύX�����̂ŁAsub02�ɂ̂ݑ���]
// 13-06-18 �o�i�[�𖢋L���œo�^����ƕύX�A�폜���ł��Ȃ����ۂ��C���B
/* �ǉ��_ */
// 02-08-15 �x�݊֘A�̗\���I���������ɁA�o�i�[�X�P�W���[���̐F��ύX����B
// 02-08-15 �O���E�����Ɉړ��ł���悤�Ƀ{�^����z�u�B
// 02-08-30 �{���̓��t��_�ł���B

try{
	// JDBC�h���C�o�̃��[�h
	Class.forName("org.postgresql.Driver");

	// ���O�C���������[�U�̎Ј��ԍ���ϐ�[ID]�Ɋi�[
	String ID = strEncode(request.getParameter("id"));

	// �p�����[�^�̎󂯎��F�O���[�v�R�[�h
	String post = request.getParameter("group");

	// �f�[�^�x�[�X�֐ڑ�
	String user = "georgir";
	String password = "georgir";

	Connection dbConn = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

	Statement stmt = dbConn.createStatement();

	/* �O���[�v�R�[�h�E�O���[�v�����R���{�{�b�N�X�ɕ\�����邽�߂̏��� */
	// SQL�̎��s�E�O���[�v���
	ResultSet GROUP = stmt.executeQuery("SELECT * FROM KINMU.GRU ORDER BY G_GRUNO");

	// �O���[�v������A�O���[�v�ɏ������Ă���Ј����ꗗ��\��
	Vector gruNO = new Vector();
	Vector gruNAME = new Vector();

	// �O���[�v��
	while(GROUP.next()){
		String gname = GROUP.getString("G_GRNAME");
		String gnum = GROUP.getString("G_GRUNO");
		gruNO.addElement(gnum);
		gruNAME.addElement(gname);
	}

	int hitGRU = gruNO.size();

	GROUP.close();

	/* �����E�O���[�v�R�[�h�EID���擾 */
	// SQL�̎��s�E�l���
	ResultSet KOJIN = stmt.executeQuery("SELECT K_����, K_GRUNO, K_ID FROM KINMU.KOJIN ORDER BY K_PASS2 , K_�Ј�NO");

	Vector kojNAME = new Vector();
	Vector kojGRU = new Vector();
	Vector kojID = new Vector();

	// �Ј���
	while(KOJIN.next()){
		String name = KOJIN.getString("K_����");
		String gru = KOJIN.getString("K_GRUNO");
		String id = KOJIN.getString("K_ID");
		kojNAME.addElement(name);
		kojGRU.addElement(gru);
		kojID.addElement(id);
	}

	int hitKOJ = kojNAME.size();

	KOJIN.close();

	// �J�����_�[���Ăяo��
	GregorianCalendar cal = new GregorianCalendar();

	// ���N:calYear
	int calYear = Integer.parseInt(""+ cal.get(Calendar.YEAR));

	// ����:calMonth
     	int calMonth = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));
	int calDayofWeek = Integer.parseInt(""+ cal.get(Calendar.WEEK_OF_MONTH));

	// �_�ŗp�F�{���̓��t
	Date kyo = cal.getTime();

	// ���̍ŏ��̏T:sWeekofMonth
	int calToday = Integer.parseInt(""+ cal.get(Calendar.DATE));

     	cal.set( calYear, calMonth-1, 0 );

	int calDate = Integer.parseInt(""+ cal.get(Calendar.DATE));
	int calWeek = Integer.parseInt(""+ cal.get(Calendar.DAY_OF_WEEK));

	String strMonth = request.getParameter("month");
	String strYear = request.getParameter("year");
	String strToday = request.getParameter("today");
	String strC = request.getParameter("c");

	int Year = 0;
	int Month = 0;
	int Today = 0;
	int C = 0;

	// �X�P�W���[���J�E���g�p�ϐ�
	int mincnt = 0;
	int xxx = 0;

	// Year
	if(strYear != null){

		Year = Integer.parseInt(strYear);
	}
	else{
		Year = calYear;
  	}

	// Month
	if(strMonth != null){
   		Month = Integer.parseInt(strMonth);
	}
	else{
		Month = calMonth;
	}

	// Today
	if(strToday != null){
		Today = Integer.parseInt(strToday);
	}
	else{
		Today = calToday;
	}

	// �J�����_�[�\��

	int i = 0;
	String strReturn = request.getParameter("s_date");
	if(strReturn != null){
		String reYear = strReturn.substring(0,4);
		String reMonth = strReturn.substring(5,7);
		String reDay = strReturn.substring(8,10);
		Year = Integer.parseInt(reYear);
		Month = Integer.parseInt(reMonth);
		Today = Integer.parseInt(reDay);
	}

	// �����̓�:eDay
	cal.set(Year, Month-1, 0);
     	int eDay = cal.get( Calendar.DATE );

	// �����̓�2:eDay2
	cal.set(Year, Month, 0);
     	int eDay2 = cal.get( Calendar.DATE );

	cal = new GregorianCalendar();
	cal.set(Year, Month-1, Today);
	int c = Integer.parseInt(""+ cal.get(Calendar.DATE));
	int d = Integer.parseInt(""+ cal.get(Calendar.DAY_OF_WEEK));

	// �������
	cal.set(Year,Month,c);
	int aftDay = Integer.parseInt(""+ cal.get(Calendar.DATE));
	int aftMonth = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));
	int aftYear = Integer.parseInt(""+ cal.get(Calendar.YEAR));

	// �O�����
	cal.set(Year,Month-2,c);
	int bfrDay = Integer.parseInt(""+ cal.get(Calendar.DATE));
	int bfrMonth = Integer.parseInt(""+ (cal.get(Calendar.MONTH) + 1));
	int bfrYear = Integer.parseInt(""+ cal.get(Calendar.YEAR));

	// ��{�ݒ�F���t
	cal.set(Year,Month-1,c);

	// ���T���
	cal.add(Calendar.DATE,7);
	String o = ""+ cal.get(Calendar.YEAR);
	int pp = cal.get(Calendar.MONTH) + 1;
	String p = ""+ pp;
	String q = ""+ cal.get(Calendar.DATE);

	// �O�T���
	cal.add(Calendar.DATE,-14);
	String r = ""+ cal.get(Calendar.YEAR);
	int ss  = cal.get(Calendar.MONTH) + 1;
	String s = ""+ ss;
	String t = ""+ cal.get(Calendar.DATE);

	cal.set(Year,Month-1,c);
	for( i = d; i > 1; i--){
	        c = c - 1;
		if(c == 0){
			Month = Month - 1;
			c = eDay;
			eDay2 = eDay;
		}
	}
	if(Month == 0){
		Month = 12;
		Year = Year - 1;
	}

	Date x = cal.getTime();
	SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");
	String z = sFmt.format(x);

	int f = 0;
	f = c;
	cal.set( Year, Month-1, c);
	Date thisMonth = cal.getTime();

	String hajime = sFmt.format(thisMonth).substring(0,10);
%>
<HTML>
<HEAD>
<TITLE>�X�P�W���[���T�\��</TITLE>
<STYLE TYPE="text/css">
.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
</STYLE>
</HEAD>
<BODY BGCOLOR="#99A5FF">
<TABLE BORDER="0">
 <TR>
  <TD><FORM ACTION="tryagain.jsp" METHOD="POST"><INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>"><INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>"><INPUT TYPE="submit" VALUE="���\��" title="���\���Ɉړ����܂��B"></FORM></TD>
  <TD><FORM ACTION="TestExample34.jsp" METHOD="POST"><INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>"><INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>"><INPUT TYPE="submit" VALUE="�T�\��" title="�T�\���Ɉړ����܂��B"></FORM></TD>
  <TD><FORM ACTION="h_hyoji.jsp" METHOD="POST"><INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>"><INPUT TYPE="hidden" NAME="group" VALUE="<%= post %>"><INPUT TYPE="submit" VALUE="���\��" title="���\���Ɉړ����܂��B"></FORM></TD>
  <TD><FORM ACTION="menu.jsp" METHOD="POST" TARGET="_top"><INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>"><INPUT TYPE="submit" VALUE="���C�����j���[�֖߂�" title="���C�����j���[�ɖ߂�܂��B"></FORM></TD>
 </TR>
</TABLE>
<TABLE BORDER="0" WIDTH="100%">
 <TR>
  <TD>
  <table border="0">
   <tr>
    <FORM action="TestExample34.jsp">
    <td>
     <FONT COLOR="white">
     <SPAN CLASS="shadow">
     �O���[�v��
     </SPAN>
     </FONT>
    </td>
    <td VALIGN="top">
     <SELECT NAME="group" STYLE=WIDTH:200>
<%
	int j = -1;
	for(i = 0; i < hitGRU; i++){
		if(gruNO.elementAt(i).equals(post)){
			j = i;
		}
	}
	for(i = 0; i < hitGRU; i++){
		if(i == j){
			%><OPTION VALUE="<%= gruNO.elementAt(i) %>" SELECTED><%= gruNAME.elementAt(i) %></OPTION><%
		}else{
			%><OPTION VALUE="<%= gruNO.elementAt(i) %>"><%= gruNAME.elementAt(i) %></OPTION><%
		}
	}
%>
      <input type="hidden" name="group" value="<%= post %>">
      <input type="hidden" name="id" value="<%= ID %>">
      <input type="submit" value="�\��" title="���L�̃O���[�v��\�����܂��B">
     </SELECT>
    </td>
    </FORM>
   </tr>
  </table>
  <center>
  <table border="0">
   <tr>
    <%--  �O�̌���  --%>
    <form method="post" action="TestExample34.jsp">
    <td>
     <input type="hidden" name="id" value="<%= ID %>">
     <input type="submit" name="previous" value="�O�̌�" title="�O�̌��Ɉړ����܂��B">
     <input type="hidden" name="today" value="<%= bfrDay %>">
     <input type="hidden" name="month" value="<%= bfrMonth %>">
     <input type="hidden" name="year" value="<%= bfrYear %>">
     <input type="hidden" name="group" value="<%= post %>">
    </td>
    </form>
    <%--  �O�̏T��  --%>
    <form method="post" action="TestExample34.jsp">
    <td>
     <input type="hidden" name="id" value="<%= ID %>">
     <input type="submit" name="previous" value="�O�̏T" title="�O�̏T�Ɉړ����܂��B">
     <input type="hidden" name="today" value="<%= t %>">
     <input type="hidden" name="month" value="<%= s %>">
     <input type="hidden" name="year" value="<%= r %>">
     <input type="hidden" name="group" value="<%= post %>">
    </td>
    </form>
    <td>
     <SPAN CLASS="shadow">
     <font size="6" color="white" title="���j�����ΏۂɂȂ��Ă��܂��B">
     <b><i>
<%
	// �����̓��t
	out.print(Year + "�N" + Month + "��");
%>
     </i></b>
     </font>
     </SPAN>
    </td>
    <%--  ���̏T�ց@--%>
    <form method="post" action="TestExample34.jsp">
    <td>
     <input type="hidden" name="id" value="<%= ID %>">
     <input type="submit" name="next" value="���̏T" title="���̏T�Ɉړ����܂��B">
     <input type="hidden" name="today" value="<%= q %>">
     <input type="hidden" name="month" value="<%= p %>">
     <input type="hidden" name="year" value="<%= o %>">
     <input type="hidden" name="group" value="<%= post %>">
    </td>
    </form>
    <%--  ���̌��ց@--%>
    <form method="post" action="TestExample34.jsp">
    <td>
     <input type="hidden" name="id" value="<%= ID %>">
     <input type="submit" name="next" value="���̌�" title="���̌��Ɉړ����܂��B">
     <input type="hidden" name="today" value="<%= aftDay %>">
     <input type="hidden" name="month" value="<%= aftMonth %>">
     <input type="hidden" name="year" value="<%= aftYear %>">
     <input type="hidden" name="group" value="<%= post %>">
    </td>
    </form>
   </tr>
  </table>
  </center>
  <%--�@�����ȃe�[�u����傫�ȃe�[�u���ł�����@--%>
  <table width="100%" border="1">
   <tr>
    <%--�@�Ј����e�[�u���@--%>
    <td width="10%" bgcolor="white">
     <center>���O</center>
    </td>
    <%--  �j���e�[�u��  --%>
    <td width="13%" bgcolor="pink">
     <center><font color="red">��</font></center>
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
     <center><font color="blue">�y</font></center>
    </td>
   </tr>
   <%-- �X�P�W���[���o�^�p�{�b�N�X�쐬     --%>
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

// �����̓��t���w�肵���`���Ƀt�H�[�}�b�g����
sFmt = new SimpleDateFormat("yyyy-MM-dd");
String kyo2 = sFmt.format(kyo);

// �Ј����̃��[�v
int AMonth = Month;
int AYear = Year;
for(i=0; i<hitKOJ; i++){
	Month = AMonth;
	Year = AYear;
	if(kojGRU.elementAt(i).equals(post)){
%>
   <%--�@�Ј����\���p�{�b�N�X�@--%>
   <tr>
    <td bgcolor="white">
     <font size="2"><%= kojNAME.elementAt(i) %></font>
    </td>
<%
		// �T���ɕ\��
		c = f;
		for(j=0; j<7; j++){

			// ���̌��̂P��
			if(c == eDay2 + 1){
				c = 1;
				Month = Month +1;
			}

			// �N���z��
			if(Month == 12){
				Month = 0;
				Year = Year + 1;
			}

			// �x���F�w�肵�������r�ł���悤��
			cal.set( Year, Month-1, c);
			thisMonth = cal.getTime();


			sFmt = new SimpleDateFormat("yyyyMMdd");
			int e = Integer.parseInt(""+ cal.get(Calendar.DAY_OF_WEEK));

			ResultSet HOLIDAY = stmt.executeQuery("SELECT * FROM KINMU.HOLIDAY WHERE H_�N���� = '"+ sFmt.format(thisMonth) +"'");

			// �x����荞�ݗp�ϐ��̏�����
			String yasumi = "";

		        while(HOLIDAY.next()){
        			yasumi = HOLIDAY.getString("H_�x����");
			}

			HOLIDAY.close();

			// �j�����Ƀo�b�N�O�����h�̐F��ύX����
			sFmt = new SimpleDateFormat("yyyy-MM-dd");
			if(sFmt.format(thisMonth).equals(kyo2)){
				// ����
				%><td height="50" align="left" valign="top" bgcolor="lavender"><%
			}
			else if(yasumi != ""){
				// �j��
				%><td height="50" align="left" valign="top" bgcolor="pink"><%
			}
			else if(j == 0){
				// ���j
				%><td height="50" align="left" valign="top" bgcolor="pink"><%
			}
			else if(j == 6){
				// �y�j
				%><td height="50" align="left" valign="top" bgcolor="skyblue"><%
			}
			else{
				// ����
				%><td height="50" align="left" valign="top" bgcolor="white"><%
			}

			// �Ј��������[�UID�֐؂�ւ���
			ResultSet KOJNAME = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_����='" + kojNAME.elementAt(i)+ "'");

			// �Ј�����荞�ݗp�ϐ��̏�����
			String no = "";

			while(KOJNAME.next()){
				no = KOJNAME.getString("K_ID");
			}

			KOJNAME.close();

			cal.set( Year, Month-1, c);
			thisMonth = cal.getTime();
			sFmt = new SimpleDateFormat("yyyy-MM-dd");

			%><A HREF="timeIn.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(thisMonth) %>&s_start=&b_start=&group=<%= post %>&kind=Week&act=" TARGET="sub02" title="�V�K�o�^�ł��܂��B" oncontextmenu="if(!event.ctrlKey){ no='<%= no %>';date='<%= sFmt.format(thisMonth) %>'; miseru<%=xxx%>(no,date);return false}"><%

			sFmt = new SimpleDateFormat("M/d");
%>
    <%= sFmt.format(thisMonth) %>
    </a>
    <font color="red"><%= yasumi %></font><br>
<%
			//�o�i�[�̌Ăяo���A�\��
			sFmt = new SimpleDateFormat("yyyy-MM-dd");
			ResultSet BANA = stmt.executeQuery("SELECT * FROM B_TABLE WHERE K_�Ј�NO = '"+ no +"' AND B_START <= '"+ sFmt.format(thisMonth) +"' AND '"+ sFmt.format(thisMonth) +"' <= B_END");

			while(BANA.next()){
				b_start = BANA.getString("B_START").substring(0,10);
				b_plan = BANA.getString("B_PLAN").trim();
				if((b_plan.equals("�x��"))||(b_plan.equals("�ċx"))){
					iro = "orange";
				}
				else{
					iro = "yellow";
				}

				%><table bgcolor="<%= iro %>" width="100%"><tr><td><%

				if(b_start.equals(sFmt.format(thisMonth)) || hajime.equals(sFmt.format(thisMonth))){

					b_plan2 = BANA.getString("B_PLAN2");
					b_place = BANA.getString("B_PLACE").trim();
					b_place2 = BANA.getString("B_PLACE2");
					bmemo = BANA.getString("B_MEMO");

					if(b_plan.equals("--")){
						b_plan = "";
					}
					if(b_place.equals("--")){
						b_place = "";
					}
					if(b_plan != "" && b_plan2 != null){

						b_plan2 = "<b>" + " : " + "</b>" + b_plan2;
					}else if(b_place2 == null){
						b_plan2 = "";
					}
					if(b_place != "" && b_place2 != null){

						b_place2 = "<b>" + " : " + "</b>" + b_place2;
					}else if(b_place2 == null){
						b_place2 = "";
					}

					if( bmemo == null || bmemo.equals("") ){
						bmemo = "";
					}else{
						bmemo = "<b><����></b><BR>"+ bmemo +"";
					}
					/*if(bmemo == null){
						bmemo = "";
					}
					else{
						bmemo = "<b><����></b><BR>"+ bmemo +"";
					}*/
					
					// 2013-06-18 �ύX��:��ؗ��q 21304
					//if(b_plan == "" && b_plan2 == "" && b_place == "" && b_place2 == "" && bmemo == ""){
					if(b_plan.length() == 0 && b_plan2.length() == 0 && b_place.length() == 0 && b_place2.length() == 0){
						bana = "�o�i�[<BR>�ڍ׏��Ȃ�";
					}else{
						bana = b_plan + b_plan2 + "<br>" + b_place + b_place2;
					}
					%><a href="dayUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=&s_start=&b_start=<%= b_start %>&group=<%= post %>&kind=Week-b&act=" TARGET="sub02" title="<%= bmemo %>">
						<font size=2>
							<%= bana + bmemo%>
						</font>
					</a>
					</td></tr></table>
					<%
				}else{
					%>�@</td></tr></table><%
				}
			}
			BANA.close();

			// �X�P�W���[���\��
			sFmt = new SimpleDateFormat("yyyy-MM-dd");
			cal.set( Year, Month-1, c);
			thisMonth = cal.getTime();

			ResultSet SCHE = stmt.executeQuery("SELECT * FROM S_TABLE WHERE S_DATE = '"+ sFmt.format(thisMonth) + "' AND GO_�Ј�NO = '"+ no +"'");

			String s_date = "";
			String s_start = "";
			String s_end = "";
			String shyou1 = "";
			String shyou2 = "";
			String memo = "";

			while(SCHE.next()){


			String s_place = SCHE.getString("S_PLACE").trim();		//�ꏊ�擾
			String s_place2 = SCHE.getString("S_PLACE2");			//�ꏊ�ڍ׎擾
			String s_plan = SCHE.getString("S_PLAN").trim();		//�\��擾
			String s_plan2 = SCHE.getString("S_PLAN2");				//�\��ڍ׎擾

			s_date = SCHE.getString("S_DATE").substring(0,10);
			s_start = SCHE.getString("S_START");
			s_end = SCHE.getString("S_END");
			memo = SCHE.getString("S_MEMO");


			String S_sTimeM = s_start.substring(2,4);				//�J�n�������u���v��
			String S_sTimeH = s_start.substring(0,2);				//          �u���v�ɕ���
			String S_eTimeM = s_end.substring(2,4);					//�I���������u���v��
			String S_eTimeH = s_end.substring(0,2);					//          �u���v�ɕ���

				shyou1 = "<b>" + "<" + S_sTimeH + ":" + S_sTimeM + "�`" + S_eTimeH + ":" + S_eTimeM + ">" + "</b>" + "<br>";
				shyou2 = "";
				if(s_plan.equals("--")){
					s_plan = "";
				}
				if(s_place.equals("--")){
					s_place = "";
				}

				if(s_plan != "" && s_plan2 != null){
					shyou2 = shyou2 + s_plan + "<b>" + " : " + "</b>" + s_plan2 + "<BR>";
				}else if(s_plan != "" && s_plan2 == null){
					shyou2 = shyou2 + s_plan + "<br>";
				}else if(s_plan == "" && s_plan2 != null){
					shyou2 = shyou2 + s_plan2 + "<BR>";
				}else{
					shyou2 = "<BR>";
				}

				if(s_place != "" && s_place2 != null){
					s_place2 = "<b>" + " : " + "</b>" + s_place2;
					shyou2 = shyou2 + s_place + s_place2 + "<br>";
				}else if(s_place == "" && s_place2 == null){
					//�������Ȃ�
				}else if(s_place != "" && s_place2 == null){
					shyou2 = shyou2 + s_place + "<br>";
				}else{
					shyou2 = shyou2 + s_place2 + "<br>";
				}

				if( memo == null || memo.equals("") ){
					memo = "";
				}else{
					memo = "<b><����></b><BR>"+ memo +"";
				}
				/*if(memo == null){
					memo = "";
				}else{
					memo = "<b><����></b><BR>"+ memo +"";
				}*/
				%>
				<a href="timeUp.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= s_date %>&s_start=<%= s_start %>&b_start=&group=<%= post %>&kind=Week-u&act=" TARGET="sub02" oncontextmenu="if(!event.ctrlKey){id='<%= ID %>';no='<%= no %>';date='<%= s_date %>';start='<%= s_start %>'; send<%=mincnt%>(id,no,date,start);return false;}">
					<font size=2>
						<%= shyou1 + shyou2 + memo %>
					</font>
				</a><%
			}
			SCHE.close();
				%>
				<script language="JavaScript1.2">
<!--
					function deleteCookie(theName){
						document.cookie = theName + "=;expires=Thu," + "01-Jan-70 00:00:01 GMT";
						return true;
					}
					function send<%= mincnt %>(a,b,c,d){
						alert("�X�P�W���[�����R�s�[���܂��B");
						var charid = a;
						var charno = b;
						var charde = c;
						var charst = d;
						deleteCookie(charid,charno,charde,charst);
						document.cookie = "id="+charid+";";
						document.cookie = "no="+charno+";";
						document.cookie = "s_date="+charde+";";
						document.cookie = "s_start="+charst+";";
						// ���_�C���N�g����
						parent.main.location.href = "TestExample34.jsp?id=<%= ID %>&no=<%= no %>&s_date=<%= sFmt.format(thisMonth) %>&s_start=<%= s_start %>&group=<%= post %>&kind=Week";
					}
					function miseru<%= xxx %>(no,date){
						alert("�X�P�W���[����\������܂��B");
						var charno = no;
						var charde = date;
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
						parent.main.location.href = "copyInsert.jsp?id="+ Eid +"&no="+ Eno +"&no2="+ charno +"&s_date="+ Es_date +"&s_date2="+ charde +"&s_start="+ Es_start +"&group=<%= post %>&kind=Week";
					}
//-->
				</script>
				<%
				mincnt = mincnt + 1;
				xxx = xxx + 1;
				c = c + 1;
			}
			%></tr></TD></TR><%
		}
	}
	stmt.close();
	dbConn.close();
}
catch(Exception e){
	e.printStackTrace();
}
%>
</TABLE>
</BODY>
</HTML>
