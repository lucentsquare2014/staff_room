<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.dao.NenkyuDAO" %><%@ page import = "kkweb.beans.B_NenkyuMST" %>
<jsp:useBean id="Shain" scope="session" class="kkweb.beans.B_ShainMentenanceMST"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{	%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
<!--
	function form_submitA(){
		//adrs ="http://www1.lucentsquare.co.jp/kintaikanri/Group_ichiran.jsp"
		adrs ="http://www.lucentsquare.co.jp:8080/kk_web/Group_ichiran.jsp"
		LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')
		LinkWin.location.href=adrs
	}
	function check(){
		var p = document.form1.f_name.value;
	   	var n = document.form1.g_name.value;
	    var h = document.form1.id.value;
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
			t.indexOf(aa) != -1 | t.indexOf(bb) != -1 | t.indexOf(cc) != -1 | t.indexOf(dd) != -1 | t.indexOf(ee) != -1 | t.indexOf(ff) != -1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{}
		if(window.confirm("�ސE�҂ɕύX���Ă�낵���ł���")){
			return true;
		}else{
			window.alert("�L�����Z������܂���");
			return false;
		}
	}
	function aboutbox() {				
		var p = document.form1.f_name.value;
	   	var n = document.form1.g_name.value;
	    var h = document.form1.id.value;
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
			t.indexOf(aa) != -1 | t.indexOf(bb) != -1 | t.indexOf(cc) != -1 | t.indexOf(dd) != -1 | t.indexOf(ee) != -1 | t.indexOf(ff) != -1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{		
			return true;
		}
	}	
-->
</script>
<title><%= Shain.getF_name()+"�@"+Shain.getG_name() %>�f�[�^�C��</title>
</head>
<body>
<center>
<font class="title"><%= Shain.getF_name()+"�@"+Shain.getG_name() %></font><br><hr color = "#008080">
<table>
<tr><td align="left"><small>1.�폳�F�҂ɕύX����ꍇ�͏��F�҃`�F�b�N����"0"�ɂ��Ă��������B</small></td></tr>
<tr><td align="left"><small>2.���F�҂ɕύX����ꍇ�͏��F�҃`�F�b�N����"1"�ɂ��Ă��������B</small></td></tr>
<tr><td align="left"><small>3.�����ԍ���<a  onClick="form_submitA()" style="cursor: pointer;"><font color="blue">�O���[�v�ꗗ</font></a>���m�F���Ă��������B</small></td></tr>
<tr><td align="left"><small><font color="red" >4.�u�ސE�҂ɕύX�v�{�^�����������ꍇ�̓V�X�e���Ǘ��ł̕������o���܂���B</font></small></td></tr>
</table><hr color = "#008080"><br>
<FORM method="post" action="c_shain_update" name="form1" onSubmit="return aboutbox()">
<TABLE BORDER="1"  class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">��</font></TH>
<TH class="t-koumoku"><font color="white">ID</font></TH>
<TH class="t-koumoku"><font color="white">�Ј��ԍ�</font></TH>
<TH class="t-koumoku"><font color="white">�����ԍ�</font></TH>
<TH class="t-koumoku"><font color="white">���F�҃`�F�b�N</font></TH>
<TH class="t-koumoku"><font color="white">���F�ҕ\������</font></TH>
<TH class="t-koumoku"><font color="white">��E</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="5" NAME="f_name" VALUE="<%= Shain.getF_name() %>"></TD>
<TD><INPUT TYPE="text" SIZE="5" NAME="g_name" VALUE="<%= Shain.getG_name() %>"></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="id" VALUE="<%= Shain.getId() %>" readonly="readonly"  style="background-color:#bfbfbf;"></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="number" VALUE="<%= Shain.getNumber() %>" readonly="readonly"  style="background-color:#bfbfbf;"></TD>
<TD><INPUT TYPE="text" SIZE="11" NAME="groupnumber" VALUE="<%= Shain.getGROUPnumber() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="20" NAME="checked" VALUE="<%= Shain.getChecked() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="18" NAME="hyouzijun" VALUE="<%= Shain.getHyouzijun() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="5" NAME="yakusyoku" VALUE="<%= Shain.getYakusyoku() %>" ></TD>
</TR>
<tr><TH class="t-koumoku" colspan="8"><font color="white">���[���A�h���X</font></TH></tr>
<tr><TD colspan="8"><INPUT TYPE="text" SIZE="112"  NAME="mail"  value="<%= Shain.getMail() %>" style="ime-mode: disabled;"></TD></tr>
</TABLE><br>
<TABLE BORDER="1"  class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">���N�x�N�x����</font></TH>
<TH class="t-koumoku"><font color="white">�c��N�x����</font></TH>
<TH class="t-koumoku"><font color="white">���N�x�N�x�g�p����</font></TH>
<TH class="t-koumoku"><font color="white">�O�N����̌J�z������</font></TH>
<TH class="t-koumoku"><font color="white">���N�x�̕t�^����</font></TH>
</TR>
<%	NenkyuDAO ndao = new NenkyuDAO();
	String sql = " where number ='"+Shain.getNumber()+"'";
	ArrayList nlist = ndao.selectTbl(sql);
	B_NenkyuMST nmst = new B_NenkyuMST();
	nmst = (B_NenkyuMST)nlist.get(0);%>
<TR>
<TD><INPUT TYPE="text" SIZE="21"  NAME="nenkyu_new" VALUE="<%= nmst.getNenkyu_new() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="21"  NAME="nenkyu_all" VALUE="<%= nmst.getNenkyu_all() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="28"  NAME="nenkyu_year" VALUE="<%= nmst.getNenkyu_year() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="30"  NAME="nenkyu_kurikoshi" VALUE="<%= nmst.getNenkyu_kurikoshi() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="24"  NAME="nenkyu_fuyo" VALUE="<%= nmst.getNenkyu_fuyo() %>" style="ime-mode: disabled; " ></TD>
</TR>
</TABLE><br>
<INPUT TYPE="submit" VALUE="�@�X�V�@"  class="bottom" >
</FORM><br>
<form action="c_shain_delete" method="post" onSubmit="return check()">
<input type="submit" VALUE="�ސE�҂ɕύX"  class="bottom" >
</form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</center>
</body>
</html>
<%}%>