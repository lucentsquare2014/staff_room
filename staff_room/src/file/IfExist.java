package file;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class IfExist
 */
//@WebServlet("/IfExist")
public class IfExist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IfExist() {
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
		
		String filename = request.getParameter("file");
		String category = request.getParameter("category");
		String page = request.getParameter("page");
		String applicationPath = getServletContext().getRealPath("");
		String uploadFilePath = "";
		if(page.equals("upload")){
			uploadFilePath = applicationPath + File.separator + page;
		}else{
			uploadFilePath = applicationPath + File.separator + page 
					+ File.separator + category;
		}
		File filesave = new File(uploadFilePath + File.separator + filename);
		PrintWriter out = response.getWriter();
		out.print(filesave.exists());
	}

}
