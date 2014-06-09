package kkweb.common;

import kkweb.dao.LoginDAO;

import org.apache.commons.codec.digest.DigestUtils;

public class C_CheckLogin {

	private boolean checkIsThereshain(String shainId,String Password){
		
		//String Password1 = DigestUtils.sha1Hex(Password);
		String Password1 = Password;
		boolean flag = true;
		LoginDAO dao = new LoginDAO();
		
//		String sql = " where id ='"+shainId+"' AND pw ='"+Password+"' AND zaiseki_flg = '1'";
		String sql = " where id ='"+shainId+"' AND pw ='"+Password1+"' AND zaiseki_flg = '1'";
		flag = dao.isThereTbl(sql);

		return flag;
	}

	public String retCheckIsThereshain(String shainId,String Password,int kbn){

		if(!checkIsThereshain(shainId,Password) == true){
			switch(kbn){
			case 1:

				String msg = "IDとパスワードを確認してください";

				return msg;
			}
		}
		return null;
	}


}
