<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.*" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
		if(strVal==null){
			return (null);
		}
		else{
			return (new String(strVal.getBytes("8859_1"),"UTF-8"));
		}
}
%>
<%
/* 修正点 */
// 02-08-13 新規スケジュール登録・スケジュール変更・バナースケジュール変更とフラグにより切り替える
// 02-09-04 パラメ−タの追加

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));
String GR = request.getParameter("group");

// 表示の種類を判別するパラメータ
String KD = strEncode(request.getParameter("kind"));

// Calender インスタンスを生成
Calendar now = Calendar.getInstance();

// 現在の時刻を取得
Date dat = now.getTime();

// 表示形式を設定
SimpleDateFormat sFmt = new SimpleDateFormat("yyyy-MM-dd");

%>
<HTML>
<HEAD><TITLE>スケジュール管理</TITLE></HEAD>
<FRAMESET COLS="75%,25%" FRAMEBORDER="0">
	<FRAME SRC="tryagain.jsp?id=<%= ID %>&s_date=<%= sFmt.format(dat) %>&group=<%= GR %>" NAME="main" noresize>
	<FRAME SRC="timeIn.jsp?id=<%= ID %>&no=<%= ID %>&s_date=<%= sFmt.format(dat) %>&s_start=&b_start=&group=<%= GR %>&kind=<%= KD %>&act=" NAME="sub02" scrolling="no" noresize>
</FRAMESET>
</HTML>
