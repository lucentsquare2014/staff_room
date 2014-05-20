<%@ page contentType="text/html; charset=UTF-8"
          import="java.io.*,java.util.*,java.text.*;" %>
<%
File syorui = new File(application.getRealPath(File.separator+"jsp"));//使用するフォルダの場所を指定
out.println(File.separator);
String filelist[] = syorui.list();//String型の配列にファイル名を入れる
File[] filedate=syorui.listFiles();//File型の配列にファイル名を入れる
for (int i = 0 ; i < filelist.length ; i++){
/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/	
	long lastModifytime = filedate[i].lastModified();
	 Date date = new Date(lastModifytime);
	 DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ",new Locale("ja", "JP", "JP"));
%>
<tr>
 	<td><%=format.format(date)%></td><!-- フォーマットを変換した 更新日時を出力　-->
    <td><a href="../jsp/<%=filelist[i]%>"><%=filelist[i]%></a></td><!-- String型のファイル名を出力 -->
</tr>
 <% } %>
 