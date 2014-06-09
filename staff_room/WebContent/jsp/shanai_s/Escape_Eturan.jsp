<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.beans.B_GamenInsatu"%><%@ page
	import="kkweb.beans.B_ZangyouMST"%><%@ page import="kkweb.beans.B_Year_month"%><%@ page
	import="javax.servlet.*"%><%@ page import="kkweb.beans.B_HolidayMST"%>
<%@ page import="kkweb.dao.ZangyouDAO"%><%@ page import="kkweb.common.*"%><%@ page
	import="kkweb.common.C_CheckGoukei"%><%@ page import="kkweb.dao.HolidayDAO"%>
<%@ page import="kkweb.common.C_HolidayBackcolor"%><%@ page
	import="kkweb.common.C_CheckMonth"%><%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DateFormat"%><%@ page
	import="java.text.SimpleDateFormat"%><%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id1 = (String)session.getAttribute("key");
	String id2 = (String)session.getAttribute("key2");
	if((id1 == null || id1.equals("false")) && (id2 == null || id2.equals("false"))){
		pageContext.forward("/ID_PW_Nyuryoku.jsp");
	}else{
		try{
%>
<jsp:useBean id="EscapeDATA" scope="session" type="java.util.ArrayList" />
<jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month" />
<html>
<head>
<SCRIPT TYPE="text/javascript">
	window.onunload = function() {
		document.body.style.cursor = 'auto';
		document.A.aa.disabled = false;
		document.B.bb.disabled = false;
	}
	function submit1() {
		document.body.style.cursor = 'wait';
		document.A.aa.disabled = true;
		document.B.bb.disabled = true;
		document.A.submit()
	}
	function submit2() {
		document.body.style.cursor = 'wait';
		document.A.aa.disabled = true;
		document.B.bb.disabled = true;
		document.B.submit()
	}
	function submit3() {
		document.body.style.cursor = 'wait';
		document.A.aa.disabled = true;
		document.B.bb.disabled = true;
		document.B.submit()
	}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<link rel="stylesheet" href="Insatu.css" type="text/css">
<title>勤務報告書閲覧</title>
</head>
<body>
	<center>
		<font class="title">勤務報告書</font>
		<%
			request.setCharacterEncoding("UTF-8");
			String escapeflg =request.getParameter("escapeflg");
					String STRAT = "";
					String END = "";
					String comment = "";
					if (EscapeDATA == null || EscapeDATA.size() == 0) {
		%><br>
		<br>
		<hr width="400">
		<div align="center">
			<font color="#8B0000"><big>対象者選択からやり直してください</big></font>
		</div>
		<hr width="400">
		<%
			if (escapeflg.equals("0")) {
		%>
		<div class="noprint">
			<center>
				<table cellpadding="5" cellspacing="2">
					<tr>
						<td>
							<form method="post" action="Menu_Gamen.jsp" name="A">
								<input type="submit" value="メニュー画面へ戻る"
									STYLE="cursor: pointer; width: 120px;" name="aa"
									onClick="submit1()"> <br>
							</form>
						</td>
						<%}else{ %>
					
					<tr>
						<td>
							<form method="post" action="SystemKanri_MenuGamen.jsp" name="A">
								<input type="submit" value="メニュー画面へ戻る"
									STYLE="cursor: pointer; width: 120px;" name="aa"
									onClick="submit1()"> <br>
							</form>
						</td>
						<%} %>
						<td>
							<form method="post" action="Escape_NameSelect.jsp" name="B">
								<input type="submit" value="対象者選択へ戻る"
									STYLE="cursor: pointer; width: 120px;" name="bb"
									onClick="submit3()"> <input type="hidden"
									id="escapeflg" name="escapeflg" value="<%=escapeflg %>">
								<%
									}else{
									B_GamenInsatu syouninroot = (B_GamenInsatu)EscapeDATA.get(0);
												String S1 = (String) syouninroot.getSyouninroot();
												if (S1 == null || S1.equals("")) {
								%><br>
								<%
									}else {
								%>
								<div align="left">
									<b>＜＜承認経路＞＞</b>
								</div>
								<div align="left"><%= S1 %></div>
								<%
									}
												B_GamenInsatu year_month = (B_GamenInsatu) EscapeDATA
														.get(0);
												String ym = (String) year_month.getYear_month();
												C_CheckMonth mont = new C_CheckMonth();
								%>
								<div align="right">
									<br />印刷は<a onClick="form_submitA()"
										style="cursor: pointer;"><font color="blue">こちら</font></a>からお願いします。
								</div>
								<br />
								<center>
									<font size="4"><b><%= ym.substring( 0 , 4 ) %>年<%= mont.MonthCheck(ym.substring( 4 , 6 )) %>月
											： <%= year_month.getName() %></b></font><br>
									<table border="0" width="800px">
										<tr>
											<td>
												<table border="1" cellspacing="0" class="houkoku">
													<tr>
														<th class="t-koumoku"><font class="f-koumoku"><B>日</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>曜日</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>Pコード</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>出勤時間</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>退勤時間</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>超過時間</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>深夜時間</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>直接時間</B></font></th>
														<th class="t-koumoku"><font class="f-koumoku"><B>備考</B></font></th>
													</tr>
													<%
														String holiday = "";
																	String day = "";
																	String month = "";
																	String month_day = "";
																	int thisMonth = Integer.parseInt(mont.MonthCheck(ym
																			.substring(4, 6)) + "00");
																	int nextMonth = thisMonth + 100;

																	C_CheckGoukei gou = new C_CheckGoukei();
																	C_HolidayBackcolor color = new C_HolidayBackcolor();
																	C_Holiday check = new C_Holiday();
																	HolidayDAO hdao = new HolidayDAO();
																	String sql_h = " where to_number(SYUKUJITUdate,'9999') > "
																			+ Integer.toString(thisMonth)
																			+ " and to_number(SYUKUJITUdate,'9999') < "
																			+ Integer.toString(nextMonth);
																	ArrayList holiArray = hdao.selectTbl(sql_h);

																	B_HolidayMST bhmst = new B_HolidayMST();
																	int cnt = 0;
																	B_GamenInsatu itiniti2 = (B_GamenInsatu) EscapeDATA
																			.get(25);

																	for (int i = 0; i < EscapeDATA.size(); i++) {
																		B_GamenInsatu itiniti = (B_GamenInsatu) EscapeDATA
																				.get(i);

																		if (thisMonth < 1000) {
																			month_day = "0"
																					+ Integer.toString(thisMonth + i + 1);
																		} else {
																			month_day = Integer.toString(thisMonth + i + 1);
																		}
																		if (holiArray.size() != 0 && holiArray != null
																				&& holiArray.size() > cnt) {
																			bhmst = (B_HolidayMST) holiArray.get(cnt);

																			if (month_day.equals(bhmst.getSYUKUJITUdate())) {
																				holiday = bhmst.getSYUKUJITUname();
																				cnt++;

																			}
																		}

																		STRAT = gou.checkgoukei(itiniti.getStartT());
																		END = gou.checkgoukei(itiniti.getEndT());
													%>
													<tr
														bgcolor="<%= color.holidaycolor(itiniti.getYoubi(),holiday) %>">
														<td align="center" style="width: 25"><center><%= itiniti.getHizuke() %><br>
															</center></td>
														<td align="center"><center><%= itiniti.getYoubi() %><br>
															</center></td>
														<td align="center"><center>
																<%
																	if (STRAT.equals("") && END.equals("")
																							|| STRAT.equals("0:00")
																							&& END.equals("0:00")) {
																					} else {
																%>
																<%=itiniti.getPROJECTcode()%>
																<%
																	}
																%>
																<br>
															</center></td>
														<%
															if (gou.checkgoukei(itiniti.getCyokuT()) == "0:00") {
														%>
														<td align="center"><center>
																<br>
															</center></td>
														<td align="center"><center>
																<br>
															</center></td>
														<td align="center"><center>
																<br>
															</center></td>
														<td align="center"><center>
																<br>
															</center></td>
														<td align="center"><center>
																<br>
															</center></td>
														<td align="center" class="biko"><font class="biko"><%= itiniti.getPROJECTname()+""+itiniti.getSYUKUJITUname() %></font>
														<div align="right">
																<FONT size="1">-<br></font>
															</div></td>
														<%}else{%>
														<td align="center"><center><%= gou.checkgoukei(itiniti.getStartT()) %><br>
															</center></td>
														<td align="center"><center><%= gou.checkgoukei(itiniti.getEndT()) %><br>
															</center></td>
														<td align="center"><center><%= gou.checkgoukei(itiniti.getCyoukaT()) %><br>
															</center></td>
														<td align="center"><center><%= gou.checkgoukei(itiniti.getSinyaT()) %><br>
															</center></td>
														<td align="center"><center><%= gou.checkgoukei(itiniti.getCyokuT()) %><br>
															</center></td>
														<td align="center" class="biko"><font class="biko"><%= itiniti.getPROJECTname()+""+itiniti.getSYUKUJITUname() %></font>
														<div align="right">
																<FONT size="1">-<%= gou.checkgoukei(itiniti.getFurouT()) %><br></font>
															</div></td>
														<%}%>
													</tr>
													<%
														holiday = "";
																	}
													%>
												</table > <br />
											</td>
										</tr>
										<tr></tr>
										<tr>
											<td>
												<table border="1" class="houkoku" cellspacing="0">
													<tr>
														<th class="t-koumoku"><font class="f-koumoku">超過時間</font></th>
														<th class="t-koumoku"><font class="f-koumoku">深夜時間</font></th>
														<th class="t-koumoku"><font class="f-koumoku">不労時間</font></th>
														<th class="t-koumoku"><font class="f-koumoku">休出日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">代休日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">年休日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">欠勤日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">Ａ休計</font></th>
														<th class="t-koumoku"><font class="f-koumoku">Ｂ休計</font></th>
														<th class="t-koumoku"><font class="f-koumoku">合計時間</font></th>
													</tr>
													<%B_GamenInsatu tuki = (B_GamenInsatu)EscapeDATA.get(0);%>
													<tr>
														<td align="right"><%= gou.checkgoukei(tuki.getCyoukaMONTH()) %></td>
														<td align="right"><%= gou.checkgoukei(tuki.getSinyaMONTH()) %></td>
														<td align="right"><%= gou.checkgoukei(tuki.getFurouMONTH()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getKyudeMONTH()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getDaikyuMONTH()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getNenkyuMONTH()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getKekkinmonth()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getAkyuMONTH()) %></td>
														<td align="right"><%= gou.checknissu(tuki.getBkyuMONTH()) %></td>
														<td align="right"><%= gou.checkgoukei(tuki.getGoukeiMONTH()) %></td>
													</tr>
												</table>

												<table border="1" cellspacing="0" class="houkoku">
													<%
														Calendar cal = Calendar.getInstance();
																	int yes = cal.get(Calendar.YEAR);
																	int muri = cal.get(Calendar.MONTH);
																	muri++;
																	String yea = String.valueOf(yes);
																	String mon = String.valueOf(muri);
																	String murim = mont.CheckMonth(mon);
																	String yemo = yea + murim;
																	int kotosi = Integer.parseInt(yemo);
																	int s = Integer.parseInt(ym);
																	if (kotosi == s || (kotosi - 1) == s) {
													%>
													<tr>
														<th class="t-koumoku"><font class="f-koumoku">当年付与日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">繰越年休日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">使用年休日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">残年休日数</font></th>
														<th class="t-koumoku"><font class="f-koumoku">月間残業時間</font></th>
														<th class="t-koumoku"><font class="f-koumoku">年間累積残業時間</font></th>
													</tr>
													<tr>
														<td align="center"><%=  tuki.getNenkyu_fuyo()  %></td>
														<td align="center"><%=  tuki.getNenkyu_kurikoshi() %></td>
														<td align="center"><%=  tuki.getNenkyu_year()  %></td>
														<td align="center"><%=  tuki.getNenkyu_all()  %></td>
														<%
															comment = "※年休データは最新の勤務報告書のみ表示します。（但し最新からひと月前の勤務報告書にも年休データが表示されることがあります。例えば８月の勤務報告書を８月中に承認完了した場合、８月中は８月の勤務報告書と７月の勤務報告書に年休データが表示されます。)";
																		} else {
														%><tr>
														<th align="center" class="t-koumoku"><font
															class="f-koumoku">月間残業時間</font></th>
														<th align="center" class="t-koumoku"><font
															class="f-koumoku">年間累積残業時間</font></th>
													</tr>
													<tr>
														<%
															comment = "";
																		}
																		ZangyouDAO zdao = new ZangyouDAO();
																		year_month = (B_GamenInsatu) EscapeDATA.get(0);
																		String y = year_month.getYear_month();
																		String number = year_month.getNumber();
																		String t = y.substring(0, 4);
																		String m = mont.MonthCheck(y.substring(4, 6));
																		String sql = " where year = '" + t + "' and number = '"
																				+ number + "' and month = '" + m + "'";
																		ArrayList zlist = zdao.selectTbl(sql);
																		B_ZangyouMST nenkan = (B_ZangyouMST) zlist.get(0);
																		if (Integer.parseInt(nenkan.getZangyoumonth()) > 9000) {
														%>
														<td align="center"><font style="color: red;"><%=gou.checkgoukei(nenkan.getZangyoumonth())%></font></td>
														<%
															} else {
														%>
														<td align="center"><%=gou.checkgoukei(nenkan.getZangyoumonth())%></td>
														<%
															}
																		if (Integer.parseInt(nenkan.getGoukeiZangyou()) > 100000) {
														%>
														<td align="center"><font style="color: red;"><%=gou.checkgoukei(nenkan.getGoukeiZangyou())%></font></td>
														<%
															} else {
														%>
														<td align="center"><%=gou.checkgoukei(nenkan.getGoukeiZangyou())%></td>
														<%	}%>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</center>
								<table width="800px">
									<td align="left"><font color="red"><%=comment %></font></td>
								</table>
								<br>
								<SCRIPT TYPE="text/javascript">
function form_submitA(){
	adrs ="/kk_web/e_eturan?number=<%= number %>&yearmonth=<%= y %>&check=1";
	//移行後は以下を使用
	//adrs ="http://www1.lucentsquare.co.jp/kintaikanri/e_eturan?number=<%= number %>&yearmonth=<%= y %>&check=1";
	LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')
	LinkWin.location.href=adrs;
}		
</script>
								<center>
									<table cellpadding="5" cellspacing="2">
										<%if(escapeflg.equals("0")){ %>
										<tr>
											<td>
												<form method="post" action="Menu_Gamen.jsp" name="A">
													<input type="submit" value="メニュー画面へ戻る"
														STYLE="cursor: pointer; width: 120px;" name="aa"
														onClick="submit1()">
												</form>
											</td>
											<%}else{%>
										
										<tr>
											<td>
												<form method="post" action="SystemKanri_MenuGamen.jsp"
													name="A">
													<input type="submit" value="メニュー画面へ戻る"
														STYLE="cursor: pointer; width: 120px;" name="aa"
														onClick="submit1()">
												</form>
											</td>
											<%}%>
											<td>
												<form method="post" action="Escape_NameSelect.jsp" name="B">
													<input type="submit" value="対象者選択へ戻る"
														STYLE="cursor: pointer; width: 120px;" name="bb"
														onClick="submit2()"> <input type="hidden"
														id="escapeflg" name="escapeflg" value="<%=escapeflg %>">
													<%
														}
													session.removeAttribute("EscapeDATA");
													%>
												</form>
											</td>
										</tr>
									</table>
								</center>
</body>
</html>
<%}catch(Exception e){
	e.printStackTrace();
}
		}%>