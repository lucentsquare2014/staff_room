package kkweb.maintenance;

import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import kkweb.common.C_CheckWord;
import kkweb.common.C_DBConnection;
import kkweb.superclass.C_ChangePageBase;

public class C_Holiday_kousin extends C_ChangePageBase{

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

	public String checkRequest(HttpServletRequest request) {

		try {

			request.setCharacterEncoding("Windows-31J");

			String h_size = request.getParameter("h_size");

			int size = Integer.parseInt(h_size);
			
			for(int j=0 ; j<=size -1; ++j ){
				String day = request.getParameter("h_day" + String.valueOf(j));
				String month = request.getParameter("h_month" + String.valueOf(j));
				String holiday = request.getParameter("h_holiday" + String.valueOf(j));
				System.out.println("holiday"+holiday+j);
				if(holiday==null || holiday.equals("") || day==null || day.equals("") || month==null || month.equals("")){
					System.out.println("holiday"+holiday);
					return "error";
				}
				
			}

			C_DBConnection dbcon = new C_DBConnection();
			Connection con = dbcon.createConnection();

			Statement stmt = con.createStatement();

			String sql = " truncate table holidaymst ";

			stmt.executeUpdate(sql);
			C_CheckWord word = new C_CheckWord();
			

			for(int j=0 ; j<=size -1; ++j ){

			String day = request.getParameter("h_day" + String.valueOf(j));
			day=word.checks(day);
			String month = request.getParameter("h_month" + String.valueOf(j));
			month=word.checks(month);
			String holiday = request.getParameter("h_holiday" + String.valueOf(j));
			System.out.println("holiday"+holiday+j);
			
			if(holiday==null || holiday.equals("")){
				System.out.println("holiday"+holiday);
				con.rollback();
				return "error";
				
			}
			holiday=word.checks(holiday);
				if(day == "" && month == "" && holiday == ""){

				}else{

				String mmoji = month;
				String dmoji = day;

				int tuki = mmoji.length();
				int hi = dmoji.length();

					if(tuki != 2){
						con.rollback();
						return "error";
					}

					if(hi != 2){
						con.rollback();
						return "error";
					}

				int imonth = Integer.parseInt(month);

					if(imonth > 12 || imonth==00){
						con.rollback();
						return "error";
					}

				int iday = Integer.parseInt(day);

					if(imonth == 2){

						if(iday >= 30 || iday == 0){
							con.rollback();
							return "error";
						}
					}


					if(imonth == 4 || imonth == 6 || imonth == 9 || imonth == 11){

						if(iday>=31 || iday == 0){
							con.rollback();
							return "error" ;

						}

					}else if(imonth == 1 || imonth == 3 || imonth == 5 || imonth == 7 || imonth == 8 || imonth == 10 || imonth == 12){

						if(iday>=32 || iday == 0){
							con.rollback();
							return "error" ;

						}
					}

						if(month == "" || day == "" || holiday == ""){
							con.rollback();
							return "error";
						}
			String sql2 = "insert into holidaymst values ('"+ month+day +"' ,  '"+ holiday +"')";

			stmt.executeUpdate(sql2);

				}
			}
			con.commit();
			return "";

		}catch(Exception e){
			System.out.println("aa");
			//e.printStackTrace();
			return "1";
		}
	}
}