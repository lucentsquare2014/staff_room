package kkweb.beans;

import java.sql.Date;


// 給与明細書の
public class PayslipStatus extends PaperStatus{
	private String tag;
	private String sikyuukubun;
	private String paytype;
	
	public PayslipStatus(){
		super();
		this.tag = "";
		this.sikyuukubun = "";
	}
	
	// 年月が登録された場合にtagを生成
	public void setYearmonth(Date yearmonth){
		super.setYearmonth(yearmonth);
		String[] ymd = yearmonth.toString().split("-");
		this.setTag(" (" + ymd[0] + "年" + ymd[1] + "月支給分" + ") ");
	}
	
	// 名前にタグをつけて返す
	public String getName(){
		return super.getName() + this.getTag();
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getSikyuukubun() {
		return sikyuukubun;
	}

	public void setSikyuukubun(String sikyuukubun) {
		this.sikyuukubun = sikyuukubun;
	}

	public String getPaytype() {
		return paytype;
	}

	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	
	public String getComment(){
		return "(支給区分 : " + this.paytype + ") " + super.getComment();
	}
}
