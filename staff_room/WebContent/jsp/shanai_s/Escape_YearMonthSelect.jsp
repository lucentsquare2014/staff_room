<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "kkweb.dao.*" %><%@ page import = "kkweb.beans.*" %><%@ page import = "java.util.*"%><%@ page import = "kkweb.common.*" %>
<%	String id1 = (String)session.getAttribute("key");
	String id2 = (String)session.getAttribute("key2");
		if((id1 == null || id1.equals("false")) && (id2 == null || id2.equals("false"))){
			pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script type="text/javascript">
	window.onunload=function(){
		document.body.style.cursor='auto';
		document.a.aa.disabled=false;
	}
	function submit1(){
		document.body.style.cursor='wait';
		document.a.aa.disabled=true;
		document.a.submit()
	}	
</script>
<title>�N���I��</title>
</head>
<body>
<CENTER>
<%	request.setCharacterEncoding("Windows-31J");
	String escapeflg = request.getParameter("escapeflg");
	String number = request.getParameter("namae");
	if(escapeflg.equals("0")){%>
<font  class="title">���F��ƒ��E���F��ƏI���̋Ζ��񍐉{��</font>
<br><br><br>
<form action="e_eturan" method="post" name="a">
<table border="3" bordercolor="#008080"  style =" border:inset 5px #008080 " >
<tr>
<td align="left">�Ώێ�</td>
<td>
<%	LoginDAO dao = new LoginDAO();
	ArrayList array = new ArrayList();
	B_ShainMST shain = new B_ShainMST();
	String sql = " where number = '"+number+"'";
	array = dao.selectTbl(sql);
	shain = (B_ShainMST)array.get(0);
	String onamae = (String)shain.getName();%>
		<%= number %>�@<%= onamae %>
</td>
</tr>
<tr>
<td align="left">�Ώ۔N���I��</td>
<td align="left">
<select id="yearmonth" name="yearmonth">
<%	GoukeiDAO G = new GoukeiDAO();
	B_GoukeiMST B = new B_GoukeiMST();
	sql ="where flg = '1' and  number = '"+number+"' or flg = '0' and  number = '"+number+"'  order by to_number(year_month,'999999') desc ";
	array = G.selectTbl(sql);
	for(int i = 0 ; i < array.size() ; i++){
	B = (B_GoukeiMST)array.get(i);
	String ym = B.getYear_month();
	String check = B.getFlg();
	C_CheckMonth mont = new C_CheckMonth();
		if(check.equals("0")){%>
<option value="<%= ym %>"><%=ym.substring( 0 , 4 ) %>�N�@<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>��</option>
<%		}else{%>	
<option value="<%= ym %>"><%=ym.substring( 0 , 4 ) %>�N�@<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>��(���F��ƒ�)</option>
<%		}
	}%>	</select>
</td>
</tr>
</table><br>
<input type="submit"  value="�@�\���@" STYLE="cursor: pointer; " onClick="submit1()" name="aa">
<input type="hidden" name="number" id="number" value="<%=number %>">
<input type="hidden" name="escapeflg" id="escapeflg" value="<%=escapeflg %>">
</form><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
<%	}else{%>
<font class="title">�ސE�҂̏��F��ƏI���̋Ζ��񍐉{��</font>
<br><br><br>
<form action="e_eturan" method="post" name="a">
<table border="3" bordercolor="#008080"  style =" border:inset 5px #008080 ;width:250px" >
<tr>
<td align="left">�ΏێґI��<br></td>
<td>
<%	LoginDAO dao = new LoginDAO();
	ArrayList array = new ArrayList();
	B_ShainMST shain = new B_ShainMST();
	String sql = " where number = '"+number+"'";
	array = dao.selectTbl(sql);
	shain = (B_ShainMST)array.get(0);
	String onamae = (String)shain.getName();%>							
		<%= number %>�@<%= onamae %>
</td>
</tr>
<tr>
<td align="left">�Ώ۔N���I��</td>
<td align="left">
<select id="yearmonth" name="yearmonth">
<%	GoukeiDAO G = new GoukeiDAO();
	B_GoukeiMST B = new B_GoukeiMST();
	sql ="where flg = '0'  and  number = '"+number+"'  order by to_number(year_month,'999999') desc ";;
	array = G.selectTbl(sql);
	for(int i = 0 ; i < array.size() ; i++){
		B = (B_GoukeiMST)array.get(i);
		String ym = B.getYear_month();
		C_CheckMonth mont = new C_CheckMonth();%>
		<option value="<%= ym %>"><%=ym.substring( 0 , 4 ) %>�N�@<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>��</option>
<%	}%>
</select>
</td>
</tr>
</table><br>
<input type="submit"  value="�@�\���@" STYLE="cursor: pointer; " onClick="submit1()" name="aa">
<input type="hidden" name="number" id="number" value="<%=number %>">
<input type="hidden" name="escapeflg" id="escapeflg" value="<%=escapeflg %>">
</form><br>
<a href="SystemKanri_MenuGamen.jsp" style="text-decoration:none;"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
<%	}%>
</CENTER>
</body>
</html>
<%}%>	