<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ page import = "kkweb.eturan.T_Eturan"  %><%@ page import = "kkweb.dao.*" %><%@ page import = "kkweb.beans.*" %><%@ page import = "java.util.*"%><%@ page import = "kkweb.common.C_CheckMonth" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key2");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{%>
<jsp:useBean id="namaenengetuDATA" scope="session" type="java.util.ArrayList"/>
<html lang = "ja">
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<script type="text/javascript" src="/javascript/chainedselects.js"></script>
<script type="text/javascript">
<!--
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
				for(var i = 1; i < originalOptions.length; i++) {
					newCategory2.appendChild(originalOptions.item(i).cloneNode(true));
				}break;
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
	if(selectValue == "0 0"){
		newCategory3.appendChild(originalOptions.item(0).cloneNode(true));
	}else{
<%	int arraySize = namaenengetuDATA.size();
	for(int i = 0; i < arraySize; i++){
		bEturan = (B_Eturangamen)namaenengetuDATA.get(i);
		String ym = (String)bEturan.getYear_month();
		C_CheckMonth mont = new C_CheckMonth();%>
		if(selectValue == "<%=bEturan.getGroupnumber() %> <%=bEturan.getNumber() %>"){
			var element<%=i%> = document.createElement("option");
			element<%=i%>.value = "<%=bEturan.getYear_month() %>";
			element<%=i%>.innerHTML = "<%=ym.substring( 0 , 4 ) %>年　<%=mont.MonthCheck(ym.substring( 4 , 6 )) %>月";
			newCategory3.appendChild(element<%=i%>);
		}
<%	}%>
	}
	thisCategory3.parentNode.replaceChild(newCategory3, thisCategory3);
	}
//-->
</script>
<title>退職者勤務報告閲覧</title>
</Head>
<body>
<center>
<font class="title">退職者の承認作業終了の勤務報告閲覧</font><div class="box4">
<Form name="formKensaku" method="POST" action="t_insatu" ><div class="box5">
<font class="eturan">　?対象者選択</font><hr color = "#008080">
<select id="number" name="number"  onchange="selectionCategory3(this);">
<option value="0 0">---</option>
<%	LoginDAO lDao = new LoginDAO();
	ArrayList sList = new ArrayList();
	B_ShainMST bshain = new B_ShainMST();
	sList = lDao.selectTbl(" where zaiseki_flg = '0' order by to_number(number,'99999') ");
	for(int i = 0; i < sList.size(); i++){
		try{
			bshain = (B_ShainMST)sList.get(i);%>
<option value="<%=bshain.getGROUPnumber() %> <%=bshain.getNumber() %>"><%= bshain.getNumber()%>　<%=bshain.getName() %></option>
<%		}catch(Exception e){
			e.printStackTrace();}}%>
</select></div>
<div class="box6"><font class="eturan">?対象年月選択</font><hr color = "#008080">
<select id="year_month" name="year_month" class="input_size_200">
<option value="0">---</option>
</select></div>
<input type="submit"  value="　表示　" STYLE="cursor: pointer; ">
</FORM><br><br>
<a href="SystemKanri_MenuGamen.jsp" style="text-decoration:none;"><font class="link"><small>[ メニューへ戻る ]</small></font></a></div>
</CENTER>
</BODY>
</HTML>
<%}%>