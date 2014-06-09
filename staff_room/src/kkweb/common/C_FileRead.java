package kkweb.common;

	import java.io.*;
import java.util.*;

public class C_FileRead {

//    public static void main(String[] args) {
//       try {
//           FileInputStream in = new FileInputStream("file.txt");
//            int ch;
//            while ((ch = in.read()) != -1) {
//                System.out.print(Integer.toHexString(ch) + " ");
//           }
//           in.close();
//       } catch (IOException e) {
//           System.out.println(e);
//       }
//   }
// テキストファイルのクラス
//	static class text{
//		public String zanke ;
//		 static text txt(String line) {
//			    StringTokenizer tokenizer = new StringTokenizer(line,",");
//			    text result = new text();
//			    result.zanke  = tokenizer.nextToken();
//			    return result;
//			  }
//	}
// テキストファイルの行単位の読み込みを行う
//	public   ArrayList readtext(String args) throws Exception {
//		FileReader yomikomi = new FileReader(args);
//		BufferedReader itigyou = new BufferedReader(yomikomi);
//		ArrayList result = new ArrayList();
//
//		while(itigyou.readLine()!= null){
//			result.add(text.txt(itigyou.readLine().toString()));
//		}
//		itigyou.close();
//		yomikomi.close();
//		return result;
//	}


//csvファイルのクラス
	static class csv{
		public String kintai;
		static  csv  nextToken(String kotai){
	    StringTokenizer tokenizer = new StringTokenizer(kotai,",");
	    csv result = new csv();
	    result.kintai  = tokenizer.nextToken();
	    return result;
		}
	}

	//csvファイルのマス単位の読み込みを行う
	public ArrayList readCSV(String args) throws Exception{
		try{
			FileReader fr = new FileReader(args);
			BufferedReader br = new BufferedReader(fr);
			ArrayList result = new ArrayList();
			String hitotunomoji;
			int i=0;
			int j=0;
			while((hitotunomoji = br.readLine()) != null) {
				StringTokenizer hitomasu = new StringTokenizer(hitotunomoji);
				while(hitomasu.hasMoreTokens()) {
				result.add(hitomasu.nextToken().toString());
				j++;
				}
				i++;
				}

		fr.close();
		br.close();
		return result;
		}catch (IOException e){

		}
		return null;
	}


}

