package holiday;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AccessDB;

/**
 * Servlet implementation class UpdateHoliday
 */
//@WebServlet("/UpdateHoliday")
public class UpdateHoliday extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateHoliday() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String year = request.getParameter("select");
		String[] month_array = request.getParameterValues("month");
		String[] day_array = request.getParameterValues("day");
		String[] name_array = (request.getParameterValues("holiday"));
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String del_sql = "DELETE FROM holiday WHERE h_年月日 like '" + year + "%'";
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(del_sql);
			for(int i = 0; i < month_array.length; i++){
				String ymd = year + month_array[i].trim() + day_array[i].trim();
				String name = new String(name_array[i].getBytes("ISO-8859-1"), "UTF-8").trim();
				if(!name.equals("") && ymd.length() > 6){
					String sql = "INSERT INTO holiday (h_年月日, h_休日名) VALUES ('" + ymd + "', '" + name + "')";
					stmt.executeUpdate(sql);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		response.sendRedirect("/staff_room/jsp/shanai_s/Holiday.jsp");
	}

}
