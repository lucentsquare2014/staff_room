<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.beans.*,java.util.*"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<String> true_user = new ArrayList<String>();
	true_user.add(application.getInitParameter("sender")); // 特定ユーザのみ表示
	true_user.add("21301"); // テストユーザ
	String id2 = (String) session.getAttribute("key");
	String from = (String) session.getAttribute("pagefrom");
	if ((id2 != null ? id2.equals("鍵") : false)
			&& true_user.contains(ShainMST.getNumber())) {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<link rel="stylesheet" href="css/mailnyuryoku.css" type="text/css">
<script type="text/javascript">
window.onunload = function() {
};
history.forward();
function submit1() {
  document.body.style.cursor = 'wait';
  document.a.aa.disabled = true;
  document.a.submit();
 }
function confirmBox(n){ 
	if(n > 0){ // 送信済みが含まれる
		var name=confirm("送信済みが"+n+"件含まれています。\n送信処理を続けますか？");
		if (name==true) {
			submit1();
		}
	}else{
		var name=confirm("メールを送信します。よろしいですか？");
		if (name==true) {
			submit1();
		}
	}
} 
</script>
<title>メール作成画面</title>
<%
	SendList sendlist = (SendList) session.getAttribute("SendList");
	request.setCharacterEncoding("UTF-8");
	String flag = request.getParameter("pagefrom");
	// ユーザーリストを取り出す
	ArrayList<ShainInfo> users = sendlist.getUsers();
	// 社員番号リストを作成
	ArrayList<String> numberList = new ArrayList<String>();
	// 最新月を登録してからメールを送信したかのログ
	ArrayList<String> sendlog = sendlist.getSendlog();
	for (ShainInfo s : users)
		numberList.add(s.getNumber());
	//form　から送られたネームリスト
	Enumeration<String> names = request.getParameterNames();
	if (flag.equals("sendselect")) {
		ArrayList<ShainInfo> usersmst = new ArrayList<ShainInfo>(users);
		ArrayList<String> sendlogmst = new ArrayList<String>(sendlog);
		users.clear();
		sendlog.clear();
		
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			// 選ばれた社員番号ならば
			if (numberList.contains(name)) {
				//System.out.println(name);
				users.add(usersmst.get(numberList.indexOf(name)));
				sendlog.add(sendlogmst.get(numberList.indexOf(name)));
			}
			/*//
			else {
				System.out.println(name + ":"
						+ request.getParameter(name));
			}
			//*/
		}
		sendlist.setUsers(users);
		sendlist.setSendlog(sendlog);
		session.setAttribute("SendList", sendlist);
	}
	String body = request.getParameter("body");
	String subject = request.getParameter("subject");
	String url_flg = request.getParameter("url");
	
	session.setAttribute("pagefrom", "mailnyuryoku");
%>
</head>
<body>
	<center>
		<table class="main">
			<tr>
				<td>
					<h1>メール作成画面</h1>
				</td>
			</tr>
			<tr>
				<td><hr color="#008080"></td>
			</tr>
			<tr>
				<td>
					<center>
						<div id="setumeiDiv">
							<table class="setumei">
								<tr>
									<td><small>
									空欄の部分は定型文が挿入されます。 
									</small></td>
								</tr>
							</table>
						</div>
					</center>
					<hr color="#008080">
				</td>
			</tr>
			<tr>
				<td>
					<div id="formDiv">
						<form action="MailSendToAllUserPayslip.jsp" method="POST" name="a">
						<input type="hidden" name="pagefrom" value="mailnyuryoku">
							<center>
							<table class="form">
								<tr class="mailSubject">
									<td >タイトル</td>
									<td class="title">"[社内文書システム]
									<input type="text" NAME="subject"
									<%if(subject != null ? subject.length() > 0 : false){%>
										value="<%=subject%>"
									<%}else{ %>
										value=""
									<%} %>
									size="50">"</td>
								</tr>
								<%-- 
								<tr class="mailBody">
									<td>書き出し</td>
									<td class="kakidasi">給与明細書(yyyy年mm月支給分)を
									<select size="1" name="kakidasi">
											<option value="公開">公開しました。</option>
											<option value="更新">更新しました。</option>
									</select>
									</td>
								</tr>
								--%>
								<tr><td>本文</td></tr>
								<tr><td></td><td class="atena">○○さんへ</td></tr>
								<tr><td colspan="2" class="mailBody">
								<%if(body != null ? body.length() > 0 : false){%>
								<textarea name="body" cols="80" rows="10" istyle="1"><%=body%></textarea>
								<%}else{%>
								<textarea name="body" cols="80" rows="10" istyle="1"></textarea>
								<%}%>
								</td></tr>
								<tr class="mailUrl">
									<td colspan="2" class="url">URLを記載　:　
									<%if(url_flg != null ? url_flg.equals("true") : false){ %>
									<input type="radio" name="url" value="true" checked="checked">する
									<input type="radio" name="url" value="false">しない
									<%}else{ %>
									<input type="radio" name="url" value="true">する
									<input type="radio" name="url" value="false" checked="checked">しない
									<%} %>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="submit"><input class="submitBt" type="submit" value="確認" name="aa">
										<%--
										onClick="confirmBox(<%=sendlist.countSended()%>)" >
										 --%>
									</td>
								</tr>
								
							</table>
							</center>
						</form>
					</div>
				</td>
			</tr>
			<tr class="home">
				<td><a href="SelectAddressPayslip.jsp">[送信者選択画面へ戻る]</a>
				<a href="SystemSelect.jsp">[システム選択へ戻る]</a></td>
			</tr>
		</table>
	</center>
</body>
</html>
<%}%>