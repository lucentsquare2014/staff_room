<%@ page language="java" contentType="text/html; charset=shift_JIS"pageEncoding="shift_JIS"session="true"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.common.*" %><%@ page import = "kkweb.dao.HolidayDAO" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" /><%@ page import = "kkweb.beans.B_HolidayMST" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){		
			pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
	window.onunload=function(){
		document.body.style.cursor='auto';
		document.a.aa.disabled=false;
		document.b.bb.disabled=false;
	}
	function submit1(){
		document.body.style.cursor='wait';
		document.a.aa.disabled=true;
		document.b.bb.disabled=true;			
		document.a.submit()
	}	
	function submit2(){
		document.body.style.cursor='wait';
		document.a.aa.disabled=true;
		document.b.bb.disabled=true;
		document.b.submit()
	}	
</script>
<title>���F�˗����̋Ζ��񍐏�</title>
</head>
<BODY>
<CENTER>
<font class="title">�Ζ��񍐏��i���F�˗����j</font><BR><hr color = "#008080">
<table>
<tr><td align="left"><small>1.�u���F�v����������A���̃y�[�W�ŏ��F�������A�������͍ď��F�˗������Ă��������B</small></td></tr>
<tr><td align="left"><small>2.�u�ԋp�v�������ƁA���͎ҁA�������͏��F�o�H�̑O�҂Ƀ��[���𑗐M���܂��B</small></td></tr>
</table>
</CENTER><hr color = "#008080"><br>
<%	request.setCharacterEncoding("Windows-31J");
	String iraisha_number = request.getParameter("iraisha_number");
	String iraisha_name = request.getParameter("iraisha_name");
	String iraisha_year_month = request.getParameter("iraisha_year_month");
	iraisha_year_month = iraisha_year_month.trim();
	String sql = " where number = '" + iraisha_number + "' AND year_month ='"+iraisha_year_month+"'";
	ArrayList golist = new ArrayList();
	GoukeiDAO goukeidao = new GoukeiDAO();
	golist = goukeidao.selectTbl(sql);
	B_GoukeiMST b_goukei = new B_GoukeiMST();
	b_goukei = (B_GoukeiMST)golist.get(0);%>
<B>�������F�o�H����</B>
<TABLE>
<TR>
<TD><%= b_goukei.getSyouninRoot() %><BR></TD>
</TR>
</TABLE>
<%	C_CheckMonth ccm = new C_CheckMonth();
	String year = iraisha_year_month.substring(0,4);
	String month =iraisha_year_month.substring(4);
	month = ccm.MonthCheck(month);%>
<CENTER>
<FONT size="4"><B><%= iraisha_name %> �F <%=year%>�N�@<%=month%>��</B></FONT><BR>
<table border="1"  cellspacing="0" class="houkoku">
<TR>
<TH class="t-koumoku" ><font class="f-koumoku">��</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">�j��</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">�o�R�[�h</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">�o�Ύ���</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">�ދΎ���</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">���ߎ���</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">�[�鎞��</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">���ڎ���</font></TH>
<TH class="t-koumoku" ><font class="f-koumoku">���l</font></TH>
</TR>
<%	String holiday = "";
	String day = "";
	
	String month_day = "";
	int thisMonth = Integer.parseInt(month+"00");
	int nextMonth = thisMonth+100;

	Calendar cal = Calendar.getInstance();
	C_Lastday cld = new C_Lastday();
	int lastday = cld.lastday(year,month);
	C_GetWeekday cgwd = new C_GetWeekday();
	C_HolidayBackcolor chbc = new C_HolidayBackcolor();
	C_CheckTime cct = new C_CheckTime();
	C_CheckGoukei ccg = new C_CheckGoukei();
	C_Holiday ch = new C_Holiday();
	KinmuDAO kdao = new KinmuDAO();
	sql = " where number='"+iraisha_number+"' AND year_month='"+iraisha_year_month+"' order by to_number(hizuke,'99')";
	ArrayList klist = kdao.selectTbl(sql);
	
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);
	
	B_HolidayMST bhmst = new B_HolidayMST();
	int cnt = 0;
	
	for(int i = 1; i <= lastday; i++){
		B_KinmuMST bkmst = new B_KinmuMST();
		bkmst = (B_KinmuMST)klist.get(i-1);
		String youbi = cgwd.weekday(year,month,i);
		if(thisMonth<1000){
			month_day = "0" + Integer.toString(thisMonth + i);
		}else{
			month_day = Integer.toString(thisMonth + i);				
		}
		if(holiArray.size() != 0 && holiArray != null && holiArray.size() > cnt){
			bhmst = (B_HolidayMST)holiArray.get(cnt);
			
			if(month_day.equals(bhmst.getSYUKUJITUdate())){
				holiday = bhmst.getSYUKUJITUname();
				cnt++;
				
			}
		}
	//	String holiday = ch.holiday(iraisha_year_month,i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td align="center" style="width:25"><%= i %><br></td>
<td align="center"><%= youbi %><br></td>
<td align="center"><%= bkmst.getPROJECTcode() %><br></td>
<td align="center"><%= cct.checktime(bkmst.getStartT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getEndT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyoukaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getSinyaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyokuT()) %><br></td>
<td align="center" class="biko"><font class="biko"><%= bkmst.getPROJECTname()+""+bkmst.getSYUKUJITUname() %></font><br><div align="right"><font size="1">-<%= cct.checktime(bkmst.getFurouT()) %><br></font></div></td>
</tr>
<%	holiday = "";
}%>
</TABLE>
<br />
<table border="1"class="houkoku" cellspacing="0">
<tr>
<th class="t-koumoku"><font class="f-koumoku">���ߎ���</font></th>
<th class="t-koumoku"><font class="f-koumoku">�[�鎞��</font></th>
<th class="t-koumoku"><font class="f-koumoku">�s�J����</font></th>
<th class="t-koumoku"><font class="f-koumoku">�x�o����</font></th>
<th class="t-koumoku"><font class="f-koumoku">��x����</font></th>
<th class="t-koumoku"><font class="f-koumoku">�N�x����</font></th>
<th class="t-koumoku"><font class="f-koumoku">���Γ���</font></th>
<th class="t-koumoku"><font class="f-koumoku">�`�x�v</font></th>
<th class="t-koumoku"><font class="f-koumoku">�a�x�v</font></th>
<th class="t-koumoku"><font class="f-koumoku">���v����</font></th>
</tr>
<TR>
<TD align="right"><%= ccg.checkgoukei(b_goukei.getCyoukaMONTH()) %></TD>
<TD align="right"><%= ccg.checkgoukei(b_goukei.getSinyaMONTH()) %></TD>
<TD align="right"><%= ccg.checkgoukei(b_goukei.getFurouMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getKyudeMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getDaikyuMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getNenkyuMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getKekkinMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getAkyuMONTH()) %></TD>
<TD align="right"><%= ccg.checknissu(b_goukei.getBkyuMONTH()) %></TD>
<TD align="right"><%= ccg.checkgoukei(b_goukei.getGoukeiMONTH()) %></TD>
</TR>
</TABLE>
</CENTER>
<CENTER>
<table border="1"class="houkoku" cellspacing="0">
<tr>
<th class="t-koumoku"><font class="f-koumoku">���N�t�^����</font></th>
<th class="t-koumoku"><font class="f-koumoku">�J�z�N�x����</font></th>
<th class="t-koumoku"><font class="f-koumoku">�g�p�N�x����</font></th>
<th class="t-koumoku"><font class="f-koumoku">�c�N�x����</font></th>
<th class="t-koumoku"><font class="f-koumoku">���Ԏc�Ǝ���</font></th>
<th class="t-koumoku"><font class="f-koumoku">�N�ԗݐώc�Ǝ���</font></th>
</tr>
<TR>
<%	NenkyuDAO_work ndao_work = new NenkyuDAO_work();
	sql = " where number ='"+iraisha_number+"' and year_month ='"+iraisha_year_month+"'" ;
	ArrayList nlist = ndao_work.selectTbl(sql);
	B_NenkyuMST_work nmst = new B_NenkyuMST_work();
	nmst = (B_NenkyuMST_work)nlist.get(0);%>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_fuyo())  %></td>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_kurikoshi()) %></td>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_year())  %></td>
<%	if(!nmst.getNenkyu_all().equals("") && nmst.getNenkyu_all().substring(0,1).equals("-")){%>
<td align="center"><font color="red"><%=  ccg.checknissu(nmst.getNenkyu_all())  %></font></td>
<%	}else{%>
<td align="center"><%=  ccg.checknissu(nmst.getNenkyu_all())  %></td>
<%	}
	ZangyouDAO zdao = new ZangyouDAO();
	sql = " where number ='"+iraisha_number+"' AND year ='"+year+"' AND month ='"+month+"'";
	ArrayList zlist = zdao.selectTbl(sql);
	B_ZangyouMST zmst = new B_ZangyouMST();
	zmst = (B_ZangyouMST)zlist.get(0);
	if(Integer.parseInt(zmst.getZangyoumonth()) > 9000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></td>
<%	}if(Integer.parseInt(zmst.getGoukeiZangyou()) > 100000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></td>
<%	}%>
</TR>
</TABLE><BR>
<TABLE>
<TR>
<TD>
<FORM method="post" action="Shouninkakunin.jsp" name="a" >
<INPUT TYPE="submit"  VALUE="�@���F�@"STYLE="cursor: pointer;" name="aa" onClick="submit1()">
<INPUT TYPE="hidden"  NAME="iraisha_number" VALUE="<%=iraisha_number %>">
<INPUT TYPE="hidden"  NAME="iraisha_name" VALUE="<%=iraisha_name%>">
<INPUT TYPE="hidden"  NAME="iraisha_year_month" VALUE="<%=iraisha_year_month%>">
</FORM>
</TD>
<TD>
<%	sql = " where id = '"+b_goukei.getIraisha()+"'";
	ArrayList sylist = new ArrayList();
	LoginDAO dao = new LoginDAO();
	sylist = dao.selectTbl(sql);
	B_ShainMST b_shain = new B_ShainMST();
	b_shain = (B_ShainMST)sylist.get(0);%>
<FORM method="post" action="MailNyuryoku_Gamen.jsp" name="b">
<INPUT TYPE="submit"  VALUE="�@�ԋp�@"STYLE="cursor: pointer;" name="bb" onClick="submit2()">
<INPUT TYPE="hidden"  NAME="okurisaki_mail" VALUE="<%=b_shain.getMail() %>">
<INPUT TYPE="hidden"  NAME="okurisaki_name" VALUE="<%=b_shain.getName() %>">
<INPUT TYPE="hidden"  NAME="iraisha_number" VALUE="<%=iraisha_number %>">
<INPUT TYPE="hidden"  NAME="iraisha_year_month" VALUE="<%=iraisha_year_month%>">
<INPUT TYPE="hidden"  NAME="iraisha_name" VALUE="<%=iraisha_name%>">
<INPUT TYPE="hidden"  NAME="shouninsha_root" VALUE="<%= b_goukei.getSyouninRoot() %>">
</FORM>
</TD>
</TR>
</TABLE><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</CENTER>
</body>
</html>
<%}%>