<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.maintenance.*" %><%@ page import="kkweb.common.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<%	request.setCharacterEncoding("windows-31j");
	C_CheckWord word = new C_CheckWord();
	String onamae = request.getParameter("kousinnamae");
	onamae = word.checks(onamae);
	String sql = "select * from codemst where flg = '0' and PROJECTcode = '"+ onamae +"' order by projectcode,kinmucode ";
	ArrayList projectlist = new ArrayList();
	CodeDAO projectdao = new CodeDAO();
	projectlist = projectdao.selectTbl(sql);
	int kazu = projectlist.size()-1;%>
<script type="text/javascript">
<!--
	function check(){							
		if(document.getElementsByName("pro_name")[0].value==""){
			if(window.confirm("�v���W�F�N�g���폜���Ă��Ă�낵���ł���")){
				return true;
			}else{
			window.alert("�L�����Z������܂���");
				return false;
			}
		}
		var aaa = "\"";
 		var bbb = "\'";
 		var ccc = "\\";
 		var ddd = ">";
 		var eee = "<";
 		var fff = "\`";
 		var j = document.form1.pro_name.value;
		if (j.indexOf(aaa) != -1 | j.indexOf(bbb) != -1 | j.indexOf(ccc) != -1 | j.indexOf(ddd) != -1 | j.indexOf(eee) != -1 | j.indexOf(fff) != -1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{}
		var A=0;
<%	for(int i = 0; i <= kazu; i++){%>
		var n = document.form1.pro_basho<%=i%>.value;
		var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";
		if (n.indexOf(aa) != -1 | n.indexOf(bb) != -1 | n.indexOf(cc) != -1 | n.indexOf(dd) != -1 | n.indexOf(ee) != -1 | n.indexOf(ff) != -1){
			A=1;
		}else{}
		<%-- 20111101 �͑��ǉ��@�x�e�̓��̓`�F�b�N --%>
		<% if(i == 0 || (i > 2 && i < 7)){ %>
		var kyukei<%=i%> = document.form1.pro_kyuukei<%=i%>.value;
		if(kyukei<%=i%> == ""){
			window.alert("�x�e���Ԃɐ��l����͂��Ă��������B");
			return false;
		}
		<% } %>		
<%	}%>
		if(A==1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{
			return true;
		}
	}	
-->
</script>
<title>�v���W�F�N�g�{���E�X�V�E�폜</title>
</head>
<body>
<center>
<font class="title">�v���W�F�N�g�}�X�^�����e�i���X</font><br>
<hr color = "#008080">
<table>
<tr><td align="left"><small>1.�{���݂̂̏ꍇ�͕ύX�����Ɂu�X�V�v�{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small>2.�X�V����ꍇ�̓v���W�F�N�g�������������ɕύX���āu�X�V�v�{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small>�E�J�n�E�I�����Ԃ�24���Ԉȏ��60���ȏ�A���p�����ł͂Ȃ��ꍇ�͐������L�q����܂���B</small></td></tr>
<tr><td align="left"><small>�E�J�n�E�I�����Ԃ�0900(9��)��1830(18��30��)�̗l�ɁA�x�e���Ԃ�60(60��)�̗l�ɋL�ڂ��Ă��������B</small></td></tr>
<tr><td align="left"><small>�E�x�݂Ȃǎ��Ԃ��L������K�v���Ȃ��ꍇ�͎��Ԙg���󗓂ɂ��Ă��������B</small></td></tr>
<tr><td align="left"><small>3.�폜����ꍇ�̓v���W�F�N�g�����������āu�X�V�v�{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small><font color="red" >�E��x�폜�����v���W�F�N�g�̓V�X�e���Ǘ��ł̕������o���܂���B</font></small></td></tr>
</table><hr color = "#008080"><br>
<%	B_Code bcode = new B_Code();
	bcode = (B_Code)projectlist.get(0);%>
<FORM method="post" action="c_project_kousin" onSubmit="return check()" name="form1">
<TABLE BORDER="1"  class="mainte">
<TR><TH colspan="7" >�v���W�F�N�g���́F<INPUT  TYPE="text" SIZE="30"  NAME="pro_name" VALUE="<%=bcode.getPROJECTname() %>" ></TH></TR>
<TR><TD colspan="7"  align="center">�v���W�F�N�g�R�[�h�F<%=onamae %></TD></TR>
<TR>
<TH class="t-koumoku"><font color="white">�Ζ���</font></TH>
<TH class="t-koumoku"><font color="white">�J�n����</font></TH>
<TH class="t-koumoku"><font color="white">�I������</font></TH>
<TH class="t-koumoku"><font color="white">�x�e����</font></TH>
<TH class="t-koumoku"><font color="white">�ꏊ</font></TH>
</TR>
<INPUT TYPE="hidden" NAME="kazu" VALUE="<%=kazu%>">
<%	for(int i=0; i<=projectlist.size()-1  ;++i){
	bcode = (B_Code)projectlist.get(i);%>
<TR>
<TD><INPUT TYPE="text" SIZE="15" style="background-color:#bfbfbf;" NAME="pro_bikou<%= i %>"VALUE="<%=bcode.getBikou() %>" readonly="readonly"></TD>
<TD><INPUT TYPE="text" SIZE="11" style="ime-mode: disabled;" maxlength="4"   NAME="pro_kaisi<%= i %>" VALUE="<%= bcode.getStartTIME() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="11" style="ime-mode: disabled;" maxlength="4"   NAME="pro_shuuryou<%= i %>" VALUE="<%= bcode.getEndTIME() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="11" style="ime-mode: disabled;" maxlength="3"   NAME="pro_kyuukei<%= i %>" VALUE="<%= bcode.getRestTIME() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="15" NAME="pro_basho<%= i %>" VALUE="<%= bcode.getBasyo() %>" ></TD>
</TR>
<%}	String size = Integer.toString(projectlist.size());%>
</TABLE>
<table>
<TR>
<TD>
<INPUT TYPE="submit" VALUE="�@�X�V�@"   class="bottom" >
<INPUT TYPE="hidden"  NAME="pro_code" VALUE="<%=onamae %>" >
<INPUT TYPE="hidden"  NAME="p_size" VALUE="<%= size %>">
</TD>
</TR>
</table></form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</center>
</body>
</html>
<%}%>	