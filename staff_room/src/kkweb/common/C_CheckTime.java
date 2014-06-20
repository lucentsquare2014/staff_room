package kkweb.common;

public class C_CheckTime {

	public String checktime(String strWhere){

		try{

		String jikan = "";

		if(!strWhere.equals("") && strWhere != null){

			switch(strWhere.length()){

			case 5:

				jikan = strWhere.substring(0,3) +":"+strWhere.substring(3);

				break;

			case 4:

				if(strWhere.substring(0,1).equals("0")){

					jikan = strWhere.substring(1,2)+":"+strWhere.substring(2);

				}else{

					jikan = strWhere.substring(0,2)+":"+strWhere.substring(2);

				}

				break;

			case 3:

				jikan = strWhere.substring(0,1)+":"+strWhere.substring(1);

				break;

			case 2:

				jikan = "0:"+strWhere;

				break;

			default:

				jikan = "0:0"+strWhere;

				break;

			}

			return jikan;


		}else{

		return "";

		}

	}catch(Exception e){

			e.printStackTrace();

			return "";
	}

	}

	public String houkokutime(String strWhere){

		try{

		String jikan = "";

		if(!strWhere.equals("") && strWhere != null){

			switch(strWhere.length()){

			case 7:

				jikan = strWhere.substring(0,4) +strWhere.substring(5);

				break;

			case 6:

				jikan = strWhere.substring(0,3) +strWhere.substring(4);

				break;

			case 5:

				jikan = strWhere.substring(0,2) +strWhere.substring(3);

				break;

			case 4:

				if(strWhere.substring(0,1).equals("0")&&strWhere.substring(2).equals("00")){

					jikan = "0";

				}else if(strWhere.substring(0,1).equals("0")){

					jikan = strWhere.substring(2);

				}else{

					jikan = strWhere.substring(0,1)+strWhere.substring(2);

				}

				break;
			}

			return jikan;


		}else{

		return "";

		}

	}catch(Exception e){
			System.out.println("hoge (C_CheckTime.java)");
			e.printStackTrace();

			return "";
	}

	}

	public String add(String args){
		try{
			String time = "";
			if(!args.equals("") && args != null){
				switch(args.length()){

				case 4:

					time = args;

				break;

				case 3:

					time = "0"+ args;

				}
				return time;

			}else{
				return "";
			}

		}catch(Exception e){
			e.printStackTrace();
			return "";
		}

	}
}


