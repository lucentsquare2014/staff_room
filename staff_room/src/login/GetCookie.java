package login;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class GetCookie {
	// 指定の名前のクッキーを取り出すメソッドの定義
	public static Cookie get(String s, HttpServletRequest req){
	    Cookie[] cookies = req.getCookies();
	    Cookie res = null;
	    if (cookies != null){
	        for(Cookie c : cookies){
	            if (s.equals(c.getName())){
	                res = c;
	                break;
	            }
	        }
	    }
	    return res;
	}
}
