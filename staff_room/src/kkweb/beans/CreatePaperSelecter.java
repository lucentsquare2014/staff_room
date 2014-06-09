package kkweb.beans;

import java.util.*;

// 作成する文書を選択するセレクトリストを表すクラス
public class CreatePaperSelecter {
	
	// 書類コードリスト
	private ArrayList<String> codes;
	// 書類名リスト
	private ArrayList<String> types;
	
	public CreatePaperSelecter(){
		this.codes = new ArrayList<String>();
		this.types = new ArrayList<String>();
	}
	
	public void addCode(String code){
		this.codes.add(code);
	}
	
	public void addType(String type){
		this.types.add(type);
	}

	public ArrayList<String> getCodes() {
		return codes;
	}
	public void setCodes(ArrayList<String> codes) {
		this.codes = codes;
	}
	public ArrayList<String> getTypes() {
		return types;
	}
	public void setTypes(ArrayList<String> types) {
		this.types = types;
	}
	
}
