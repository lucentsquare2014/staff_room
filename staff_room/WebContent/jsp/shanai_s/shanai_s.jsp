<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html"></jsp:include>
<title>社内システム</title>
<style>
body {
    width: 100%;
    height: 610px;
    background-attachment: fixed;
    background-color:white;
    background-size: 100% 100%;
    overflow: hidden;
}
.conetent{
    padding: 0; 
    padding-top: 42px; 
    height: 100%; 
    width: 100%;
    margin-left:auto;
    margin-right:auto;
    background-color:white;
}
</style>
</head>
<body>
    <jsp:include page="/jsp/header/header.jsp" />
    <div class="conetent">
        <%
        String value = null;
        value = request.getParameter("mode");
        if(value==null){
        	value="1";
        }
        %>
        <%if(value.equals("5")){ %>
            <iframe width="100%" height="100%" src="./doc/manual01.pdf"></iframe>
        <%} %>
        <%if(value.equals("4")){ %>
            <iframe width="100%" height="100%" src="./administrator.jsp"></iframe>
        <%} else { %>
            <iframe width="100%" height="100%" src="./ID_PW_Nyuryoku.jsp?mode=<%=value%>"></iframe>
        <% } %>
    </div>
</body>
</html>