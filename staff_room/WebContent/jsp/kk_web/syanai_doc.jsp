<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0061)http://www.lucentsquare.co.jp:8080/kk_web/OfficeDocuments.jsp -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="./syanaibunsyo_files/officedocuments.js"></script>

<link rel="stylesheet" href="./syanaibunsyo_files/officedocuments.css" type="text/css">
<link rel="stylesheet" href="./syanaibunsyo_files/Syanaibunshou.css" type="text/css">


<title>社内文書確認画面</title>
</head>
<body>
	<center>
		<div class="main">
			<div class="shadowbox">
				<div class="mainbox">
					<table class="frame">
						<tbody><tr>
							<th colspan="2">
								<h1>社内文書確認</h1>
								<hr class="title_bottom" size="1px" color="#008080">
								<center>
									<table class="coment">
										<tbody><tr>
											<td class="tyuui1">*注意書き*
											</td>
										</tr>
										<tr><td class="tyuui">1 : 新着情報のフィルターは現在表示されているものを絞り込みます。</td><td></td></tr>

										<tr>
											<td class="tyuui">2 : PDFリーダーはAdobe Readerをご使用ください。その他のソフトウェアではファイルが破損する可能性があります。

											</td><td>
										</td></tr>
										<tr>
											<td class="tyuui">
											3 : PDFファイルが表示されているページの更新、再読み込みはご遠慮願います。ファイルが破損する可能性があります。
											</td><td>
										</td></tr>
										<tr>
											<td class="tyuui">
											4 : IEの互換モード表示をOFFにしてください。ページデザインが崩れ見づらくなる恐れがあります。
											</td><td>
										</td></tr>
										<!--
										<tr>
											<td class="tyuui">
											5 : 現在テスト中のためテストサーバのデータを参照しています。
											<td>
										</tr>
										 -->
									</tbody></table>
								</center>
							</th>
						</tr>
						<tr>
							<td colspan="2" class="user_name">ようこそ玉城　亨文さん
							</td>
						</tr>
						<tr>
							<td colspan="2">最新の更新状況</td>
						</tr>

						<!-- フィルター -->
						<tr><td>
								
										10件
										<a href="http://www.lucentsquare.co.jp:8080/kk_web/OfficeDocuments.jsp?limit=30">30件</a>
										<a href="http://www.lucentsquare.co.jp:8080/kk_web/OfficeDocuments.jsp?limit=50">50件</a>
								
								</td>
							<td class="newinfot" colspan="2">
								<form name="newinfo">
									<select class="newinfoc" name="filternewinfopul" size="1" onchange="tblfilter(&#39;newinfobox&#39;,this.options[this.selectedIndex].value);">
										<option value="">全ての書類</option>
										<option value="給与明細書">
給与明細書
</option>


									</select>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<!-- 新着情報のテーブル -->
								<form name="newinfoselect" method="post">
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
												
												
												<tr id="selective" title="給与明細書" onclick="submitNewInfo(&#39;0&#39;, &#39;SalaryPage&#39;)">
													<td class="date">
													2014-05-02
													</td>
													<td class="type">給与明細書 (2014年04月支給分) </td>
													<td class="status">(支給区分 : 給与) 更新</td>
												</tr>
												
												
											</tbody>
										</table>
									</div>
								 <br>
							</td>
						</tr>
						
						<!-- 給与明細書表示のプルダウンリスト -->
						<tr>
							<td class="salary">給与明細書表示</td>
							<td class="yearmonth">
								<form name="month" action="http://www.lucentsquare.co.jp:8080/kk_web/SalaryPage" method="post">
									<select class="salaryselect1" name="year1" size="1">
										<option value="def">
										年月を選択してください</option>
											

										<option value="1396278000000">
											2014年4月</option>
											

									</select> から <select class="salaryselect2" name="year2" size="1">
										<option value="def">------</option>
											

										<option value="1396278000000">
											2014年4月
											</option>

											

									</select> <input type="submit" value="表示">
								</form>
							</td>
						</tr>

						<!-- 申請書作成のプルダウンリスト -->
						<tr>
							<td class="salary">申請書作成</td>
							<td class="yearmonth">
								<form name="make" method="post">
									<select class="docuselect" name="docu" size="1" onchange="jumpSelectMakeDcu()">
										<option value="def">書類を選択してください</option>
										

										<option value="">
										旅費精算書
										</option>
											

										<option value="">
										伝票
										</option>
											

									</select>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan="2"><div align="right">
									<font size="2"><a href="http://www.lucentsquare.co.jp:8080/kk_web/SystemSelect.jsp">[システム選択に戻る]</a></font>
								</div></td>
						</tr>

					</tbody></table>
				</div>
			</div>
		</div>
	</center>



</body></html>