package file;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

//@WebServlet(name = "DocumentUpload", urlPatterns = { "/document" })
//@MultipartConfig(fileSizeThreshold = 5000000, maxFileSize = 700 * 1024 * 1024)
public class DocumentUpload extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
    	
    	String page = "";
    	String category = "";
    	String applicationPath = getServletContext().getRealPath("");
    	DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        factory.setSizeThreshold(1024);
        upload.setSizeMax(-1);
        upload.setHeaderEncoding("UTF-8");
        
        try{
        	List<FileItem> list = upload.parseRequest(request);
			Iterator<FileItem> iterator = list.iterator();
			while(iterator.hasNext()){
				FileItem fItem = (FileItem)iterator.next();
				if(fItem.isFormField()){
					String paraName=fItem.getFieldName(); 
					String paraValue=fItem.getString(); 
					if(paraName.equals("category")){
						category = new String(paraValue.getBytes("ISO-8859-1"),"UTF-8");
					}else{
						page = paraValue;
					}
				}
			}
			String uploadFilePath = applicationPath + File.separator + page 
					+ File.separator + category;
			File fileSaveDir = new File(uploadFilePath);
	        if (!fileSaveDir.exists()) {
	            fileSaveDir.mkdirs();
	        }
	        Iterator<FileItem> iterator2 = list.iterator();
			while(iterator2.hasNext()){
				FileItem fItem = (FileItem)iterator2.next();
				if(!(fItem.isFormField())){
					String fileName = fItem.getName();
					if((fileName != null) && (!fileName.equals(""))){
			            fileName=(new File(fileName)).getName();
			            fItem.write(new File(uploadFilePath + File.separator + fileName));
			        }
				}
			}
        }catch (FileUploadException e) {
			e.printStackTrace();
		}catch (Exception e) {
		    e.printStackTrace();
	    }
    	if(page.equals("Docs")){
    		response.sendRedirect("/staff_room/jsp/document/teisyutsusyorui.jsp");
    	}else{
    		response.sendRedirect("/staff_room/jsp/manual/manual.jsp");
    	}
    }
}
