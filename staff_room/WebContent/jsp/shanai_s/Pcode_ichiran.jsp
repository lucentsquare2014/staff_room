<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.beans.B_Code" %><%@ page import = "kkweb.dao.CodeDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{	%>
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<title>Pコード一覧表</title>
<script type="text/javascript">
<!--
window.focus();
-->
</script>
</head>
<body>
<table border="1" width="380px" >
<tr>
<th class="t-koumoku" ><font class="f-koumoku">Ｐコード</font></th>
<th class="t-koumoku" ><font class="f-koumoku">名称</font></th>
<th class="t-koumoku" ><font class="f-koumoku">場所</font></th>
</tr>
<%	CodeDAO cdao = new CodeDAO();
	String sql = " select * from codeMST where KINMUcode = '1' AND flg = '0' order by projectcode asc";
	ArrayList clist = cdao.selectTbl(sql);
	B_Code codetbl = new B_Code();
	for(int i = 0; i < clist.size(); i++){
		codetbl = (B_Code)clist.get(i);%>
<tr>
<td><%= codetbl.getPROJECTcode() %></td>
<td><%= codetbl.getPROJECTname() %></td>
<td><%= codetbl.getBasyo() %></td>
</tr>
<%	}%>
</table>
</body>
</html>
<%}%>