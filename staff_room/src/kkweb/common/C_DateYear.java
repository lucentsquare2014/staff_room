package kkweb.common;

import java.util.Calendar;

public class C_DateYear {

	public String thisYear(String hizuke){

		Calendar cal = Calendar.getInstance();
		String kotoshi = Integer.toString(cal.get(Calendar.YEAR));

		if(!hizuke.equals("")){
			if(Integer.parseInt(hizuke) < Integer.parseInt(kotoshi)){
				kotoshi = hizuke;
			}
		}
		return kotoshi;
	}

	public String thisMonth(String hizuke){

		Calendar cal = Calendar.getInstance();
		String kongetsu = Integer.toString(cal.get(Calendar.MONTH));

		if(!hizuke.equals("")){
			kongetsu = hizuke;
		}
		return kongetsu;
	}

}
