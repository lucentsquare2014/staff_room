package kkweb.superclass;

import javax.servlet.*;
import javax.servlet.http.*;

public class C_ChangePageBase extends HttpServlet {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private final static String[] redirect_urls = {
		"SalaryPage",
		"OfficeDocuments",
		"MailSendToAllUserPayslip",
		"SelectAddressPayslip",
		"SystemSelect"
	};
	private final static String url = "//localhost:8080/kk_web";
//	private final static String url = "http://www.lucentsquare.co.jp:8080/kk_web";

	public void doGet(HttpServletRequest request, HttpServletResponse response){

		doTask(request,response);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response){

		doTask(request,response);

	}

	public void doTask(HttpServletRequest request, HttpServletResponse response){

		try{
//			long time11 = System.currentTimeMillis();
			String nextpage = null;
			String errmsg = "";
			String chk_ses = "";

			chk_ses = checkSession(request);

			if(!chk_ses.equals("NG")){

				errmsg = checkRequest(request);

				setBean(request, errmsg);

				if (errmsg!=null && !errmsg.equals("")){
					nextpage = backPage(request);

				}else{
					nextpage = nextPage(request);
					doMain(request);
//					long time8 = System.currentTimeMillis();
//					long time9 = time8-time11;
//					System.out.println("時間"+time9);
				}
			}else{

				nextpage = nextPage(request);
			}
			gotoPage(request,response,nextpage);

		}catch(Exception e){

		}
	}

	public ServletContext gotoPage(HttpServletRequest request, HttpServletResponse response,String nextpage){

		try{
			// 既存処理
			ServletContext context = getServletContext();
			RequestDispatcher rd = context.getRequestDispatcher(nextpage);
			//System.out.println("disp : " + nextpage);

			for(String t : redirect_urls){ // リダイレクトリストにあるurlにリンクする場合
				if(nextpage.indexOf(t) >= 0){
					response.sendRedirect(url + nextpage);
					return null;
				}
			}
			// 既存のページ
			rd.forward(request, response); //
			//response.sendRedirect(url + nextpage);
			return null;

		}catch(Exception e){

			return null;
		}
	}

	public String checkSession(HttpServletRequest request){

		String chk_ses = "";
		return chk_ses;
	}

	public String checkRequest(HttpServletRequest request){

		return null;
	}

	public String nextPage(HttpServletRequest request){

		return null;
	}

	public String backPage(HttpServletRequest request){

		return null;
	}

	public void setBean(HttpServletRequest request, String errmsg){

		return;
	}

	public void doMain(HttpServletRequest request){

	}
}