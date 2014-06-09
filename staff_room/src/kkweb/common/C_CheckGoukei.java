package kkweb.common;

public class C_CheckGoukei {

	public String checkgoukei(String strWhere){

		String goukei = "";

		if(strWhere.equals("")){

			return "0:00";

		}else{

		switch(strWhere.length()){

		case 6:

			goukei = strWhere.substring(0,4)+":"+strWhere.substring(4);

			break;

		case 5:

			goukei = strWhere.substring(0,3)+":"+strWhere.substring(3);

			break;

		case 4:

			if(strWhere.substring(0,1).equals("0")){

				goukei = strWhere.substring(1,2)+":"+strWhere.substring(2);

			}else{

				goukei = strWhere.substring(0,2)+":"+strWhere.substring(2);
			}

			break;

		case 3:

			goukei = strWhere.substring(0,1)+":"+strWhere.substring(1);

			break;

		case 2:

			goukei = "0:"+strWhere;

			break;

		default:

			goukei = "0:0"+strWhere;

			break;

		}

			return goukei;

		}
	}

	public String checknissu(String strWhere){

		if(strWhere.equals("")){
			return "0";

		}else{
			return strWhere;
		}
	}
}


