package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import dao.NewsDAO;
import dao.ShainDB;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		// Login.jspからidとpasswordを取得する
		String id = request.getParameter("id").trim();
	    String pwd = request.getParameter("password").trim();
	    
	    HttpSession session = request.getSession(true);
	    // idとパスワードが一致しているかチェックする
	    boolean check = authUser(id, pwd);
	    if(check) {
/* クッキーでセッションが切れてもログイン情報を保持できる処理（作業中）
 * 		    // ログイン情報を保持するにチェックがついていたらランダムな文字列を生成して
		    // DBとクッキーに保存する.
	    	String remember = request.getParameter("remember_me");
		    if(remember.equals("1")){
		    	String cookie_id = UUID.randomUUID().toString();
		    	System.out.println("cookie: "+ cookie_id);
		    	// クッキーを生成して追加
		    	Cookie newcookie = new Cookie("cookie_id", cookie_id);
		        newcookie.setMaxAge(60 * 60 * 24 * 3); // クッキーの有効期限１秒単位
		        response.addCookie(newcookie);		    	
		        
		    }
*/
	    	// セッションにログインユーザーとパスワードを保存（パスワードは社内システムの改修時に削除予定）
	    	session.setAttribute("login", id);
	    	session.setAttribute("password", pwd);

	    	// 現在の社員データを取得しlogin_timeを更新する
	    	String[] kanri_info = getInfo(id);
	    	// 最終ログインの時間を変数に格納
	    	String last_login = kanri_info[1].substring(0, kanri_info[1].indexOf("."));
	    	
	    	// 最終ログイン時以降更新された記事のIDを取得
	    	NewsDAO news = new NewsDAO();
	    	String new_ids = news.getNewsFromLastLogin(last_login);
	    	if( new_ids != null){
	    		// 前回までの未読記事に今回取得した未読記事を追加してデータベースを更新する
	    		updateReadCheck(kanri_info[2], new_ids, kanri_info[0]);
	    		kanri_info[2] = kanri_info[2] + new_ids;
	    	}

	    	// 未読記事の情報をセッションに保存
	    	session.setAttribute("unread",kanri_info[2]);
	    	// top画面に遷移
	    	response.sendRedirect("./jsp/top/top.jsp");
	    } else {

	    	// ログイン回数をプラスする
	    	int n = Integer.valueOf(String.valueOf(session.getAttribute("count")));
	    	session.setAttribute("count", ++n);
	    	String msg = "idまたはパスワードが正しくありません。";
	    	request.setAttribute("error",msg);
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
	    }
	}
	
	//idとpasswordは一致しているかをデータベースに照合
	protected boolean authUser(String id, String pwd) {
		if(id == null || id.length() == 0 || pwd == null || pwd.length() == 0) {
			return false;
		}
		//　互換性を保つためにパスワードを暗号化に使用する
		pwd =  DigestUtils.sha1Hex(pwd);
		// 社員データベースから照合する
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		String sql = "SELECT * FROM shainmst WHERE id = ? AND pw = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
		    pstmt.setString(2, pwd);
		    ResultSet rs = pstmt.executeQuery();
		    if(rs.next()){
		    	shain.closeShainDB(con);
		    	return true;
		    } else{
		    	shain.closeShainDB(con);
		    	return false;
		    }
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	//社員の管理情報を取得、今回のlogin_timeを更新
	private String[] getInfo(String id){
		String sql = "SELECT * FROM shainkanri WHERE shain_number = " +
				"(SELECT number FROM shainmst WHERE id = '" + id + "')";
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		Statement stmt;
		String[] data = new String[4];
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				data[0] = rs.getString("shain_number");
				data[1] = rs.getString("login_time");
				data[2] = rs.getString("read_check");
				data[3] = rs.getString("cookie");
			}
			String update_sql = "UPDATE shainkanri SET login_time = current_timestamp WHERE shain_number = '" + data[0] + "'";
			stmt.executeUpdate(update_sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		shain.closeShainDB(con);
		return data;
	}
	
	//未読記事を更新する
	private void updateReadCheck(String unread_ids,String new_ids,String number){
		String update_ids = unread_ids + new_ids;
		String sql = "UPDATE shainkanri SET read_check = '" + update_ids + 
				"' WHERE shain_number = '" + number + "'";
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		Statement stmt;
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		shain.closeShainDB(con);
	}

}
