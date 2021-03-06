<%@ page contentType="text/html; charset=UTF-8"
	import="java.io.File,java.text.DateFormat,
            java.text.SimpleDateFormat,
            java.util.Date,
            java.util.Locale,java.net.URLDecoder,java.net.URLEncoder"%>
<% String user2 = String.valueOf(session.getAttribute("admin")); %>
<%
	File base_folder = new File(application.getRealPath(File.separator + "Docs"));//使用する親フォルダの場所を指定
	if(!base_folder.exists()){
		base_folder.mkdirs();
	}
	String foldername[] = base_folder.list();//String型の配列にファイル名を入れる
	for (int i = 0; i < foldername.length; i++) {
		File folder = new File(application.getRealPath(File.separator + "Docs" + File.separator + foldername[i]));//使用する子フォルダの場所を指定
		String filename[] = folder.list();//String型の配列にファイル名を入れる
		if(folder.list()==null){
			filename= new String[0];
		}
		File[] filedate = folder.listFiles();//File型の配列にファイル名を入れる
		for (int x = 0; x < filename.length; x++) {
			/**File型のファイルの更新日時をlastModified()メソッドで取得し、long型に変換後、Date型として指定しフォーマットを変換*/
			long lastModifytime = filedate[x].lastModified();
			Date date = new Date(lastModifytime);
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			DateFormat dddate = new SimpleDateFormat("yyyy/MM/dd ",new Locale("JP", "JP", "JP"));
%>
<tr class="uk-text-center">
	<!-- -----------管理者用チェックボックス作成----------- -->
	<% if(user2.equals("1")){%>
	<td class="coL1" ><input type="checkbox" name="aa" value="<%=foldername[i]%>/<%=filename[x]%>"></td>
	<%}%>

	<!-- ファイル数の半分の時にのみ出力 -->
	<%if (x == 0) {%>
	<td  id="type"rowspan=<%=filename.length%> class="coL2 uk-text-middle uk-text-left uk-text-bold"><%=foldername[i]%></td>
	<%}%>

	<!-- フォーマットを変換した 更新日時を出力-->
	<td class="coL3"  id="time"><%=dddate.format(date)%></td>

	<!-- String型のファイル名を出力 -->
	<td  class="coL4 uk-text-left" id="filename">
		<a href="/staff_room/Docs/<%=foldername[i]%>/<%=filename[x]%>"><%=filename[x]%></a>
		<% if(user2.equals("1")){%>
		&nbsp;
		<i class="uk-icon-edit" id="edit" data-uk-modal="{target:'#edit_form'}"></i>
		<% } %>
	</td>
</tr>
<%}}%>