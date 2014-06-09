package kkweb.maintenance;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.*;
import kkweb.superclass.C_ChangePageBase;

public class C_Holiday_tuika extends C_ChangePageBase {

	public String nextPage(HttpServletRequest request){

		try{

			String nextpage = "/Holiday_Maintenance.jsp";

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
			String month = request.getParameter("month");
			month = word.checks(month);
			String day = request.getParameter("day");
			day= word.checks(day);
			String holiday = request.getParameter("holiday");
			holiday=word.checks(holiday);
			C_DBConnection dbcon = new C_DBConnection();
			Connection con = dbcon.createConnection();;

			Statement stmt = con.createStatement();

			String mmoji = month;
			String dmoji = day;

			int tuki = mmoji.length();
			int hi = dmoji.length();

				if(tuki != 2){

					return "error";
				}

				if(hi != 2){

					return "error";
				}

			int imonth = Integer.parseInt(month);

				if(imonth > 12 || imonth==00){

					return "error";
				}

			int iday = Integer.parseInt(day);

				if(imonth == 2){

					if(iday >= 30 || iday == 0){

							return "error";
					}
				}

				if(imonth == 4 || imonth == 6 || imonth == 9 || imonth == 11){

					if(iday>=31 || iday == 0){

						return "error" ;

					}

				}else if(imonth == 1 || imonth == 3 || imonth == 5 || imonth == 7 || imonth == 8 || imonth == 10 || imonth == 12){

					if(iday>=32 || iday == 0){

						return "error" ;

					}
				}

				if(month == "" || day == "" || holiday == ""){

					return "error";
				}

			String sql = "insert into holidaymst values ('"+month+day+"','"+holiday+"')";

			stmt.executeUpdate(sql);

			return "";


		}catch(Exception e){

			//e.printStackTrace();

			return "1";
		}
	}
}
