<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
<%
	String filePassword = "qqqq";	
	String inpPassword = request.getParameter("pass");

	if(filePassword.equals(inpPassword)){
%>
	<jsp:forward page="kanri_admin.jsp">
	<jsp:param name="pass" value="<%= inpPassword %>" />
	</jsp:forward>
<%
	}else{
%>
	<jsp:forward page="kanri_error.jsp">
	<jsp:param name="error" value="1" />
	</jsp:forward>
<%
	}
%>