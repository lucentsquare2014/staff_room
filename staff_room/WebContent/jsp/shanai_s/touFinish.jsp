<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal == null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("UTF-8"),"UTF-8"));
		}
}
%>
<%
// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));
%>
<HTML>
<HEAD>
<TITLE>登録完了画面</TITLE>
<STYLE TYPE="text/css">

.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}

</STYLE>
</HEAD>
<BODY BGCOLOR="#8291FF" BACKGROUND="GEORGE/bg.bmp" BACKGROUND-REPEAT:REPEAT-X>
<CENTER>
<FONT COLOR="#ffffff">
<SPAN CLASS="shadow">
<H1>登録しました</H1><br>
</FONT>
</SPAN>
<FORM ACTION="menu.jsp" METHOD="Post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
<INPUT TYPE="submit" VALUE="メインメニューへ戻る">
</FORM>
</CENTER>
</BODY>
</HTML>