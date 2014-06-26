package news;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewsDAO;

/**
 * Servlet implementation class DeleteNews
 */
//@WebServlet(description = "記事を削除する", urlPatterns = { "/DeleteNews" })
public class DeleteNews extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteNews() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// writeNews.jspから送信された削除する記事のIDを取得
		String del_id = request.getParameter("del_id");
		// 送信されてきた記事IDの文字列を配列に変換
		String[] ids = del_id.split(",",0);
		NewsDAO dao = new NewsDAO();
		dao.deleteNews(ids);		
	}

}
