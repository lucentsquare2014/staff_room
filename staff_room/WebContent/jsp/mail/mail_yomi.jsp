<%@ page contentType="text/html; charset=UTF-8"
	import="java.util.*,
	        java.io.File,
            java.io.FileReader,
            java.io.BufferedReader,
            java.io.FileNotFoundException,
            java.io.IOException;"%>
            
<% String user2 = String.valueOf(session.getAttribute("login")); %>
<style type="text/css">
 	td#time {
 		font-size: 80%;
 		vertical-align: middle;
 	}
 	td#type {
 		background-color: #FAFAFA;
 	}
 	tr{white-space:nowrap;}
</style>
    <%
      	File file = new File("C:/workspace/pj/src/Javajava/Address3.txt");

        if(checkBeforeReadfile(file))
        {
        	BufferedReader br = new BufferedReader(new FileReader(file));
        	List<String> AIUEO = new ArrayList<String>();
        
        	String name;
        	while((name = br.readLine()) != null){
            	AIUEO.add( name );
        	}  
        	
        	List<String> name1 = new ArrayList<String>();		
        	List<String> yomi1 = new ArrayList<String>();		
        	List<String> mail1 = new ArrayList<String>();		
        			
        	for ( int i = 0; i < AIUEO.size(); ++i ) 
            {
   				if(i % 3 == 0){	 
   					name1.add(AIUEO.get(i));
         		}else if(i % 3 == 2){
        			mail1.add(AIUEO.get(i));
         		}else if(i % 3 == 1){
         			yomi1.add(AIUEO.get(i));
         		}
         	}
        
        	for ( int namename = 0; namename < name1.size(); ++namename){
          	out.println(yomi1.get(namename)+"<br>");
       }
     	
     	
     	}%>
 
     
     	
     	
	<%!
    private static boolean checkBeforeReadfile(File file){
    if (file.exists()){
    	if (file.isFile() && file.canRead()){
      		return true;
    	}
    }
    return false;
}
%>