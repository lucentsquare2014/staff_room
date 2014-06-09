package kkweb.beans;

import java.sql.Date;
import java.util.ArrayList;

// 新着情報を表すクラス
public class NewInfoBox {
	// 各書類のIDを表す
	private ArrayList<String> codes;
	// 各書類の名前を表す
	private ArrayList<String> names;
	// sqlパッケージのDateリスト
	// 各書類の作成年月を表す
	private ArrayList<Date> yearmonth;
	// sqlパッケージのDateリスト
	// 各書類の更新日時を表す
	private ArrayList<Date> updateStamps;
	// 各書類のコメントを表す
	private ArrayList<String> comments;
	// 書類のステータスリスト
	private ArrayList<PaperStatus> status;

	public NewInfoBox(){
		this.comments = new ArrayList<String>();
		this.codes = new ArrayList<String>();
		this.yearmonth = new ArrayList<Date>();
		this.updateStamps = new ArrayList<Date>();
		this.comments = new ArrayList<String>();
		this.status = new ArrayList<PaperStatus>();
	}

	// 書類の種類コード一覧を返す
	public ArrayList<String> getPaperList(){
		ArrayList<String> list = new ArrayList<String>();
		for(String c : this.codes){
			if(!list.contains(c)) list.add(c);
		}
		return list;
	}

	// 重複なし書類名一覧を返す
	public ArrayList<String> getPaperNameList(){
		ArrayList<String> list = new ArrayList<String>();
		for(String c : this.names){
			if(!list.contains(c)) list.add(c);
		}
		return list;
	}

	public String toString(){
		return yearmonth.toString() +
				updateStamps.toString() +
				comments.toString() +
				names.toString() +
				status.toString();
	}

	// getterとsetter
	public ArrayList<String> getCodes() {
		return codes;
	}
	public void setCodes(ArrayList<String> codes) {
		this.codes = codes;
	}


	public ArrayList<String> getNames() {
		return names;
	}

	public void setNames(ArrayList<String> names) {
		this.names = names;
	}

	public ArrayList<Date> getYearmonth() {
		return yearmonth;
	}
	public void setYearmonth(ArrayList<Date> createStamps) {
		this.yearmonth = createStamps;
	}
	public ArrayList<Date> getUpdateStamps() {
		return updateStamps;
	}
	public void setUpdateStamps(ArrayList<Date> updateStamps) {
		this.updateStamps = updateStamps;
	}

	public ArrayList<String> getComments() {
		return comments;
	}

	public void setComments(ArrayList<String> comments) {
		this.comments = comments;
	}

	public ArrayList<PaperStatus> getStatus() {
		return status;
	}

	public void setStatus(ArrayList<PaperStatus> status) {
		this.status = status;
	}
}
