package kkweb.beans;

import java.sql.Date;

// 過去の給与明細書をリスト化する際に使用する年月を表すクラス
public class YearMonthOfPayslip {
	
	private String year;
	private String month;
	private String sikyuukubun;
	private Date yearmonth;
	
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
	public String getSikyuukubun() {
		return sikyuukubun;
	}
	public void setSikyuukubun(String sikyuukubun) {
		this.sikyuukubun = sikyuukubun;
	}
	public Date getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(Date yearmonth) {
		this.yearmonth = yearmonth;
	}
	
}
