package kkweb.common;

	import java.io.*;


public class C_FileDelete {


		    //ファイルやフォルダを削除
		    //フォルダの場合、中にあるすべてのファイルやサブフォルダも削除されます
		    public static boolean deleteFile(File dirOrFile) {
		        if (dirOrFile.isDirectory()) {//ディレクトリの場合
		            String[] children = dirOrFile.list();//ディレクトリにあるすべてのファイルを処理する
		            for (int i=0; i<children.length; i++) {
		                boolean success = deleteFile(new File(dirOrFile, children[i]));
		                if (!success) {
		                    return false;
		                }
		                else{}
		            }
		        }
		        // 削除
		        return dirOrFile.delete();
		    }

	}


