package kkweb.common;

import java.util.*;

import kkweb.beans.B_HolidayMST;
import kkweb.dao.HolidayDAO;

public class C_Holiday {

	public String holiday(String year_month,int hizuke){

		try{
			String month = year_month.substring(4);
			String day = "";

			if(hizuke <10){

				day = "0"+Integer.toString(hizuke);

			}else{

				day = Integer.toString(hizuke);

			}

			String month_day = month+day;

			HolidayDAO hdao = new HolidayDAO();
			String sql = " where SYUKUJITUdate ='"+month_day+"'";

			boolean hday = hdao.isThereTbl(sql);

			if(hday == true){

			ArrayList list = hdao.selectTbl(sql);

			B_HolidayMST bhmst = new B_HolidayMST();
			bhmst = (B_HolidayMST)list.get(0);

			return bhmst.getSYUKUJITUname();

			}else{

				return "";

			}

		}catch(Exception e){

			e.printStackTrace();

			return "";

		}
	}

}
