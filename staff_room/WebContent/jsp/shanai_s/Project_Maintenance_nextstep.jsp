<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %><%@ page import="kkweb.maintenance.*" %><%@ page import="kkweb.common.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){		
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; Charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
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
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{	
			return true;
		}
	}	
// -->
</SCRIPT>
<title>プロジェクト追加</title>
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
<hr width="400"><font color="#8B0000"><big>プロジェクトコードを入力してください</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="再入力">
</center>
<%	}else if( project_no_namae == ""){%>
<center>
<hr width="400"><font color="#8B0000"><big>プロジェクト名を入力してください</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="再入力">
</center>
<%	}else if( kensaku.isThereTbl(sql) ){%>
<center>
<hr width="400"><font color="#8B0000"><big>プロジェクトコードが重複しています</big></font><hr width="400"><br>
<INPUT type="button" onClick='history.back();return false;' value="再入力" >
</center>
<%	}else{%>
<body>
<center>
<font class="title">プロジェクトマスタメンテナンス</font><br><hr color = "#008080">
<table>
<tr><td align="left"><small>1.必要な項目を記入後「追加」ボタンを押してください。</small></td></tr>
<tr><td align="left"><small>・備考欄は必要に応じて削除・変更を行ってください。</small></td></tr>
<tr><td align="left"><small>・備考名称と備考コードが無ければその欄はデータベースに反映されません。</small></td></tr>
<tr><td align="left"><small>・開始・終了時間が24時間以上や60分以上、半角数字ではない場合は正しく記述されません。</small></td></tr>
<tr><td align="left"><small>・<%= project_no_namae %>の開始・終了時間は0900(9時)や1830(18時30分)の様に、休憩時間は60(60分)の様に記載してください。</small></td></tr>
<tr><td align="left"><small>・休みなど時間を記入する必要がない場合は、時間枠を空欄にしてください。</small></td></tr>
</table><hr color = "#008080"><br>
<form method="post" action="c_project_tuika" name="form1" onSubmit="return aboutbox()">
<table BORDER="1"  class="mainte">
<tr>
<TH class="t-koumoku"><font color="white">備考名称</font></TH>
<TH class="t-koumoku"><font color="white">備考コード</font></TH>
<TH class="t-koumoku"><font color="white">開始時間</font></TH>
<TH class="t-koumoku"><font color="white">終了時間</font></TH>
<TH class="t-koumoku"><font color="white">休憩時間</font></TH>
</tr>
<%	ArrayList bikouran = new ArrayList();
	bikouran.add("年休");bikouran.add("本社");bikouran.add("欠勤");bikouran.add("特別休暇");
	bikouran.add("代休");bikouran.add("午前半休");bikouran.add("午後半休");bikouran.add("休出(超過)");
	bikouran.add("休出(振休有)");bikouran.add("");bikouran.add("");
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
<input TYPE="submit" VALUE="　追加　"   class="bottom">
<input TYPE="hidden"  NAME="p_size" VALUE="1">
</td>
</tr>
</table>
</form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
<%	}%>
</html>
<%}%>	