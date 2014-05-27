import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "Upload", urlPatterns = { "/upload" })
@MultipartConfig(fileSizeThreshold = 5000000, maxFileSize = 700 * 1024 * 1024, location = "//global01/82_新人研修/2014年度新人用/10_個別/upload")
public class Upload extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
    	response.setCharacterEncoding("utf-8");
    	for (Part part : request.getParts()) {
                String name = getFilename(part);
                part.write(name);
        }
    	response.setContentType("application/json");
        request.setCharacterEncoding("utf-8");
    }
    
    private String getFilename(Part part) {
        for (String cd : part.getHeader("Content-Disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim()
                        .replace("\"", "");
            }
        }
        return null;
    }
}