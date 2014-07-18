package kkweb.beans;

public class B_ShainMST {

	private String id;
	private String pw;
	private String checked;
	private String name;
	private String number;
	private String GROUPnumber;
	private String mail;
	private String zaiseki_flg;
	private String hyouzijun;
	private String yakusyoku;
	// フリガナを追加
	private String hurigana;
	// 管理権限の追加
	private String administrator;

	public String getYakusyoku() {
		return yakusyoku;
	}
	public void setYakusyoku(String yakusyoku) {
		this.yakusyoku = yakusyoku;
	}
	
	public String getHyouzijun() {
		return hyouzijun;
	}
	public void setHyouzijun(String hyouzijun) {
		this.hyouzijun = hyouzijun;
	}
	
	public String getZaiseki_flg() {
		return zaiseki_flg;
	}
	public void setZaiseki_flg(String zaiseki_flg) {
		this.zaiseki_flg = zaiseki_flg;
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

	public String getGROUPnumber() {
		return GROUPnumber;
	}
	public void setGROUPnumber(String GROUPnumber) {
		this.GROUPnumber = GROUPnumber;
	}

	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getHurigana() {
		return hurigana;
	}
	public void setHurigana(String hurigana) {
		this.hurigana = hurigana;
	}
	
	public String getAdministrator() {
		return administrator;
	}

	public void setAdministrator(String administrator) {
		this.administrator = administrator;
	}
	
}