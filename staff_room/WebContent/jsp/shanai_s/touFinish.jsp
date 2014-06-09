<%@ page contentType = "text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*" %>
<%!
// •¶ŽšƒGƒ“ƒR[ƒh‚ðs‚¢‚Ü‚·B
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal == null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"Shift_JIS"));
		}
}
%>
<%
// ƒƒOƒCƒ“‚µ‚½ƒ†[ƒU‚ÌŽÐˆõ”Ô†‚ð•Ï”[ID]‚ÉŠi”[
String ID = strEncode(request.getParameter("id"));
%>
<HTML>
<HEAD>
<TITLE>“o˜^Š®—¹‰æ–Ê</TITLE>
<STYLE TYPE="text/css">

.shadow{filter:shadow(color=black,direction=135);position:relative;height:50;width:100%;}

</STYLE>
</HEAD>
<BODY BGCOLOR="#8291FF" BACKGROUND="GEORGE/bg.bmp" BACKGROUND-REPEAT:REPEAT-X>
<CENTER>
<FONT COLOR="#ffffff">
<SPAN CLASS="shadow">
<H1>“o˜^‚µ‚Ü‚µ‚½</H1><br>
</FONT>
</SPAN>
<FORM ACTION="menu.jsp" METHOD="Post">
<INPUT TYPE="hidden" NAME="id" VALUE="<%= ID %>">
<INPUT TYPE="submit" VALUE="ƒƒCƒ“ƒƒjƒ…[‚Ö–ß‚é">
</FORM>
</CENTER>
</BODY>
</HTML>