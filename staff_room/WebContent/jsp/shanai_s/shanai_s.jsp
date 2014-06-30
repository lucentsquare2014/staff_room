<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String value = null;
	value = request.getParameter("mode");
	String uri = request.getRequestURL().toString();
	uri = uri.substring(0, uri.lastIndexOf("/"));
	System.out.println(uri + "   (shanai_s.jsp)");
	System.out.println();
	if (value == null) {
		value = "1";
	}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html"></jsp:include>
<title>社内システム</title>
<style>
body {
    width: 100%;
    height: 100%;
    background-attachment: fixed;
    background-size: 100% 100%;
    background-color: #fff;
}
.content{
    padding: 0; 
    padding-top: 42px; 
    height: 600px;
    width: 100%;
    margin-left:auto;
    margin-right:auto;
    background-color:white;
}
</style>
<script type="text/javascript">
function framesize(){
    var w = $(window).height();
    $('iframe').css("height", w-42);
}
$(function(){
	framesize();
});
$(window).resize(function(){
	framesize();
});

</script>
</head>
<body>
    <jsp:include page="/jsp/header/header.jsp" />
    <div class="content">
        <%
        /*
        * 渡されたゲットパラメータをID_PW_Nyuryoku.jspに渡して表示している。
        * 管理者の場合はadministrator.jspを表示している。
        */
        if(value.equals("4")){ %>
            <iframe width="100%" height="100%" src="<%=uri %>/administrator.jsp"></iframe>
        <%} else { %>
            <iframe width="100%" height="100%" src="<%=uri %>/ID_PW_Nyuryoku.jsp?mode=<%=value%>"></iframe>
        <% } %>
    </div>
</body>
</html>