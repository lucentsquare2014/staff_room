<%@ page language="java" contentType="text/html; charset=shift_JIS"pageEncoding="shift_JIS"%>
<%@ page import = "kkweb.eturan.G_Eturan"  %><%@ page import = "kkweb.dao.*" %><%@ page import = "kkweb.beans.*" %><%@ page import = "java.util.*"%><%@ page import = "kkweb.common.C_CheckMonth" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){
			pageContext.forward("/ID_PW_Nyuryoku.jsp");
		}else{%>
<jsp:useBean id="namenengetuDATA" scope="session" type="java.util.ArrayList"/>
<html lang = "ja">
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=shift_JIS">
<meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script type="text/javascript" src="/javascript/chainedselects.js"></script>
<script type="text/javascript">
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,'');
	};
	function selectionCategory2(category1) {
		if(!window.originalCategory2)
			window.originalCategory2 = document.getElementById("number").cloneNode(true);
		var selectValue = category1.value;
		var valueLength = selectValue.length;
		var thisCategory2 = document.getElementById("number");
		var newCategory2 = window.originalCategory2.cloneNode(false);
		var originalOptions = window.originalCategory2.options;
		newCategory2.appendChild(originalOptions.item(0).cloneNode(true));
		for(var i = 1; i < originalOptions.length; i++) {
			if((selectValue == originalOptions.item(i).value.substring(0, 2).trim()) | (selectValue == originalOptions.item(i).value.substring(0, 3).trim())){
			newCategory2.appendChild(originalOptions.item(i).cloneNode(true));
			}else if(selectValue == "000"){
				newCategory2 = window.originalCategory2.cloneNode(true);
				break;
			}
		}
		thisCategory2.parentNode.replaceChild(newCategory2, thisCategory2);
		selectionCategory3(document.getElementById("number"));
	}
	function selectionCategory3(category2) {
		if(!window.originalCategory3)
			window.originalCategory3 = document.getElementById("year_month").cloneNode(true);
		var selectValue = category2.value;
		var valueLength = selectValue.length;
		var thisCategory3 = document.getElementById("year_month");
		var newCategory3 = window.originalCategory3.cloneNode(false);
		var originalOptions = window.originalCategory3.options;
<%	B_Eturangamen bEturan = new B_Eturangamen();%>
		if(selectValue == "00 00"){
			newCategory3.appendChild(originalOptions.item(0).cloneNode(true));
		}else{
<%	int arraySize = namenengetuDATA.size();
		for(int i = 0; i < arraySize; i++){
			bEturan = (B_Eturangamen)namenengetuDATA.get(i);
			String ym = (String)bEturan.getYear_month();
			C_CheckMonth mont = new C_CheckMonth();%>
		if(selectValue == "<%=bEturan.getGroupnumber() %> <%=bEturan.getNumber() %>"){
			var element<%=i%> = document.createElement("option");
			if (<%=bEturan.getFlg()%>== "0"){
				element<%=i%>.value = "<%=bEturan.getYear_month() %>";
				element<%=i%>.innerHTML = "<%=ym.substring( 0 , 4 ) %>年　<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>月";
			}else{
				element<%=i%>.value = "<%=bEturan.getYear_month() %>";
				element<%=i%>.innerHTML = "<%=ym.substring( 0 , 4 ) %>年　<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>月(承認作業中)";
			}
			newCategory3.appendChild(element<%=i%>);
		}
<%		}%>
			}
		thisCategory3.parentNode.replaceChild(newCategory3, thisCategory3);
	}
<!--selectionCategory2(category1);-->
</script>
<title>勤務報告書閲覧</title>
</Head>
<body>
<center>
<font  class="title">承認作業中・承認作業終了の勤務報告閲覧</font>
<div class="box4">
<Form name="formKensaku" method="POST" action="g_insatu" >
<div class="box1">
<font class="eturan">? 対象グループ選択</font>
<hr color = "#008080">
<select id="group" name="group"  onchange="selectionCategory2(this);">
<option value="000">全グループ</option>
<%	GroupDAO gDao = new GroupDAO();
	ArrayList gList = new ArrayList();
	B_GroupMST bgroup = new B_GroupMST();
	gList = gDao.selectTbl("");
	for(int i = 0; i < gList.size(); i++){
		try{
			bgroup = (B_GroupMST)gList.get(i);%>
<option value="<%=bgroup.getGROUPnumber() %>"><%=bgroup.getGROUPname() %></option>
<%		}catch(Exception e){
			e.printStackTrace();
		}
	}%>	</select></div><div class="box2">
<font class="eturan">? 対象者選択</font>
<hr color = "#008080">
<select id="number" name="number"  onchange="selectionCategory3(this);">
<option value="00 00">---</option>
<%	LoginDAO lDao = new LoginDAO();
	ArrayList sList = new ArrayList();
	B_ShainMST bshain = new B_ShainMST();
	String strWhere = " where zaiseki_flg = '1' order by to_number(number,'99999') ";
	sList = lDao.selectTbl(strWhere);
	for(int i = 0; i < sList.size(); i++){
		try{
			bshain = (B_ShainMST)sList.get(i);%>
<option value="<%=bshain.getGROUPnumber() %> <%=bshain.getNumber() %>"><%=bshain.getNumber()%>　<%=bshain.getName() %></option>
<%		}catch(Exception e){
			e.printStackTrace();
		}
	}%>	</select></div><div class="box3">
<font class="eturan">? 対象年月選択</font>
<hr color = "#008080">
<select id="year_month" name="year_month" class="input_size_200">
<option value="0">---</option>
</select></div>
<input type="submit"  value="　表示　" STYLE="cursor: pointer; ">
</FORM><br><br>
<form method="post" action="Escape_NameSelect.jsp">
<input type="submit" value="⇒　javascript未対応の方はこちらから" style="cursor: pointer;background:none;border:none;color:blue;text-decoration:underline">
<input type="hidden" name="escapeflg" id="escapeflg" value="0">
</form><br>
<a href="Menu_Gamen.jsp" style="text-decoration:none;"><font class="link"><small>[ メニューへ戻る ]</small></font></a></div>
</CENTER>
</BODY>
</HTML>
<%}%>