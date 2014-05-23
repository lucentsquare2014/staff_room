<%@ page contentType="text/html; charset=UTF-8"
	import="java.io.File,java.text.DateFormat,
            java.text.SimpleDateFormat,
            java.util.Date,
            java.util.Locale,java.net.URLDecoder,java.net.URLEncoder"%>
<%
	File folder = new File(application.getRealPath(File.separator + "jsp"));//使用するフォルダの場所を指定
	String filename[] = folder.list();//String型の配列にファイル名を入れる
	File[] filedate = folder.listFiles();//File型の配列にファイル名を入れる
	for (int i = 0; i < filename.length; i++) {
		/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/
		long lastModifytime = filedate[i].lastModified();
		Date date = new Date(lastModifytime);
		DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ",new Locale("ja", "JP", "JP"));
%>
<tr>
	<!-- フォーマットを変換した 更新日時を出力　-->
	<td class="uk-text-center"><%=format.format(date)%></td>
	
	<!-- String型のファイル名を出力 -->
	<td class="uk-text-center"><a href="../jsp/<%=filename[i]%>"><%=filename[i]%></a></td>
</tr>
<%}%>