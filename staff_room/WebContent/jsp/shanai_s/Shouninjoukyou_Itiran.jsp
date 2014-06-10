<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.dao.*"%>
<%@ page import="kkweb.dao.GroupDAO"%>
<%@ page import="kkweb.joukyou.S_Joukyou"%>
<%@ page import="kkweb.common.C_DBConnection"%>
<%@ page import="kkweb.beans.B_Shouninjoukyou"%>
<%@ page import="kkweb.beans.B_GroupMST"%>
<%@ page import="kkweb.beans.B_GoukeiMST"%>
<%@ page import="kkweb.beans.B_ShainMST"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="Year_month_group" scope="session"
	class="kkweb.beans.B_Year_month_group" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String) session.getAttribute("key");
	if (id2 == null || id2.equals("false")) {
		pageContext.forward("/");
	} else {
%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<title>承認状況一覧</title>
</head>
<BODY>
	<CENTER>
		<%
		System.out.println(Year_month_group.getGroupname());
			if (Year_month_group.getGroupname().equals(" 全グループ ")) {
		%>
		<font class="title">承認状況一覧</font><br>
		<br> <BIG><B><%=Year_month_group.getYear()%>年 <%=Year_month_group.getMonth()%>月<BR></B></BIG>
		<TABLE border="1" bordercolor="#008080"
			style="border: inset 5px #008080; width: 900px;">
			<TR>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>氏
							名</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>種
							類</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認状況</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
				<TD style="border-style: none;" class="cell2"></TD>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>氏
							名</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>種
							類</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認状況</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
				<TD style="border-style: none;" class="cell2"></TD>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>氏
							名</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>種
							類</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認状況</B></font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
			</TR>
			<TR>
				<%
					String flg = "";
							String c = "0";
							int j = 0;
							String id = "";
							String number = "";
							LoginDAO ldao = new LoginDAO();
							String sql = " where zaiseki_flg = '1' and not number='18901' "
									+ "and to_number(number,'99999') < 80000 order by to_number(number,'99999') asc  ";
							ArrayList slist = ldao.selectTbl(sql);
							B_ShainMST smst = new B_ShainMST();
							GoukeiDAO gdao = new GoukeiDAO();
							String sql2 = "select * from (goukeiMST inner join shainMST on goukeiMST.number = shainMST.number) "
									+ "where zaiseki_flg = '1' and year_month = '"
									+ Year_month_group.getYear_month()
									+ "' order by to_number(shainMST.number,'99999') asc ";
							ArrayList glist = gdao.selectTbl2(sql2);
							B_GoukeiMST gmst = new B_GoukeiMST();

							System.out.println("debug: 2");

							for (int i = 0; i < slist.size(); i++) {
								smst = (B_ShainMST) slist.get(i);
								id = smst.getId();
								if (j < glist.size()) {
									gmst = (B_GoukeiMST) glist.get(j);
									id2 = gmst.getId();
									if (id.equals(id2)) {
										flg = gmst.getFlg();
										j = j + 1;
									} else {
										flg = "";
									}
								} else {
									flg = "";
								}
								if (flg != null && flg.equals("0")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">勤務報告書</TD>
				<TD class="cell" align="center"
					STYLE="background-color: aqua; font-size: 12px">承認終了</TD>
				<TD class="cell" align="center" STYLE="font-size: 10px"><%=gmst.getSyouninRoot()%>
				</TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								} else if (flg != null && flg.equals("1")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">勤務報告書</TD>
				<TD class="cell" align="center"
					STYLE="background-color: yellow; font-size: 12px">承認中</TD>
				<TD class="cell" align="center" STYLE="font-size: 10px"><%=gmst.getSyouninRoot()%>
				</TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								} else if (flg != null && flg.equals("2")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">
				</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<TD class="cell" align="center" STYLE="font-size: 10px"></TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								} else if (flg == null || flg.equals("")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">
				</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<TD class="cell" align="center" STYLE="font-size: 10px"></TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								}
							}
							session.removeAttribute("Year_month_group");
				%>
			</TR>
		</TABLE>
		<%
			} else {
		%>
		<font class="title">承認状況一覧</font><br>
		<br> <BIG><B><%=Year_month_group.getYear()%>年 <%=Year_month_group.getMonth()%>月
				<%=Year_month_group.getGroupname()%></B></BIG><br>
		<TABLE border="1" bordercolor="#008080"
			style="border: inset 5px #008080; width: 800px;">
			<TR>
				<th nowrap class="t-koumoku"><font class="f-koumoku">氏
						名</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">種
						類</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">承認状況</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
				<TD style="border-style: none;" class="cell2"></TD>
				<th nowrap class="t-koumoku"><font class="f-koumoku">氏
						名</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">種
						類</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">承認状況</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
				<TD style="border-style: none;" class="cell2"></TD>
				<th nowrap class="t-koumoku"><font class="f-koumoku">氏
						名</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">種
						類</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku">承認状況</font></th>
				<th nowrap class="t-koumoku"><font class="f-koumoku"><B>承認経路</B></font></th>
			</TR>
			<TR>
				<%
					String flg = "";
							String c = "0";
							int j = 0;
							String id = "";
							String number = "";
							LoginDAO ldao = new LoginDAO();
							String sql = " where GROUPnumber = '"
									+ Year_month_group.getGroupnumber()
									+ "' AND zaiseki_flg = '1' and not number='18901' "
									+ "order by case when hyouzijun is null then'2' when hyouzijun ='' then '1' else '0' end , hyouzijun , to_number(number,'99999') asc";
							ArrayList slist = ldao.selectTbl(sql);
							B_ShainMST smst = new B_ShainMST();
							GoukeiDAO gdao = new GoukeiDAO();
							String sql2 = "select * from (goukeiMST inner join shainMST on goukeiMST.number = shainMST.number) "
									+ "where zaiseki_flg = '1' and year_month = '"
									+ Year_month_group.getYear_month()
									+ "' and GROUPnumber = '"
									+ Year_month_group.getGroupnumber()
									+ "' order by case when hyouzijun is null then'2' when hyouzijun ='' then '1' else '0' end , hyouzijun , to_number(shainMST.number,'99999') asc ";
							ArrayList glist = gdao.selectTbl2(sql2);
							B_GoukeiMST gmst = new B_GoukeiMST();
							for (int i = 0; i < slist.size(); i++) {
								smst = (B_ShainMST) slist.get(i);
								id = smst.getId();
								if (j < glist.size()) {
									gmst = (B_GoukeiMST) glist.get(j);
									id2 = gmst.getId();
									if (id.equals(id2)) {
										flg = gmst.getFlg();
										j = j + 1;
									} else {
										flg = "";
									}
								} else {
									flg = "";
								}
								if (flg != null && flg.equals("0")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">勤務報告書</TD>
				<TD class="cell" align="center"
					STYLE="background-color: aqua; font-size: 12px">承認終了</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"><%=gmst.getSyouninRoot()%>
				</TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								} else if (flg != null && flg.equals("1")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">勤務報告書</TD>
				<TD class="cell" align="center"
					STYLE="background-color: yellow; font-size: 12px">承認中</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"><%=gmst.getSyouninRoot()%>
				</TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								} else if (flg != null && flg.equals("2")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">
				</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
				%>
				<%
					} else if (flg == null || flg.equals("")) {
				%>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px"><%=smst.getName()%></TD>
				<TD nowrap class="cell" align="center" STYLE="font-size: 12px">
				</TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<TD class="cell" align="center" STYLE="font-size: 12px"></TD>
				<%
					if (c != null && c.equals("0")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "1";
									} else if (c != null && c.equals("1")) {
				%>
				<TD class="cell" style="border-style: none;"></TD>
				<%
					c = "2";
									} else if (c != null && c.equals("2")) {
				%>
			</TR>
			<TR>
				<%
					c = "0";
									}
								}
							}
							session.removeAttribute("Year_month_group");
				%>
			</TR>
		</TABLE>
		<%
			}
		%><br> <a href="Menu_Gamen.jsp" style="text-decoration: none;"><font
			class="link"><small>[ メニューへ戻る ]</small></font></a>
	</CENTER>
</BODY>
</HTML>
<%
	}
%>