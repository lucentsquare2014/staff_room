<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.common.C_GetWeekday" %><%@ page import = "kkweb.common.C_HolidayBackcolor" %>
<%@ page import = "kkweb.common.C_Hyoujyun_sakusei" %><%@ page import = "kkweb.common.C_Lastday" %><%@ page import = "kkweb.common.C_Sengetu" %>
<%@ page import = "kkweb.common.C_Holiday" %><%@ page import = "kkweb.common.C_JikanKeisan" %><%@ page import = "kkweb.beans.B_Code" %>
<%@ page import = "kkweb.beans.B_KinmuMST" %><%@ page import = "kkweb.beans.B_Projectname" %><%@ page import = "kkweb.beans.B_HolidayMST" %>
<%@ page import = "kkweb.beans.B_Codehyouji" %><%@ page import = "kkweb.beans.B_Jido_Keisan" %><%@ page import = "kkweb.dao.CodeDAO" %>
<%@ page import = "kkweb.dao.KinmuDAO" %><%@ page import = "kkweb.dao.PROJECTnameDAO" %><%@ page import = "kkweb.dao.HolidayDAO" %><%@ page import = "kkweb.dao.GoukeiDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//  金澤　ch.holidayでＤＢにアクセスしないようにした。7/21

		String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){
	pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{
%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST"/><jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month"/>
<jsp:useBean id="Hyoujyun" scope="session" class="kkweb.beans.B_Code" /><jsp:useBean id="Project" scope="session" class="kkweb.beans.B_Codehyouji" />
<jsp:useBean id="IchijiDATA" scope="session" class="kkweb.beans.B_Kinmu_nyuryoku_2" /><jsp:useBean id="codedata" scope="session" class="kkweb.beans.B_Jido_Keisan" />
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<title>勤務報告書入力</title>
<%	Calendar cal = Calendar.getInstance();
	C_Lastday cld = new C_Lastday();
	C_GetWeekday cgwd = new C_GetWeekday();
	C_HolidayBackcolor chbc = new C_HolidayBackcolor();
	int lastday = cld.lastday(Year_month.getYear(),Year_month.getMonth());
	GoukeiDAO gdao = new GoukeiDAO();
	String sql2 = " where number ='"+ShainMST.getNumber()+"' AND year_month ='"+Year_month.getYear_month()+"'";%>
<script type="text/javascript">
<!--
	window.onunload=function(){
		document.body.style.cursor='auto';
		document.form1.aa.disabled=false;
		document.form1.bb.disabled=false;
		document.form1.hyoujun.disabled=false;
		document.form1.hyouji.disabled=false;
	}
	function form_submitA(){
		var A=0;
		var lastday = <%= lastday %>;	
		for(i = 1;i < lastday;i++){
			var pcode = eval("document.form1.pcode" + i);
			var p = pcode.value;
			var code = eval("document.form1.code" + i);
   			var n = code.value;
   			var bikou = eval("document.form1.bikou" + i);
   			var s = bikou.value;
   			var aa = "\"";
   			var bb = "\'";
   			var cc = "\\";
   			var dd = ">";
   			var ee = "<";
   			var ff = "\`";
   			var gg = "(";
   			var hh = ")";
			if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1 | p.indexOf(dd) != -1 | p.indexOf(ee) != -1 | p.indexOf(ff) != -1 | p.indexOf(gg) != -1 | p.indexOf(hh) != -1 | 
				n.indexOf(aa) != -1 | n.indexOf(bb) != -1 | n.indexOf(cc) != -1 | n.indexOf(dd) != -1 | n.indexOf(ee) != -1 | n.indexOf(ff) != -1 | n.indexOf(gg) != -1 | n.indexOf(hh) != -1 |
				s.indexOf(aa) != -1 | s.indexOf(bb) != -1 | s.indexOf(cc) != -1 | s.indexOf(dd) != -1 | s.indexOf(ee) != -1 | s.indexOf(ff) != -1 | s.indexOf(gg) != -1 | s.indexOf(hh) != -1){
				A=1;
			}else{}
		}					
		if(A==1){
			alert("\"\'\<>\`()は入力しないでください。");
			document.body.style.cursor='auto';
			return false;
		}else{
			document.body.style.cursor='wait';
			document.form1.aa.disabled=true;
			document.form1.bb.disabled=true;
			document.form1.hyoujun.disabled=true;
			document.form1.hyouji.disabled=true;
			document.form1.action = 's_kinmu_nyuryoku_kakunin';
			document.form1.submit();					
		}
	}
	function form_submitB(){
		var A=0;			
<%	for(int i = 1; i <= lastday; i++){%>
		var p = document.form1.pcode<%=i%>.value;
		var n = document.form1.code<%=i%>.value;
		var s = document.form1.bikou<%=i%>.value;
		var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";
		var gg = "(";
   		var hh = ")";
	   	if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1 | p.indexOf(dd) != -1 | p.indexOf(ee) != -1 | p.indexOf(ff) != -1 | p.indexOf(gg) != -1 | p.indexOf(hh) != -1 |
			n.indexOf(aa) != -1 | n.indexOf(bb) != -1 | n.indexOf(cc) != -1 | n.indexOf(dd) != -1 | n.indexOf(ee) != -1 | n.indexOf(ff) != -1 | n.indexOf(gg) != -1 | n.indexOf(hh) != -1 |
			s.indexOf(aa) != -1 | s.indexOf(bb) != -1 | s.indexOf(cc) != -1 | s.indexOf(dd) != -1 | s.indexOf(ee) != -1 | s.indexOf(ff) != -1 | s.indexOf(gg) != -1 | s.indexOf(hh) != -1){
			A=1;
		}else{}		<%	}%>
		if(A==1){
			alert("\"\'\<>\`()は入力しないでください。");
			document.body.style.cursor='auto';
			return false;
		}else{
			document.body.style.cursor='wait';
			document.form1.aa.disabled=true;
			document.form1.bb.disabled=true;
			document.form1.hyoujun.disabled=true;
			document.form1.hyouji.disabled=true;
			document.form1.action = 's_kinmu_hozon'
			document.form1.submit()
		}
	}
	function form_submitC(){
		//adrs ="http://192.36.253.27:8080/kintaikanri/Pcode_ichiran.jsp"移行後は以下を使用
		adrs ="http://www.lucentsquare.co.jp:8080/kk_web/Pcode_ichiran.jsp"
		LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')
		LinkWin.location.href=adrs
	}
	function form_submitD(){
		document.form1.action = 's_codehyouji'
		document.form1.aa.disabled=true;
		document.form1.bb.disabled=true;
		document.form1.hyoujun.disabled=true;
		document.form1.hyouji.disabled=true;
		document.form1.submit()
	}
	function form_submitE(){
		document.form1.action = 's_hyoujyun_sakusei'
		document.form1.aa.disabled=true;
		document.form1.bb.disabled=true;
		document.form1.hyoujun.disabled=true;
		document.form1.hyouji.disabled=true;	
		document.form1.submit()
	}
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,'');
	};
	function checkT(hour,minute){
		var h = ""+hour;
		var m = ""+minute;
		var h_m = "";
		if(minute < 10){
			h_m = h+"0"+m;
		}else{
			h_m = h+m;
		}return Number(h_m);
	}
	/*function keisan(hizuke){
		var m = hizuke;
		var pcode = String(document.getElementsByName("pcode"+m)[0].value);
		var code = String(document.getElementsByName("code"+m)[0].value);
		if(code != "" && pcode == ""){
			var i = m-1;
			while(i > 0){
				pcode = String(document.getElementsByName("pcode"+i)[0].value);
				if(pcode != ""){break;
				}i--;
			}document.getElementsByName("pcode"+m)[0].value = pcode;
		}
	}*/
-->
</script>
</head>
<body>
<STYLE type="text/css"></STYLE>
<center>
<font class="title">勤務報告入力</font><br>
<hr color = "#008080">
<table>
<tr>
<td valign="top">・</td>
<td align="left" ><small>通常勤務の人は、Ｐコード、コード、出勤、退勤、備考のみ入力してください。（その他の欄は自動計算します ）</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>シフト勤務等の人は、コードの欄先頭に「半角のFかf」を入力し、全ての欄を入力してください。（自動計算は行いません）</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small><font color="red">超過/深夜/直接/休憩/不労時間を直接入力する場合は 、コードの欄先頭に「半角のFかf」を入力し、全ての欄を入力してください。（自動計算は行いません）</font></small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>Ｐコードが空白のときは、直近で入力したＰコードを使用します。（Ｐコードは<a  onClick="form_submitC()" style="cursor: pointer;"><font color="blue">こちら</font></a>からご覧ください）</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>コードが50のときは、特別休暇扱いです。備考欄に何休暇かを入力してください。</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>24時以降は時間＋2400で入力してください。(1時ならば2500)</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>出勤時間と退勤時間は半角数字4桁で入力してください。(9時ならば0900)</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>出勤時間がコードの出勤時間より早い時間の場合、コードの出勤時間から勤務を開始したことになります。</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>退勤時間がコードの退勤時間より遅い時間の場合、自動で30分休憩したことになります。</small></td></tr><tr>
<td valign="top">・</td>
<td align="left" ><small>各ボタンの機能については下記をご覧ください。</small></td></tr>
</table>
<hr color = "#008080"><br>
<table>
<tr><%	C_Sengetu cs = new C_Sengetu();%>
<form method="post" action="" name="form1">
<td nowrap="nowrap">
<select name="pname">
<option value="sengetu" ><%= cs.sengetu_year(Year_month.getYear(),Year_month.getMonth()) %>年<%= cs.sengetu_month(Year_month.getMonth()) %>月の最終日に入力したPコードを使用して標準作成</option>
<%	PROJECTnameDAO dao = new PROJECTnameDAO();
	String sql = " select distinct PROJECTname,PROJECTcode from codeMST  where flg = '0' order by projectcode asc";
	ArrayList list = dao.selectTbl(sql);
	B_Projectname codetbl = new B_Projectname();
	for(int s = 0; s < list.size(); s++){
	//	B_Projectname codetbl = new B_Projectname();
		codetbl = (B_Projectname)list.get(s);  %>
<option value="<%= codetbl.getPROJECTcode() %>"><%= codetbl.getPROJECTcode() + "　" + codetbl.getPROJECTname() %></option><%	}%>
</select>
</td>
</tr><tr><td align="left">
<input type="button" value="標準作成" name="hyoujun" onClick="document.body.style.cursor='wait';form_submitE()" style="cursor: pointer; width:90px" >
<input type="button" value="コード表表示"  name="hyouji" onClick="document.body.style.cursor='wait';form_submitD()" style="cursor: pointer; width:90px">
</td></tr>
</table><br>	
</center>
<table>
<tr><td>	
<table border="1" style =" border:solid 1px #008080; font-size:12px; table-style:fixed;"  cellspacing="0">
<tr>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080" ><font color="#F5F5F5"><B>日</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>曜日</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>Pコード</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>コード</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>出勤</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>退勤</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>超過</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>深夜</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>直接</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>休憩</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>不労</B></font></td>
<td nowrap="nowrap" align="center" STYLE="background-color:#008080"><font color="#F5F5F5"><B>備考欄</B></font></td>
</tr>
<%	int thisMonth = Integer.parseInt(Year_month.getMonth()+"00");
	int nextMonth = thisMonth+100;
	HolidayDAO hdao = new HolidayDAO();
	String sql_h = " where to_number(SYUKUJITUdate,'9999') > " + Integer.toString(thisMonth) +" and to_number(SYUKUJITUdate,'9999') < " + Integer.toString(nextMonth) ;
	ArrayList holiArray = hdao.selectTbl(sql_h);
	String day = "";
	String month = "";
	String month_day = "";
	String holiday = "";
	
	if(Hyoujyun.getPROJECTcode() != null){
		
		C_Hyoujyun_sakusei chs = new C_Hyoujyun_sakusei();
		C_Holiday ch = new C_Holiday();
		B_HolidayMST bhmst = new B_HolidayMST();
		int cnt = 0;
		for(int i = 1; i <= lastday; i++){
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
			String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
			//String holiday = ch.holiday(Year_month.getYear_month(),i);
%>	
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td><%= i %></td>
<td><%= youbi %></td>
<td><input type="text" style="ime-mode: disabled;" name="pcode<%= i %>" value="<%= chs.hyoujyun(youbi,holiday,Hyoujyun.getPROJECTcode()) %>" size="10" ></td>
<td><input type="text" style="ime-mode: disabled;" name="code<%= i %>" value="<%= chs.hyoujyun(youbi,holiday,Hyoujyun.getKINMUcode()) %>"  size="6"></td>
<td><input type="text" style="ime-mode: disabled;" <%// onkeypress='if(event.keyCode<"0".charCodeAt(0) || "9".charCodeAt(0)<event.keyCode)return false;'%>maxlength="4" name="start<%= i %>" value="<%= chs.hyoujyun(youbi,holiday,Hyoujyun.getStartTIME()) %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="end<%= i %>" value="<%= chs.hyoujyun(youbi,holiday,Hyoujyun.getEndTIME()) %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="cyouka<%= i %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="sinya<%= i %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="cyoku<%= i %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3" name="rest<%= i %>" value="<%= chs.hyoujyun(youbi,holiday,Hyoujyun.getRestTIME()) %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3" name="furou<%= i %>" size="5"></td>
<td><input type="text" name="bikou<%= i %>" value="<%= holiday %>"  size="25"></td>
</tr><%	if(holiday != null || holiday.equals("")){ 
			holiday = "" ;
		}}	session.removeAttribute("Hyoujyun");
		
	}else if(IchijiDATA.getPkinmu() != null){
		
		C_Holiday ch = new C_Holiday();
		String[] pkinmu = IchijiDATA.getPkinmu();
		String[] ckinmu = IchijiDATA.getCkinmu();
		String[] skinmu = IchijiDATA.getSkinmu();
		String[] ekinmu = IchijiDATA.getEkinmu();
		String[] cykinmu = IchijiDATA.getCykinmu();
		String[] sikinmu = IchijiDATA.getSikinmu();
		String[] cyokinmu = IchijiDATA.getCyokinmu();
		String[] rkinmu = IchijiDATA.getRkinmu();
		String[] fkinmu = IchijiDATA.getFkinmu();
		String[] bkinmu = IchijiDATA.getBkinmu();
		B_HolidayMST bhmst = new B_HolidayMST();
		int cnt = 0;
		for(int i = 1; i <= lastday; i++){
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
			String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
			//String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td><%= i %></td>
<td><%= youbi %></td>
<td><input type="text" style="ime-mode: disabled;"  name="pcode<%= i %>" value="<%= pkinmu[i-1]  %>" size="10" ></td>
<td><input type="text" style="ime-mode: disabled;"  name="code<%= i %>" value="<%= ckinmu[i-1] %>"  size="6"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="start<%= i %>" value="<%= skinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="end<%= i %>" value="<%= ekinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="cyouka<%= i %>" value="<%= cykinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="sinya<%= i %>" value="<%= sikinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="cyoku<%= i %>" value="<%= cyokinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3"  name="rest<%= i %>" value="<%= rkinmu[i-1] %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3"  name="furou<%= i %>" value="<%= fkinmu[i-1] %>" size="3"></td>
<td><input type="text" name="bikou<%= i %>" value="<%= bkinmu[i-1] %>"  size="25"></td>
</tr><%	if(holiday != null || holiday.equals("")){ 

	holiday = "" ;
	}}	session.removeAttribute("IchijiDATA");
		
	}else if(gdao.isThereTbl(sql2)){
		
		C_Holiday ch = new C_Holiday();
		C_JikanKeisan cjk = new C_JikanKeisan();
		KinmuDAO kdao = new KinmuDAO();
		sql = " where number='"+ShainMST.getNumber()+"' AND year_month='"+Year_month.getYear_month()+"' ORDER BY to_number(hizuke,'99') ";
		
		ArrayList klist = kdao.selectTbl(sql);
		
		B_HolidayMST bhmst = new B_HolidayMST();
		B_KinmuMST bkmst = new B_KinmuMST();
		int cnt = 0;
		
		for(int i = 1; i <= lastday; i++){
			
		//	B_KinmuMST bkmst = new B_KinmuMST();
			bkmst = (B_KinmuMST)klist.get(i-1);		
			
			int number1 = bkmst.getPROJECTname().lastIndexOf(")");
			
			number1=number1+1;
			String bikou2=bkmst.getPROJECTname().substring(number1);
			
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
			
			String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
			//String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td><%= i %></td>
<td><%= youbi %></td>
<td><input type="text" style="ime-mode: disabled;" name="pcode<%= i %>" value="<%= bkmst.getPROJECTcode() %>" size="10" ></td>
<td><input type="text" style="ime-mode: disabled;" name="code<%= i %>" value="<%= bkmst.getKINMUcode() %>"size="6"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="start<%= i %>" value="<%= bkmst.getStartT() %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="end<%= i %>" value="<%= bkmst.getEndT() %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="cyouka<%= i %>" value="<%= bkmst.getCyoukaT() %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="sinya<%= i %>" value="<%= bkmst.getSinyaT() %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4"  name="cyoku<%= i %>" value="<%= bkmst.getCyokuT() %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3"  name="rest<%= i %>" value="<%= bkmst.getRestT() %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3"  name="furou<%= i %>" value="<%= bkmst.getFurouT() %>" size="3"></td>
<td><input type="text" name="bikou<%= i %>" value="<%= bkmst.getSYUKUJITUname()+bikou2 %>" size="25"></td>
</tr><%	if(holiday != null || holiday.equals("")){ 
	
			holiday = "";
		} } }else{
			
		C_Holiday ch = new C_Holiday();
		B_HolidayMST bhmst = new B_HolidayMST();
		int cnt = 0;
		for(int i = 1; i <= lastday; i++){
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
			String youbi = cgwd.weekday(Year_month.getYear(),Year_month.getMonth(),i);
			//String holiday = ch.holiday(Year_month.getYear_month(),i);%>
<tr bgcolor="<%= chbc.holidaycolor(youbi,holiday) %>" >
<td><%= i %></td>
<td><%= youbi %></td>
<td><input type="text" style="ime-mode: disabled;" name="pcode<%= i %>" value=""  size="10"></td>
<td><input type="text" style="ime-mode: disabled;" name="code<%= i %>"  size="6"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="start<%= i %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="end<%= i %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="cyouka<%= i %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="sinya<%= i %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="4" name="cyoku<%= i %>"  size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3" name="rest<%= i %>" size="5"></td>
<td><input type="text" style="ime-mode: disabled;" maxlength="3" name="furou<%= i %>"  size="3"></td>
<td><input type="text" name="bikou<%= i %>" value="<%= holiday %>" size="25"></td>
</tr><%	if(holiday != null || holiday.equals("")){ 
	
			holiday = "" ;
		}	}	}%>
</table><br>
<center>
<input type="button" value="報告"  name="aa" onClick="form_submitA()" style="cursor: pointer; width:75px">
<input type="button" value="保存"  name="bb" onClick="form_submitB()" style="cursor: pointer; width:75px">
</center>
</td>	
<td valign="TOP" align="center">
<hr color = "#008080">
<ul style="margin-left: 10px; ,padding-left: 10px; ,margin-bottom: 1px;,margin-top: 1px;,list-style-type:square;">
<li style="text-align:left; "><small>「標準作成」を押すと、選択されたプロジェクトコードより１ヶ月分を標準作成します。</small></li>
<li style="text-align:left; "><small>「コード表表示」を押すと選択されたプロジェクトコードの勤務コード表を表示します。</small></li>
<li style="text-align:left; "><small>「保存」を押すと現在の入力状況を保存します。</small></li>
<li style="text-align:left; "><small>「報告」を押すと確認画面を表示します。</small></li>
</ul>
<hr color = "#008080">
<%	if(Project.getPROJECTname() != null){%>
<center><b>Pコード：<%= Project.getPROJECTcode() %></b></center>
<table border="1" style =" border:solid 1px #008080;">
<tr><td COLSPAN="5" align="center" ><B><%= Project.getPROJECTname() %></B></td></tr>
<tr>
<td align="center" STYLE="background-color:#008080"><font color="#F5F5F5">コード</font></td>
<td align="center" STYLE="background-color:#008080"><font color="#F5F5F5">出勤</font></td>
<td align="center" STYLE="background-color:#008080"><font color="#F5F5F5">退勤</font></td>
<td align="center" STYLE="background-color:#008080"><font color="#F5F5F5">昼休時間</font></td>
<td align="center" STYLE="background-color:#008080"><font color="#F5F5F5">備考</font></td>
</tr>
<%	CodeDAO cdao = new CodeDAO();
	sql = "select * from codeMST where PROJECTcode='"+Project.getPROJECTcode()+"' order by kinmucode asc";
	ArrayList clist = cdao.selectTbl(sql);
	B_Code bc = new B_Code();
	for(int m = 0; m < clist.size(); m++){
		bc = (B_Code)clist.get(m);%>
<tr>
<td><%= bc.getKINMUcode() %><br></td><td><%= bc.getStartTIME() %><br></td><td><%= bc.getEndTIME() %><br></td><td><%= bc.getRestTIME() %><br></td><td><%= bc.getBikou() %><br></td>
</tr><%	}	session.removeAttribute("Project");%>
</table><%	}%>
</td></tr>
</table>
<STYLE type="text/css"></STYLE>
</body>
</html><%}%>