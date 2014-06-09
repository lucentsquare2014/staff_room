package kkweb.beans;

// 書類を表すクラス
// 各書類および給与明細書はこのクラスを継承する
public class Paper {
	private String number;
	private String year;
	private String month;
	private String url;

	// 新着情報用に自身の状況をカンマ区切りで返す
	// 継承したクラスはこのメソッドをオーバーライドする
	public String toStatus(){
		return  this.number + "," +
				this.year + "," +
				this.month;
	}
	
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	// 継承したクラスはこのメソッドをオーバーライドする
	public String toString(){
		return 	this.number + "," +
				this.year + "," +
				this.month + "," +
				this.url;
	}
}
