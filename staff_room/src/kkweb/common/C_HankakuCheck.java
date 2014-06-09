package kkweb.common;

public class C_HankakuCheck {

	private boolean checkHanAlph (String item){	//チェックする文字列
		boolean flag = true;
		for(int i=0; item.length()>i && flag==true; i++){

			if(('a'<=item.charAt(i) && item.charAt(i)<='z')||
					('A'<=item.charAt(i) && item.charAt(i)<='Z')){
			}else{
				flag=false;
			}
		}
		return flag;
	}

	public String retCheckHanAlph(	String val,	//チェックする文字列
									int kbn)	//エラーメッセージ区分
	{
		if(!checkHanAlph(val)){
			switch (kbn){
			case 1:
				return "半角英字で入力してください。";
			}
		}
		return null;
	}

}
