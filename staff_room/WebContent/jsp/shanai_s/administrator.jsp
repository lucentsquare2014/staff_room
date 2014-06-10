<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("login") != null){
        String user = String.valueOf(session.getAttribute("login"));
        if (!user.equals("admin")){
            response.sendRedirect("/staff_room/jsp/top/top.jsp");
        }
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang = "ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Language" content="ja">
<script type="text/javascript">
    window.onload=function(){
        document.theform.submit();
    };
</script>
</head>
<body>
<form method="POST" action="c_checkpwsystem" name="theform">
<input type="hidden" name="action" value="gate">
<input type="hidden" name="Pwd"  value='qqqq' size="25">
</form>
</body>
</html>