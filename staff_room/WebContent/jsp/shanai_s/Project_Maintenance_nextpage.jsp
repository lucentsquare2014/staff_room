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
			if(window.confirm("プロジェクトを削除してしてよろしいですか")){
				return true;
			}else{
			window.alert("キャンセルされました");
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
			alert("\"\'\<>\`は入力しないでください。");
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
		<%-- 20111101 河村追加　休憩の入力チェック --%>
		<% if(i == 0 || (i > 2 && i < 7)){ %>
		var kyukei<%=i%> = document.form1.pro_kyuukei<%=i%>.value;
		if(kyukei<%=i%> == ""){
			window.alert("休憩時間に数値を入力してください。");
			return false;
		}
		<% } %>		
<%	}%>
		if(A==1){
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{
			return true;
		}
	}	
-->
</script>
<title>プロジェクト閲覧・更新・削除</title>
</head>
<body>
<center>
<font class="title">プロジェクトマスタメンテナンス</font><br>
<hr color = "#008080">
<table>
<tr><td align="left"><small>1.閲覧のみの場合は変更せずに「更新」ボタンを押してください。</small></td></tr>
<tr><td align="left"><small>2.更新する場合はプロジェクト名を消去せずに変更して「更新」ボタンを押してください。</small></td></tr>
<tr><td align="left"><small>・開始・終了時間が24時間以上や60分以上、半角数字ではない場合は正しく記述されません。</small></td></tr>
<tr><td align="left"><small>・開始・終了時間は0900(9時)や1830(18時30分)の様に、休憩時間は60(60分)の様に記載してください。</small></td></tr>
<tr><td align="left"><small>・休みなど時間を記入する必要がない場合は時間枠を空欄にしてください。</small></td></tr>
<tr><td align="left"><small>3.削除する場合はプロジェクト名を消去して「更新」ボタンを押してください。</small></td></tr>
<tr><td align="left"><small><font color="red" >・一度削除したプロジェクトはシステム管理での復元が出来ません。</font></small></td></tr>
</table><hr color = "#008080"><br>
<%	B_Code bcode = new B_Code();
	bcode = (B_Code)projectlist.get(0);%>
<FORM method="post" action="c_project_kousin" onSubmit="return check()" name="form1">
<TABLE BORDER="1"  class="mainte">
<TR><TH colspan="7" >プロジェクト名称：<INPUT  TYPE="text" SIZE="30"  NAME="pro_name" VALUE="<%=bcode.getPROJECTname() %>" ></TH></TR>
<TR><TD colspan="7"  align="center">プロジェクトコード：<%=onamae %></TD></TR>
<TR>
<TH class="t-koumoku"><font color="white">勤務種</font></TH>
<TH class="t-koumoku"><font color="white">開始時間</font></TH>
<TH class="t-koumoku"><font color="white">終了時間</font></TH>
<TH class="t-koumoku"><font color="white">休憩時間</font></TH>
<TH class="t-koumoku"><font color="white">場所</font></TH>
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
<INPUT TYPE="submit" VALUE="　更新　"   class="bottom" >
<INPUT TYPE="hidden"  NAME="pro_code" VALUE="<%=onamae %>" >
<INPUT TYPE="hidden"  NAME="p_size" VALUE="<%= size %>">
</TD>
</TR>
</table></form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>	