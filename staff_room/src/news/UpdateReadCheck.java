package news;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import dao.ShainDB;

/**
 * Servlet implementation class UpdateReadCheck
 */
@WebServlet(description = "未読記事を更新するサーブレット", urlPatterns = { "/UpdateReadCheck" })
public class UpdateReadCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateReadCheck() {
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
		HttpSession session = ((HttpServletRequest)request).getSession();
		if(session == null) {
			session = ((HttpServletRequest)request).getSession(true);
		}
		// セッションに保存しているログインIDと未読記事のデータを取得
		String login_id = String.valueOf(session.getAttribute("login"));
		String unread = String.valueOf(session.getAttribute("unread"));
		// 送信された記事IDを取得
		String news_id = request.getParameter("news_id");

		try {
			// 文字列を一旦ArrayListに変換
			// 現在は配列に変換しているが将来的には正規表現で返す（正規表現で返すとは言ってない）
			List<String> read_check = this.toArrayList(unread, ",");

			/*
			// 要素を検索してその要素のインデックスを取得
			int news_index = read_check.indexOf(news_id);
			// インデックスの位置にある要素を削除
			read_check.remove(news_index);
			*/
			// インデックスを取得せずに要素を検索して直接削除する
			read_check.remove(news_id);
			
			/* 再びカンマ区切りの文字列に変換
			 * 正規表現は…誰かがするかも */
			String update_str = StringUtils.join(read_check, ",");
			
			// DBのread_checkを更新
			this.updateReadchk(update_str, login_id);
			// セッションにある未読記事の情報を更新
			session.setAttribute("unread", update_str);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	/* read_checkを更新するメソッド */
	private void updateReadchk(String read_check, String login_id) throws SQLException{
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		// 未読記事を更新する
		String sql = "update shainkanri set read_check=? where shain_number ="
				   + "(SELECT number FROM shainmst WHERE id = ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, read_check);
		pstmt.setString(2, login_id);
		
		pstmt.executeUpdate();
		shain.closeShainDB(con);
	}
	
	/* 
	 * 文字列をArrayList<String>に変換するメソッド
	 *
	 * @return ArrayList<String>を返す
	 *  */
	private ArrayList<String> toArrayList(String str, String separate_char){
		// 文字列を配列に変換 → 例："1,2,3,4"を{1,2,3,4}に
		String[] strArray = str.split(separate_char);
		ArrayList<String> result = new ArrayList<String>(Arrays.asList(strArray)); 
		return result;
	}

}
