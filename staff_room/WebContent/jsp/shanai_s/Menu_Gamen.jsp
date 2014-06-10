<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%><%@ page import="java.util.*"%><%@ page
	import="kkweb.beans.B_ShainMST"%>
<%@ page import="kkweb.beans.B_GroupMST"%><%@ page
	import="kkweb.beans.B_SyouninIraiMST"%><%@ page import="kkweb.common.C_DateYear"%>
<%@ page import="javax.servlet.http.HttpSession"%><%@ page
	import="javax.servlet.http.HttpServletRequest"%><%@ page
	import="kkweb.dao.GroupDAO"%>
<%@ page import="kkweb.dao.SyouninIraiDAO"%><%@ page import="kkweb.dao.LoginDAO"%><%@ page
	import="kkweb.common.C_CheckWord"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" /><jsp:setProperty
	property="checked" name="ShainMST" />
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
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="menu.css" type="text/css">
<script type="text/javascript">
	window.onunload = function() {
		document.body.style.cursor = 'auto';
		document.a.aa.disabled = false;
		document.b.bb.disabled = false;
		document.c.cc.disabled = false;
	}
	function submit1() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.a.submit()
	}
	function submit2() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.b.submit()
	}
	function submit3() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.c.submit()
	}
	function submit4() {
		document.body.style.cursor = 'wait';
		document.a.aa.disabled = true;
		document.b.bb.disabled = true;
		document.c.cc.disabled = true;
		document.d.dd.disabled = true;
		document.d.submit()
	}
</script>
<title>メニュー画面</title>
</head>
<body>

	<center>
		<div class="box5"></div>
		<div class="box2">
			<big><font class="title1">Member's room</font></big>
			<hr color="#008080">
			<br>
			<form method="post" action="s_kinmuhoukoku_nyuryoku" name="a">
				<ul>
					<li><b><font class="index1">勤務報告入力</font></b> <input
						type="submit" value="　入力　" class="botton1" onClick="submit1()"
						name="aa"> <select class="year" name="year">
							<%
								Calendar cal = Calendar.getInstance();
									int y = cal.get(Calendar.YEAR);
							%>
							<option value="<%=y%>" selected="<%=y%>"><%=y%>年
							</option>
							<%
								y--;
									for (int i = 2001; y > i; y--) {
							%>
							<option value="<%=y%>"><%=y%>年
							</option>
							<%
								}
							%>
					</select> <select class="month" name="month">
							<%
								int now_m = cal.get(Calendar.MONTH);
									now_m++;
									for (int m = 1; m < 13; m++) {
										if (m == now_m) {
							%>
							<option value="<%=m%>" selected="<%=m%>"><%=m%>月
							</option>
							<%
								} else {
							%>
							<option value="<%=m%>"><%=m%>月
							</option>
							<%
								}
									}
							%>
					</select></li>
				</ul>
			</form>
			<br>
			<form method="post" action="Escape_NameSelect.jsp" name="b">
				<ul>
					<li><b><font class="index1" style="word-spacing: 30px;">勤務報告閲覧</font></b>
						<input type="submit" value="　閲覧　" class="botton1"
						onClick="submit2()" name="bb"><input type="hidden"
						name="escapeflg" id="escapeflg" value="0"></li>
				</ul>
			</form>
			<br>
			<form method="post" action="s_joukyou" name="c">
				<ul>
					<li><b><font class="index1" style="word-spacing: 50px;">承認状況確認</font></b>
						<input type="submit" value="　表示　" class="botton1"
						onClick="submit3()" name="cc">
						<select class="year" name="year">
							<%
								y = cal.get(Calendar.YEAR);
									for (int j = 2001; y > j; y--) {
							%>
							<option value="<%=y%>"><%=y%>年
							</option>
							<%
								}
							%>
					</select><select class="month" name="month">
							<%
								for (int m2 = 1; m2 < 13; m2++) {
										if (m2 == now_m) {
							%>
							<option value="<%=m2%>" selected="<%=m2%>"><%=m2%>月
							</option>
							<%
								} else {
							%>
							<option value="<%=m2%>"><%=m2%>月
							</option>
							<%
								}
									}
							%>
					</select> <select class="group" name="group" style="width: 180px">
							<option value=" 全グループ ">全グループ</option>
							<%
								GroupDAO group = new GroupDAO();
									String sql = "";
									ArrayList list = group.selectTbl(sql);
									for (int s = 0; s < list.size(); s++) {
										B_GroupMST grouptbl = new B_GroupMST();
										grouptbl = (B_GroupMST) list.get(s);
										if(grouptbl.getGROUPnumber().equals("000") || grouptbl.getGROUPnumber().equals("800")) continue;
							%>
							<option value="<%=grouptbl.getGROUPname()%>"><%=grouptbl.getGROUPname()%></option>
							<%
								}
							%>
					</select></li>
				</ul>
			</form>
			<br> <a href="/staff_room/"
				class="link"><font class="link"><small>[
						スタッフルームトップへ ]</small></font></a>
		</div>
		<%
			if (ShainMST.getChecked().equals("1")) {
		%>
		<div class="box3">
			<font class="title2">承認依頼</font><br>
			<table>
				<tr>
					<td align="left"><font class="memo1">・同一の社員から複数の承認依頼が来ている場合、古いものから承認をお願いします。</font></td>
				</tr>
				<tr>
					<td align="left"><font class="memo1">・過去の勤務報告書の承認作業を行った場合、それ以降の勤務報告書の修正が必要となります。対象社員へ再提出を依頼してください。</font></td>
				</tr>
			</table>
			<TABLE border="3" bordercolor="#008080" class="ichiran">
				<%
					sql = "";
							ArrayList glist = new ArrayList();
							GroupDAO groupdao = new GroupDAO();
							glist = groupdao.selectTbl(sql);
							B_GroupMST b_group = new B_GroupMST();
				%>
				<TR>
					<%
						int m = 1;

								String login_id = ShainMST.getId();
								String login_number = ShainMST.getNumber();
								sql = " where syouninNumber = '" + login_number + "'";
								ArrayList sylist = new ArrayList();
								SyouninIraiDAO syouniniraidao = new SyouninIraiDAO();
								sylist = syouniniraidao.selectTbl(sql);

								for (int j = 0; j <= glist.size() - 1; ++j) {
									b_group = (B_GroupMST) glist.get(j);
									if(b_group.getGROUPnumber().equals("000") || b_group.getGROUPnumber().equals("800")) continue;
									if (m > 5) {
					%>
				</TR>
				<TR>
					<%
						m = 1;
									}
					%><TD align="center" valign="top" class="ichiran">
						<TABLE>
							<TR align="center">
								<TD align="center"><FONT class="ichiran"><%=b_group.getGROUPname()%></FONT><BR></TD>
							</TR>
							<%
								C_CheckWord word = new C_CheckWord();
											//	String login_id = ShainMST.getId();
											//	String login_number = ShainMST.getNumber();

											login_number = word.checks(login_number);
											//	sql = " where syouninNumber = '"+ login_number +"'";
											//	ArrayList sylist = new ArrayList();
											//	SyouninIraiDAO syouniniraidao = new SyouninIraiDAO();
											//	sylist = syouniniraidao.selectTbl(sql);

											B_SyouninIraiMST b_syouninirai = new B_SyouninIraiMST();
											for (int t = 0; t <= sylist.size() - 1; t++) {
												b_syouninirai = (B_SyouninIraiMST) sylist.get(t);
												sql = " where number = '"
														+ b_syouninirai.getIraiNumber() + "'";
												ArrayList alist = new ArrayList();
												LoginDAO logindao = new LoginDAO();
												alist = logindao.selectTbl(sql);
												B_ShainMST b_shain = new B_ShainMST();
												b_shain = (B_ShainMST) alist.get(0);
												String g_number = ShainMST.getGROUPnumber();
												if (b_group.getGROUPnumber().equals(
														b_shain.getGROUPnumber())) {
													String YEAR_MONTH = b_syouninirai
															.getYear_month();
													String YEAR = YEAR_MONTH.substring(0, 4);
													String MONTH = YEAR_MONTH.substring(4, 6);
							%>
							<TR>
								<TD>
									<FORM method="post" action="Shouninhoukoku.jsp" name="d">
										<INPUT TYPE="submit"
											VALUE="<%=YEAR%>年<%=MONTH %>月　<%=b_shain.getName()%> "
											class="botton3" name="dd"> <INPUT TYPE="hidden"
											NAME="iraisha_number" VALUE="<%=b_shain.getNumber()%>">
										<INPUT TYPE="hidden" NAME="iraisha_name"
											VALUE=" <%=b_shain.getName()%> "> <INPUT
											TYPE="hidden" NAME="iraisha_year_month"
											VALUE=" <%=b_syouninirai.getYear_month()%> ">
									</FORM>
								</TD>
							</TR>
							<%		}

	}%>
						</TABLE>
					</TD>
					<%	m++;
	}%>
				</TR>
			</TABLE>
			<%	}%>
		</div>
	</center>
</body>
</html>
<%}%>