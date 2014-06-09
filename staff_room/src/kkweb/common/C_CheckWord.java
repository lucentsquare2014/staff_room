package kkweb.common;

public class C_CheckWord  {
	public String checks (String args){
		try{
			if(args.equals("")){
				return "";
			}else{
				args = args.replaceAll("<","");
				args = args.replaceAll(",","");
				args = args.replaceAll(";","");
				args = args.replaceAll("'","");
			return args;
			}
		}catch (Exception e){
			e.printStackTrace();
			return "";
		}

	}

}
