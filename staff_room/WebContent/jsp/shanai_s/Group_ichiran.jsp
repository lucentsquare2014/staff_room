<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.beans.B_GroupMST" %><%@ page import = "kkweb.dao.GroupDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/");
		}else{	%>
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<title>グループ一覧表</title>
<script type="text/javascript">
<!--
window.focus();
-->
</script>
</head>
<body>
<table border="1" width="350" >
<tr>
<th class="t-koumoku" ><font class="f-koumoku">所属番号</font></th>
<th class="t-koumoku" ><font class="f-koumoku">所属名称</font></th>
</tr>
<%
	GroupDAO gdao = new GroupDAO();
	String sql = " order by to_number(groupnumber,'99') asc ";
	ArrayList glist = gdao.selectTbl(sql);
	B_GroupMST grouptbl = new B_GroupMST();
	for(int i = 0; i < glist.size(); i++){
		grouptbl = (B_GroupMST)glist.get(i);%>
<tr>
<td><%= grouptbl.getGROUPnumber() %></td>
<td><%= grouptbl.getGROUPname() %></td>
</tr>
<%	}%>
</table>
</body>
</html>
<%}%>