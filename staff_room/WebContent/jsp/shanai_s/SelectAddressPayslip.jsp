<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@page
	import="kkweb.dao.*,kkweb.beans.*,java.util.ArrayList,java.sql.Date,org.apache.commons.codec.digest.DigestUtils"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<String> true_user = new ArrayList<String>();
	true_user.add(application.getInitParameter("sender")); // 特定ユーザのみ表示
	true_user.add("21409"); //テストユーザー
	//
	String id2 = (String) session.getAttribute("key");
	String from = (String) session.getAttribute("pagefrom");
	if ((id2 != null ? id2.equals("鍵") : false)
	&& true_user.contains(ShainMST.getNumber())) {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<link rel="stylesheet" href="css/selectaddresspayslip.css"
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
		document.sendform.cansel.disabled = true;
		document.sendform.submit();
	}
</script>
<title>送信者選択</title>
</head>
<%
		request.setCharacterEncoding("UTF-8");
		String flag = request.getParameter("pagefrom");
		// 在籍する社員情報を取得
		SendList sendlist = new SendListDAO().payslipSendList();
		session.setAttribute("SendList", sendlist);

		// ユーザーリストを取り出す
		ArrayList<ShainInfo> users = sendlist.getUsers();
		// 送信対象年月
		ArrayList<Date> yearmonth = sendlist.getYearmonth();
		// 送信ログ
		ArrayList<String> sendlog = sendlist.getSendlog();

		ArrayList<B_GroupMST> groups = new GroupDAO().selectTbl("");
		session.setAttribute("pagefrom", "sendselect");
		String body = request.getParameter("body");
		String subject = request.getParameter("subject");
		String url_flg = request.getParameter("url");
		String kakidasi = request.getParameter("kakidasi");
		if(body == null) body ="";
		if(subject == null) subject ="";
		if(url_flg == null) url_flg ="true";
		session.setAttribute("SendList", sendlist);
%>
<body>
	<center>
		<table class="main">
			<tr>
				<td>
					<h1>送信者選択</h1>
				</td>
			</tr>
			<tr>
				<td>
					<div id="attentionDiv">
						<center>
							<table class="attention">
								<thead>
									<tr>
										<th class="0">*注意*</th>
									</tr>
								</thead>
								<tbody>
									<tr class="at">
										<td class="1">1. 選択者リストに表示されている方にメールが送信されます。</td>
									</tr>
									<tr class="at">
										<td class="1">2. 行をクリックすると選択者リストに反映されます。</td>
									</tr>
									<tr class="at">
										<td class="1">3. フィルターを使用すると、未送信者や部署ごとに絞り込めます。</td>
									
									<%-- 
		<tr class="at"><td class="1">3.　送信ボタンを押すと直ちにメールが送信されます。</td></tr>
		<tr class="at"><td class="1">4.　「部署を選択」ボタンを押すとボタン左のリストで選択されている部署に所属する方がチェックされます。</td></tr>
		<tr class="at"><td class="1">5.　「部署を選択解除」ボタンを押すとボタン左のリストで選択されている部署に所属する方のチェックが外れます。</td></tr>
		<tr class="at"><td class="1">6.　「リセット」ボタンを押すと全てのチェックが外れます。</td></tr>
		<tr class="at"><td class="1">7.　送信をやめる場合はページを閉じるか最下のリンクから退室してください。</td></tr>
		<tr class="at"><td class="1">8.　メールを送信していない方のみ表示されます。</td></tr>
		--%>
								</tbody>
							</table>
						</center>
					</div>
				</td>
			</tr>
			<tr class="filterTr">
				<td class="groupFilterTd"><select id="groupFilter"
					class=groupFilter name="groupFilter" size="1"
					onchange="tblfilter('selectTable',this.options[this.selectedIndex].value);">
						<option value="all">全ての部署</option>
						<option value="nosend">未送信</option>
						<%
							// 部署コードをリスト化
								for (B_GroupMST g : groups) {
									out.println("<option value=\"" + g.getGROUPnumber() + "\">");
									out.println(g.getGROUPname());
									out.println("</option>");
								}
						%>
				</select>

					<button onclick="checkGroup()">一括選択</button>
					<button onclick="uncheckGroup()">一括解除</button></td>
			</tr>
			<tr id="fromTr">
				<td>
					<%--
		<form action="MailNyuryokuPayslip.jsp" method="POST" name="sendform" >
		 --%>
					<center>
						<form action="MailSendToAllUserPayslip.jsp" method="POST" name="sendform">
							<input type="hidden" name="body" value="<%=body%>">
							<input type="hidden" name="subject" value="<%=subject%>">
							<input type="hidden" name="url" value="<%=url_flg%>">
							<input type="hidden" name="kakidasi" value="<%=kakidasi%>">
							<input type="hidden" name="pagefrom" value="sendselect">
															
							<div id="selectTableDiv">
								<table id="selectTable" class="selectTable">
									<thead>
										<tr>
											<td></td>
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
													//String log = sendlog.get(i);
													String[] ymd = yearmonth.get(i).toString().split("-");
													String log = sendlog.get(i);
										%>
										<tr
											title="<%=u.getGroupnumber()%>,<%=u.getNumber()%>,<%=u.getId()%>,<% if (log.equals("未送信")) { %>nosend<% } %>,all"
											onclick="clickBox('<%=u.getId()%>','<%=u.getNumber()%>')">
											<td class="check"><input type="checkbox"
												value="<%=u.getNumber()%>" id="<%=u.getId()%>"
												name="<%=u.getNumber()%>"
												onchange="changeBox(this.id,'<%=u.getNumber()%>')">
											</td>
											<td class="group"><%=u.getGroupnumber()%></td>
											<td class="syainbangou"><%=u.getNumber()%></td>
											<td class="name"><%=u.getName()%> さん</td>
											<td class="mail"><%=u.getMail()%></td>
											<td class="date"><%=ymd[0]%>年<%=ymd[1]%>月支給分</td>
											<%--
							<td class="log">
							<%=log%></td>
							 --%>
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
							<h2>選択者リスト</h2>
							<div id="selectedTableDiv">
								<table id="selectedTable" class="selectedTable">
									<thead>
										<tr id="headder">
											<td>部署番号</td>
											<td>社員番号</td>
											<td>名前</td>
											<td>アドレス</td>
											<td>URL対象</td>
											<td>送信状態</td>
										</tr>
									</thead>
									<tbody>
										<%
											for (int i = 0; i < users.size(); i++) {
												ShainInfo u = users.get(i);
												//String log = sendlog.get(i);
												String[] ymd = yearmonth.get(i).toString().split("-");
												String log = sendlog.get(i);
										%>
										<tr id="<%=u.getNumber()%>"
											title="<%=u.getGroupnumber()%>,<%=u.getNumber()%>">
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
									</tbody>
								</table>
							</div>
							<%--
							<h2></h2>
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
								<%if(subject != null ? subject.length() > 0 : false){ %>
									<font class="rewritable"><%=subject%></font>
								<%}else{ %> 
									<font class="rewritable">給与明細書を公開しました。</font>
								<%}%>
								</td>
							</tr>
							<tr>
								<td>本文</td>
								<td>OOさんへ</td>
							</tr>
							<%if(body != null ? body.length() > 0 : false){
									String[] strs = body.split("\n");
									///System.out.println(strs.length);
									for(String s : strs ){
										System.out.println(s);
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
						</table>
						--%>
							<input class="bt" type="submit" name="send" value="送信確認"
								disabled="disabled" onclick="submit1()">
							<%--
							<input
								class="bt" type="button" name="send_nyuryoku" value="本文を変更"
								disabled="disabled"
								onclick="sendNyuryoku('MailNyuryokuPayslip.jsp')">
							 --%>
							 <input
								class="bt" type="reset" name="cansel" value="リセット"
								onclick="resetCheckBox()">
						</form>
					</center>
				</td>
			</tr>
			<%--
			<tr>
				<td><strong>本文の変更</strong>から<font class="rewritable">緑の斜体</font>部分を手入力で編集できます。</td>
			</tr>
			 --%>
			<tr class="home">
				<td colspan="2"><a href="/staff_room" target="_parent">[スタッフルームへ戻る]</a></td>
		</table>
	</center>
</body>
</html>
<%}%>