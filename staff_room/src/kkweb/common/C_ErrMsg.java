package kkweb.common;

public class C_ErrMsg {

	public String errMsgConn(String msg, String msgAdd, String obj){

		if(!msg.equals("") && msgAdd != null){
			msg = msg + obj + msgAdd;

			return msg;
		}

		return "";
	}
}
