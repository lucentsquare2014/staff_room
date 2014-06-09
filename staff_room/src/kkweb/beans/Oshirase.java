package kkweb.beans;

import java.sql.Date;

public class Oshirase extends Paper{
	private Date yearmonth;
	private String koumoku;
	private Integer linenumber;
	
	public Date getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(Date yearmonth) {
		this.yearmonth = yearmonth;
	}
	public String getKoumoku() {
		return koumoku;
	}
	public void setKoumoku(String koumoku) {
		this.koumoku = koumoku;
	}
	public Integer getLinenumber() {
		return linenumber;
	}
	public void setLinenumber(Integer linenumber) {
		this.linenumber = linenumber;
	}
	
	public String toString(){
		return super.toString() + "," +
				this.yearmonth + "," + this.koumoku + this.linenumber;
	}
	
}
