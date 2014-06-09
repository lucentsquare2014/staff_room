package kkweb.maintenance;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Group_tuika extends C_ChangePageBase {

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

			C_CheckWord word = new C_CheckWord();
			String group_number = request.getParameter("group_number");
			group_number=word.checks(group_number);
			String group_name = request.getParameter("group_name");
			group_name=word.checks(group_name);

			C_DBConnection dbcon = new C_DBConnection();
			Connection con = dbcon.createConnection();;
			Statement stmt = con.createStatement();

			if(group_number == "" ||  group_name == ""){

					return "error";
				}

			int g_number = Integer.parseInt(group_number);

				if (!(0 <= g_number) && !(g_number <= 999)){

					return "error";
				}

			String sql = "insert into groupmst values ('"+group_number+"','"+group_name+"')";
			stmt.executeUpdate(sql);

			return "";

		}catch(Exception e){

			//e.printStackTrace();

			return "error";
		}
	}
}