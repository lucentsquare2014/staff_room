<%@ page language="java" contentType="text/html; charset=shift_JIS" pageEncoding="shift_JIS"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/Pw_Nyuryoku_system.jsp");
		}else{%> --%>
<%
/// 2013/07/12 �V�� �ǉ�
/// �ړI:�p�X���[�h�ύX�������̂ݕ\���ł���悤�ɂ��邽��
String changedpw = (String)session.getAttribute("changedpw");
if( changedpw == null || changedpw.equals("false")
  ){
	pageContext.forward("/ID_PW_Nyuryoku.jsp");
}else{
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="message.css" type="text/css">
<title>�p�X���[�h�ύX����</title>
</head>
<body>
<center><div class="location">
<center><div class="location2">
<font class="msg">�p�X���[�h������ɕύX����܂����B</font><br><br>
<a href="ID_PW_Nyuryoku.jsp" class="link"><font class="link">[ ID�E�p�X���[�h���֖͂߂� ]</font></a>
</div></center></div></center>
</body>
</html>
<%
session.removeAttribute("changedpw");
}%>
