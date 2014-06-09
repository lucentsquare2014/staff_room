package kkweb.common;

public class C_GoukeiKeisan {

	private int check(String strWhere){

		if(strWhere.equals("")){
			return 0;

		}else{

			return strWhere.length();
		}
	}

	private String checkT(int hour, int minute){

		String h = Integer.toString(hour);
		String m = Integer.toString(minute);

		String h_m = "";

		if(minute < 10){

			h_m = h+"0"+m;

		}else{

			h_m = h+m;
		}

		return h_m;

	}

	public String cyouka(String cyouka1,String cyouka2){

		int h1;
		int m1;
		int h2;
		int m2;

		try{

			switch(check(cyouka1)){


			case 0:

				h1 = 0;
				m1 = 0;

			break;

			case 1:

				h1 = 0;
				m1 = 0;

			break;

			case 2:

				h1 = 0;
				m1 = Integer.parseInt(cyouka1);

			break;

			case 3:

				h1 = Integer.parseInt(cyouka1.substring(0,1));
				m1 = Integer.parseInt(cyouka1.substring(1));

			break;

			case 4:

				h1 = Integer.parseInt(cyouka1.substring(0,2));
				m1 = Integer.parseInt(cyouka1.substring(2));

			break;

			case 5:

				h1 = Integer.parseInt(cyouka1.substring(0,3));
				m1 = Integer.parseInt(cyouka1.substring(3));

			break;

			default:

				h1 = Integer.parseInt(cyouka1.substring(0,4));
				m1 = Integer.parseInt(cyouka1.substring(4));

			break;

			}

			switch(check(cyouka2)){

			case 0:

				h2 = 0;
				m2 = 0;

			break;

			case 1:

				h2 = 0;
				m2 = 0;

			break;

			case 2:

				h2 = 0;
				m2 = Integer.parseInt(cyouka2);

			break;

			case 3:

				h2 = Integer.parseInt(cyouka2.substring(0,1));
				m2 = Integer.parseInt(cyouka2.substring(1));

			break;

			case 4:

				h2 = Integer.parseInt(cyouka2.substring(0,2));
				m2 = Integer.parseInt(cyouka2.substring(2));

			break;

			case 5:

				h2 = Integer.parseInt(cyouka2.substring(0,3));
				m2 = Integer.parseInt(cyouka2.substring(3));

			break;

			default:

				h2 = Integer.parseInt(cyouka2.substring(0,4));
				m2 = Integer.parseInt(cyouka2.substring(4));

			break;

			}

			int goukei = ((h1*60)+m1)+((h2*60)+m2);

			int goukei_h = goukei/60;
			int goukei_m = goukei%60;

			return checkT(goukei_h,goukei_m);

		}catch(Exception e){

			e.printStackTrace();

			return cyouka1;
		}
	}

	public int kyudemonth(int kyude,String code){

		try{

			if(code.equals("96") || code.equals("97") || code.equals("98") || code.equals("99") || code.equals("f96") || code.equals("f97") || code.equals("f98") || code.equals("f99") || code.equals("F96") || code.equals("F97") || code.equals("F98") || code.equals("F99")){

				return kyude + 1;

			}else{

				return kyude;

			}

		}catch(Exception e){

			e.printStackTrace();

			return kyude;

		}
	}

	public int daikyumonth(int daikyu,String code){

		try{

			if(code.equals("88")){

				return daikyu + 1;

			}else{

				return daikyu;

			}

		}catch(Exception e){

			e.printStackTrace();

			return daikyu;

		}
	}

	public int nenkyumonth(int nenkyu,String code){

		try{

			if(code.equals("n")){

				return nenkyu + 1;

			}else{

				return nenkyu;

			}

		}catch(Exception e){

			e.printStackTrace();

			return nenkyu;

		}
	}

	public int kekkinmonth(int kekkin,String code){

		try{

			if(code.equals("k")){

				return kekkin + 1;

			}else{

				return kekkin;

			}

		}catch(Exception e){

			e.printStackTrace();

			return kekkin;

		}
	}

	public int akyumonth(int akyu,String code){

		try{

			if(code.equals("90") || code.equals("91") || code.equals("92") || code.equals("f90") || code.equals("f91") || code.equals("f92") || code.equals("F90") || code.equals("F91") || code.equals("F92")){

				return akyu + 1;

			}else{

				return akyu;

			}

		}catch(Exception e){

			e.printStackTrace();

			return akyu;

		}
	}

	public int bkyumonth(int bkyu,String code){

		try{

			if(code.equals("93") || code.equals("94") || code.equals("95") || code.equals("f93") || code.equals("f94") || code.equals("f95") || code.equals("F93") || code.equals("F94") || code.equals("F95")){

				return bkyu + 1;

			}else{

				return bkyu;

			}

		}catch(Exception e){

			e.printStackTrace();

			return bkyu;

		}
	}

}
