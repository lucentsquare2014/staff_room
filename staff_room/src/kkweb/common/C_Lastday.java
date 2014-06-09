package kkweb.common;

public class C_Lastday {

	public int lastday(String year,String month){

		
		int y = Integer.parseInt(year);
		int m = Integer.parseInt(month);
		int lday;
		
		switch(m){

		case 2:

			if((y%4)==0){

				lday = 29;

			}else{

				lday = 28;

			}

		break;

		case 4:

			lday = 30;

		break;

		case 6:

			lday = 30;

		break;

		case 9:

			lday = 30;

		break;

		case 11:

			lday = 30;

		break;

		default:

			lday = 31;

		break;

		}
		
		return lday;
	}

}
