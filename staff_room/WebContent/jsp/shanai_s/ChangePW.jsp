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
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else {
			document.form1.submit();
			return true;
		}
	}
// -->
</SCRIPT>
<title>�p�X���[�h�ύX</title>
</head>
<body>
<center>
<font class="title">�p�X���[�h�ύX</font>
<form method="post" action="c_changepw" name="form1" onSubmit="return aboutbox()">
<div class="box4">
<ul><li>���݂�ID�ƃp�X���[�h����͂��Ă�������</li></ul>
<table>
<tr>
<td align="center">I D</td>
<td align="left"><input type="text"  name="id"  value='' size="30" maxlength="20" class="text"></td>
</tr>
<tr>
<td align="center">�߽ܰ��</td>
<td align="left"><input type="password" name="pw"  value='' size="25" maxlength="20"></td>
</tr>
</table>
</div>
<div class="box5">
<ul><li><font>�ύX����p�X���[�h����͂��Ă�������</font></li></ul>
<input type="password" name="new_pw1"  value='' size="25" maxlength="20"><br>
<ul><li><font>�m�F�̂��߂�����x���͂��Ă�������</font></li></ul>
<input type="password" name="new_pw2"  value='' size="25" maxlength="20"><br><br>
<!-- <input type="submit"  value="�@�ύX�@"  style="cursor: pointer;"><br><br> -->
<input type="button"  value="�@�ύX�@" onclick="aboutbox()" style="cursor: pointer;"><br><br>
<a href="ID_PW_Nyuryoku.jsp" class="link"><font class="link"><small>[ ID�E�p�X���[�h���֖͂߂� ]</small></font></a>
</div>
</form>
</center>
</body>
</html>