<%@ page language="java"
    contentType="text/html; charset=Windows-31J" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- code.jsp��jpn2unicode���\�b�h ���������h�~�̕����R�[�h�ϊ����\�b�h --%>

<%@ include file="code.jsp" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="dao.NewsDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.SQLException" %>
<HTML>
<BODY>

				<%

				//���̓t�H�[������n���ꂽ�f�[�^��HashMap�^newsWrite�Ɋi�[

				HashMap<String,String> Newsdata = new HashMap<String,String>();

					Newsdata.put("postID", jpn2unicode(request.getParameter("inputPost"), "Windows-31J"));
					Newsdata.put("title", jpn2unicode(request.getParameter("inputTitle"), "Windows-31J"));
					Newsdata.put("text", jpn2unicode(request.getParameter("inputText"), "Windows-31J"));

				/*�Y�t�t�@�C�� ��������ۗ�
					Newsdata.put("file", jpn2unicode(request.getParameter("inputFile"), "Windows-31J")); */

					Newsdata.put("writer", jpn2unicode(request.getParameter("inputWriter"), "Windows-31J"));

				//  ���Ԃ��擾���č쐬���Ƃ��Ċi�[

				Date date = new Date();

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");

					Newsdata.put("created", sdf.format(date));

					// DAO���烁�\�b�h�̌Ăяo��
					NewsDAO dao = new NewsDAO();

							//�f�[�^�x�[�X��hashMap���珑������
							dao.writeNews(Newsdata);

					%>


				<%
				if (Newsdata.containsKey("postID")){
					%>
					 <%= Newsdata.get("postID") %>
					 <%= Newsdata.get("title") %>
					 <%= Newsdata.get("text") %>
					 <%= Newsdata.get("file") %>
					 <%= Newsdata.get("writer") %>
					 <%= Newsdata.get("created") %>
				<%
				}else{
				%>
					  �w�肵���L�[�͑��݂��܂���
				 <%
				 	}
				 %>


</BODY>
</HTML>