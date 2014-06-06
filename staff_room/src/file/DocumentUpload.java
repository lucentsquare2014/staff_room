package file;

import java.io.File;
import java.io.IOException;

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
    	// ページ名を取得
    	String page = request.getParameter("page");
    	String applicationPath = request.getServletContext().getRealPath("");
    	String uploadFilePath = applicationPath + File.separator + page;
    	// 申請書類の場合はカテゴリを取得。
    	// マニュアルもカテゴリあれば、このif文はいらない。
    	if(page.equals("document")){
    		String category = new String(request.getParameter("category").getBytes("ISO-8859-1"),"UTF-8");
    		uploadFilePath = uploadFilePath + File.separator + category;
    	}
    	File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
    	for (Part part : request.getParts()) {
    		if(part.getName().equals("inputFile")){
    			String name = getFilename(part);
    			part.write(uploadFilePath + File.separator + name);
    		}
        }
    	if(page.equals("document")){
    		response.sendRedirect("/staff_room/jsp/document/teisyutsusyorui.jsp");
    	}else{
    		response.sendRedirect("/staff_room/jsp/manual/manual.jsp");
    	}
    }
    
    // ファイルの名前を取得
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
