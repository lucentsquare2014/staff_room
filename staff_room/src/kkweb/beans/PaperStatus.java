package kkweb.beans;

import java.sql.Date;

public abstract class PaperStatus {
	// 書類の年月
	private Date yearmonth;
	// インスタンス固有の書類名
	private String name;
	// コメント
	private String comment;
	
	public PaperStatus(){
		this.comment = "";
		this.name = "";
		this.yearmonth = null;
	}
	
	public Date getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(Date yearmonth) {
		this.yearmonth = yearmonth;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	
	
}
