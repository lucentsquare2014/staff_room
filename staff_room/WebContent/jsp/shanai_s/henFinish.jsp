<%@ page contentType = "text/html; charset=UTF-8" import="java.sql.*,java.io.*,java.util.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"JISAutoDetect"));
		}
}
%>
<%
// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));
%>
<HTML>
<HEAD>
<TITLE>変更完了画面</TITLE>
<STYLE TYPE="text/css">
.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}
</style>
</HEAD>
<BODY BGCOLOR="#99A5FF">
<CENTER>
<FONT COLOR="#ffffff">
<SPAN CLASS="shadow">
<H1>変更しました。</H1>
</FONT>
</SPAN>
<FORM ACTION="menu.jsp" METHOD="Post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
<INPUT TYPE="submit" VALUE="メインメニューへ戻る">
</FORM>
</CENTER>
</BODY>
</HTML>