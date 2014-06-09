package kkweb.beans;

import java.sql.Date;
import java.util.ArrayList;


public class SendList {
	private ArrayList<ShainInfo> users;
	private ArrayList<Date> yearmonth;
	private ArrayList<String> sendlog;
	
	public SendList(){
		this.users = null;
		this.yearmonth = null;
		this.sendlog = null;
	}
	
	// 送信済みの数を返す
	public int countSended(){
		int c = 0;
		for(String s : sendlog)
			if(s.indexOf("送信済") >= 0) c++;
		
		return c;
	}
	
	
	public ArrayList<ShainInfo> getUsers() {
		return users;
	}

	public void setUsers(ArrayList<ShainInfo> users) {
		this.users = users;
	}


	public ArrayList<Date> getYearmonth() {
		return yearmonth;
	}


	public void setYearmonth(ArrayList<Date> yearmonth) {
		this.yearmonth = yearmonth;
	}


	public ArrayList<String> getSendlog() {
		return sendlog;
	}


	public void setSendlog(ArrayList<String> sendlog) {
		this.sendlog = sendlog;
	}
	
	
	
}
