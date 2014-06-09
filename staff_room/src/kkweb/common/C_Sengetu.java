package kkweb.common;

public class C_Sengetu {

	public String sengetu_month(String month){

		int m = Integer.parseInt(month);

		if(m==1){

			return "12";

		}else{

			return Integer.toString(m-1);

		}
	}

	public String sengetu_year(String year,String month){

		int y = Integer.parseInt(year);

		if(sengetu_month(month).equals("12")){

			y--;

		}

		return Integer.toString(y);
	}

}
