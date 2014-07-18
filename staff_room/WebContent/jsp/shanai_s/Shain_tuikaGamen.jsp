<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="kintaikanri.css" type="text/css"><link rel="stylesheet" href="report.css" type="text/css">
<script type="text/javascript">
<!--
	function form_submitA(){
	//adrs ="http://www1.lucentsquare.co.jp/kintaikanri/Group_ichiran.jsp"
	//移行後は以下を使用
	adrs ="/staff_room/jsp/shanai_s/Group_ichiran.jsp"
	LinkWin=window.open("","NewPage",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=400,height=500')
	LinkWin.location.href=adrs
	}
	function aboutbox() {	
		var p = document.form1.f_name.value;
	   	var n = document.form1.g_name.value;
	   	var a = document.form1.hurigana.value;
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
            a.indexOf(aa) != -1 | a.indexOf(bb) != -1 | a.indexOf(cc) != -1 | a.indexOf(dd) != -1 | a.indexOf(ee) != -1 | a.indexOf(ff) != -1 |
			y.indexOf(aa) != -1 | y.indexOf(bb) != -1 | y.indexOf(cc) != -1 | y.indexOf(dd) != -1 | y.indexOf(ee) != -1 | y.indexOf(ff) != -1){
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
<title>社員追加</title>
</head>
<body>
<center>
<font class="title">社員追加</font><br><hr color ="#008080">
<table>
<tr><td align="left"><small>1.名前とフリガナ以外の項目は全て半角英数字で入力してください。</small></td></tr>
<tr><td align="left"><small>2.フリガナは姓名をスペースで区切って入力してください。。</small></td></tr>
<tr><td align="left"><small>3.承認者である場合は承認者チェック欄に"1"を入力してください。</small></td></tr>
<tr><td align="left"><small>4.被承認者である場合は承認者チェック欄に"0"を入力してください。</small></td></tr>
<tr><td align="left"><small>5.所属番号は<a  onClick="form_submitA()" style="cursor: pointer;"><font class="link">グループ一覧</font></a>より確認してください。</small></td></tr>
</table><hr color ="#008080"><br>
<FORM method="post" action="c_shain_tuika" name="form1" onSubmit="return aboutbox()" >
<TABLE BORDER="1" class="mainte">
<TR>
<TH class="t-koumoku"><font color="white">姓</font></TH>
<TH class="t-koumoku"><font color="white">名</font></TH>
<TH class="t-koumoku"><font color="white">フリガナ</font></TH>
<TH class="t-koumoku"><font color="white">ID</font></TH>
<TH class="t-koumoku"><font color="white">パスワード</font></TH>
<TH class="t-koumoku"><font color="white">社員番号</font></TH>
<TH class="t-koumoku"><font color="white">グループ番号</font></TH>
<TH class="t-koumoku"><font color="white">承認者チェック</font></TH>
<TH class="t-koumoku"><font color="white">承認者表示順序</font></TH>
<TH class="t-koumoku"><font color="white">役職</font></TH>
</TR>
<TR>
<TD><INPUT TYPE="text" SIZE="7"  NAME="f_name" ></TD>
<TD><INPUT TYPE="text" SIZE="7"  NAME="g_name" ></TD>
<TD><INPUT TYPE="text" SIZE="15"  NAME="hurigana" ></TD>
<TD><INPUT TYPE="text" SIZE="10" NAME="id" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="13" NAME="pw" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="11"  NAME="number" style="ime-mode: disabled;"></TD>
<TD><INPUT TYPE="text" SIZE="17"  NAME="groupnumber" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="20"  NAME="checked" style="ime-mode: disabled;" ></TD>
<TD><INPUT TYPE="text" SIZE="18"  NAME="hyouzijun" ></TD>
<TD><INPUT TYPE="text" SIZE="5"  NAME="yakusyoku" ></TD>
</TR>
<tr><TH class="t-koumoku" colspan="8"><font color="white">メールアドレス</font></TH>
<TH class="t-koumoku" colspan="2"><font color="white">管理者権限</font></TH></tr>
<tr>
<TD colspan="8"><INPUT TYPE="text" SIZE="85"  NAME="mail" style="ime-mode: disabled;">@lucentsquare.co.jp</TD>
<TD colspan="2" align="center">
<select name="administrator">
<option value="0" selected>一般アカウント</option>
<option value="1">管理者</option>
</select>
</TD>
</tr>
</TABLE><br>
<TABLE>
<TR><TD><INPUT TYPE="submit" VALUE="　追加　" class="bottom" ></TD></TR>
</TABLE>
</FORM><br>
<a href="SystemKanri_MenuGamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>