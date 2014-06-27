package file;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class IpAddressFilter
 */
@WebFilter("/IpAddressFilter")
public class IpAddressFilter implements Filter {

    /**
     * Default constructor. 
     */
	private FilterConfig config;
	private String allow_ip;
	
    public IpAddressFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		this.config = null;
		this.allow_ip = null;
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		// クライアントのIPアドレスを取得
		final String ip_address = ((HttpServletRequest)request).getRemoteAddr();
		if(ip_address.startsWith(allow_ip) 
				){
			chain.doFilter(request, response);
		}else{
			String page = ((HttpServletRequest)request).getRequestURI();
			if(page.indexOf("document") != -1){
				((HttpServletResponse) response).sendRedirect("/staff_room/jsp/error/ip_forbidden.jsp");
			}else{
				((HttpServletResponse) response).sendError(HttpServletResponse.SC_FORBIDDEN);
			}
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		this.config = fConfig;
		this.allow_ip = config.getInitParameter("allowIP");
	}

}
