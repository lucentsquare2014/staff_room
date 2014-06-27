package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dao.AccessDB;

/**
 * Servlet Filter implementation class LoginFilter
 */
//@WebFilter("/LoginFilter")
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
		// アクセスされたURIを取得
		String accessURL = ((HttpServletRequest) request).getServletPath();
		System.out.println(accessURL + " (LoginFilter.jsp)");
		request.setAttribute("accessURL", accessURL);
		
		/* クッキー情報を確認してセッション情報も確認する*/
		Cookie login_cookie = GetCookie.get("login_cookie", (HttpServletRequest)request);
		if(login_cookie==null){
			// クッキーがない、もしくはクッキーを保存しない設定の場合にセッションも確認
			// 認証されているかセッション情報をチェックする
			HttpSession session = ((HttpServletRequest)request).getSession();
			if(session==null){
				session = ((HttpServletRequest)request).getSession(true);
		        //((HttpServletResponse)response).sendRedirect("/staff_room/login.jsp");
				RequestDispatcher dispatch = request.getRequestDispatcher("/login.jsp");
				dispatch.forward(request, response);
		        return;
			}else{
				Object loginCheck = session.getAttribute("login");
				if(loginCheck == null) {
					//((HttpServletResponse)response).sendRedirect("/staff_room/login.jsp");
					RequestDispatcher dispatch = request.getRequestDispatcher("/login.jsp");
					dispatch.forward(request, response);
					return;
				}
			}
		}else{
			String[] data = getInfo(login_cookie.getValue());
			HttpSession session = ((HttpServletRequest)request).getSession();
			session.setAttribute("login", data[0]);
			session.setAttribute("admin", data[1]);
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}
	
	private String[] getInfo(String cookie_id){
		String sql = "select id, administrator from shainmst where number=" +
				"(select shain_number from shainkanri where cookie=?)";
		AccessDB shain = new AccessDB();
		Connection con = shain.openDB();
		PreparedStatement pstmt;
		String[] data = new String[2];
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cookie_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				data[0] = rs.getString("id");
				data[1] = rs.getString("administrator");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			shain.closeDB(con);
		}
		return data;
	}
	
}
