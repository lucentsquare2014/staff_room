<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "kkweb.dao.*" %><%@ page import = "kkweb.beans.*" %><%@ page import = "java.util.*"%>
<%
	String id1 = (String)session.getAttribute("key");
	String id2 = (String)session.getAttribute("key2");
		if((id1 == null || id1.equals("false")) && (id2 == null || id2.equals("false"))){
			pageContext.forward("/staff_room/jsp/shanai_s/ID_PW_Nyuryoku.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script type="text/javascript">
	window.onunload=function(){
		document.body.style.cursor='auto';
		document.theform.aa.disabled=false;
	}
	function submit1(){
		document.body.style.cursor='wait';
		document.theform.aa.disabled=true;
		document.theform.submit()	
	}	
</script>
<title>�ΏێґI��</title>
</head>
<body>
<CENTER>
<%	request.setCharacterEncoding("Windows-31J");
	String escapeflg = request.getParameter("escapeflg");
	if(escapeflg.equals("0")){%>
<font class="title">���F��ƒ��E���F��ƏI���̋Ζ��񍐉{��</font>
<br><br><br>
<form action="Escape_YearMonthSelect.jsp" method="post" name="theform">
<table border="3" bordercolor="#008080"  style =" border:inset 5px #008080 " >
<tr>
<td align="left">�ΏێґI��</td>
<td align="left">
<select id="namae" name="namae" >
<%	LoginDAO dao = new LoginDAO();
	ArrayList array = new ArrayList();
	B_ShainMST shain = new B_ShainMST();
	String sql = " where zaiseki_flg = '1' and to_number(number,'99999') < 80000 order by to_number(number,'99999') ";
	array = dao.selectTbl(sql);
		for(int i = 0; i < array.size(); i++){
			shain = (B_ShainMST)array.get(i);%>
<option value="<%=shain.getNumber() %>"><%=shain.getNumber()%>�@<%=shain.getName() %></option>
<%		}%>
</select>
</td>
</tr>
</table><br>
<input type="submit"  value="�@���ց@" STYLE="cursor: pointer; " name="aa" onClick="submit1()">
<input type="hidden" name="escapeflg" id="escapeflg" value="<%=escapeflg %>">
</form><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
<%	}else{%>
<font class="title">�ސE�҂̏��F��ƏI���̋Ζ��񍐉{��</font>
<br><br><br>
<form action="Escape_YearMonthSelect.jsp" method="post" name="theform">
<table border="3" bordercolor="#008080"" style =" border:inset 5px #008080 ;width:250px" >
<tr>
<td align="left">�ΏێґI��</td>
<td align="left">
<select id="namae" name="namae" >
<%	LoginDAO dao = new LoginDAO();
	ArrayList array = new ArrayList();
	B_ShainMST shain = new B_ShainMST();
	String sql = " where zaiseki_flg = '0' order by to_number(number,'99999') ";
	array = dao.selectTbl(sql);
		for(int i = 0; i < array.size(); i++){
			shain = (B_ShainMST)array.get(i);%>
<option value="<%=shain.getNumber() %>"><%=shain.getNumber()%>�@<%=shain.getName() %></option>
<%		}%>
</select>
</td>
</tr>
</table><br>
<input type="submit"  value="�@���ց@" STYLE="cursor: pointer; " name="aa" onClick="submit1()">
<input type="hidden" name="escapeflg" id="escapeflg" value="<%=escapeflg %>">
</form><br>
<a href="SystemKanri_MenuGamen.jsp" style="text-decoration:none;"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
<%	}%>
</CENTER>
</body>
</html>
<%}%>