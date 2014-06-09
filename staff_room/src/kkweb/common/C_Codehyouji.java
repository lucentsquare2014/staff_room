package kkweb.common;

public class C_Codehyouji {

	public String code (String strWhere){

		try{
			if(strWhere.equals("")){

				return "";

			}else{

				return strWhere;
			}

		}catch(Exception e){

			e.printStackTrace();

			return "";
		}
	}

}
