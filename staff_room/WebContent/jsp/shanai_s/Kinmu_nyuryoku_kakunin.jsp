<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.common.C_GetWeekday" %><%@ page import = "kkweb.common.C_HolidayBackcolor" %>
<%@ page import = "kkweb.common.C_CheckTime" %><%@ page import = "kkweb.common.C_CheckGoukei" %><%@ page import = "kkweb.common.C_Lastday" %>
<%@ page import = "kkweb.common.C_Holiday" %><%@ page import = "kkweb.beans.B_ShainMST" %><%@ page import = "kkweb.beans.B_Year_month" %>
<%@ page import = "kkweb.beans.B_Kinmu_nyuryoku_2"%><%@ page import =  "kkweb.beans.B_GoukeiMST" %><%@ page import = "kkweb.beans.B_KinmuMST" %><%@ page import = "kkweb.beans.B_HolidayMST" %>
<%@ page import = "kkweb.beans.B_NenkyuMST_work" %><%@ page import = "kkweb.beans.B_ZangyouMST" %><%@ page import = "kkweb.dao.LoginDAO" %><%@ page import = "kkweb.dao.HolidayDAO" %>
<%@ page import = "kkweb.dao.KinmuDAO" %><%@ page import = "kkweb.dao.GoukeiDAO" %><%@ page import = "kkweb.dao.NenkyuDAO_work" %><%@ page import = "kkweb.dao.ZangyouDAO" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST"/>
<jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
	if(id2 == null || id2.equals("false")){	
		pageContext.forward("/ID_PW_Nyuryoku.jsp");
	}else{%>
<html lang="ja">
<head>
<SCRIPT TYPE="text/javascript">
	window.onunload=function(){
	document.body.style.cursor='auto';
	document.A.aa.disabled=false;
	document.B.bb.disabled=false;
	}
	function submit1(){
		document.body.style.cursor='wait';
		document.A.aa.disabled=true;
		document.B.bb.disabled=true;
		document.A.submit()				
	}	
	function submit2(){
		document.body.style.cursor='wait';
		document.A.aa.disabled=true;
		document.B.bb.disabled=true;	
		document.B.submit()			
	}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<title>�Ζ��񍐏��m�F</title>
</head>
<body>
<center>
<font class="title">�Ζ��񍐏�</font><br><br>
<font size="4"><b><%= ShainMST.getName() %> �F <%= Year_month.getYear() %>�N�@<%= Year_month.getMonth() %>��</b></font><br>
<table border="1" cellspacing="0" class="houkoku">
<tr>
<th class="t-koumoku"  ><font class="f-koumoku">��</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">�j��</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">�o�Ύ���</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">�ދΎ���</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">���ߎ���</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">�[�鎞��</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">���ڎ���</font></th>
<th class="t-koumoku"  ><font class="f-koumoku">���l</font></th>
</tr>
<%	Calendar cal = Calendar.getInstance();
	String sql = "";
	String holiday = "";
	String day = "";
	String month = "";
	String month_day = "";
	int thisMonth = Integer.parseInt(Year_month.getMonth()+"00");
	int nextMonth = thisMonth+100;
	C_Lastday cld = new C_Lastday();
	int lastday = cld.lastday(Year_month.getYear(),Year_month.getMonth());
	C_GetWeekday cgwd = new C_GetWeekday();
	C_HolidayBackcolor chbc = new C_HolidayBackcolor();
	C_CheckTime cct = new C_CheckTime();
	C_CheckGoukei ccg = new C_CheckGoukei();
	C_Holiday ch = new C_Holiday();
	request.setCharacterEncoding("Windows-31J");
	KinmuDAO kdao = new KinmuDAO();
	sql = " where number='"+ShainMST.getNumber()+"' AND year_month='"+Year_month.getYear_month()+"' ORDER BY to_number(hizuke,'99') ASC " ;
	ArrayList klist = kdao.selectTbl(sql);
	B_KinmuMST bkmst = new B_KinmuMST();
	
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);
	
	B_HolidayMST bhmst = new B_HolidayMST();
	int cnt = 0;
	
	for(int i = 1; i <= lastday; i++){
		bkmst = (B_KinmuMST)klist.get(i-1);
		String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
		
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
		//String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td align="center" style="width:25"><%= i %><br></td>
<td align="center"><%= youbi %><br></td>
<td align="center"><%= cct.checktime(bkmst.getStartT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getEndT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyoukaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getSinyaT()) %><br></td>
<td align="center"><%= cct.checktime(bkmst.getCyokuT()) %><br></td>
<td align="center" class="biko"><font class="biko"><%= bkmst.getPROJECTname()+""+bkmst.getSYUKUJITUname() %></font><br><div align="right"><font size="1">-<%= cct.checktime(bkmst.getFurouT()) %><br></font></div></td>
</tr>
<%holiday = "";	
}%>
</table>
<br />
<table border="1"cellspacing="0" class="houkoku">
<tr>
<th  class="t-koumoku"><font class="f-koumoku">���ߎ���</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�[�鎞��</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�s�J����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�x�o����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">��x����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�N�x����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">���Γ���</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�`�x�v</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�a�x�v</font></th>
<th  class="t-koumoku"><font class="f-koumoku">���v����</font></th>
</tr>
<%	GoukeiDAO gdao = new GoukeiDAO();
	sql = " where number='"+ShainMST.getNumber()+"' AND year_month ='"+Year_month.getYear_month()+"'";
	ArrayList glist = gdao.selectTbl(sql);
	B_GoukeiMST bgmst = new B_GoukeiMST();
	bgmst = (B_GoukeiMST)glist.get(0);%>
<tr>
<td align="right"><%= ccg.checkgoukei(bgmst.getCyoukaMONTH()) %></td>
<td align="right"><%= ccg.checkgoukei(bgmst.getSinyaMONTH()) %></td>
<td align="right"><%= ccg.checkgoukei(bgmst.getFurouMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getKyudeMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getDaikyuMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getNenkyuMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getKekkinMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getAkyuMONTH()) %></td>
<td align="right"><%= ccg.checknissu(bgmst.getBkyuMONTH()) %></td>
<td align="right"><%= ccg.checkgoukei(bgmst.getGoukeiMONTH()) %></td>
</tr>
</table>
<table border="1" cellspacing="0" class="houkoku">
<tr>
<th  class="t-koumoku"><font class="f-koumoku">���N�t�^����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�J�z�N�x����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�g�p�N�x����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�c�N�x����</font></th>
<th  class="t-koumoku"><font class="f-koumoku">���Ԏc�Ǝ���</font></th>
<th  class="t-koumoku"><font class="f-koumoku">�N�ԗݐώc�Ǝ���</font></th>
</tr>
<tr>
<%	NenkyuDAO_work ndao_work = new NenkyuDAO_work();
	sql = " where number ='"+ShainMST.getNumber()+"' and year_month ='" + Year_month.getYear_month() + "'";
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
	sql = " where number ='"+ShainMST.getNumber()+"' AND year ='"+Year_month.getYear()+"' AND month ='"+Year_month.getMonth()+"'";
	ArrayList zlist = zdao.selectTbl(sql);
	B_ZangyouMST zmst = new B_ZangyouMST();
	zmst = (B_ZangyouMST)zlist.get(0);
	if(Integer.parseInt(zmst.getZangyoumonth()) > 9000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getZangyoumonth()) %></td>
<%	}
	if(Integer.parseInt(zmst.getGoukeiZangyou()) > 100000){%>
<td align="right"><font color="red"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></font></td>
<%	}else{%>
<td align="right"><%= ccg.checkgoukei(zmst.getGoukeiZangyou()) %></td>
</tr>
<%	}%>
</table><br>
<table>
<tr>
<td>
<form action="s_kinmu_houkoku" method="post" name="A">
<input type="submit" value="���F�˗��i�񍐁j" style="cursor: pointer;width:120px;" name="aa" onClick="submit1()">
</form>
</td>
<td>
<form method="post" action="Kinmu_Nyuryoku.jsp" name="B">
<input type="button" onClick='history.back();' value="�ē���" style="cursor: pointer;width:120px;" name="bb" onClick="submit2()">
</form>
</td>
</tr>
</table>
</center>
</body>
</html>
<%}%>