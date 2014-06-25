<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="kkweb.dao.LoginDAO,java.util.HashMap" %>
<html lang = "ja">
<head>
<script type="text/javascript">
/*
 * ページがロードされるとフォームを送信する処理
 */
    window.onload=function(){
    	document.theform.submit();
    };

    /*多分いらない既存のコード */
    window.onunload=function(){
		document.body.style.cursor='auto';
		document.theform.aa.disabled=false;
		document.theform.bb.disabled=false;
	};
	function submit1(){
		document.body.style.cursor='wait';
		document.theform.aa.disabled=true;
		document.theform.bb.disabled=true;
		document.theform.submit();
		}	

	/*//多分いらない既存のコード */
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<!-- <link rel="stylesheet" href="login.css" type="text/css">
 -->
 <title>認証画面</title>
</head>
<body>
<%
LoginDAO ldao = new LoginDAO();
String id = session.getAttribute("login").toString();
HashMap<String,String> info = ldao.loginInfo(id);
System.out.println(info+" (ID_PW_Nyuryoku.jsp)");
%>
<%
/*
送信されたIDを使ってDBから取得した情報と
ゲットパラメータの情報を元にsevletにログイン認証を行っている。
servlet(kkweb.shain.S_Login.java)
*/
%>
<form method="POST" action="/staff_room/jsp/shanai_s/s_login" name="theform">
<input type="hidden" name="action" value="gate">
<input type="hidden"  name="shainID"  value='<%=info.get("id") %>' size="30" maxlength="20" class="text">
<input type="hidden" name="Pwd"  value='<%=info.get("password") %>' size="25" maxlength="20">
<input type="hidden" name="mode" value="<%=request.getParameter("mode") %>" />
</form>
</body>
</html>