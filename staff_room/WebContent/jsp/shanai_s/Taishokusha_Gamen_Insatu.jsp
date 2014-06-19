<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.beans.B_GamenInsatu"%><%@ page
	import="kkweb.beans.B_ZangyouMST"%><%@ page import="javax.servlet.*"%>
<%@ page import="kkweb.dao.ZangyouDAO"%><%@ page import="kkweb.common.*"%><%@ page
	import="kkweb.common.C_CheckGoukei"%>
<%@ page import="kkweb.common.C_HolidayBackcolor"%><%@ page
	import="kkweb.common.C_CheckMonth"%><%@ page
	import="java.util.ArrayList"%>
<%@ page import="java.text.DateFormat"%><%@ page
	import="java.text.SimpleDateFormat"%><%@ page import="java.util.*"%><%@ page
	import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String) session.getAttribute("key2");
	if (id2 == null || id2.equals("false")) {
		pageContext.forward("/");
	} else {
%>
<jsp:useBean id="InsatuDATA" scope="session" type="java.util.ArrayList" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"
	media="all">
<link rel="stylesheet" href="Insatu.css" type="text/css" media="print">
<SCRIPT TYPE="text/javascript">
	function PrintPage() {
		if (document.getElementById || document.layers) {
			window.print();
		}
	}
</SCRIPT>
<title>退職者勤務報告書</title>
</head>
<body>
	<center>
		<div class="noprint">
			<font class="title">勤務報告書</font>
			<%
				request.setCharacterEncoding("windows-31j");
					if (InsatuDATA == null || InsatuDATA.size() == 0) {
			%><br>
			<br>
			<hr width="400">
			<p>
				<font color="#8B0000"><big>前画面に戻って選択し直してください</big></font>
			</p>
			<hr width="400">
			<%
				} else {
						B_GamenInsatu syouninroot = (B_GamenInsatu) InsatuDATA
								.get(0);
						String S1 = (String) syouninroot.getSyouninroot();
						if (S1 == null || S1.equals("")) {
			%><br>
			<%
				} else {
			%>
		
	</center>
	<center>
		<br />
		<br />
		<A HREF="javascript:PrintPage()">印刷</A>
	</center>
	<div align="left">＜＜承認経路＞＞</div>
	<div align="left"><%=S1%></div>
	<center>
		<%
			}
					B_GamenInsatu year_month = (B_GamenInsatu) InsatuDATA
							.get(0);
					String ym = (String) year_month.getYear_month();
					C_CheckMonth mont = new C_CheckMonth();
		%>
		<font size="4"><%=ym.substring(0, 4)%>年<%=mont.MonthCheck(ym.substring(4, 6))%>月
			： <%=year_month.getName()%></font><br>
		<table border="0" width="800px">
			<tr>
				<td>
					<table border="1" width="800px">
						<tr>
							<th nowrap="nowrap">日</th>
							<th nowrap="nowrap">曜日</th>
							<th nowrap="nowrap">Pコード</th>
							<th nowrap="nowrap">出勤時間</th>
							<th nowrap="nowrap">退勤時間</th>
							<th nowrap="nowrap">超過時間</th>
							<th nowrap="nowrap">深夜時間</th>
							<th nowrap="nowrap">直接時間</th>
							<th nowrap="nowrap">備考</th>
						</tr>
						<%
							C_CheckGoukei gou = new C_CheckGoukei();
									C_HolidayBackcolor color = new C_HolidayBackcolor();
									C_Holiday check = new C_Holiday();
									for (int i = 0; i < InsatuDATA.size(); i++) {
										B_GamenInsatu itiniti = (B_GamenInsatu) InsatuDATA
												.get(i);
						%>
						<tr
							bgcolor="<%=color.holidaycolor(itiniti.getYoubi(),
								check.holiday(ym, i + 1))%>">
							<td align="center"><center><%=itiniti.getHizuke()%><br>
								</center></td>
							<td align="center"><center><%=itiniti.getYoubi()%><br>
								</center></td>
							<td align="center"><center><%=itiniti.getPROJECTcode()%><br>
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
							<td><font size="1"><%=itiniti.getPROJECTname() + ""
									+ itiniti.getSYUKUJITUname()%></font>
							<div align="right">
									<FONT size="1">-<br></font>
								</div></td>
							<%
								} else {
							%>
							<td align="center"><center><%=gou.checkgoukei(itiniti.getStartT())%><br>
								</center></td>
							<td align="center"><center><%=gou.checkgoukei(itiniti.getEndT())%><br>
								</center></td>
							<td align="center"><center><%=gou.checkgoukei(itiniti.getCyoukaT())%><br>
								</center></td>
							<td align="center"><center><%=gou.checkgoukei(itiniti.getSinyaT())%><br>
								</center></td>
							<td align="center"><center><%=gou.checkgoukei(itiniti.getCyokuT())%><br>
								</center></td>
							<td><font size="1"><%=itiniti.getPROJECTname() + ""
									+ itiniti.getSYUKUJITUname()%></font>
							<div align="right">
									<FONT size="1">-<%=gou.checkgoukei(itiniti.getFurouT())%><br></font>
								</div></td>
							<%
								}
							%>
						</tr>
						<%
							}
						%>
					</table>
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td>
					<table border="1" width="800px">
						<tr>
							<th align="center">超過時間</th>
							<th align="center">深夜時間</th>
							<th align="center">不労時間</th>
							<th align="center">休出日数</th>
							<th align="center">代休日数</th>
							<th align="center">年休日数</th>
							<th align="center">欠勤日数</th>
							<th align="center">Ａ休計</th>
							<th align="center">Ｂ休計</th>
							<th align="center">合計時間</th>
						</tr>
						<%
							B_GamenInsatu tuki = (B_GamenInsatu) InsatuDATA.get(0);
						%>
						<tr>
							<td align="right"><%=gou.checkgoukei(tuki.getCyoukaMONTH())%></td>
							<td align="right"><%=gou.checkgoukei(tuki.getSinyaMONTH())%></td>
							<td align="right"><%=gou.checkgoukei(tuki.getFurouMONTH())%></td>
							<td align="right"><%=gou.checknissu(tuki.getKyudeMONTH())%></td>
							<td align="right"><%=gou.checknissu(tuki.getDaikyuMONTH())%></td>
							<td align="right"><%=gou.checknissu(tuki.getNenkyuMONTH())%></td>
							<td align="right"><%=gou.checknissu(tuki.getKekkinmonth())%></td>
							<td align="right"><%=gou.checknissu(tuki.getAkyuMONTH())%></td>
							<td align="right"><%=gou.checknissu(tuki.getBkyuMONTH())%></td>
							<td align="right"><%=gou.checkgoukei(tuki.getGoukeiMONTH())%></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table border="1" width="800px">
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
							<th align="center">当年付与日数</th>
							<th align="center">繰越年休日数</th>
							<th align="center">使用年休日数</th>
							<th align="center">残年休日数</th>
							<th align="center">月間残業時間</th>
							<th align="center">年間累積残業時間</th>
						</tr>
						<tr>
							<td align="center"><%=tuki.getNenkyu_fuyo()%></td>
							<td align="center"><%=tuki.getNenkyu_kurikoshi()%></td>
							<td align="center"><%=tuki.getNenkyu_year()%></td>
							<td align="center"><%=tuki.getNenkyu_all()%></td>
							<%
								} else {
							%>
						
						<tr>
							<th align="center">月間残業時間</th>
							<th align="center">年間累積残業時間</th>
						</tr>
						<tr>
							<%
								}
										ZangyouDAO zdao = new ZangyouDAO();
										year_month = (B_GamenInsatu) InsatuDATA.get(0);
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
							<%
								}
							%>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</center>
	<br>
	<center>
		<div class="noprint">
			<table>
				<tr>
					<td><a href="SystemKanri_MenuGamen.jsp"
						style="text-decoration: none;"><font class="link"><small>[
									メニューへ戻る ]</small></font></a></td>
					<td STYLE="cursor: default;"></td>
					<%
						}
							session.removeAttribute("InsatuDATA");
					%>
					<td><a href="Taishokusha_Eturan_Gamen.jsp"
						style="text-decoration: none;"><font class="link"><small>[
									選択画面へ戻る ]</small></font></a></td>
				</tr>
			</table>
		</div>
	</center>
</body>
</html>
<%
	}
%>