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
 * Servlet implementation class NewGroup
 */
//@WebServlet("/NewGroup")
public class NewGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewGroup() {
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
		String no = request.getParameter("add_gruno");
		String name = new String(request.getParameter("add_grname").getBytes("ISO-8859-1"),"UTF-8");
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String sql = "INSERT INTO schedule.gru (g_gruno, g_grname) VALUES ('" + no + "', '" + name + "')";
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		response.sendRedirect("/staff_room/jsp/shanai_s/Schedule_Maintenance.jsp");
	}

}
