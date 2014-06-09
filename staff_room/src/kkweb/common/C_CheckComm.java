package kkweb.common;

public class C_CheckComm {

	private boolean checkNull(String val){

		try{

			if(val == null){
				return false;
			}

			val = val.trim();

			if(val.equals("")){
				return false;
			}

			return true;

		}catch(Exception e){
			return false;
		}
	}

	public String retCheckNull(String val,int kbn){

		if(!checkNull(val)){
			switch(kbn){

			case 1:

				return "入力必須項目です";
			}
		}
		return null;
	}
}
