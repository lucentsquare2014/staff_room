<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="login.css" type="text/css">
<title>認証画面（システム管理）</title>
</head>
<body>
<center><div class="box3"></div><div class="box1">
<form method="POST" action="c_checkpwsystem" name="theform">
<input type="hidden" name="action" value="gate">
<b><font class="title">パスワードを入力してください</font></b><hr color = "#008080">
<table>
<tr><td align="left"><small>1.必要事項を入力し、OKを押してください。</small></td></tr>
<tr><td align="left"><small>2.全角カナは使用しないでください。</small></td></tr>
</table><hr color = "#008080"><br>
<div class="box2" style="padding-bottom:0px;">
<table border="5" bordercolor="#008080" cellpadding="0" cellspacing="5" width="280px">
<tr>
<td align="center">ﾊﾟｽﾜｰﾄﾞ</td>
<td align="left"><input type="password" name="Pwd"  value='' size="25"></td>
</tr>
</table>
<table>
<tr>
<td><input type="submit"  value="ＯＫ" class ="button"></td>
<td><input type="reset"  value="CLEAR" class ="button"></td>
</tr>
</table></div>
</form><br>
<a href="http://www.lucentsquare.co.jp/staff/staff_main.html" class="link"><font class="link"><small>[ スタッフルームへ戻る ]</small></font></a></div>
</center>
</body>
</html>