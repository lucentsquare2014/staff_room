<%@page import="kkweb.mail.C_MailSend"%>
<%@page
	import="kkweb.dao.*,kkweb.beans.*,java.util.Enumeration,java.util.ArrayList,java.sql.Date,org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<String> true_user = new ArrayList<String>();
	true_user.add(application.getInitParameter("sender")); // 特定ユーザのみ表示
	//true_user.add("21409");
	String id2 = (String) session.getAttribute("key");
	String from = (String) session.getAttribute("pagefrom");
	if ((id2 != null ? id2.equals("鍵") : false)
	&& true_user.contains(ShainMST.getNumber())) {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<link rel="stylesheet" href="css/mailsendtoalluserpayslip.css"
	type="text/css">
<script type="text/javascript" src="javascript/selectaddresspayslip.js"></script>
<script type="text/javascript">
	window.onunload = function() {
	};
	history.forward();
	function submit1() {
		document.body.style.cursor = 'wait';
		document.sendform.send.disabled = true;
		//document.sendform.send_nyuryoku.disabled = true;
		document.sendform.reselect.disabled = true;
	}
	function sendNyuryoku(action){
		document.body.style.cursor = 'wait';
		document.sendform.send.disabled = true;
		//document.sendform.send_nyuryoku.disabled = true;
		document.sendform.reselect.disabled = true;
		document.sendform.action=action;
	    document.sendform.submit();
	}
	function confirmBox(n, action){
		if(n > 0){ // 送信済みが含まれる
			var name=confirm("送信済みが"+n+"件含まれています。\n送信処理を続けますか？");
			if (name==true) {
				sendNyuryoku(action);
			}
		}else{
			var name=confirm("メールを送信します。よろしいですか？");
			if (name==true) {
				sendNyuryoku(action);
			}
		}
	}

</script>
<%
	request.setCharacterEncoding("UTF-8");
	String flag = request.getParameter("pagefrom");

	// 給与明細書が登録されている在籍社員情報の取得
	SendList sendlist = null;
	if(flag != null ? flag.equals("sendselect") || flag.equals("mailnyuryoku") : false)
		sendlist = (SendList)session.getAttribute("SendList");
	else sendlist = new SendListDAO().payslipSendList();
	// ユーザーリストを取り出す
	ArrayList<ShainInfo> users = sendlist.getUsers();
	// 社員番号リストを作成
	ArrayList<String> numberList = new ArrayList<String>();
	for (ShainInfo s : users)
		numberList.add(s.getNumber());

	ArrayList<Date> yearmonth = sendlist.getYearmonth();
	ArrayList<String> sendlog = sendlist.getSendlog();
	ArrayList<B_GroupMST> groups = new GroupDAO().selectTbl("");
	String disabled = "disabled";
	if (users.size() > 0)
		disabled = "";
	//System.out.println("flag : " + flag);
	if (flag != null ? flag.equals("sendselect") : false) {
		//form　から送られたネームリスト
		Enumeration<String> names = request.getParameterNames();
		ArrayList<ShainInfo> usersmst = new ArrayList<ShainInfo>(
				users);
		ArrayList<String> sendlogmst = new ArrayList<String>(
				sendlog);
		users.clear();
		sendlog.clear();

		while (names.hasMoreElements()) {
			String name = names.nextElement();
			//System.out.println(name);
			// 選ばれた社員番号ならば
			if (numberList.contains(name)) {
				//System.out.println(name);
				users.add(usersmst.get(numberList.indexOf(name)));
				sendlog.add(sendlogmst.get(numberList.indexOf(name)));
			}
		}
		sendlist.setUsers(users);
		sendlist.setSendlog(sendlog);
	} else {
		flag = "";
	}
	int countSended = sendlist.countSended();

	String title = "一斉送信確認";
	if (flag.equals("sendselect") || flag.equals("mailnyuryoku")) {
		title = "送信確認";
	}

	String body = request.getParameter("body");
	String subject = request.getParameter("subject");
	String url_flg = request.getParameter("url");
	String kakidasi = request.getParameter("kakidasi");
	if (body == null)
		body = "";
	if (subject == null)
		subject = "";
	if (url_flg == null)
		url_flg = "true";
	if (kakidasi == null)
		kakidasi = "1";
	session.setAttribute("SendList", sendlist);
	session.setAttribute("pagefrom", "sendall");
%>

<title><%=title%></title>
</head>
<body>
	<center>
		<div id="mainTable">
			<table id="main">
				<tr>
					<td>
						<h1><%=title %></h1>
					</td>
				</tr>
				<tr>
					<td>以下の方にメールを送信します。</td>
				</tr>
				<tr>
					<td class="groupFilterTd"><select class=groupFilter
						name="groupFilter" size="1"
						onchange="tblfilter('for',this.options[this.selectedIndex].value);">
							<option value="">全ての部署</option>
							<%
								// 部署コードをリスト化
									for (B_GroupMST g : groups) {
										out.println("<option value=\"" + g.getGROUPnumber() + "\">");
										out.println(g.getGROUPname());
										out.println("</option>");
									}
							%>
					</select></td>
				</tr>
				<tr>
					<td>
						<div id="sendlist">

							<table class="for" id="for">
								<thead>
									<tr>
										<td>部署番号</td>
										<td>社員番号</td>
										<td>名前</td>
										<td>アドレス</td>
										<td>URL対象</td>
										<td>送信状態</td>
									</tr>
								</thead>
								<tbody>
									<%-- 新着情報作成のループ開始 --%>
									<%
										for (int i = 0; i < users.size(); i++) {
												ShainInfo u = users.get(i);
												String[] ymd = yearmonth.get(i).toString().split("-");
												String log = sendlog.get(i);
									%>
									<tr title="<%=u.getGroupnumber()%>,<%=u.getNumber()%>">
										<td class="group"><%=u.getGroupnumber()%></td>
										<td class="syainbangou"><%=u.getNumber()%></td>
										<td class="name"><%=u.getName()%> さん</td>
										<td class="mail"><%=u.getMail()%></td>
										<td class="date"><%=ymd[0]%>年<%=ymd[1]%>月支給分</td>
										<%
											if (log.equals("送信済")) {
										%>
										<td class="logSended"><%=log%></td>
										<%
											} else {
										%>
										<td class="logUnsend"><%=log%></td>
										<%
											}
										%>
									</tr>
									<%
										}
									%>
									<%-- 新着情報作成のループ終了 --%>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
				<%--
				<tr>
					<td>ページ下部にある<strong>本文の変更</strong>から内容を変更できます。
					</td>
				</tr>
				<tr>
					<td><font class="rewritable">緑の斜体</font>は手入力で編集できます。</td>
				</tr>
				 --%>
				<tr>
					<td>
					<form action="PayslipMailSender" method="post" name="sendform">
					<%--					<input type="hidden" name="body" value="<%=body%>">
											<input type="hidden" name="subject" value="<%=subject%>">
											<input type="hidden" name="url" value="<%=url_flg%>">
											<input type="hidden" name="pagefrom" value="sendall">
						 --%>

						<center>
							<table class="mailtmp">
								<tr>
									<td class="midasi" colspan="2"><strong>送信内容</strong></td>
								</tr>
								<tr>
									<td colspan="2"><hr class="underline" size="2px"></td>
								</tr>
								<tr>
									<td>タイトル</td>
									<td>[社内文書システム]
									<%-->
									<%if(subject != null ? subject.length() > 0 : false){ %>
										<font class="rewritable"><%=subject%></font>
									<%}else{ %>
										<font class="rewritable">給与明細書を公開しました。</font>
									<%}%>
									--%>
									<input type="text" NAME="subject"
									<%if(subject != null ? subject.length() > 0 : false){%>
										value="<%=subject%>"
									<%}else{ %>
										value="給与明細書を公開しました。"
									<%} %>
									size="50"></td>
								</tr>
								<tr>
									<td>本文</td>
									<td>OOさんへ</td>
								</tr>
								<tr><td>書き出し</td>
								<td>
									<select size="1" name="kakidasi">
											<option value="0"
											<%if(kakidasi.equals("0"))
												out.println("selected=\"selected\"");
											%>>空欄</option>
											<option value="1"
											<%if(kakidasi.equals("1"))
												out.println("selected=\"selected\"");
											%>>給与明細書(yyyy年mm月支給分)を公開しました。</option>
											<option value="2"
											<%if(kakidasi.equals("2"))
												out.println("selected=\"selected\"");
											%>>給与明細書(yyyy年mm月支給分)を更新しました。</option>
									</select>
								</td>
								</tr>
								<tr><td></td>
								<td>
								<%if(body != null ? body.length() > 0 : false){%>
								<textarea name="body" cols="90" rows="5" istyle="1"><%=body%></textarea>
								<%}else{%>
<textarea name="body" cols="90"  rows="5" istyle="1" >
</textarea>
								<%}%>
								</td></tr>

								<tr><td></td><td><%=ShainMST.getName()%>より</td></tr>
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
									<td>URL内容</td>
									<td><font class="selectable">以下のURLから支給年月が最も新しい給与明細書がPDF形式でご確認できます。</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">-------------------------------------------------------------------</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">URL :
											http://www.lucentsquare.co.jp:8080/staff_room/jsp/shanai_s/SalaryPage?code=各個人の専用コード</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">-------------------------------------------------------------------</font></td>
								</tr>
								<%--
								<%if(body != null ? body.length() > 0 : false){
									String[] strs = body.split("\n");
									///System.out.println(strs.length);
									for(String s : strs ){
										////System.out.println(s);
								%>
								<tr>
									<td></td>
									<td><font class="rewritable"><%=s%></font></td>
								</tr>
								<%	} %>
								<%}else{%>
								<tr>
									<td></td>
									<td><font class="rewritable">給与明細書(yyyy年mm月支給分)を公開しました。</font></td>
								</tr>
								<%
								}
								if (url_flg != null ? url_flg.equals("true") : true) {
								%>
								<tr>
									<td></td>
									<td><font class="selectable">以下のURLから支給年月が最も新しい給与明細書がPDF形式でご確認できます。</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">-------------------------------------------------------------------</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">URL :
											http://www.lucentsquare.co.jp:8080/kk_web/SalaryPage?code=各個人の専用コード</font></td>
								</tr>
								<tr>
									<td></td>
									<td><font class="selectable">-------------------------------------------------------------------</font></td>
								</tr>
								<%}%>
								 --%>
							</table>
						</center>
						<div id="sendformdiv">
							<table class="sendform">
								<tr>
									<td class="submit">
										<%--
									<form action="MailNyuryokuPayslip.jsp" method="post">
									 --%>
											<input name="send"  class="button"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												type="button" value="送信"
												onclick="confirmBox(<%=countSended%>,'PayslipMailSender')">
												<%--
											<input name="send_nyuryoku"  class="button" type="button" value="本文の変更"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												onclick="sendNyuryoku('MailNyuryokuPayslip.jsp')">
										 		--%>
									</td>
									<td class="reselect">
									<%--<form action="SelectAddressPayslip.jsp" method="post"
											name="reselectform"> --%>
											<input name="reselect" class="button"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												type="button" value="送信先を選択し直す" onclick="sendNyuryoku('SelectAddressPayslip.jsp')">
									</td>
								</tr>
								<tr class="home">
									<td colspan="2"><a href="SystemSelect.jsp">[スタッフルームトップへ]</a></td>
								</tr>
							</table>
						</div>
						</form>
					</td>
				</tr>
<%--			<tr>
					<td>
						<div id="sendformdiv">
							<table class="sendform">
								<tr>
									<td class="submit">
										<form action="PayslipMailSender" method="post" name="sendform">
											<input type="hidden" name="body" value="<%=body%>">
											<input type="hidden" name="subject" value="<%=subject%>">
											<input type="hidden" name="url" value="<%=url_flg%>">
											<input type="hidden" name="pagefrom" value="sendall">
											<input name="send"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												type="button" value="送信"
												onclick="confirmBox(<%=countSended%>,'PayslipMailSender')">
											<input name="send_nyuryoku" type="button" value="本文の変更"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												onclick="sendNyuryoku('MailNyuryokuPayslip.jsp')">
										</form>
									</td>
									<td class="reselect">
										<form action="SelectAddressPayslip.jsp" method="post"
											name="reselectform">
											<input type="hidden" name="body" value="<%=body%>">
											<input type="hidden" name="subject" value="<%=subject%>">
											<input type="hidden" name="url" value="<%=url_flg%>">
											<input type="hidden" name="pagefrom" value="sendall">
											<input name="reselect"
												<%if (users.size() == 0)out.println("disabled=\"true\"");%>
												type="submit" value="送信先を選択し直す" onclick="submit1()">
										</form>
									</td>
								</tr>
								<tr class="home">
									<td colspan="2"><a href="SystemSelect.jsp">[システム選択へ戻る]</a></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
 --%>
				</table>
		</div>
	</center>
</body>
</html>
<%
	}
%>