package schedule;

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
 * Servlet implementation class NewSection
 */
//@WebServlet("/NewSection")
public class NewSection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewSection() {
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
		String type = request.getParameter("section");
		String order = "";
		if(type.equals("1")){
			order = request.getParameter("order1");
		}else{
			order = request.getParameter("order2");
		}
		String place = new String(request.getParameter("content").getBytes("ISO-8859-1"),"UTF-8");
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String sql = "INSERT INTO schedule.yotei (区分, 場所, 順番) VALUES ('" + type + "', '" + place + "', '" + order + "')";
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		response.sendRedirect("/staff_room/jsp/shanai_s/schedule_maintenance.jsp");
	}

}
