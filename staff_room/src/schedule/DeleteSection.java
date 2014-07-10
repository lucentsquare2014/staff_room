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
 * Servlet implementation class DeleteSection
 */
//@WebServlet("/DeleteSection")
public class DeleteSection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteSection() {
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
		String order = request.getParameter("delete");
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String sql = "DELETE FROM schedule.yotei WHERE 順番 = '" + order + "'";
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
