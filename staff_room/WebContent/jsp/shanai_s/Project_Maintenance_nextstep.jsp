<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.maintenance.*" %><%@ page import="kkweb.common.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){		
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; Charset=Shift_JIS"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
	window.onunload=function(){};
	history.forward();
</script>
<SCRIPT Language="JavaScript">
<!--
	function aboutbox() {
		var A=0;
<%	for(int i = 0; i < 11; i++){%>
		var p = document.form1.k_name<%=i%>.value;
		var n = document.form1.k_code<%=i%>.value;
		var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";	
		if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1 | p.indexOf(dd) != -1 | p.indexOf(ee) != -1 | p.indexOf(ff) != -1 | 
			n.indexOf(aa) != -1 | n.indexOf(bb) != -1 | n.indexOf(cc) != -1 | n.indexOf(dd) != -1 | n.indexOf(ee) != -1 | n.indexOf(ff) != -1){
			A=1;
		}else{}
<%	}%>
		if(A==1){
			alert("\"\'\<>\`�͓��͂��Ȃ��ł��������B");
			return false;
		}else{	
			return true;
		}
	}	
// -->
</SCRIPT>
<title>�v���W�F�N�g�ǉ�</title>
</head>
<%	request.setCharacterEncoding("Windows-31J");
	C_CheckWord word = new C_CheckWord();
	String project_no_code = request.getParameter("p_code");
	project_no_code = word.checks(project_no_code);
	String basho_no_namae = request.getParameter("basho");
	basho_no_namae = word.checks(basho_no_namae);
	String project_no_namae = request.getParameter("p_name");
	project_no_namae = word.checks(project_no_namae);
	String sql = " where projectcode = '"+ project_no_code + "'";
	CodeDAO kensaku = new CodeDAO();
	if(project_no_code == ""){%>
<center>
<hr width="400"><font color="#8B0000"><big>�v���W�F�N�g�R�[�h����͂��Ă�������</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="�ē���">
</center>
<%	}else if( project_no_namae == ""){%>
<center>
<hr width="400"><font color="#8B0000"><big>�v���W�F�N�g������͂��Ă�������</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="�ē���">
</center>
<%	}else if( kensaku.isThereTbl(sql) ){%>
<center>
<hr width="400"><font color="#8B0000"><big>�v���W�F�N�g�R�[�h���d�����Ă��܂�</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="�ē���" >
</center>
<%	}else{%>
<body>
<center>
<font class="title">�v���W�F�N�g�}�X�^�����e�i���X</font><br><hr color = "#008080">
<table>
<tr><td align="left"><small>1.�K�v�ȍ��ڂ��L����u�ǉ��v�{�^���������Ă��������B</small></td></tr>
<tr><td align="left"><small>�E���l���͕K�v�ɉ����č폜�E�ύX���s���Ă��������B</small></td></tr>
<tr><td align="left"><small>�E���l���̂Ɣ��l�R�[�h��������΂��̗��̓f�[�^�x�[�X�ɔ��f����܂���B</small></td></tr>
<tr><td align="left"><small>�E�J�n�E�I�����Ԃ�24���Ԉȏ��60���ȏ�A���p�����ł͂Ȃ��ꍇ�͐������L�q����܂���B</small></td></tr>
<tr><td align="left"><small>�E<%= project_no_namae %>�̊J�n�E�I�����Ԃ�0900(9��)��1830(18��30��)�̗l�ɁA�x�e���Ԃ�60(60��)�̗l�ɋL�ڂ��Ă��������B</small></td></tr>
<tr><td align="left"><small>�E�x�݂Ȃǎ��Ԃ��L������K�v���Ȃ��ꍇ�́A���Ԙg���󗓂ɂ��Ă��������B</small></td></tr>
</table><hr color = "#008080"><br>
<form method="post" action="c_project_tuika" name="form1" onSubmit="return aboutbox()">
<table BORDER="1"  class="mainte">
<tr>
<TH class="t-koumoku"><font color="white">���l����</font></TH>
<TH class="t-koumoku"><font color="white">���l�R�[�h</font></TH>
<TH class="t-koumoku"><font color="white">�J�n����</font></TH>
<TH class="t-koumoku"><font color="white">�I������</font></TH>
<TH class="t-koumoku"><font color="white">�x�e����</font></TH>
</tr>
<%	ArrayList bikouran = new ArrayList();
	bikouran.add("�N�x");bikouran.add("�{��");bikouran.add("����");bikouran.add("���ʋx��");
	bikouran.add("��x");bikouran.add("�ߑO���x");bikouran.add("�ߌ㔼�x");bikouran.add("�x�o(����)");
	bikouran.add("�x�o(�U�x�L)");bikouran.add("");bikouran.add("");
	ArrayList bikoucode = new ArrayList();
	bikoucode.add("n");bikoucode.add("1");bikoucode.add("k");bikoucode.add("50");bikoucode.add("88");bikoucode.add("90");
	bikoucode.add("93");bikoucode.add("96");bikoucode.add("97");bikoucode.add("");bikoucode.add("");
	ArrayList kaishijikan = new ArrayList();
	kaishijikan.add("");kaishijikan.add("0900");kaishijikan.add("");kaishijikan.add("");kaishijikan.add("");kaishijikan.add("1300");
	kaishijikan.add("0900");kaishijikan.add("0900");kaishijikan.add("0900");kaishijikan.add("");kaishijikan.add("");
	ArrayList shuuryoujikan = new ArrayList();
	shuuryoujikan.add("");shuuryoujikan.add("1730");shuuryoujikan.add("");shuuryoujikan.add("");shuuryoujikan.add("");shuuryoujikan.add("1730");
	shuuryoujikan.add("1200");shuuryoujikan.add("0900");shuuryoujikan.add("1730");shuuryoujikan.add("");shuuryoujikan.add("");
	ArrayList kyuukeijikan = new ArrayList();
	kyuukeijikan.add("");kyuukeijikan.add("60");kyuukeijikan.add("");kyuukeijikan.add("");kyuukeijikan.add("");kyuukeijikan.add("0");
	kyuukeijikan.add("0");kyuukeijikan.add("0");kyuukeijikan.add("60");kyuukeijikan.add("");kyuukeijikan.add("");
	String shorisize = Integer.toString(bikouran.size());
	int size = Integer.parseInt(shorisize);
	for (int s = 0 ; s <= size -1 ; ++s ){
		String ran = (String)bikouran.get(s);
		String code = (String)bikoucode.get(s);
		String kaishi = (String)kaishijikan.get(s);
		String shuuryou = (String)shuuryoujikan.get(s);
		String kyuukei = (String)kyuukeijikan.get(s);%>
<tr>
<td><input type="text" size="20"  name="k_name<%= s %>"value="<%=ran %>"></td>
<td><input type="text" size="15"  name="k_code<%= s %>"value="<%= code %>"style="ime-mode: disabled;"></td>
<td><input type="text" size="15"  name="kaisi_jikan<%= s %>"value="<%= kaishi %>" style="ime-mode: disabled;" maxlength="4"></td>
<td><input type="text" size="15"  name="shuuryou_jikan<%= s %>"value="<%= shuuryou %>" style="ime-mode: disabled;" maxlength="4"></td>
<td><input type="text" size="15"  name="kyuukei_jikan<%= s %>"value="<%= kyuukei %>"style="ime-mode: disabled;" maxlength="3" ></td>
</tr>
<input type="hidden" name="p_name<%= s %>" value="<%=project_no_namae %>">
<input type="hidden" name="p_code<%= s %>" value="<%=project_no_code %>">
<input type="hidden" name="basho<%= s %>" value="<%=basho_no_namae %>">
<%	}%>
</table>
<table>
<tr>
<td>
<input TYPE="submit" VALUE="�@�ǉ��@"   class="bottom">
<input TYPE="hidden"  NAME="p_size" VALUE="1">
</td>
</tr>
</table>
</form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ ���j���[�֖߂� ]</small></font></a>
</center>
</body>
<%	}%>
</html>
<%}%>	