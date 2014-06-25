<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.Enumeration" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<p><%= request.getRemoteAddr() %></p>
<p><%= request.getRemoteHost() %></p>
<p><%= request.getRemotePort() %></p>
<p><%= request.getRemoteUser() %></p>
<%
Enumeration<String> headernames = ((HttpServletRequest) request).getHeaderNames();
while (headernames.hasMoreElements()){
  String name = (String)headernames.nextElement();
  Enumeration<String> headervals = ((HttpServletRequest) request).getHeaders(name);
  while (headervals.hasMoreElements()){
    String val = (String)headervals.nextElement();
    out.print("<p>" + name + ":" + val + "</p>");
   
  }
}
%>
<p><%= request.getHeader("X-FORWARDED-FOR") %></p>
</body>
</html>