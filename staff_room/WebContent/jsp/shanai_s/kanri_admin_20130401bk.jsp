<%@ page contentType="text/html; charset=Shift_JIS" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.util.Date,java.text.*,java.lang.*" %>
<%!
// �����G���R�[�h���s���܂��B
	public String strEncode(String strVal) throws UnsupportedEncodingException{
			if(strVal==null){
				return (null);
			}
			else{
				return (new String(strVal.getBytes("8859_1"),"Shift_JIS"));
			}
	}
%>
<%
	//sql������
	String table_select = "";
	String sql_select = "";
	String sql = "";
	String teishi_flg = "0";
	
	if(request.getParameter("table_select") != null && !request.getParameter("table_select").equals("")){
		table_select = request.getParameter("table_select");
	}else{
		table_select = "";
	}
	if(request.getParameter("sql_select") != null && !request.getParameter("sql_select").equals("")){
		sql_select = request.getParameter("sql_select");
	}else{
		sql_select = "";
	}
	String inpPassword = request.getParameter("pass");

	// JDBC�h���C�o�̃��[�h
	Class.forName("org.postgresql.Driver");

	// �f�[�^�x�[�X�֐ڑ�
	//String user = "kinmu";     // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃��[�U��
	//String password = "kinmu"; // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃p�X���[�h
	String user = "georgir";     // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃��[�U��
	String password = "georgir"; // �f�[�^�x�[�X�ɃA�N�Z�X���邽�߂̃p�X���[�h


	Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.101.26:5432/georgir", user, password);
	Statement stmt = con.createStatement();
	Statement upData = con.createStatement();

	//�O���[�v
	ResultSet rs = stmt.executeQuery(" select * from GRU order by G_GRUNO");
	//ResultSet rs = stmt.executeQuery(" select * from kinmu.GRU order by G_GRUNO");

	String[][] group = new String[2][200];
	int group_count = 0;
	while(rs.next()){
		group[0][group_count] = rs.getString("G_GRUNO");
		group[1][group_count] = rs.getString("G_GRNAME");
		group_count++;
	}

	rs = stmt.executeQuery("select * from KOJIN order by K_PASS2,K_�Ј�NO");
	//rs = stmt.executeQuery("select * from kinmu.KOJIN order by K_PASS2,K_�Ј�NO");
	String[][] kojin = new String[7][500];
	int kojin_count = 0;
	while(rs.next()){
		kojin[0][kojin_count] = rs.getString("K_�Ј�NO");	
		kojin[1][kojin_count] = rs.getString("K_���FLV");	
		kojin[2][kojin_count] = rs.getString("K_ID");	
		kojin[3][kojin_count] = rs.getString("K_PASS");	
		kojin[4][kojin_count] = rs.getString("K_����");	
		kojin[5][kojin_count] = rs.getString("K_GRUNO");	
		kojin[6][kojin_count] = rs.getString("K_MAIL");
		kojin_count++;
	}

	//�\��
	//rs = stmt.executeQuery("select * from YOTEI order by ����");
	rs = stmt.executeQuery("select * from kinmu.YOTEI order by ����");
	String[][] yotei = new String[3][200];
	int[][] junban = new int[50][2];
	int tenji_junban = 0;
	int sup_junban = 1;
	String sw_junban = "1";
	String sup_kubun = "1";
	int yotei_count = 0;
	while(rs.next()){
		yotei[0][yotei_count] = rs.getString("�敪");	
		yotei[1][yotei_count] = rs.getString("�ꏊ");	
		yotei[2][yotei_count] = rs.getString("����");
		while(sw_junban.equals("1") || sup_junban == 50){
			if(Integer.parseInt(yotei[2][yotei_count]) == sup_junban){
				sw_junban = "0";
				sup_junban++;
			}else{
				junban[tenji_junban][0] = Integer.parseInt(sup_kubun);
				junban[tenji_junban][1] = sup_junban;
				sup_junban++;
				tenji_junban++;
			}
		}
		sup_kubun = yotei[0][yotei_count].trim();
		sw_junban = "1";
		yotei_count++;
	}
	if(sup_junban < 50){
		for(int g = sup_junban;g < 51;g++){
			tenji_junban++;
			junban[tenji_junban][0] = 2;
			junban[tenji_junban][1] = g;
		}
	}
	
	if(table_select.equals("holiday")){
		String select_year = request.getParameter("year");
		String[] shuku_name = new String[21];
		String[] shuku_day = new String[21];
		String sup_day = "";
		int intYear = Integer.parseInt(select_year);
		int a_count = 0;
		Calendar cal = null;
		
		// ���U
		shuku_day[a_count] = select_year + "0101";
		shuku_name[a_count] = "���U";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,0,1);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "0102";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// ���l�̓�
		
		// ��2���j���ɂȂ肤����͂W?�P�S���Ȃ̂ŁA�W?�P�S���ԂŌ��j���̓������l�̓��ƂȂ�
		for(int n = 8;n <= 14;n++){
			cal = new GregorianCalendar(intYear,0,n);
			if(cal.get(cal.DAY_OF_WEEK) == 2){
				if(n < 10){
					sup_day = "0" + Integer.toString(n);
			  	}else{
				  	sup_day = Integer.toString(n);
			  	}
				shuku_day[a_count] = select_year + "01" + sup_day;
				shuku_name[a_count] = "���l�̓�";			  
				a_count++;
				break;
		  }
		}
		
		// �����L�O��
		shuku_day[a_count] = select_year + "0211";
		shuku_name[a_count] = "�����L�O��";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,1,11);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "0212";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// �t���̓�
		sup_day = Long.toString(Math.round(20.8431+0.242194*(intYear-1980) - (intYear-1980)/4 - 0.5));
		shuku_day[a_count] = select_year + "03" + sup_day;
		shuku_name[a_count] = "�t���̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,2,Integer.parseInt(sup_day));
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "03" + Integer.toString(Integer.parseInt(sup_day) + 1);
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// �݂ǂ�̓�
		shuku_day[a_count] = select_year + "0429";
		shuku_name[a_count] = "�݂ǂ�̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,3,29);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "0430";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;

		// ���@�L�O��
		shuku_day[a_count] = select_year + "0503";
		shuku_name[a_count] = "���@�L�O��";
		a_count++;
		
		// �����̋x��
		shuku_day[a_count] = select_year + "0504";
		shuku_name[a_count] = "�����̋x��";
		a_count++;
		
		// ���ǂ��̓�
		shuku_day[a_count] = select_year + "0505";
		shuku_name[a_count] = "���ǂ��̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,4,5);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "0506";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;

		
		// �C�̓�
		  // ��R���j���̏ꍇ
		  // ��R���j���ɂȂ肤����͂P�T?�Q�P���Ȃ̂ŁA�P�T?�Q�P���ԂŌ��j���̓����C�̓��ƂȂ�
		for(int n = 15;n <= 21;n++){
			cal = new GregorianCalendar(intYear,6,n);
			if(cal.get(cal.DAY_OF_WEEK) == 2){
				sup_day = Integer.toString(n);
				shuku_day[a_count] = select_year + "07" + sup_day;
				shuku_name[a_count] = "�C�̓�";			  
				a_count++;
				break;
			}
		}
		
		// �h�V�̓�
		// 2003�N����͑�R���j���ƂȂ�
		  // ��R���j���̏ꍇ
		  // ��R���j���ɂȂ肤����͂P�T?�Q�P���Ȃ̂ŁA�P�T?�Q�P���ԂŌ��j���̓����h�V�̓��ƂȂ�
		for(int n = 15;n <= 21;n++){
			cal = new GregorianCalendar(intYear,8,n);
			if(cal.get(cal.DAY_OF_WEEK) == 2){
				sup_day = Integer.toString(n);
				shuku_day[a_count] = select_year + "09" + sup_day;
				shuku_name[a_count] = "�h�V�̓�";			  
				a_count++;
				break;
			}
		}
		
		
		// �H���̓�
		sup_day = Long.toString(Math.round(23.2488+0.242194*(intYear-1980) - (intYear-1980)/4 - 0.5));
		shuku_day[a_count] = select_year + "09" + sup_day;
		shuku_name[a_count] = "�H���̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,8,Integer.parseInt(sup_day));
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "09" + Integer.toString(Integer.parseInt(sup_day) + 1);
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// �̈�̓�
		
		// ��2���j���ɂȂ肤����͂W?�P�S���Ȃ̂ŁA�W?�P�S���ԂŌ��j���̓����̈�̓��ƂȂ�
		for(int n = 8;n <= 14;n++){
			cal = new GregorianCalendar(intYear,9,n);
			if(cal.get(cal.DAY_OF_WEEK) == 2){
				if(n < 10){
					sup_day = "0" + Integer.toString(n);
			  	}else{
				  	sup_day = Integer.toString(n);
			  	}
				shuku_day[a_count] = select_year + "10" + sup_day;
				shuku_name[a_count] = "�̈�̓�";			  
				a_count++;
				break;
		  }
		}
				
		// �����̓�
		shuku_day[a_count] = select_year + "1103";
		shuku_name[a_count] = "�����̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,10,3);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "1104";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// �ΘJ���ӂ̓�
		shuku_day[a_count] = select_year + "1123";
		shuku_name[a_count] = "�ΘJ���ӂ̓�";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,10,23);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "1124";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		// �V�c�a����
		shuku_day[a_count] = select_year + "1223";
		shuku_name[a_count] = "�V�c�a����";
		// �j���𒲂ׂ�
		cal = new GregorianCalendar(intYear,10,23);
		if(cal.get(cal.DAY_OF_WEEK) == 1){
			a_count++;
			shuku_day[a_count] = select_year + "1224";
			shuku_name[a_count] = "�U�֋x��";
		}
		a_count++;
		
		for(int w = 0;w < a_count;w++){
			sql = "insert into HOLIDAY values('" + shuku_day[w] + "','" + shuku_name[w] + "')";
			upData.execute(sql);
		}
	}
	
	if(table_select.equals("user")){
		if(sql_select.equals("ins")){
			String k_lv = "";
			if((request.getParameter("ex1") == null || request.getParameter("ex1").equals("")) 
					&& (request.getParameter("ex2") == null || request.getParameter("ex2").equals(""))){
				k_lv = "0";				
			}else if(request.getParameter("ex1").equals("on")){
				k_lv = "1";
			}else if(request.getParameter("ex1").equals("on")){
				k_lv = "2";
			}
			String k_no = "";
			String k_id = "";
			String k_pass = "";
			String k_name = "";
			String k_gruno = "";
			String k_mail = "";

			if((request.getParameter("number") == null || request.getParameter("number").equals(""))
					|| (request.getParameter("usrid") == null || request.getParameter("usrid").equals(""))
					|| (request.getParameter("usrpw") == null || request.getParameter("usrpw").equals(""))
					|| (request.getParameter("usrname") == null || request.getParameter("usrname").equals(""))
					|| (request.getParameter("group") == null || request.getParameter("group").equals(""))
					|| (request.getParameter("mail") == null || request.getParameter("mail").equals(""))){
				teishi_flg = "2";
			}else{
				k_no = request.getParameter("number");
				k_id = request.getParameter("usrid");
				k_pass = request.getParameter("usrpw");
				k_name = strEncode(request.getParameter("usrname"));
				k_gruno = request.getParameter("group");
				k_mail = request.getParameter("mail");
			}
			if(teishi_flg.equals("0")){
				for(int u = 0;u < kojin_count;u++){
						if(kojin[0][u].equals(k_no)){
							teishi_flg = "3";
						}
						if(kojin[4][u].equals(k_name)){
							teishi_flg = "4";
						}
						if(kojin[2][u].equals(k_id)){
							teishi_flg = "5";
						}
						if(kojin[3][u].equals(k_pass)){
							teishi_flg = "6";
						}
				}
			}
			if(teishi_flg.equals("0")){
				sql = "insert into KOJIN(K_�Ј�No,K_���FLV,K_ID,K_PASS,K_����,K_GRUNo,K_MAIL) values('" + k_no + "','" + k_lv + "','" + k_id + "','" + k_pass + "','" + k_name + "','" + k_gruno + "','" + k_mail + "')";
			}
		}else if(sql_select.equals("del")){
			String k_no = request.getParameter("user_del");
			sql = "delete from KOJIN where K_�Ј�NO='" + k_no + "'";
		}else if(sql_select.equals("upd")){
			String k_lv = "";
			if((request.getParameter("ex1") == null || request.getParameter("ex1").equals("")) 
					&& (request.getParameter("ex2") == null || request.getParameter("ex2").equals(""))){
				k_lv = "0";				
			}else if(request.getParameter("ex1").equals("on")){
				k_lv = "1";
			}else if(request.getParameter("ex1").equals("on")){
				k_lv = "2";
			}
			String k_no = "";
			String k_id = "";
			String k_pass = "";
			String k_name = "";
			String k_gruno = "";
			String k_mail = "";

			if(request.getParameter("new_id") == null || request.getParameter("new_id").equals("")){
				teishi_flg = "7";
			}else if(request.getParameter("new_pw") == null || request.getParameter("new_pw").equals("")){
				teishi_flg = "8";
			}else if(request.getParameter("new_name") == null || request.getParameter("new_name").equals("")){
				teishi_flg = "10";
			}else if(request.getParameter("new_mail") == null || request.getParameter("new_mail").equals("")){
				teishi_flg = "9";
			}else{
				k_no = request.getParameter("new_num");
				k_id = request.getParameter("new_id");
				k_pass = request.getParameter("new_pw");
				k_name = strEncode(request.getParameter("new_name"));
				k_gruno = request.getParameter("new_gr");
				k_mail = request.getParameter("new_mail");
			}
			if(teishi_flg.equals("0")){
				sql = "update KOJIN set K_���FLv='" + k_lv + "',K_ID='" + k_id + "',K_PASS='" + k_pass + "',K_����='" + k_name + "',K_GRUNo='" + k_gruno + "',K_MAIL='" + k_mail + "' where K_�Ј�NO='" + k_no + "'";
			}			
		}
	}
	if(table_select.equals("gru")){
		if(sql_select.equals("ins")){
			String g_code = "";
			String g_name = "";

			if((request.getParameter("gr_code") == null || request.getParameter("gr_code").equals(""))
					|| request.getParameter("gr_name") == null || request.getParameter("gr_name").equals("")){
				teishi_flg = "2";
			}else{
				g_code = request.getParameter("gr_code");
				g_name = strEncode(request.getParameter("gr_name"));
			}
			if(teishi_flg.equals("0")){
				for(int q = 0;q < group_count;q++){
						if(group[0][q].equals(g_code)){
							teishi_flg = "11";
						}
						if(group[1][q].equals(g_name)){
							teishi_flg = "12";
						}
				}
			}
			if(teishi_flg.equals("0")){
				sql = "insert into GRU values('" + g_code + "','" + g_name + "')";
			}
		}else if(sql_select.equals("del")){
			String g_code = request.getParameter("gr_num");
			sql = "delete from GRU where G_GRUNO='" + g_code + "'";
		}else if(sql_select.equals("upd")){
			String gr_num = "";
			String gr_name = "";

			if(request.getParameter("n_gr_name") == null || request.getParameter("n_gr_name").equals("")){
				teishi_flg = "13";
			}else if(request.getParameter("n_gr_num") == null || request.getParameter("n_gr_num").equals("")){
				teishi_flg = "14";
			}else{
				gr_name = strEncode(request.getParameter("n_gr_name"));
				gr_num = request.getParameter("n_gr_num");
			}
			if(teishi_flg.equals("0")){
				sql = "update GRU set G_GRUNO='" + gr_num + "',G_GRNAME='" + gr_name + "' where G_GRUNO='" + gr_num + "'";
			}			
		}
	}
	
	if(table_select.equals("yotei")){
		if(sql_select.equals("ins")){
			String y_kubun = "";
			String y_naiyou = "";
			String y_junban = "";
			
			if(request.getParameter("y_data") == null || request.getParameter("y_data").equals("")){
				teishi_flg = "2";
			}else{
				y_kubun = request.getParameter("kubun");
				y_naiyou = strEncode(request.getParameter("y_data"));
				if(y_kubun.equals("1")){
					y_junban = request.getParameter("y_junban");
				}else{
					y_junban = request.getParameter("b_junban");
				}
			}
			if(teishi_flg.equals("0")){
				sql = "insert into yotei values('" + y_kubun + "','" + y_naiyou + "','" + y_junban + "')";
			}
		}else if(sql_select.equals("del")){
			String y_kubun = request.getParameter("y_kubun");
			String y_naiyou = strEncode(request.getParameter("y_basyo"));
			sql = "delete from yotei where �敪='" + y_kubun + "' and �ꏊ='" + y_naiyou + "'";
		}
	}

	if(!table_select.equals("") && !table_select.equals("holiday") && teishi_flg.equals("0")){
		upData.execute(sql);
	}else if(!table_select.equals("") && !teishi_flg.equals("0")){
		// �ڑ�����
		rs.close();
		stmt.close();
		con.close();
%>
		//�G���[�y�[�W�ɔ��
		<jsp:forward page="kanri_error.jsp">
		<jsp:param name="error" value="<%= teishi_flg %>" />
		</jsp:forward>
<%
	}

	if(table_select.equals("gru") && teishi_flg.equals("0")){
		//�O���[�v
		//rs = stmt.executeQuery("select * from GRU order by G_GRUNO");
		rs = stmt.executeQuery("select * from kinmu.GRU order by G_GRUNO");
		group = new String[2][200];
		group_count = 0;
		while(rs.next()){
			group[0][group_count] = rs.getString("G_GRUNO");
			group[1][group_count] = rs.getString("G_GRNAME");
			group_count++;
		}
	}else if(table_select.equals("user") && teishi_flg.equals("0")){
		//rs = stmt.executeQuery("select * from KOJIN order by K_PASS2,K_�Ј�NO");
		rs = stmt.executeQuery("select * from kinmu.KOJIN order by K_PASS2,K_�Ј�NO");
		kojin = new String[7][500];
		kojin_count = 0;
		while(rs.next()){
			kojin[0][kojin_count] = rs.getString("K_�Ј�NO");	
			kojin[1][kojin_count] = rs.getString("K_���FLV");	
			kojin[2][kojin_count] = rs.getString("K_ID");	
			kojin[3][kojin_count] = rs.getString("K_PASS");	
			kojin[4][kojin_count] = rs.getString("K_����");	
			kojin[5][kojin_count] = rs.getString("K_GRUNO");	
			kojin[6][kojin_count] = rs.getString("K_MAIL");
			kojin_count++;
		}
	}else if(table_select.equals("yotei") && teishi_flg.equals("0")){
		//�\��
		//rs = stmt.executeQuery("select * from YOTEI order by ����");
		rs = stmt.executeQuery("select * from kinmu.YOTEI order by ����");
		yotei = new String[3][200];
		junban = new int[50][2];
		tenji_junban = 0;
		sup_junban = 1;
		sw_junban = "1";
		sup_kubun = "1";
		yotei_count = 0;
		while(rs.next()){
			yotei[0][yotei_count] = rs.getString("�敪");	
			yotei[1][yotei_count] = rs.getString("�ꏊ");	
			yotei[2][yotei_count] = rs.getString("����");
			while(sw_junban.equals("1") || sup_junban == 50){
				if(Integer.parseInt(yotei[2][yotei_count]) == sup_junban){
					sw_junban = "0";
					sup_junban++;
				}else{
					junban[tenji_junban][0] = Integer.parseInt(sup_kubun);
					junban[tenji_junban][1] = sup_junban;
					sup_junban++;
					tenji_junban++;
				}
			}
			sup_kubun = yotei[0][yotei_count].trim();
			sw_junban = "1";
			yotei_count++;
		}
		if(sup_junban < 50){
			for(int g = sup_junban;g < 51;g++){
				tenji_junban++;
				junban[tenji_junban][0] = 2;
				junban[tenji_junban][1] = g;
			}
		}
	}

	// �ڑ�����
	rs.close();
	stmt.close();
	con.close();
%>
<html>
<head>
	<meta HTTP-EQUIV=Content-Type CONTENT=text/html;Charset=Shift_Jis>
	<title>�Ǘ����</title>
	
	<script type="text/javascript"><!--
		function back_main() {
			document.MyForm.action = 'http://www.lucentsquare.co.jp/kinmu_db/top.html';
			document.MyForm.submit();
		}
		function back_main2() {
			document.MyForm2.action = 'http://www.lucentsquare.co.jp/kinmu_db/top.html';
			document.MyForm2.submit();
		}
		function back_main3() {
			document.MyForm3.action = 'http://www.lucentsquare.co.jp/kinmu_db/top.html';
			document.MyForm3.submit();
		}

		function jump(n) {
			location.hash=n;
		}
		
		function change_junban(val){
			if(val == 1){
				document.formYotei.b_junban.style.display = "none";				
				document.formYotei.y_junban.style.display = "block";
			}else{
				document.formYotei.b_junban.style.display = "block";				
				document.formYotei.y_junban.style.display = "none";				
			}
		}
	//--></script>
</head>
<body style="bgcolor:#F5F5F5;link:#000099;alink:00FFFF;vlink:000099">
<form NAME="MyForm">
	<input type="button" style="background-color:#FFFFFF;width:50" value="�߂�" onClick="location.href='http://www.lucentsquare.co.jp/kinmu_db/top.html'">
</form>

<center>
	<FORM action="kanri_admin.jsp" method="POST">
	<table>
		<tr>
			<td>
				<INPUT TYPE="button" STYLE="background-color:#FFFFFF;width:100" VALUE="���[�U�[�ꗗ" onClick="location.href='#USER'">
			</td>
			<TD>
				<INPUT TYPE="button" STYLE="background-color:#FFFFFF;width:100" VALUE="�O���[�v�o�^" onClick="location.href='#GROUP'">
			</TD>
			<td>
				<INPUT TYPE="button" STYLE="background-color:#FFFFFF;width:100" VALUE="�\��敪�o�^" onClick="location.href='#YOTEI'">
			</TD>
			<TD>
				<INPUT TYPE="hidden" NAME="action" VALUE="get_holiday">
				<INPUT TYPE="hidden" NAME="table_select" VALUE="holiday">
				<INPUT TYPE="hidden" NAME="sql_select" VALUE="ins">
				<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
				<INPUT TYPE="submit" VALUE="�j��" STYLE="background-color:#FFFFFF;width:100">
				<SELECT NAME="year">
<%
Calendar calendar = new GregorianCalendar();
Date trialtime = new Date();
calendar.setTime(trialtime);
int intTodayY = calendar.get(Calendar.YEAR);

for(int x = intTodayY;x <= intTodayY + 1;x++){
%>
					<OPTION VALUE=<%= x %>><%= x %></OPTION>
<%
}
%>
				</SELECT>
			</TD>
		</tr>
	</TABLE>
	</FORM>
</CENTER>

<HR SIZE="3" color="#000099">
	<TABLE STYLE="width:100%">
		<TR>
			<TH bgcolor="#000099">
				<FONT color="#FFFFFF"><B>1. ���[�U�[�o�^</B></FONT>
			</TH>
		</TR>
	</TABLE>

	<HR SIZE="3" color="000099">
		<CENTER>
			<TABLE>
				<TR>
					<TD>
						<SMALL>1.�Ǘ��҂̕��͐ӔC�������ĊǗ����ĉ������B</SMALL>
					</TD>
				</TR>
				<TR>
					<TD>
						<SMALL>2.���F���闧��̐l�́A���F�҂̗��Ƀ`�F�b�N���ĉ������B</SMALL>
					</TD>
				</TR>
			</TABLE>
			<BR><BR>

			<FORM action="kanri_admin.jsp" method="POST">
				<INPUT TYPE="hidden" NAME="action" VALUE="regist">
				<INPUT TYPE="hidden" NAME="table_select" VALUE="user">
				<INPUT TYPE="hidden" NAME="sql_select" VALUE="ins">
				<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
				<TABLE>
					<TR>
						<TD align="center">���F��</TD>
						<TD align="center" colspan="3">-�P<INPUT TYPE="checkbox" NAME="ex1">-�@�@-�Q<INPUT TYPE="checkbox" NAME="ex2">-</TD>
					</TR>
					<TR>
						<TD align="center">�h�@�c</TD>
						<TD align="center">
							<INPUT TYPE="text" NAME="usrid" SIZE="20">
						</TD>
						<TD align="center">Ұٱ��ڽ</TD>
						<TD align="center">
							<INPUT TYPE="text" SIZE="30" NAME="mail">
						</TD>
					</TR>
					<TR>
						<TD align="center">�߽ܰ��</TD>
						<TD align="center">
							<INPUT TYPE="text" NAME="usrpw" SIZE="20">
						</TD>
						<TD align="center">�Ј��ԍ�</TD>
						<TD align="left">
							<INPUT TYPE="text" SIZE="16" NAME="number" maxlength="20">
						</TD>
					</TR>
					<TR>
						<TD align="center">���@��</TD>
						<TD align="center">
							<INPUT TYPE="text" NAME="usrname" SIZE="20">
						</TD>
						<TD align="center">���@��</TD>
						<TD align="left">
							<SELECT NAME="group">
<%
for(int x = 1;x < group_count;x++){
%>
									<OPTION VALUE="<%= group[0][x] %>"><%= group[1][x] %></OPTION>
<%
}
%>
							</SELECT>
						</TD>
					</TR>
					<TR>
						<TD COLSPAN="4" align="center">
							<INPUT TYPE="submit" STYLE="background-color:#FFFFFF;width:50" VALUE="   �n�j   ">
							<INPUT TYPE="reset" STYLE="background-color:#FFFFFF;width:50" VALUE="�b��������">
						</TD>
					</TR>
				</TABLE>
			</FORM>
		</CENTER>
		
		<BR>
		<FORM NAME="MyForm2">
			<INPUT TYPE="button" STYLE="background-color:#FFFFFF;width:50" VALUE="�߂�" onClick="location.href='http://www.lucentsquare.co.jp/kinmu_db/top.html'">
		</FORM>

		<A NAME="USER"></A>

		<CENTER>
			<TABLE STYLE="width:100%">
				<TR>
					<TH bgcolor="#000099">
						<FONT color="#FFFFFF"><B>2. ���[�U�[�ꗗ�\ ��</B></FONT>
					</TH>
				</TR>
			</TABLE>

			<HR SIZE="3" color="000099">
					���� <B><%= kojin_count %></B>���̓o�^������܂�

				<TABLE border="1">
					<tr>
						<th STYLE="width:75" align="center">���O</th>
						<th align="center" NOWRAP>���F��</th>
						<th align="center">�ύX</th>
						<th align="center">�폜</th>
						<td></td>
						<th STYLE="width:75" align="center">���O</th>
						<th align="center" NOWRAP>���F��</th>
						<th align="center">�ύX</th>
						<th align="center">�폜</th>
						<td></td>
						<th STYLE="width:75" align="center">���O</th>
						<th align="center" NOWRAP>���F��</th>
						<th align="center">�ύX</th>
						<th align="center">�폜</th>
					</tr>
					<TR>
<%
	int row_count = 1;
	for(int y = 1;y < kojin_count;y++){
 	    if(row_count > 3) {
%>
 	    			</TR><TR>
<%
			row_count=1;
		}else if(row_count == 2){
%>
						<TD STYLE="width:5"></TD>
<%
		}else if(row_count == 3){
%>			
						<TD STYLE="width:5"></TD>
<%
		}else if(row_count == 1) {}
%>		
  						<TD align="center" STYLE="font-size:12"><%= kojin[4][y] %><BR></TD>
  						<TD align="center"><%= kojin[1][y] %><BR></TD>
						<FORM action="kanri_henkou.jsp" method="POST">
   							<TD>
								<INPUT TYPE="hidden" NAME="action" VALUE="kojin_change_gamen">
								<INPUT TYPE="hidden" NAME="table_select" VALUE="user">
								<INPUT TYPE="hidden" NAME="sql_select" VALUE="upd">
								<INPUT TYPE="hidden" NAME="number" VALUE="<%= kojin[0][y] %>">
								<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
								<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" VALUE="�ύX">
							</TD>
						</FORM>
						<FORM action="kanri_admin.jsp" method="POST">
							<TD NOWRAP>
								<INPUT TYPE="hidden" NAME="action" VALUE="user_del">
								<INPUT TYPE="hidden" NAME="table_select" VALUE="user">
								<INPUT TYPE="hidden" NAME="sql_select" VALUE="del">
								<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
								<INPUT TYPE="hidden" NAME="user_del" value="<%= kojin[0][y] %>">
								<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" value="�폜">
							</TD>
						</FORM>
<%
	row_count++;
  }
%>
					</TR>
				</TABLE>
		</CENTER>

		<form NAME="MyForm">
			<input type="button" style="background-color:#FFFFFF;width:50" value="�߂�" onClick="location.href='http://www.lucentsquare.co.jp/kinmu_db/top.html'">
		</form>


		<A NAME="GROUP"></A>

		<CENTER>
			<TABLE STYLE="width:100%">
				<TR>
					<TH bgcolor="#000099">
						<FONT color="#FFFFFF"><B>4. �O���[�v�o�^</B></FONT>
					</TH>
				</TR>
			</TABLE>

			<HR SIZE="3" color="000099">�O���[�v�o�^
			<FORM action="kanri_admin.jsp" method="POST">
				<TABLE>
					<TR>
						<TD>�O���[�v�R�[�h</TD>
						<TD>
							<INPUT TYPE="text" NAME="gr_code" SIZE="10">
						</TD>
					</TR>
					<TR>
						<TD>�O���[�v��</TD>
						<TD>
							<INPUT TYPE=text NAME="gr_name" SIZE="30">
						</TD>
					</TR>
				</TABLE>
				<INPUT TYPE="hidden" NAME="action" VALUE="gr_input">
				<INPUT TYPE="hidden" NAME="table_select" VALUE="gru">
				<INPUT TYPE="hidden" NAME="sql_select" VALUE="ins">
				<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
				<INPUT TYPE="submit" STYLE="background-color:#FFFFFF;width:50" VALUE="�o�^">
			</FORM>
			<BR>
			<TABLE border="1">
				<TR>
					<TD align="center"><B>�O���[�v�R�[�h</B></TD>
					<TD align="center"><B>�O���[�v��</B></TD>
					<TD COLSPAN="3" align="center"><B>Function</B></TD>
				</TR>
<%
	for(int z = 0;z < group_count;z++){
%>
  				<TR STYLE="font-size:12">
  					<TD align="center"><%= group[0][z] %></TD>
  					<TD align="center"><%= group[1][z] %></TD>
  					<FORM action="kanri_henkou.jsp" method="POST">
  						<TD>
  							<INPUT TYPE="hidden" NAME="gr_num" VALUE="<%= group[0][z] %>">
  							<INPUT TYPE="hidden" NAME="gr_name" VALUE="<%= group[1][z] %>">
  							<INPUT TYPE="hidden" NAME="action" VALUE="gr_change_gamen">
							<INPUT TYPE="hidden" NAME="table_select" VALUE="gru">
							<INPUT TYPE="hidden" NAME="sql_select" VALUE="upd">
  							<INPUT TYPE="hidden" NAME="pass" VALUE="<%=inpPassword %>">
  							<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" VALUE="�ύX">
  						</TD>
 				  	</FORM>
  					<FORM action="kanri_admin.jsp" method="POST">
   						<TD>
  							<INPUT TYPE="hidden" NAME="gr_num" VALUE="<%= group[0][z] %>">
  							<INPUT TYPE="hidden" NAME="gr_name" VALUE="<%= group[1][z] %>">
  							<INPUT TYPE="hidden" NAME="action" VALUE="gr_del">
  							<INPUT TYPE="hidden" NAME="table_select" VALUE="gru">
							<INPUT TYPE="hidden" NAME="sql_select" VALUE="del">
  							<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
  							<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" VALUE="�폜">
  						</TD>
   					</FORM>
  				</TR>
<%
  }
%>
			</TABLE>
		</center>
		<BR>
		
		<FORM NAME="MyForm2">
			<INPUT TYPE="button" STYLE="background-color:#FFFFFF;width:50" VALUE="�߂�" onClick="location.href='http://www.lucentsquare.co.jp/kinmu_db/top.html'">
		</FORM>
		
		<A NAME="YOTEI"></A>
		<CENTER>
			<TABLE STYLE="width:100%">
				<TR>
					<TH bgcolor="#000099">
						<FONT color="#FFFFFF"><B>5. �\��敪�o�^</B></FONT>
					</TH>
				</TR>
			</TABLE>

			<HR SIZE="3" color="000099">�\��敪�o�^
			<FORM action="kanri_admin.jsp" method="POST" name="formYotei">
				<TABLE>
					<TR>
						<TD>�敪</TD>
						<TD>
							<SELECT NAME="kubun" onChange="change_junban(this.value)" style="float:left">
								<OPTION VALUE="1">�\��</OPTION>
								<OPTION VALUE="2">�ꏊ</OPTION>
							</SELECT>
							<SELECT NAME="y_junban" style="display:block">
<%
	for(int o = 0;o < tenji_junban;o++){
		if(junban[o][0] == 1){
%>
								<OPTION VALUE="<%= junban[o][1] %>"><%= junban[o][1] %></OPTION>
<%
		}
	}
%>
							</SELECT>
							<select name="b_junban" style="display:none">
<%
	for(int d = 0;d < tenji_junban;d++){
		if(junban[d][0] == 2){
%>
								<OPTION VALUE="<%= junban[d][1] %>"><%= junban[d][1] %></OPTION>
<%
		}
	}
%>
							</SELECT>
						</TD>
					</TR>
					<TR>
						<TD>���e</TD>
						<TD>
							<INPUT TYPE="text" NAME="y_data" SIZE="30">
						</TD>
					</TR>
				</TABLE>
				<INPUT TYPE="hidden" NAME="table_select" VALUE="yotei">
				<INPUT TYPE="hidden" NAME="sql_select" VALUE="ins">
				<INPUT TYPE="hidden" NAME="action" VALUE="yotei_input">
				<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
				<INPUT TYPE="submit" STYLE="background-color:#FFFFFF;width:50" VALUE="�o�^">
			</FORM>
			<BR>

			<TABLE border="0">
				<TD valign="TOP">
					<TABLE border="1">
						<TR>
							<TD align="center"><B>�\����e</B></TD>
							<TD align="center"><B>Function</B></TD>
						</TR>
<%
  for(int t = 0;t < yotei_count;t++){
    if((yotei[0][t].trim()).equals("1")){
%>
    					<TR STYLE="font-size:12">
    						<TD align="center"><%= yotei[1][t] %></TD>
   							<FORM action="kanri_admin.jsp" method="POST">
   								<TD align="center">
   									<INPUT TYPE="hidden" NAME="y_kubun" VALUE="<%= yotei[0][t].trim() %>">
    								<INPUT TYPE="hidden" NAME="y_basyo" VALUE="<%= yotei[1][t] %>">
    								<INPUT TYPE="hidden" NAME="action" VALUE="yotei_dat_del">
    								<INPUT TYPE="hidden" NAME="table_select" VALUE="yotei">
									<INPUT TYPE="hidden" NAME="sql_select" VALUE="del">
       								<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
    								<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" VALUE="�폜">
    							</TD>
    						</FORM>
    					</TR>
<%
	}

  }
%>
					</TABLE>

				</TD>
				<TD valign="TOP">
					<TABLE border="1">
						<TR>
							<TD align="center"><B>�ꏊ</B></TD>
							<TD align="center"><B>Function</B></TD>
						</TR>
<%
  for(int i = 0;i < yotei_count;i++){
    if((yotei[0][i].trim()).equals("2")){
%>
    					<TR STYLE="font-size:12">
    						<TD align="center"><%= yotei[1][i] %></TD>
    						<FORM action="kanri_admin.jsp" method="POST">
    							<TD align="center">
    								<INPUT TYPE="hidden" NAME="y_kubun" VALUE="<%= yotei[0][i].trim() %>">
    								<INPUT TYPE="hidden" NAME="y_basyo" VALUE="<%= yotei[1][i] %>">
    								<INPUT TYPE="hidden" NAME="action" VALUE="yotei_basyo_del">
									<INPUT TYPE="hidden" NAME="table_select" VALUE="yotei">
									<INPUT TYPE="hidden" NAME="sql_select" VALUE="del">
    								<INPUT TYPE="hidden" NAME="pass" VALUE="<%= inpPassword %>">
    								<INPUT TYPE="submit" STYLE="background-color:#FFFFFF" VALUE="�폜">
   								</TD>
     						</FORM>
    					</TR>
<%
    }
}
%>
					</TABLE>
				</TD>
			</TABLE>
		</CENTER>
		<form NAME="MyForm">
			<input type="button" style="background-color:#FFFFFF;width:50" value="�߂�" onClick="location.href='http://www.lucentsquare.co.jp/kinmu_db/top.html'">
		</form>
		</body>
	</html>