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
<title>認証画面</title>
</head>
<body>

<center>
<div class="box3"></div><div class="box1">
<form method="POST" action="s_login" name="theform">
<input type="hidden" name="action" value="gate">
<b><font class="title">ID＆パスワードを入力してください</font></b>
<hr  color = "#008080">
<table>
<tr><td align="left"><small>1.必要事項を入力し、OKを押してください。</small></td></tr>
<tr><td align="left"><small>2.全角カナは使用しないでください。</small></td></tr>
<tr><td align="left"><small>3.システム管理は<a href="Pw_Nyuryoku_system.jsp" class="link"><font class="link">こちら</font></a>から入ってください。</small></td></tr>
</table>
<hr  color = "#008080"><br>
<div class="box2">
<table border="5" bordercolor="#008080" cellpadding="0" cellspacing="5" width="280px">
<tr>
<td align="center">I D</td>
<td align="left"><input type="text"  name="shainID"  value='' size="30" maxlength="20" class="text"></td>
</tr>
<tr>
<td align="center">ﾊﾟｽﾜｰﾄﾞ</td>
<td align="left"><input type="password" name="Pwd"  value='' size="25" maxlength="20"></td>
</tr>
</table>
<table>
<tr>
<td><input type="submit"  value="ＯＫ" class ="button" name="aa" onClick="submit1()"></td>
<td><input type="reset"  value="CLEAR" class ="button" name="bb"></td>
</tr>
</table>
<div style="text-align: right; margin-right: 10px;"><a href="ChangePW.jsp" class="link"><font class="link" Style="font-size:10px;">＊パスワード変更</font></a></div></div>
</form><br>
<a href="http://www.lucentsquare.co.jp/staff/staff_main.html" class="link"><font class="link"><small>[ スタッフルームへ戻る ]</small></font></a></div>
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