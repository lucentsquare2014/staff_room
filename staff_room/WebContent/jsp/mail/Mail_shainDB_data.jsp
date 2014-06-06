<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

		//配列
		ArrayList<Integer> x = new ArrayList<Integer>();
		ShainDB dao = new ShainDB();
		ArrayList<HashMap<String, String>> list = null;
	
		dao.ShainDB("select mail, from where name = "
		+ value + " order by  " );
		ArrayList<HashMap<String, String>> name = null;
		name = dao.ShainDB("select postname from id where name =" + value);
		System.out.print(name);
		HashMap<String, String> raw = name.get(0);
			%>


	HashMap<String, String> row = list.get(i);
				%>
				<tr>
				<td class="uk-h3 uk-width-medium-3-10 uk-text-center"><%=row.get("ShainDB")%>&nbsp;</td>
				<td class="uk-h3 uk-width-medium-7-10 uk-text-left">
				<!--記事のタイトルなどを表示-->
					
					<%if (!row.get("filename").equals("")){ %>
                    	<div id="my-id<%=i%>" class="uk-h2 uk-text-left uk-hidden">
                    		<pre><%= row.get("text") %><br><br>添付ファイル：<br><%String arr[] = row.get("filename").split( "," );for (int f = 0; f<arr.length; f++){%>
                    			<a href=""><%out.println(arr[f]);%></a><%}%></pre></div>
					<%}else{ %>

		</table>
		<!-- 次へボタン、戻るボタンの処理　 -->
		<div class="uk-grid" style="padding-bottom: 50px;">
			<div class="uk-width-1-2 page-prev uk-text-large uk-text-left"
				style="<%if (page_num.equals("1")) {
				out.print("display: none;");
				}%>">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) - 1%>&news_id=<%=value2%>">&lt;&lt;前へ</a></span>
			</div>
			<div class="uk-width-1-2 page-next uk-text-large uk-text-right"
				style="<%if (list.size() < 10) {
				out.print("display: none;");
			}%>%">
				<span><a
					href="/staff_room/jsp/news.jsp?page=<%=Integer.parseInt(page_num) + 1%>&news_id=<%=value2%>">次へ&gt;&gt;</a></span>
			</div>
		</div>
</div></div></div></div>
</body>
</html>