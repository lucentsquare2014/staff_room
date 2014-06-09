
<%@ page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=shift-jis"
	pageEncoding="UTF-8"%>
<%@ page import="kkweb.beans.B_ShainMST"%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,java.text.*,kkweb.beans.*,kkweb.dao.*,kkweb.error.*"%>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String)session.getAttribute("key");
	if(id2 != null ? id2.equals("鍵") : false) {
%>
<%!// 書類名でアクション先を選択する
String selectAction(String name){
	// ページ名に給与明細を含む場合
	if(name.indexOf("給与明細") >= 0) return "SalaryPage";
	// 新しいページは同様にいかに追加
	//if(name.equals("旅費精算書")) return "RyohiseisanPage";

	return "";
	//return "PayslipError.jsp";
}%>
<html>
<head>

<script type="text/javascript" src="javascript/officedocuments.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=shift-jis">
<link rel="stylesheet" href="css/officedocuments.css" type="text/css">
<link rel="stylesheet" href="Syanaibunshou.css" type="text/css">
<%
	// 社員番号
	String number = "";

	number = ShainMST.getNumber();
	// 最新の更新表示件数
	String num = request.getParameter("limit");
	int limit = 10;
	try {
		int tmp = Integer.parseInt(num);
		limit = tmp;
		if(!(tmp == 10 || tmp == 30 || tmp == 50)) tmp = 10;
	} catch (NumberFormatException e) {
	}
	// 最新の更新表示ボックス
	NewInfoBox nibox = new NewInfoBoxDAO().getNewInfoBox(number, limit);
	ArrayList<Date> updates = nibox.getUpdateStamps(); // 更新日時
	ArrayList<String> names = nibox.getNames(); // 書類名
	ArrayList<PaperStatus> statuses = nibox.getStatus(); // 書類の状況

	// 重複なし書類名リスト
	ArrayList<String> plist_uniq = nibox.getPaperNameList();
	// 過去の給与明細書閲覧用リスト
	ArrayList<Date> ym = new YearMonthOfPayslipDAO()
			.getUniqYearMonth(number);
	// 書類作成用セレクター
	CreatePaperSelecter cpselect = new CreatePaperSelecterDAO()
			.createSelecter();
	ArrayList<String> maketypes = cpselect.getTypes();
	// 書類のステータスをセッションに追加
	session.setAttribute("newinfobox", nibox);
%>

<title>社内文書確認画面</title>
</head>
<body>
	<center>
		<div class=main>
			<div class="shadowbox">
				<div class="mainbox">
					<table class="frame">
						<tr>
							<th colspan=2>
								<h1>社内文書確認</h1>
								<hr class=title_bottom size="1px" color="#008080">
								<center>
									<table class="coment">
										<tr>
											<td class="tyuui1">*注意書き*
											</td>
										</tr>
										<%
											if (ShainMST.getChecked().equals("1")) {
												out.println("<tr><td class=\"tyuui\">1 : 新着情報と承認依頼一覧のフィルターは現在表示されているものを絞り込みます。<td></tr>");
											} else {
												out.println("<tr><td class=\"tyuui\">1 : 新着情報のフィルターは現在表示されているものを絞り込みます。<td></tr>");
											}
										%>
										<tr>
											<td class="tyuui">2 : PDFリーダーはAdobe Readerをご使用ください。その他のソフトウェアではファイルが破損する可能性があります。

											<td>
										</tr>
										<tr>
											<td class="tyuui">
											3 : PDFファイルが表示されているページの更新、再読み込みはご遠慮願います。ファイルが破損する可能性があります。
											<td>
										</tr>
										<tr>
											<td class="tyuui">
											4 : IEの互換モード表示をOFFにしてください。ページデザインが崩れ見づらくなる恐れがあります。
											<td>
										</tr>
										<!--
										<tr>
											<td class="tyuui">
											5 : 現在テスト中のためテストサーバのデータを参照しています。
											<td>
										</tr>
										 -->
									</table>
								</center>
							</th>
						</tr>
						<tr>
							<td colspan="2" class="user_name">ようこそ<%=ShainMST.getName()%>さん
							</td>
						</tr>
						<tr>
							<td colspan=2>最新の更新状況</td>
						</tr>

						<!-- フィルター -->
						<tr><td>
								<%
									if(limit == 10){
								%>
										10件
										<a href="OfficeDocuments.jsp?limit=30">30件</a>
										<a href="OfficeDocuments.jsp?limit=50">50件</a>
								<%
									} else if(limit == 30){
								%>
										<a href="OfficeDocuments.jsp?limit=10">10件</a>
										30件
										<a href="OfficeDocuments.jsp?limit=50">50件</a>
								<%
									} else {
								%>
										<a href="OfficeDocuments.jsp?limit=10">10件</a>
										<a href="OfficeDocuments.jsp?limit=30">30件</a>
										50件
								<%
									}
								%>
								</td>
							<td class="newinfot" colspan=2>
								<form name=newinfo>
									<select class=newinfoc name="filternewinfopul" size="1"
										onchange="tblfilter('newinfobox',this.options[this.selectedIndex].value);">
										<option value="">全ての書類</option>
										<%
											// 書棚にある書類の種類をリスト化
											for (int i = 0; i < plist_uniq.size(); i++) {
												out.println("<option value=\"" + plist_uniq.get(i) + "\">");
												out.println(plist_uniq.get(i));
												out.println("</option>");
											}
										%>

									</select>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<!-- 新着情報のテーブル -->
								<form name=newinfoselect method="post">
								<input type="hidden" value="" name="position">
								</form>
									<div id="newinfodiv">
										<table id="newinfobox" class="newtable">
											<thead>
												<tr>
													<td>更新日</td>
													<td>書類名</td>
													<td>コメント</td>
												</tr>
											</thead>
											<tbody>
												<%-- 新着情報作成のループ開始 --%>
												<%
													// statuses have name, comments, yearmonth
													for (int i = 0; i < statuses.size(); i++) {
														String name = statuses.get(i).getName();
												%>
												<tr id="selective" title="<%=names.get(i)%>" onclick="submitNewInfo('<%=i%>', '<%=selectAction(name)%>')">
													<td class="date">
													<%=updates.get(i).toString()%>
													</td>
													<td class="type"><%=statuses.get(i).getName()%></td>
													<td class="status"><%=statuses.get(i).getComment()%></td>
												</tr>
												<%
													}
												%>
												<%-- 新着情報作成のループ終了 --%>
											</tbody>
										</table>
									</div>
								 <br>
							</td>
						</tr>
						<%
							if (ShainMST.getChecked().equals("1")) {
						%>
						<tr>
							<td colspan=2>承認依頼一覧</td>
						</tr>
						<tr>
							<td class="syounininfot" colspan=2>
								<form name=syounininfo>
									<select class=syounininfoc name="filternewinfopul" size="1"
										onchange="tblfilter('syounininfobox',this.options[this.selectedIndex].value);">
										<option value="">全ての書類</option>
										<%
											// 書棚にある書類の種類をリスト化
												for (int i = 0; i < plist_uniq.size(); i++) {
													out.println("<option value=\"" + plist_uniq.get(i) + "\">");
													out.println(plist_uniq.get(i));
													out.println("</option>");
												}
										%>

									</select>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan=2>
								<form name=syounininfoselect method="post">
									<div id="syounininfodiv">
										<table id="syounininfobox" class="syounintable">
											<thead>
												<tr>
													<td>日付</td>
													<td>書類名</td>
													<td>状態</td>
												</tr>
											</thead>
											<tbody>
												<%--    現在はテストデータでハードコーディング   --%>
												<%--
												<tr id="selective" onclick="submitSyouninInfo('1')">
													<td class="date">2012-05-01</td>
													<td class="type">旅費精算書</td>
													<td class="status">未承認</td>
												</tr>
												 --%>
											</tbody>
										</table>
									</div>
								</form> <br>
							</td>
						</tr>
						<%
							}
						%>
						<!-- 給与明細書表示のプルダウンリスト -->
						<tr>
							<td class="salary">給与明細書表示</td>
							<td class="yearmonth">
								<form name=month action="SalaryPage" method="post">
									<select class=salaryselect1 name="year1" size="1">
										<option value="def">
										年月を選択してください</option>
											<%
												for (Date d : ym) {
													Calendar cal = Calendar.getInstance();
													cal.setTime(d);
													int year = cal.get(Calendar.YEAR);
													int month = cal.get(Calendar.MONTH) + 1;
											%>

										<option value="<%=d.getTime()%>">
											<%=year%>年<%=month%>月</option>
											<%
												}
											%>

									</select> から <select class=salaryselect2 name="year2" size="1">
										<option value="def">------</option>
											<%
												for (Date d : ym) {
													Calendar cal = Calendar.getInstance();
													cal.setTime(d);
													int year = cal.get(Calendar.YEAR);
													int month = cal.get(Calendar.MONTH) + 1;
											%>

										<option value="<%=d.getTime()%>">
											<%=year%>年<%=month%>月
											</option>

											<%
												}
											%>

									</select> <input type="submit" value="表示" />
								</form>
							</td>
						</tr>

						<!-- 申請書作成のプルダウンリスト -->
						<tr>
							<td class="salary">申請書作成</td>
							<td class="yearmonth">
								<form name=make method="post">
									<select class=docuselect name="docu" size="1"
										onchange="jumpSelectMakeDcu()">
										<option value="def">書類を選択してください</option>
										<%
											for (String t : maketypes) {
												if(t.equals("給与明細書")) continue;
										%>

										<option value="">
										<%=t%>
										</option>
											<%
												}
											%>

									</select>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan=2><div align="right">
									<font size="2"><a href="SystemSelect.jsp">[システム選択に戻る]</a></font>
								</div></td>
						</tr>

					</table>
				</div>
			</div>
		</div>
	</center>
</body>

</html>
<%}%>