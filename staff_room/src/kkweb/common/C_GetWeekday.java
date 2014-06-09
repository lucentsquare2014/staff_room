package kkweb.common;

import java.util.*;

public class C_GetWeekday {

	public String weekday(String year,String month,int day){

		try{

			if(year.equals("") || month.equals("") || day <= 0){
				return "";
			}

			String youbi = "";

			int y = Integer.parseInt(year);
			int m = Integer.parseInt(month);

			/* 2011/1/10 河村　不具合修正
			if(m == 1){
				m = 12;
			}else{
				m--;
			}
			*/
			
			m--;
			
			Calendar cal = new GregorianCalendar(y,m,day);

			switch(cal.get(Calendar.DAY_OF_WEEK)){

			case Calendar.SUNDAY:
				youbi = "日";

			break;

			case Calendar.MONDAY:
				youbi = "月";

			break;

			case Calendar.TUESDAY:
				youbi = "火";

			break;

			case Calendar.WEDNESDAY:
				youbi = "水";

			break;

			case Calendar.THURSDAY:
				youbi = "木";

			break;

			case Calendar.FRIDAY:
				youbi = "金";

			break;

			default:
				youbi = "土";

			break;
			}

			return youbi;

		}catch(Exception e){

			e.printStackTrace();

			return "";
		}

	}
}
