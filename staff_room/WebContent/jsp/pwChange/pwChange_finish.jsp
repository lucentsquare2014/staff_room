<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="dao.ShainDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<html class="uk-height-1-1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/html/head.html" />
<style type="text/css">
	body {
		background-image: url("/staff_room/images/input.png");
	}
</style>
<head>
<title>パスワード変更完了</title>
</head>
<body>
	<jsp:include page="/jsp/header/header.jsp" />
	<div class="uk-height-1-1 uk-vertical-align uk-text-center">

	<%
		String pwd = DigestUtils.sha1Hex(request.getParameter("now_pw1"));
		String id = session.getAttribute("login").toString();
		ShainDB shain = new ShainDB();
	Connection con = shain.openShainDB();
	String sql = "SELECT * FROM shainmst WHERE id = ? AND pw = ?";
	try {
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
	    pstmt.setString(2, pwd);
	    ResultSet rs = pstmt.executeQuery();
	    if(!rs.next()){
	    	String msg = "現在のパスワードが間違っています。もう一度入力してください。";
	    	request.setAttribute("error",msg);
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/pwChange/pwChange.jsp");
	    		dispatcher.forward(request, response);
	    	shain.closeShainDB(con);
	    }else{
	    	String update = "UPDATE shainmst SET "
					+ "pw=?"
					+ " WHERE id=?";
			System.out.println(update);
	// プリペアードステートメントを作成
	// preparedStatementでエスケープ処理
			pstmt = con.prepareStatement(update);
	// ここでsetした値がsql分の？と置き換わる
			pstmt.setString(1, DigestUtils.sha1Hex(request.getParameter("new_pw1")));

			String login_id = session.getAttribute("login").toString();
			pstmt.setString(2,login_id);
	// executeUpdateメソッドで実行。書き込んだフィールドの数を返す。
			pstmt.executeUpdate();
			shain.closeShainDB(con);
	    }
	} catch (SQLException e) {
		e.printStackTrace();
	}


	%>
	<div style="position:relative; top:250px;">
		<div class="uk-width-medium-1-2 uk-container-center uk-vertical-align-middle">
			<div class="uk-panel uk-panel-box uk-text-center">
				<h1 class="uk-text-success"><i class="uk-icon-smile-o"></i>パスワードの変更が完了しました。</h1>
				<br>
				<a href="/staff_room/jsp/top/top.jsp" class="uk-button uk-button-success uk-button-large">TOPに戻る</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>