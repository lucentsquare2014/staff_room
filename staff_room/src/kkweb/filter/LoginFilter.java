package kkweb.filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {

	/**
	 * Default constructor. 
	 */
	public LoginFilter() {
		// 
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// 
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//System.out.println("fil");
		request.setCharacterEncoding("shift-jis");
		try {
			HttpSession session = ((HttpServletRequest)request).getSession(false);
			String target = ((HttpServletRequest)request).getRequestURI();
			target = target.substring(target.lastIndexOf("/"));
			Enumeration<String> names = request.getParameterNames();
			if(names.hasMoreElements()) target += "?";
			while(names.hasMoreElements()){
				String n = names.nextElement();
				target += n + "=";
				target += request.getParameter(n);
				if(names.hasMoreElements()) target += "&";
			}
			//System.out.println("target : " + target);
			if (session == null ){
				//System.out.println("no session");
				/* まだ認証されていない */
				session = ((HttpServletRequest)request).getSession(true);
				session.setAttribute("target", target);
				
				request.getRequestDispatcher("ID_PW_Nyuryoku.jsp").forward(request, response);
			}else{
				//System.out.println("have session");
				Object loginCheck = session.getAttribute("key");
				Object shainmst = session.getAttribute("ShainMST");
				if (loginCheck == null || shainmst == null){
					/* まだ認証されていない */
					//System.out.println("no key");
					session.setAttribute("target", target);
					request.getRequestDispatcher("ID_PW_Nyuryoku.jsp").forward(request, response);
				}
			}
			// pass the request along the filter chain
			chain.doFilter(request, response);
		} catch (Exception e) {
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// 
	}

}
