<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
<!--
	function form_submitA(){
	//adrs ="http://www1.lucentsquare.co.jp/kintaikanri/Group_ichiran.jsp"
	//�ڍs��͈ȉ����g�p
	adrs ="http://www.lucentsquare.co.jp:8080/kk_web/Group_ichiran.jsp"
	LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')
	LinkWin.location.href=adrs
	}
	function aboutbox() {	
		var p = document.form1.f_name.value;
	   	var n = document.form1.g_name.value;
	    var h = document.form1.id.value;
	    var y = document.form1.pw.value;
	    var i = document.form1.number.value;
	    var t = document.form1.mail.value;
	    var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";
		if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1 | p.indexOf(dd) != -1 | p.indexOf(ee) != -1 | p.indexOf(ff) != -1 | 
			n.indexOf(aa) != -1 | n.indexOf(bb) != -1 | n.indexOf(cc) != -1 | n.indexOf(dd) != -1 | n.indexOf(ee) != -1 | n.indexOf(ff) != -1 |
			h.indexOf(aa) != -1 | h.indexOf(bb) != -1 | h.indexOf(cc) != -1 | h.indexOf(dd) != -1 | h.indexOf(ee) != -1 | h.indexOf(ff) != -1 |
			i.indexOf(aa) != -1 | i.indexOf(bb) != -1 | i.indexOf(cc) != -1 | i.indexOf(dd) != -1 | i.indexOf(ee) != -1 | i.indexOf(ff) != -1 |
			t.indexOf(aa) != -1 | t.indexOf(bb) != -1 | t.indexOf(cc) != -1 | t.indexOf(dd) != -1 | t.indexOf(ee) != -1 | t.indexOf(ff) != -1 |
			y.indexOf(aa) != -1 | y.indexOf(bb) != -1 | y.indexOf(cc) != -1 | y.indexOf(dd) != -1 | y.indexOf(ee) != -1 | y.indexOf(ff) != -1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{	
			return true;			
		}
	}
-->
</script>
<title>�Ј��ǉ�</title>
</head>
<body>
<center>
<font class="title">�Ј��ǉ�</font><br><hr color ="#008080">
<table>
<tr><td align="left"><small>1.���O�ȊO�̍��ڂ͑S�Ĕ��p�p�����œ��͂��Ă��������B</small></td></tr>
<tr><td align="left"><small>2.���F�҂ł���ꍇ�͏��F�҃`�F�b�N����"1"����͂��Ă��������B</small></td></tr>
<tr><td align="left"><small>3.�폳�F�҂ł���ꍇ�͏��F�҃`�F�b�N����"0"����͂��Ă��������B</small></td></tr>
<tr><td align="left"><small>4.�����ԍ���<a  onClick="form_submitA()" style="cursor: pointer;"><font class="link">�O���[�v�ꗗ</font></a>���m�F���Ă��������B</small></td></tr>
</table><hr color ="#008080"><br>
<FORM method="post" action="c_shain_tuika" name="form1" onSubmit="return aboutbox()" >
<TABLE BORDER="1" class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">ID</font></TH>
<TH class="t-koumoku"><font color="white">�p�X���[�h</font></TH>
<TH class="t-koumoku"><font color="white">�Ј��ԍ�</font></TH>
<TH class="t-koumoku"><font color="white">�O���[�v�ԍ�</font></TH>
<TH class="t-koumoku"><font color="white">���F�҃`�F�b�N</font></TH>
<TH class="t-koumoku"><font color="white">���F�ҕ\������</font></TH>
<TH class="t-koumoku"><font color="white">��E</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="7"  NAME="f_name" ></TD>
<TD><INPUT TYPE="text" SIZE="7"  NAME="g_name" ></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="id" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="13" NAME="pw" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="11"  NAME="number" style="ime-mode: disabled;"></TD>
<TD><INPUT TYPE="text" SIZE="17"  NAME="groupnumber" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="20"  NAME="checked" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="5"  NAME="hyouzijun" ></TD>
<TD><INPUT TYPE="text" SIZE="5"  NAME="yakusyoku" ></TD>
</TR>
<tr><TH class="t-koumoku" colspan="7"><font color="white">���[���A�h���X</font></TH></tr>
<tr><TD colspan="7"><INPUT TYPE="text" SIZE="85"  NAME="mail" style="ime-mode: disabled;">@lucentsquare.co.jp</TD></tr>
</TABLE><br>
<TABLE>
<TR><TD><INPUT TYPE="submit" VALUE="�@�ǉ��@" class="bottom" ></TD></TR>
</TABLE>
</FORM><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</center>
</body>
</html>
<%}%>