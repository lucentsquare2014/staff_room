package kkweb.beans;

public class B_Jido_Keisan {

	private String[] PROJECTcode;
	private String[] KINMUcode;
	private String[] startTIME;
	private String[] endTIME;
	private String[] restTIME;

	public void clear(){

	}

	public String[] getPROJECTcode(){
		return PROJECTcode;
	}

	public void setPROJECTcode(String[] PROJECTcode){
		this.PROJECTcode = PROJECTcode;
	}

	public String[] getKINMUcode(){
		return KINMUcode;
	}
	public void setKINMUcode(String[] KINMUcode){
		this.KINMUcode = KINMUcode;
	}
	public String[] getStartTIME(){
		return startTIME;
	}
	public void setStartTIME(String[] startTIME){
		this.startTIME = startTIME;
	}
	public String[] getEndTIME(){
		return endTIME;
	}
	public void setEndTIME(String[] endTIME){
		this.endTIME = endTIME;
	}
	public String[] getRestTIME(){
		return restTIME;
	}
	public void setRestTIME(String[] restTIME){
		this.restTIME = restTIME;
	}
}