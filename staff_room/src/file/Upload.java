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

//@WebServlet(name = "Upload", urlPatterns = { "/upload" })
//@MultipartConfig(fileSizeThreshold = 5000000, maxFileSize = 700 * 1024 * 1024)
public class Upload extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
    	response.setCharacterEncoding("utf-8");
    	String applicationPath = request.getServletContext().getRealPath("");
    	String uploadFilePath = applicationPath + File.separator + "upload";
    	File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        //ServletFileUploadオブジェクトを生成
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
    	response.setContentType("text/html");
        request.setCharacterEncoding("utf-8");
        //アップロードする際の基準値を設定
        factory.setSizeThreshold(1024);
        upload.setSizeMax(-1);
        upload.setHeaderEncoding("UTF-8");
        try {
			List<FileItem> list = upload.parseRequest(request);
			Iterator<FileItem> iterator = list.iterator();
			while(iterator.hasNext()){
				FileItem fItem = (FileItem)iterator.next();
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
    }

}