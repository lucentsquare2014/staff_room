<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%-- code.jsp＝jpn2unicodeメソッド 文字化け防止の文字コード変換メソッド --%>

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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<BODY>

				<%

				//入力フォームから渡されたデータをHashMap型newsWriteに格納

				HashMap<String,String> Newsdata = new HashMap<String,String>();

					Newsdata.put("postID", jpn2unicode(request.getParameter("inputPost"), "Windows-31J"));
					Newsdata.put("title", jpn2unicode(request.getParameter("inputTitle"), "Windows-31J"));
					Newsdata.put("text", jpn2unicode(request.getParameter("inputText"), "Windows-31J"));

				/*添付ファイル いったん保留
					Newsdata.put("file", jpn2unicode(request.getParameter("inputFile"), "Windows-31J")); */

					Newsdata.put("writer", jpn2unicode(request.getParameter("inputWriter"), "Windows-31J"));

				//  時間を取得して作成日として格納

				Date date = new Date();

					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  hh:mm");

					Newsdata.put("created", sdf.format(date));

					// DAOからメソッドの呼び出し
					NewsDAO dao = new NewsDAO();

							//データベースにhashMapから書き込み
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
					  指定したキーは存在しません
				 <%
				 	}
				 %>


</BODY>
</HTML>