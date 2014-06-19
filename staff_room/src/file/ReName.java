package file;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReName
 */
//@WebServlet("/ReName")
public class ReName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReName() {
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
		
		String page = request.getParameter("page");
		String category = request.getParameter("category");
		String applicationPath = request.getServletContext().getRealPath("");
    	String uploadFilePath = applicationPath + File.separator + page 
    							+ File.separator + category;
    	String new_name = request.getParameter("new_name");
    	String older_name = request.getParameter("older_name");
    	File older_file = new File(uploadFilePath + File.separator + older_name);
    	File new_file = new File(uploadFilePath + File.separator + new_name);
    	if(older_file.exists()){
    		older_file.renameTo(new_file);
    	}
	}

}
