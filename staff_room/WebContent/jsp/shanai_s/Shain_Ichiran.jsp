<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.beans.B_ShainMST" %><%@ page import = "kkweb.beans.B_GroupMST" %><%@ page import = "kkweb.dao.LoginDAO" %><%@ page import = "kkweb.dao.GroupDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{	%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<title>社員マスタメンテナンス</title>
</head>
<body>
<center>
<font class="title">社員一覧</font><br><hr color ="#008080">
<table>
<tr><td align="left"><small>1.新たに社員を登録する場合は<a  href="Shain_tuikaGamen.jsp"  style="text-decoration:none;"><font color="blue">こちら</font></a>を押してください。</small></td></tr>
<tr><td align="left"><small>2.社員データの修正、又は退職者に変更をする場合は下表から変更する社員名のボタンを押してください。</small></td></tr>
</table><hr color ="#008080"><br>
<table border="3" bordercolor="#008080" class="ichiran" style="table-layout:fixed;">
<tr>
<%	GroupDAO group = new GroupDAO();
	String sql = "";
	ArrayList list = group.selectTbl(sql);
	int j = 1;
	for(int s = 0; s < list.size(); s++){
		B_GroupMST grouptbl = new B_GroupMST();
		grouptbl = (B_GroupMST)list.get(s);
		if(j > 5){%>
</tr><tr><%j = 1;
		}%>
<TD align="center" valign="top" class="ichiran" width="154">
<font class="ichiran"><strong><%= grouptbl.getGROUPname() %></strong><br/>　</font>
<%	LoginDAO ldao = new LoginDAO();
	String sql_2 = " where GROUPnumber='"+grouptbl.getGROUPnumber()+"' AND zaiseki_flg ='1' order by case when number ='20909' then '3' when hyouzijun is null then'2' when hyouzijun ='' then '1' else '0' end , hyouzijun , to_number(number,'99999') asc";
	ArrayList slist = ldao.selectTbl(sql_2);
		for(int i = 0; i < slist.size(); i++){
			B_ShainMST bshain = new B_ShainMST();
			bshain = (B_ShainMST)slist.get(i);
			if(!bshain.getName().equals("")){%>
<form action="c_shain_jyouhou" method="post">
	
<input type="submit" value="<%= bshain.getName() %>"  class="ichiran">
<input type="hidden" name="shain_number" value="<%= bshain.getNumber() %>">
		
</form><%	}
		}%>

</td><%j++;
		}%>
</TR>
</TABLE><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>