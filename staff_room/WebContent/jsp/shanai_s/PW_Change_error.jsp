<%@ page language="java" contentType="text/html; charset=shift_JIS"pageEncoding="shift_JIS"%>
<jsp:useBean id="errmsg" scope="session" class="kkweb.beans.B_Errmsg"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
/// 2013/07/12 �V�� �ǉ�
/// �ړI : �p�X���[�h�ύX�G���[�p�ɐV�K�쐬
/// TODO : �R�[�f�B���O�X�^�C�������E���Ă���̂ŃG���[�y�[�W�̋��L������������K�v����
if(errmsg == null || errmsg.getErrmsg() == null){
	pageContext.forward("/ID_PW_Nyuryoku.jsp");
}else{%>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<link rel="stylesheet" href="message.css" type="text/css">
<title>�G���[</title>
</head>
<body>
<center>
<div class="location"><div class="location2"><font class="error"><%= errmsg.getErrmsg() %></font>
<%	session.removeAttribute("errmsg");%><br><br>
<button onClick="history.back()">�ē���</button></div></div>
</center>
</body>
</html>
<%}%>