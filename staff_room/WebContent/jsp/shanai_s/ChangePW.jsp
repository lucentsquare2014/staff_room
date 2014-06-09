<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="login.css" type="text/css">
<SCRIPT Language="JavaScript">
		<!--

	function aboutbox() {
		var p = document.form1.new_pw1.value;
		var n = document.form1.new_pw2.value;
		var id = document.form1.id.value;
		var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";

		if (p.indexOf(aa) != -1 || p.indexOf(bb) != -1 || p.indexOf(cc) != -1
				|| p.indexOf(dd) != -1 || p.indexOf(ee) != -1
				|| p.indexOf(ff) != -1 || n.indexOf(aa) != -1
				|| n.indexOf(bb) != -1 || n.indexOf(cc) != -1
				|| n.indexOf(dd) != -1 || n.indexOf(ee) != -1
				|| n.indexOf(ff) != -1) {
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else {
			document.form1.submit();
			return true;
		}
	}
// -->
</SCRIPT>
<title>パスワード変更</title>
</head>
<body>
<center>
<font class="title">パスワード変更</font>
<form method="post" action="c_changepw" name="form1" onSubmit="return aboutbox()">
<div class="box4">
<ul><li>現在のIDとパスワードを入力してください</li></ul>
<table>
<tr>
<td align="center">I D</td>
<td align="left"><input type="text"  name="id"  value='' size="30" maxlength="20" class="text"></td>
</tr>
<tr>
<td align="center">ﾊﾟｽﾜｰﾄﾞ</td>
<td align="left"><input type="password" name="pw"  value='' size="25" maxlength="20"></td>
</tr>
</table>
</div>
<div class="box5">
<ul><li><font>変更するパスワードを入力してください</font></li></ul>
<input type="password" name="new_pw1"  value='' size="25" maxlength="20"><br>
<ul><li><font>確認のためもう一度入力してください</font></li></ul>
<input type="password" name="new_pw2"  value='' size="25" maxlength="20"><br><br>
<!-- <input type="submit"  value="　変更　"  style="cursor: pointer;"><br><br> -->
<input type="button"  value="　変更　" onclick="aboutbox()" style="cursor: pointer;"><br><br>
<a href="ID_PW_Nyuryoku.jsp" class="link"><font class="link"><small>[ ID・パスワード入力へ戻る ]</small></font></a>
</div>
</form>
</center>
</body>
</html>