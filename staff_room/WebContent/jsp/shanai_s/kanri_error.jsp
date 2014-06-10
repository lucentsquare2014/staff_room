<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
<%!
// 文字エンコードを行います。
	public String strEncode(String strVal) throws UnsupportedEncodingException{
			if(strVal==null){
				return (null);
			}
			else{
				return (new String(strVal.getBytes("UTF-8"),"UTF-8"));
			}
	}
%>
<%
	String Msg_error = "";
	String Cd_error = request.getParameter("error");
	int num_error = Integer.parseInt(Cd_error);
	
	switch(num_error){
	case 1:
		Msg_error = "パスワードが違います";
		break;
	case 2:
		Msg_error = "入力もれがあります";
		break;
	case 3:
		Msg_error = "この社員番号は既に登録されています";
		break;
	case 4:
		Msg_error = "この氏名は既に登録されています";
		break;
	case 5:
		Msg_error = "このＩＤは既に登録されています";
		break;
	case 6:
		Msg_error = "このパスワードは既に登録されています";
		break;
	case 7:
		Msg_error = "ＩＤが入力されていません";
		break;
	case 8:
		Msg_error = "パスワードが入力されていません";
		break;
	case 9:
		Msg_error = "メールアドレスが入力されていません";
		break;
	case 10:
		Msg_error = "氏名が入力されていません";
		break;
	case 11:
		Msg_error = "このグループコードは既に登録されています";
		break;
	case 12:
		Msg_error = "このグループ名は既に登録されています";
		break;
	case 13:
		Msg_error = "グループ名が入力されていません";
		break;
	case 14:
		Msg_error = "グループコードが入力されていません";
		break;
	default:
		Msg_error = "予期せぬエラーが発生しました。管理者に報告してください";
		break;	
	}
%>
	<html>
		<HEAD>
			<META HTTP-EQUIV=Content-Type CONTENT=text/html;Charset=UTF-8>
			<TITLE></TITLE>
		</HEAD>
		<BODY bgcolor=#F5F5F5 text=#000000 link=#008080 alink=#00CCCC vlink=#008080>
			<CENTER>
				<HR WIDTH=400><H3>ERROR !</H3>
				<P><FONT color=#AA0000><%= Msg_error %></FONT>
				<P><HR WIDTH=400>
			</CENTER>
		</body>
	</html>