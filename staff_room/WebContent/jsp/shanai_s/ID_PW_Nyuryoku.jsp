<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang = "ja">
<head>
<script type="text/javascript">
	window.onunload=function(){
		document.body.style.cursor='auto';
		document.theform.aa.disabled=false;
		document.theform.bb.disabled=false;
	}
	function submit1(){
		document.body.style.cursor='wait';
		document.theform.aa.disabled=true;
		document.theform.bb.disabled=true;
		document.theform.submit();
		}	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=shift-jis">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="login.css" type="text/css">
<title>�F�؉��</title>
</head>
<body>

<center>
<div class="box3"></div><div class="box1">
<form method="POST" action="s_login" name="theform">
<input type="hidden" name="action" value="gate">
<b><font class="title">ID���p�X���[�h����͂��Ă�������</font></b>
<hr  color = "#008080">
<table>
<tr><td align="left"><small>1.�K�v��������͂��AOK�������Ă��������B</small></td></tr>
<tr><td align="left"><small>2.�S�p�J�i�͎g�p���Ȃ��ł��������B</small></td></tr>
<tr><td align="left"><small>3.�V�X�e���Ǘ���<a href="Pw_Nyuryoku_system.jsp" class="link"><font class="link">������</font></a>��������Ă��������B</small></td></tr>
</table>
<hr  color = "#008080"><br>
<div class="box2">
<table border="5" bordercolor="#008080" cellpadding="0" cellspacing="5" width="280px">
<tr>
<td align="center">I D</td>
<td align="left"><input type="text"  name="shainID"  value='' size="30" maxlength="20" class="text"></td>
</tr>
<tr>
<td align="center">�߽ܰ��</td>
<td align="left"><input type="password" name="Pwd"  value='' size="25" maxlength="20"></td>
</tr>
</table>
<table>
<tr>
<td><input type="submit"  value="�n�j" class ="button" name="aa" onClick="submit1()"></td>
<td><input type="reset"  value="CLEAR" class ="button" name="bb"></td>
</tr>
</table>
<div style="text-align: right; margin-right: 10px;"><a href="ChangePW.jsp" class="link"><font class="link" Style="font-size:10px;">���p�X���[�h�ύX</font></a></div></div>
</form><br>
<a href="http://www.lucentsquare.co.jp/staff/staff_main.html" class="link"><font class="link"><small>[ �X�^�b�t���[���֖߂� ]</small></font></a></div>
</center>
</body>
<%--
 Enumeration<String> enume = session.getAttributeNames();
 while(enume.hasMoreElements()){
	String key = enume.nextElement();
	if(key.equals("target")) continue;
	session.removeAttribute(key);
 }
--%>
</html>