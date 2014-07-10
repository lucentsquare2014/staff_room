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
 * Servlet implementation class UpdateGroup
 */
//@WebServlet("/UpdateGroup")
public class UpdateGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateGroup() {
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
		String[] no = request.getParameterValues("gruno");
		String[] name = request.getParameterValues("grname");
		AccessDB access = new AccessDB();
		Connection con = access.openDB();
		Statement stmt;
		String del_sql = "DELETE FROM schedule.gru";
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(del_sql);
			for(int i = 0; i < no.length; i++){
				String g_no = no[i].trim();
				String g_name = new String(name[i].getBytes("ISO-8859-1"), "UTF-8").trim();
				if(!g_no.equals("") && !g_name.equals("")){
					String sql = "INSERT INTO schedule.gru (g_gruno, g_grname) VALUES ('" + g_no + "', '" + g_name + "')";
					stmt.executeUpdate(sql);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			access.closeDB(con);
		}
		response.sendRedirect("/staff_room/jsp/shanai_s/schedule_maintenance.jsp");
	}

}
