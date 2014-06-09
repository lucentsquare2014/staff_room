package kkweb.common;

import kkweb.dao.LoginDAO;

import org.apache.commons.codec.digest.DigestUtils;

public class C_CheckSystemLogin {

	private boolean checkIsTherePw(String Password){

		boolean flag = true;

		LoginDAO dao = new LoginDAO();
		String Password2 = DigestUtils.sha1Hex(Password);
		
		String sql = " where pw ='"+Password2+"' AND id = 'admin'";
		flag = dao.isThereTbl(sql);

		return flag;
	}

	public String retCheckIsTherePw(String Password,int kbn){

		if(!checkIsTherePw(Password) == true){
			switch(kbn){
			case 1:

				String msg = "パスワードを確認してください";

				return msg;
			}
		}
		return null;
	}

}
