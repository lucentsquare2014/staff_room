package kkweb.beans;

import java.sql.Date;

public class PayslipURL {
	private String number;
	private String url;
	private Date limit;
	private Date yearmonth;
	
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getLimit() {
		return limit;
	}
	public void setLimit(Date limit) {
		this.limit = limit;
	}
	public Date getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(Date yearmonth) {
		this.yearmonth = yearmonth;
	}
	
	
}
