<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<title>承認作業終了確認</title>
</head>
<body>
<center>
<font class="title">承認作業終了確認</font><br><hr color = "#008080">
<table>
<tr><td align="left"><small>1.「承認作業終了」ボタンを押して承認作業を完了させてください。</small></td></tr>
<tr><td align="left"><small>2. 再度承認依頼を行う場合は下表の承認者一覧から選択してください。</small></td></tr>
</table><hr color = "#008080"><br>
<%	request.setCharacterEncoding("UTF-8");
	String iraisha_number = request.getParameter("iraisha_number");
	String iraisha_year_month = request.getParameter("iraisha_year_month");
	String iraisha_name = request.getParameter("iraisha_name");%>
<FORM method="post" action="s_shouninkakunin">
<INPUT TYPE="submit" VALUE="承認作業終了" STYLE="cursor: pointer; width:90;background-color:aqua">
<INPUT TYPE="hidden"  NAME="iraisha_number" VALUE="<%=iraisha_number %>">
<INPUT TYPE="hidden"  NAME="iraisha_year_month" VALUE="<%=iraisha_year_month %>">
</FORM><br>
<TABLE border="3"  bordercolor="#008080" class="ichiran" >
<%	String sql = "";
	ArrayList glist = new ArrayList();
	GroupDAO groupdao = new GroupDAO();
	glist = groupdao.selectTbl(sql);
	B_GroupMST b_group = new B_GroupMST();%>
<TR>
<%	int m = 1;
	for(int j=0;j<=glist.size() - 1;++j){
	b_group = (B_GroupMST)glist.get(j);
		if(m > 5){%>
</TR><TR>
<%	m = 1;}%>
<TD align="center" valign="top" class="ichiran" >
<TABLE>
<TR><TD align="center"><FONT class="ichiran"><%= b_group.getGROUPname()%></FONT></TD></TR>
<%	sql = "";
	ArrayList sylist = new ArrayList();
	SyouninshaDAO syouninshadao = new SyouninshaDAO();
	sylist = syouninshadao.selectTbl(sql);
	B_SyouninshaMST b_syouninsha = new B_SyouninshaMST();
	for(int i=0;i<=sylist.size() - 1;++i){
		b_syouninsha = (B_SyouninshaMST)sylist.get(i);
		if(b_group.getGROUPnumber().equals(b_syouninsha.getGROUPnumber())){%>
<TR>
<TD>
<FORM method="post" action="MailSend_Gamen3.jsp">
<INPUT TYPE="submit" VALUE="<%= b_syouninsha.getName() %>" NAME="shouninsha_name" class="ichiran">
<INPUT TYPE="hidden" NAME="shouninsha_number" VALUE="<%= b_syouninsha.getNumber() %>">
<INPUT TYPE="hidden" NAME="shouninsha_mail" VALUE="<%= b_syouninsha.getMail() %>">
<INPUT TYPE="hidden" NAME="shouninsha_name" VALUE="<%= b_syouninsha.getName() %>">
<INPUT TYPE="hidden" NAME="iraisha_number"VALUE="<%=iraisha_number %>" >
<INPUT TYPE="hidden" NAME="iraisha_name" VALUE="<%=iraisha_name %>">
<INPUT TYPE="hidden" NAME="iraisha_year_month"VALUE="<%=iraisha_year_month %>" >
<INPUT TYPE="hidden" NAME="body" VALUE=" <%= b_syouninsha.getName() %> さんへ <%= iraisha_name %> さんの勤務報告書の承認をお願いします。 <%= ShainMST.getName() %> より　http://www.lucentsquare.co.jp:8080/staff_room/jsp/shanai_s/shanai_s?mode=2"/>
</FORM>
</TD>
</TR>
<%	}}%>
</TABLE>
</TD>
<%m++;}%>
</TR>
</TABLE><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>