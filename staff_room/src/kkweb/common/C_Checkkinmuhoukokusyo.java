package kkweb.common;

import kkweb.dao.GoukeiDAO;

public class C_Checkkinmuhoukokusyo {


	private boolean checkIsTherekinmuhoukokusyo(String shainNumber,String year,String month){

		boolean flag = true;

		GoukeiDAO dao = new GoukeiDAO();
		String sql = " where number ='"+shainNumber+"' AND year_month ='"+year+month+"'";
		flag = dao.isThereTbl(sql);

		return flag;
	}

	public String retCheckIsTherekinmuhoukokusyo(String shainNumber,String year,String month,int kbn){

		if(!checkIsTherekinmuhoukokusyo(shainNumber,year,month) == true){
			switch(kbn){
			case 1:

				String msg = "該当月の勤務報告書はありません";

				return msg;
			}
		}
		return null;
	}
}
