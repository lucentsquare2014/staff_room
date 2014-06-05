package file;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "DocumentUpload", urlPatterns = { "/document" })
@MultipartConfig(fileSizeThreshold = 5000000, maxFileSize = 700 * 1024 * 1024)
public class DocumentUpload extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
    	//System.out.println(request.getParameter("type"));
    	String applicationPath = request.getServletContext().getRealPath("");
    	String uploadFilePath = applicationPath + File.separator + "document";
    	File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
    	for (Part part : request.getParts()) {
    		String name = getFilename(part);
            part.write(uploadFilePath + File.separator + name);
        }
    	RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/document/teisyutsusyorui.jsp");
        dispatcher.forward(request, response);
    }
    
    private String getFilename(Part part) {
        for (String cd : part.getHeader("Content-Disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
            	if(cd.trim().indexOf("\\") == -1){
            		return cd.substring(cd.indexOf('=') + 1).trim()
                            .replace("\"", "");
            	}else{
            		cd = cd.substring(cd.indexOf('=') + 1).trim()
                            .replace("\"", "");
            		String[] str= cd.split("\\\\");
            		return str[str.length - 1];
            	}
            }
        }
        return null;
    }
}
