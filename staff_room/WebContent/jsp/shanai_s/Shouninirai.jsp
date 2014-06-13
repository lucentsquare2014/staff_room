<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.util.*" %><%@ page import="kkweb.beans.*" %><%@ page import="kkweb.dao.*" %>
<jsp:useBean id="ShainMST" scope="session" class="kkweb.beans.B_ShainMST" /><jsp:useBean id="Year_month" scope="session" class="kkweb.beans.B_Year_month"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	String id2 = (String)session.getAttribute("key");
		if(id2 == null || id2.equals("false")){	
			pageContext.forward("/");
		}else{	%>
<html>
<head>
<script type="text/javascript">
	window.onunload=function(){};
	history.forward();
	
	function submit1(satoh){
		var satou=satoh;
		document.body.style.cursor='wait';
		var kazu=document.aa.shouninsyasuu.value;
		for(var i=1;i<=kazu;i++){
			documentform = eval("document.A"+i+".shouninsha_name"+i);
			documentform.disabled=true;
		}
		documentform = eval("document.A"+satou)
		documentform.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta http-equiv="Content-Language" content="ja">
<link rel="stylesheet" href="kintaikanri.css" type="text/css">
<title>承認依頼終了確認</title>
</head>
<body>
<center>
<font class="title">承認依頼</font><br><br>
<%  String iraisha_number = ShainMST.getNumber();
	// 役職順にソートする場合に使用するインデックス配列
	// 社員番号を役職が上の方から記述する
	/*String[] sort_index = 
	{
		
		"18901", // 社長
		"20101", // GM
		"20308", // GM
		"20626", // GM
		"19003", // AM
		"19304", // AM
		"15005", // SM
		"18534", // SM
		"19603", // SM
		"20214", // SM
		"20617", // SM
		"20726", // SM
		"21208", // SM
		"18237", // MM
		"18331", // MM
		"18332", // MM
		"18531", // MM
		"18904", // MM
		"19705", // MM
		"19904", // MM
		"20301", // MM
		"20310", // MM
		"18234", // JM
		"18236", // JM
		"18532", // JM
		"19503", // JM
		"19701", // JM
		"19801", // JM
		"19806", // JM
		"20432", // JM
		"20701", // JM
		"20822", // JM
		"21209", // JM
		"18432", // TL
		"18731", // TL
		"18732", // TL
		"19910", // TL
		"19235", // TL
		"19833", // TL
		"20212", // TL
		"20309", // TL
		"20331", // TL
		"20407", // TL
		"20511", // TL
		"20609", // TL
		"20702", // TL
		"20703", // TL
		"20709", // TL
		"20728", // TL
		"20807", // TL
		"20905", // TL
		"15006", // PO
		"17531", // PO
		"20218", // PO
		"20306", // PO
		"20401", // PO
		
	}; */
	String iraisha_year_month = Year_month.getYear_month();
	if(ShainMST.getChecked().equals("1")){%>
<form method="post" action="s_shouninkakunin" name="C">
<input TYPE="submit" VALUE="承認作業終了" STYLE="cursor: pointer;width:100px;background-color:aqua" name="cc">
<input TYPE="hidden" NAME="iraisha_number" VALUE="<%=iraisha_number%>">
<input TYPE="hidden" NAME="iraisha_year_month" VALUE="<%=iraisha_year_month%>">
</form><br>
<%	}%>
<TABLE border="3" bordercolor="#008080" class="ichiran" style="table-layout:fixed;">
<%	String sql = "";
	GroupDAO group = new GroupDAO();
	ArrayList list = group.selectTbl(sql);
	B_GroupMST grouptbl = new B_GroupMST();%>
<TR>
<%	int m = 1;
	int b=0;
	for(int j=0;j<=list.size() - 1;++j){
		grouptbl = (B_GroupMST)list.get(j);
		if(grouptbl.getGROUPnumber().equals("000") || grouptbl.getGROUPnumber().equals("800")) continue;
		if(m > 5){%>
</TR><TR>
<%	m = 1;}%>
<TD align="center" valign="top" class="ichiran" width="154">

<FONT class="ichiran"><strong><%= grouptbl.getGROUPname()%></strong><br>　</FONT>
<%//	String sql_2 = " where GROUPnumber='"+grouptbl.getGROUPnumber()+"' AND number !='"+ShainMST.getNumber()+"'";
String sql_2 = " where GROUPnumber='"+grouptbl.getGROUPnumber()+"'";
	SyouninshaDAO sdao = new SyouninshaDAO();
	ArrayList slist = sdao.selectTbl(sql_2);
	B_SyouninshaMST bsyounin = new B_SyouninshaMST();
	String login_id = ShainMST.getId();
	String login_mail = ShainMST.getMail();
	//String aaa=ShainMST.getSyounin_junban();
	
/*	ArrayList<B_SyouninshaMST> slist_sorted = new ArrayList<B_SyouninshaMST>();
	for(int i = 0; i < sort_index.length; i++){
		String target = sort_index[i];
		for(int k = 0; k < slist.size() ; k++){
			B_SyouninshaMST tmp = (B_SyouninshaMST)slist.get(k);
			// target と同じ社員番号をもつtmpをslist_sortedに追加
			if(target.equals(tmp.getNumber())){
				slist_sorted.add(tmp);
			}
		}
	}
	// 役職を持たない方を追加
	
	for(int i = 0; i < slist.size(); i++){
		B_SyouninshaMST tmp = (B_SyouninshaMST)slist.get(i);
		// sort_indexに社員番号が無い場合
		if(tmp.equals(sort_index)) {
			
		}else if(!tmp.equals(sort_index)) {
		}else{	
			slist_sorted.add(tmp);
		}
	}
	
	
	// 置き換え
	slist = slist_sorted;
	
	*/
	for(int i=0;i<=slist.size() - 1;++i){
		bsyounin = (B_SyouninshaMST)slist.get(i);
		b++;
		if(grouptbl.getGROUPnumber().equals(bsyounin.getGROUPnumber())){%>
	
<FORM method="post" action="MailSend_Gamen4.jsp" name="A<%=b %>" >
<INPUT TYPE="submit" VALUE="<%= bsyounin.getName() %>" NAME="shouninsha_name<%=b %>" class="ichiran" onClick="submit1(<%=b %>)">
<INPUT TYPE="hidden" NAME="iraisha_number" VALUE="<%= iraisha_number %>">
<INPUT TYPE="hidden" NAME="iraisha_year_month" VALUE="<%= iraisha_year_month %>">
<INPUT TYPE="hidden" NAME="iraisha_mail" VALUE="<%= login_mail %>">
<INPUT TYPE="hidden" NAME="shouninsha_mail" VALUE="<%= bsyounin.getMail() %>">
<INPUT TYPE="hidden" NAME="shouninsha_name" VALUE="<%= bsyounin.getName() %>">
<INPUT TYPE="hidden" NAME="shouninsha_number" VALUE="<%= bsyounin.getNumber() %>">
<INPUT TYPE="hidden" NAME="body" VALUE="　<%= bsyounin.getName() %>さんへ  勤務報告書の承認をお願いします。<%= ShainMST.getName() %>より http://www.lucentsquare.co.jp:8080/kk_web/Menu_Gamen.jsp"/>
</FORM>
	
	<%	}
		}%>

</TD>
<%m++;}
%>
<form name="aa">
<input type="hidden" name="shouninsyasuu" value="<%=b %>">
</form>
</TR>
</TABLE><br>
<a href="Menu_Gamen.jsp" class="link"><font class="link"><small>[ メニューへ戻る ]</small></font></a>
</center>
</body>
</html>
<%}%>	