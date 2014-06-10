<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*,java.util.Date,java.util.Calendar,java.io.*,java.text.* , java.util.Vector" %>
<%!
// 文字エンコードを行います。
public String strEncode(String strVal) throws UnsupportedEncodingException{
	if(strVal==null){
		return (null);
	}
	else{
		return (new String(strVal.getBytes("UTF-8"),"UTF-8"));
	}
}
%>
<%
/* 修正点 */
// 06-06-14 削除ボタンを押した際に、共有者じゃない人の予定を、削除してしまうことがあるのを修正
// 02-09-20 共有者の追加・削除を行うファイルとして作成

// ログインしたユーザの社員番号を変数[ID]に格納
String ID = strEncode(request.getParameter("id"));

// パラメータの取得[共用パラメータ]
String NO = request.getParameter("no");
String DA = strEncode(request.getParameter("s_date"));
String GR = request.getParameter("group");

// パラメータの取得[pubs使用]
String ST = strEncode(request.getParameter("s_start"));
String BS = strEncode(request.getParameter("b_start"));
String AC = strEncode(request.getParameter("act"));

// 表示の種類を判別するパラメータ
String KD = request.getParameter("kind");

%>
<html>
<head><title>エラー</title></head>
<body BGCOLOR="#99A5FF">
<%

// JDBCドライバのロード
Class.forName("org.postgresql.Driver");

// ユーザ認証情報の設定
String user = "georgir";
String password = "georgir";

// Connectionオブジェクトの生成
Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir",user,password);

// Statementオブジェクトの生成
Statement stmt = con.createStatement();

/* 同グループであるかを比較するために使用する */
// SQL実行・グループ情報[本人]
ResultSet GROUPID = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + ID + "'");

// 初期化を行っている
String group_id = "";

while(GROUPID.next()){
	group_id = GROUPID.getString("K_GRUNO");
}

GROUPID.close();

// SQL実行・グループ情報[他のユーザ]
ResultSet GROUPNO = stmt.executeQuery("SELECT * FROM KINMU.KOJIN WHERE K_ID = '" + NO + "'");

String group_no = "";

while(GROUPNO.next()){
	group_no = GROUPNO.getString("K_GRUNO");
}

GROUPNO.close();

/* 追加リスト処理 ここから */

// 重複チェック用flag
boolean check = false;

// 共有者の削除とスケジュールの削除が行われた時に切り替わるflag
boolean MWD = false;

if(AC.equals("追加") && (group_id.equals(group_no) || group_id.equals("900"))){
	String[] addlist = request.getParameterValues("add");
	if(ID.equals(NO)){
		if((addlist != null) && (addlist[0].length() != 0)){
			for(int i = 0; i < addlist.length; i++){
				// 選択された項目に本人が含まれていたら、エラーとする。
				if(addlist[i].equals(ID)){
					%>
					<jsp:forward page="error.jsp">
					<jsp:param name="flag" value="2" />
					</jsp:forward>
					<%
				}else{
					// 重複チェック用SQLの実行
					ResultSet CHECK = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_社員NO = '" + addlist[i] + "' AND K_社員NO2 = '" + ID + "' AND KY_FLAG = '0'");
					
					while(CHECK.next()){
						check = true;
					}
					
					CHECK.close();
					
					if(!check){
						stmt.execute("INSERT INTO KY_TABLE(K_社員NO,K_社員NO2,KY_FLAG) VALUES('" + addlist[i] + "','" + ID + "','0')");
					}
				}
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}else{
		if((addlist != null) && (addlist[0].length() != 0)){
			for(int i = 0; i < addlist.length; i++){
				// 選択された項目に本人が含まれていたら、エラーとする。
				if(addlist[i].equals(NO)){
					%>
					<jsp:forward page="error.jsp">
					<jsp:param name="flag" value="2" />
					</jsp:forward>
					<%
				}else{
					// 重複チェック用SQLの実行
					ResultSet CHECK = stmt.executeQuery("SELECT * FROM KY_TABLE WHERE K_社員NO = '" + addlist[i] + "' AND K_社員NO2 = '" + NO + "' AND KY_FLAG = '0'");
					
					while(CHECK.next()){
						check = true;
					}
					
					CHECK.close();
					
					if(!check){
						stmt.execute("INSERT INTO KY_TABLE(K_社員NO,K_社員NO2,KY_FLAG) VALUES('" + addlist[i] + "','" + NO + "','0')");
					}
				}
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}
	if(KD.equals("Month")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Month-u")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Month-b")){
		%>
		<script>
		<!--
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week-u")){
		%>
		<script>
		<!--
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Week-b")){
		%>
		<script>
		<!--
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day-u")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}else if(KD.equals("Day-b")){
		%>
		<script>
		<!--
			parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
			parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
		//-->
		</script>
		<%
	}
}
/* 追加リスト処理 ここまで */

/* 削除リスト処理 ここから */
else if(AC.equals("削除") && (group_id.equals(group_no) || group_id.equals("900"))){
	String[] dellist = request.getParameterValues("del");
	if(ID.equals(NO)){
		if((dellist != null) && (dellist[0].length() != 0)){
			for(int i = 0; i < dellist.length; i++){
				stmt.execute("DELETE FROM KY_TABLE WHERE (K_社員NO = '" + dellist[i] + "' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "')) AND KY_FLAG = '1') OR (K_社員NO = '" + dellist[i] + "' AND KY_FLAG = '0')");
				if(!ST.equals("")){
					MWD = true;
					stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + dellist[i] + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "' AND S_TOUROKU = '0' ");
				}else if(!BS.equals("")){
					MWD = true;
					stmt.execute("DELETE FROM B_TABLE WHERE K_社員NO = '" + dellist[i] + "' AND B_START = '" + BS + "' AND B_TOUROKU = '0' ");
				}
			}
			if(MWD && KD.equals("Month")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-u")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-b")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-u")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-b")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-u")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-b")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}else{
		if((dellist != null) && (dellist[0].length() != 0)){
			for(int i = 0; i < dellist.length; i++){
				stmt.execute("DELETE FROM KY_TABLE WHERE (K_社員NO = '" + dellist[i] + "' AND ((S_DATE = '" + DA + "' AND S_START = '" + ST + "') OR (B_START = '" + BS + "')) AND KY_FLAG = '1') OR (K_社員NO = '" + dellist[i] + "' AND KY_FLAG = '0')");
				if(!ST.equals("")){
					stmt.execute("DELETE FROM S_TABLE WHERE GO_社員NO = '" + dellist[i] + "' AND S_DATE = '" + DA + "' AND S_START = '" + ST + "' AND S_TOUROKU = '0' ");
				}else if(!BS.equals("")){
					stmt.execute("DELETE FROM B_TABLE WHERE K_社員NO = '" + dellist[i] + "' AND B_START = '" + BS + "' AND B_TOUROKU = '0' ");
				}
			}
			if(MWD && KD.equals("Month")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-u")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Month-b")){
				%>
				<script>
				<!--
					parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-u")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Week-b")){
				%>
				<script>
				<!--
					parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-u")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
					parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}else if(MWD && KD.equals("Day-b")){
				%>
				<script>
				<!--
					parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= BS %>&group=<%= GR %>';
					parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
				//-->
				</script>
				<%
			}
		}else{
			%>
			<jsp:forward page="error.jsp">
			<jsp:param name="flag" value="0" />
			</jsp:forward>
			<%
		}
	}
}
/* 削除リスト処理 ここまで */

else{
	%>
	<jsp:forward page="error.jsp">
	<jsp:param name="flag" value="5" />
	</jsp:forward>
	<%
}

if(check){
	%>
	<jsp:forward page="error.jsp">
	<jsp:param name="flag" value="1" />
	</jsp:forward>
	<%
}

if(KD.equals("Month")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Month-u")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Month-b")){
	%>
	<script>
	<!--
		parent.main.location.href='tryagain.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week-u")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Week-b")){
	%>
	<script>
	<!--
		parent.main.location.href='TestExample34.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeIn.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day-u")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='timeUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}else if(KD.equals("Day-b")){
	%>
	<script>
	<!--
		parent.main.location.href='h_hyoji.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&group=<%= GR %>';
		parent.sub02.location.href='dayUp.jsp?id=<%= ID %>&no=<%= NO %>&s_date=<%= DA %>&s_start=<%= ST %>&b_start=<%= BS %>&group=<%= GR %>&kind=<%= KD %>&act=';
	//-->
	</script>
	<%
}
%>
</body>
</html>