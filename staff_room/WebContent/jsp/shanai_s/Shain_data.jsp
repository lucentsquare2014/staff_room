<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %><%@ page import = "kkweb.dao.NenkyuDAO" %><%@ page import = "kkweb.beans.B_NenkyuMST" %>
<jsp:useBean id="Shain" scope="session" class="kkweb.beans.B_ShainMentenanceMST"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/");
		}else{	%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
<!--
	function form_submitA(){
		//adrs ="http://www1.lucentsquare.co.jp/kintaikanri/Group_ichiran.jsp"
		//adrs ="//www.lucentsquare.co.jp:8080/kk_web/Group_ichiran.jsp"
		adrs="/staff_room/jsp/shanai_s/Group_ichiran.jsp";
		LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500');
		LinkWin.location.href=adrs;
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
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{}
		if(window.confirm("退職者に変更してよろしいですか")){
			return true;
		}else{
			window.alert("キャンセルされました");
			return false;
		}
	}
	function aboutbox() {				
		var p = document.form1.f_name.value;
	   	var n = document.form1.g_name.value;
	   	// フリガナを追加
	   	
        var a = document.form1.hurigana.value;
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
            a.indexOf(aa) != -1 | a.indexOf(bb) != -1 | a.indexOf(cc) != -1 | a.indexOf(dd) != -1 | a.indexOf(ee) != -1 | a.indexOf(ff) != -1 |
			t.indexOf(aa) != -1 | t.indexOf(bb) != -1 | t.indexOf(cc) != -1 | t.indexOf(dd) != -1 | t.indexOf(ee) != -1 | t.indexOf(ff) != -1){
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		}else{		
            if(!a.match(/^[ァ-ロワヲンー 　\r\n\t]*$/)){
                alert("フリガナに入力できるのは全角カナとスペースだけです。");
                return false;
            }
			return true;
		}
	}	
-->
</script>
<title><%= Shain.getF_name()+"　"+Shain.getG_name() %>データ修正</title>
</head>
<body>
<center>
<font class="title"><%= Shain.getF_name()+"　"+Shain.getG_name() %></font><br><hr color = "#008080">
<table>
<tr><td align="left"><small>1.被承認者に変更する場合は承認者チェック欄を"0"にしてください。</small></td></tr>
<tr><td align="left"><small>2.承認者に変更する場合は承認者チェック欄を"1"にしてください。</small></td></tr>
<tr><td align="left"><small>3.所属番号は<a  onClick="form_submitA()" style="cursor: pointer;"><font color="blue">グループ一覧</font></a>より確認してください。</small></td></tr>
<tr><td align="left"><small><font color="red" >4.「退職者に変更」ボタンを押した場合はシステム管理での復元が出来ません。</font></small></td></tr>
</table><hr color = "#008080"><br>
<FORM method="post" action="c_shain_update" name="form1" onSubmit="return aboutbox()">
<TABLE BORDER="1"  class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">姓</font></TH>
<TH class="t-koumoku"><font color="white">名</font></TH>
<TH class="t-koumoku"><font color="white">フリガナ</font></TH>
<TH class="t-koumoku"><font color="white">ID</font></TH>
<TH class="t-koumoku"><font color="white">社員番号</font></TH>
<TH class="t-koumoku"><font color="white">所属番号</font></TH>
<TH class="t-koumoku"><font color="white">承認者チェック</font></TH>
<TH class="t-koumoku"><font color="white">承認者表示順序</font></TH>
<TH class="t-koumoku"><font color="white">役職</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="5" NAME="f_name" VALUE="<%= Shain.getF_name() %>"></TD>
<TD><INPUT TYPE="text" SIZE="5" NAME="g_name" VALUE="<%= Shain.getG_name() %>"></TD>
<TD><INPUT TYPE="text" SIZE="15" NAME="hurigana" VALUE="<%= Shain.getHurigana() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="id" VALUE="<%= Shain.getId() %>" readonly="readonly"  style="background-color:#bfbfbf;"></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="number" VALUE="<%= Shain.getNumber() %>" readonly="readonly"  style="background-color:#bfbfbf;"></TD>
<TD><INPUT TYPE="text" SIZE="11" NAME="groupnumber" VALUE="<%= Shain.getGROUPnumber() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="20" NAME="checked" VALUE="<%= Shain.getChecked() %>" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="18" NAME="hyouzijun" VALUE="<%= Shain.getHyouzijun() %>" ></TD>
<TD><INPUT TYPE="text" SIZE="5" NAME="yakusyoku" VALUE="<%= Shain.getYakusyoku() %>" ></TD>
</TR>
<tr><TH class="t-koumoku" colspan="8"><font color="white">メールアドレス</font></TH></tr>
<tr><TD colspan="8"><INPUT TYPE="text" SIZE="112"  NAME="mail"  value="<%= Shain.getMail() %>" style="ime-mode: disabled;"></TD></tr>
</TABLE><br>
<TABLE BORDER="1"  class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">今年度年休日数</font></TH>
<TH class="t-koumoku"><font color="white">残り年休日数</font></TH>
<TH class="t-koumoku"><font color="white">今年度年休使用日数</font></TH>
<TH class="t-koumoku"><font color="white">前年からの繰越し日数</font></TH>
<TH class="t-koumoku"><font color="white">今年度の付与日数</font></TH>
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
<INPUT TYPE="submit" VALUE="　更新　"  class="bottom" >
</FORM><br>
<form action="c_shain_delete" method="post" onSubmit="return check()">
<input type="submit" VALUE="退職者に変更"  class="bottom" >
</form><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>