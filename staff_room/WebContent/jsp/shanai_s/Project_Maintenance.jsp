<%@ page language="java" contentType="text/html; charset=shift_JIS"
	pageEncoding="shift_JIS"%>
<%@ page import="java.util.*"%><%@ page import="kkweb.beans.*"%><%@ page
	import="kkweb.dao.*"%><%@ page import="kkweb.maintenance.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id2 = (String) session.getAttribute("key2");
	if (id2 == null || id2.equals("false")) {
		pageContext.forward("/Pw_Nyuryoku_system.jsp");
	} else {
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<link rel="stylesheet" href="report.css" type="text/css">
<SCRIPT Language="JavaScript">
<!--
	function aboutbox() {
		var p = document.form1.p_name.value;
		var n = document.form1.p_code.value;
		var h = document.form1.basho.value;
		var aa = "\"";
		var bb = "\'";
		var cc = "\\";
		var dd = ">";
		var ee = "<";
		var ff = "\`";
		if (p.indexOf(aa) != -1 | p.indexOf(bb) != -1 | p.indexOf(cc) != -1
				| p.indexOf(dd) != -1 | p.indexOf(ee) != -1
				| p.indexOf(ff) != -1 | n.indexOf(aa) != -1
				| n.indexOf(bb) != -1 | n.indexOf(cc) != -1
				| n.indexOf(dd) != -1 | n.indexOf(ee) != -1
				| n.indexOf(ff) != -1 | h.indexOf(aa) != -1
				| h.indexOf(bb) != -1 | h.indexOf(cc) != -1
				| h.indexOf(dd) != -1 | h.indexOf(ee) != -1
				| h.indexOf(ff) != -1) {
			alert("\"\'\<>\`は入力しないでください。");
			return false;
		} else {
			return true;
		}
	}
// -->
</SCRIPT>
<title>プロジェクトマスタメンテナンス</title>
</head>
<body>
	<center>
		<font class="title">プロジェクトマスタメンテナンス</font><br>
		<hr color="#008080">
		<table>
			<tr>
				<td align="left"><small>1.追加する場合は上の三つのボックス全てを記入して「時間記入」ボタンを押してください。</small></td>
			</tr>
			<tr>
				<td align="left"><small>2.閲覧・更新・削除する場合は該当するプロジェクト名を選択して「次へ」ボタンを押してください。</small></td>
			</tr>
		</table>
		<hr color="#008080">
		<br>
		<form method="post" action="Project_Maintenance_nextstep.jsp"
			name="form1" onSubmit="return aboutbox()">
			<TABLE BORDER="1" class="mainte">
				<TR>
					<TH class="t-koumoku"><font color="white">プロジェクトコード</font></TH>
					<TH class="t-koumoku"><font color="white">プロジェクト名称</font></TH>
					<TH class="t-koumoku"><font color="white">場所</font></TH>
				</TR>
				<tr>
					<td><input type="text" size="30" name="p_code"
						onpaste="return false;" style="ime-mode: disabled;"></td>
					<td><input type="text" size="30" name="p_name"></td>
					<td><input type="text" size="15" name="basho"></td>
				</tr>
			</TABLE>
			<TABLE>
				<TR>
					<TD colspan="3"><INPUT TYPE="submit" VALUE="　時間記入　"
						class="bottom"></TD>
				</TR>
			</TABLE>
		</form>
		<BR>
		<FORM method="post" action="Project_Maintenance_nextpage.jsp">
			<table border="1" class="mainte" width="60%">
				<tr>
					<th colspan="2" class="t-koumoku"><font color="white">対象プロジェクト選択</font></th>
				</tr>
				<tr>
					<td colspan="2">
						<center>
							<select id="kousinnamae" name="kousinnamae">
								<%
									String sql = " select distinct PROJECTname,PROJECTcode from codeMST  where flg = '0' order by projectcode ";
										ArrayList projectlist = new ArrayList();
										int z = 0;
										PROJECTnameDAO projectdao = new PROJECTnameDAO();
										projectlist = projectdao.selectTbl(sql);
										B_Projectname bcode = new B_Projectname();
										for (int i = 0; i <= projectlist.size() - 1; ++i) {
											//z++;
											bcode = (B_Projectname) projectlist.get(i);
								%>
								<option value="<%=bcode.getPROJECTcode()%>"><%=bcode.getPROJECTcode() + "　"
							+ bcode.getPROJECTname()%></option>
								<%
									}//System.out.println(z);
								%>
							</select>
						</center>
					</td>
				</tr>
			</table>
			<TABLE>
				<TR>
					<TD colspan="3"><INPUT TYPE="submit" VALUE="　次へ　"
						class="bottom"></TD>
				</TR>
			</TABLE>
		</FORM>
		<br> <a href="SystemKanri_MenuGamen.jsp" class="link"><font
			class="link"><small>[ メニューへ戻る ]</small></font></a>
	</center>
</body>
</html>
<%
	}
%>