package kkweb.beans;

public class ShainInfo {
	private String id;
	private String pw;
	private String checked;
	private String name;
	private String number;
	private String groupnumber;
	private String mail;
	private String zaiseki_flg;
	private String checker;
	private String syounin_junban;
	
	public ShainInfo(){
		this.id = null;
		this.pw = null;
		this.checked = null;
		this.name = null;
		this.number = null;
		this.groupnumber = null;
		this.mail = null;
		this.zaiseki_flg = null;
		this.checker = null;
		this.syounin_junban=null;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getChecked() {
		return checked;
	}

	public void setChecked(String checked) {
		this.checked = checked;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getGroupnumber() {
		return groupnumber;
	}

	public void setGroupnumber(String groupnumber) {
		this.groupnumber = groupnumber;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getZaiseki_flg() {
		return zaiseki_flg;
	}

	public void setZaiseki_flg(String zaiseki_flg) {
		this.zaiseki_flg = zaiseki_flg;
	}

	public String getChecker() {
		return checker;
	}

	public void setChecker(String checker) {
		this.checker = checker;
	}
	
	public String getSyounin_junban() {
		return syounin_junban;
	}
	public void setSyounin_junban(String syounin_junban) {
		this.syounin_junban = syounin_junban;
	}
	
	public String toString(){
		String str = "";
		str += id + ":";
		str += pw + ":";
		str += checked + ":";
		str += name + ":";
		str += number + ":";
		str += groupnumber + ":";
		str += mail + ":";
		str += zaiseki_flg + ":";
		str += checker;
		str += syounin_junban;
		return str;
	}
}
