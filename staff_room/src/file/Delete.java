package file;


import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewsDAO;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
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
		String filename = request.getParameter("deleteFile");
		String news_id = request.getParameter("newsId");
		String getFilename = "";
		if(news_id != null){
			getFilename = getFilename(Integer.valueOf(news_id));
		}
		String applicationPath = request.getServletContext().getRealPath("");
    	String deleteFilePath = applicationPath + File.separator + "upload";
    	File file = new File(deleteFilePath + File.separator + filename);
    	if(file.exists()){
    		file.delete();
    		if(news_id != null || getFilename != ""){
    			updateDB(Integer.valueOf(news_id),getFilename,filename);
    		}
    	}
	}
	
	public String getFilename(int news_id){
		String select_sql = "select filename from news where news_id = " + news_id;
		Connection con = NewsDAO.openNewsDB();
		Statement stmt;
		String filename = "";
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(select_sql);
			if(rs.next()){
				filename = rs.getString("filename");
			}
			NewsDAO.closeNewsDB(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return filename;
	}
	
	public void updateDB(int news_id, String filename, String delete_name){
		filename = filename.replace(delete_name + ",", "");
		String update_sql = "UPDATE news SET filename = '" + filename 
				+ "' where news_id = " + news_id;
		Connection con = NewsDAO.openNewsDB();
		Statement stmt;
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(update_sql);
			NewsDAO.closeNewsDB(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
