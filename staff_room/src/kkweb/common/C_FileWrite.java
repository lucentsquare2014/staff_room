package kkweb.common;

import java.io.*;
import java.util.ArrayList;

public class C_FileWrite {

	public void writeTextfile(ArrayList text,String name)throws IOException {
		File outputfile = new File(name);
		  	BufferedWriter writer = null;
		  	try {
//		  		if (checkBeforeWritefile(outputfile)){
	            writer = new BufferedWriter(new FileWriter(outputfile));
	            for(int i = 0 ; i < text.size() ; i++){
	            String kakikomi = (String)text.get(i);
	            writer.write(kakikomi);
	            writer.newLine();
	            }
//		  		}else{

//		  		}
	        } catch (IOException e) {
	            throw e;
	        } finally {
	            if (writer != null) {
	                writer.close();
	            }
	        }
	    }

//		  private static boolean checkBeforeWritefile(File file){
//		    if (file.exists()){
//		      if (file.isFile() && file.canWrite()){
//		        return true;
//		      }
//		    }
//
//		    return false;
//		  }
}
