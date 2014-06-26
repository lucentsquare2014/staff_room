package news;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NewsDAO;

/**
 * Servlet implementation class SaveNews
 */
//@WebServlet("/SaveNews")
public class SaveNews extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveNews() {
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
		
		//入力フォームから渡されたデータをHashMap型newsWriteに格納
		HashMap<String, String> Newsdata = new HashMap<String, String>();
		
		Newsdata.put("post_id", request.getParameter("inputPostid"));
		Newsdata.put("title", new String(request.getParameter("inputTitle").getBytes("ISO-8859-1"), "UTF-8"));
		Newsdata.put("text", new String(request.getParameter("inputText").getBytes("ISO-8859-1"), "UTF-8"));
		Newsdata.put("filename", new String(request.getParameter("inputFiles").getBytes("ISO-8859-1"), "UTF-8"));
		Newsdata.put("writer", new String(request.getParameter("inputWriter").getBytes("ISO-8859-1"), "UTF-8"));
		Newsdata.put("primary_flag", request.getParameter("inputPrimary"));
		// DAOからメソッドの呼び出し
		NewsDAO dao = new NewsDAO();
		//確認画面から渡されたname="inputNewsid"がnullかどうかで呼ぶメソッドを判断 文字コード変換のせいでnullという文字列になっていることに注意
		if(request.getParameter("inputNewsid")==null || request.getParameter("inputNewsid").equals("null")){
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss");
			Newsdata.put("created", sdf.format(date));
			//データベースにhashMapから書き込み
			// post_idのシーケンスを最新のものに更新
			dao.setPostIdSequence();
			dao.writeNews(Newsdata);
		}else{
			Newsdata.put("news_id", request.getParameter("inputNewsid"));
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd  HH:mm:ss");
			Newsdata.put("update", sdf.format(date));
			//データベースにhashMapから更新
			dao.updateNews(Newsdata);
		}
		response.sendRedirect("/staff_room/jsp/writeNews/write_finish.jsp");
	}

}
