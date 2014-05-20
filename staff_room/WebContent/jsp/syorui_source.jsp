<%@ page contentType="text/html; charset=UTF-8"
          import="java.io.*,java.util.*,java.text.*;" %>

<!-- 変更等届書類の表を出力するためのJSP --> 
<%File syorui = new File(application.getRealPath(File.separator+"html"));//使用するフォルダの場所を指定
String filelist[] = syorui.list();//String型の配列にファイル名を入れる
File[] filedate=syorui.listFiles();//File型の配列にファイル名を入れる
for (int i = 0 ; i < filelist.length ; i++){
/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/	
	long lastModifytime = filedate[i].lastModified();
	 Date date = new Date(lastModifytime);
	 DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ",new Locale("ja", "JP", "JP"));
%>
<tr>
    <td><not><%if(i==filelist.length/2)%>変更等届書類</not></td><!-- ファイル数の半分の時にのみ出力 -->
 	<td><%=format.format(date)%></td><!-- フォーマットを変換した 更新日時を出力　-->
    <td><a href="../html/<%=filelist[i]%>"><%=filelist[i]%></a></td><!-- String型のファイル名を出力 -->
</tr>
 <%}%>
 
<!-- 申請書類の表を出力するためのJSP -->  
<%File syorui2 = new File(application.getRealPath(File.separator+"fonts"));//使用するフォルダの場所を指定
String filelist2[] = syorui2.list();//String型の配列にファイル名を入れる
File[] filedate2=syorui2.listFiles();//File型の配列にファイル名を入れる
for (int i = 0 ; i < filelist2.length ; i++){
/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/	
	long lastModifytime2 = filedate2[i].lastModified();
	 Date date2 = new Date(lastModifytime2);
	 DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ",new Locale("ja", "JP", "JP"));
%>
<tr>
    <td><not><%if(i==filelist2.length/2)%>申請書類</not></td>
 	<td><%=format.format(date2)%></td><!-- フォーマットを変換した 更新日時を出力　-->
    <td><a href="../fonts/<%=filelist2[i]%>"><%=filelist2[i]%></a></td><!-- String型のファイル名を出力 -->
</tr>
 <%}%>
 
<!-- 金銭に関する書類の表を出力するためのJSP --> 
<%File syorui3 = new File(application.getRealPath(File.separator+"css"));//使用するフォルダの場所を指定
String filelist3[] = syorui3.list();//String型の配列にファイル名を入れる
File[] filedate3=syorui3.listFiles();//File型の配列にファイル名を入れる
for (int i = 0 ; i < filelist3.length ; i++){
/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/	
	long lastModifytime3 = filedate3[i].lastModified();
	 Date date3 = new Date(lastModifytime3);
	 DateFormat format = new SimpleDateFormat("GGGGyy年 MMMM d日 ",new Locale("ja", "JP", "JP"));
%>
<tr>
    <td><not><%if(i==filelist3.length/2)%>金銭に関する書類</not></td>
 	<td><%=format.format(date3)%></td><!-- フォーマットを変換した 更新日時を出力　-->
    <td><a href="../css/<%=filelist3[i]%>"><%=filelist3[i]%></a></td><!-- String型のファイル名を出力 -->
</tr>
 <%}%>