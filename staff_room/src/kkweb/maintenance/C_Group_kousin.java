package kkweb.maintenance;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Group_kousin extends C_ChangePageBase{

	public String nextPage(HttpServletRequest request){

		try{

			String nextpage = "/Group_Maintenance.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String backpage = "/Maintenance_error.jsp";

			return backpage;

		}catch(Exception e){

			//e.printStackTrace();
			return null;
		}
	}

	public String checkRequest(HttpServletRequest request){

		try {

			request.setCharacterEncoding("Windows-31J");

			String g_size = request.getParameter("g_size");

			int size = Integer.parseInt(g_size);

			for(int j=0 ; j<=size -1; ++j ){
				String g_number = request.getParameter("g_number" + String.valueOf(j));
				String g_name = request.getParameter("g_name" + String.valueOf(j));
				//System.out.println("holiday"+g_name+j);
				
				//if((g_name==null || g_name.equals("")) || (g_number==null || g_number.equals(""))){
				if(g_name.length() > 0 && g_number.length() >0)
				{
					//System.out.println("holiday"+g_name);
				}else if((g_name==null || g_name.equals(""))&& (g_number==null || g_number.equals(""))){
				}else{					
					return "error";
				}

			}

			C_DBConnection dbcon = new C_DBConnection();
			Connection con = dbcon.createConnection();;
			Statement stmt = con.createStatement();

			String sql = " truncate table groupmst ";
			stmt.executeUpdate(sql);
			C_CheckWord word = new C_CheckWord();

			for(int j=0 ; j<=size -1; ++j ){

				String g_number = request.getParameter("g_number" + String.valueOf(j));
				g_number=word.checks(g_number);
				String g_name = request.getParameter("g_name" + String.valueOf(j));
				g_name=word.checks(g_name);

				if(g_number == "" && g_name == ""){
					
				}else{

					int g_n = Integer.parseInt(g_number);


					if (!(0 <= g_n) && !(g_n <= 999)){
						con.rollback();

						return "error";

					}
					else if(g_number == "" || g_name == ""){
						con.rollback();
						return "error";
					}else{

						String sql2 = "insert into groupmst values ('"+ g_number +"' ,  '"+ g_name +"')";
						stmt.executeUpdate(sql2);
					}

				}


			}
			con.commit();
			return "";

		}catch(Exception e){
			//e.printStackTrace();
			return "";
		}
	}
}