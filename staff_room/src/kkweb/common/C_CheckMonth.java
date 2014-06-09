package kkweb.common;

public class C_CheckMonth {

	public String CheckMonth(String strWhere){

		String m = "";

		if(strWhere.length() == 1){
			m = "0" + strWhere;

		}else{
			m = strWhere;
		}

		return m;
	}

		public String MonthCheck(String strWhere){

		int i = Integer.parseInt(strWhere);
		if (i<10){
			return  strWhere.substring(1);
		}else{
			return strWhere;
		}
		}
}
