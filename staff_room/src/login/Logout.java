package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Logout() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// セッションを無効化する
		HttpSession session = request.getSession(true);
	    session.invalidate();
	    // クッキーを削除する
	    Cookie login_cookie = GetCookie.get("login_cookie", request);
	    Cookie pass_cookie = GetCookie.get("pass_cookie", request);
	    if(login_cookie!=null){
	    	login_cookie.setMaxAge(0);
		    response.addCookie(login_cookie);
	    	
	    }
	    if(pass_cookie!=null){
	    	pass_cookie.setMaxAge(0);
		    response.addCookie(pass_cookie);
	    	
	    }
	    // 会社のHPへ飛ばす
	    response.sendRedirect("http://www.lucentsquare.co.jp/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
