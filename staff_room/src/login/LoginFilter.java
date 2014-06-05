package login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("/LoginFilter")
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/* クッキー情報を確認してセッション情報も確認する*/
		Cookie login_cookie = GetCookie.get("login_cookie", (HttpServletRequest)request);
		if(login_cookie==null){
			// クッキーがない、もしくはクッキーを保存しない設定の場合にセッションも確認
			// 認証されているかセッション情報をチェックする
			HttpSession session = ((HttpServletRequest)request).getSession();
			if(session==null){
				session = ((HttpServletRequest)request).getSession(true);
		        ((HttpServletResponse)response).sendRedirect("/staff_room/login.jsp");
		        return;
			}else{
				Object loginCheck = session.getAttribute("login");
				if(loginCheck == null) {
					((HttpServletResponse)response).sendRedirect("/staff_room/login.jsp");
					return;
				}
			}
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
