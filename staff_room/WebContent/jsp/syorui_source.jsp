<%@ page contentType="text/html; charset=UTF-8"
	import="java.io.*,java.util.*,java.text.*;"%>

<%
	File syorui = new File(application.getRealPath(File.separator+"syorui_test"));//使用する親フォルダの場所を指定
	String filelist[] = syorui.list();//String型の配列にファイル名を入れる
	for (int i = 0; i < filelist.length; i++) {
		File syorui1 = new File(application.getRealPath(File.separator+"syorui_test"+File.separator+filelist[i]));//使用するフォルダの場所を指定
		String filelist1[] = syorui1.list();//String型の配列にファイル名を入れる
		File[] filedate = syorui1.listFiles();//File型の配列にファイル名を入れる
		for (int x = 0; x < filelist1.length; x++) {
			/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/
			long lastModifytime = filedate[x].lastModified();
			Date date = new Date(lastModifytime);
			DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ", new Locale("ja", "JP", "JP"));
%>
<tr>
	<td><not> <%if (x == filelist1.length / 2)%><%=filelist[i]%></not></td><!-- ファイル数の半分の時にのみ出力 -->
	<td><%=format.format(date)%></td><!-- フォーマットを変換した 更新日時を出力-->
	<td><a href="../syorui_test/<%=filelist[i]%>/<%=filelist1[x]%>"><%=filelist1[x]%></a></td><!-- String型のファイル名を出力 -->
</tr>
<%
	}}
%>