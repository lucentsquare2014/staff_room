package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import dao.ShainDB;

/**
 * Servlet implementation class Login
 */
//@WebServlet("/Login")
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
		Cookie login_cookie = GetCookie.get("login_cookie", request);
		if(login_cookie!=null){
			this.doPost(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// アクセスされたURLを取得
		String accessURL = request.getParameter("accessURL").toString();
		System.out.println(accessURL + "(Login.jsp)");
		// Login.jspからidとpasswordを取得する
		String id = request.getParameter("id").trim();
	    String pwd = request.getParameter("password").trim();
	    //ユーザの名前
	    String username = "";
	    
	    HttpSession session = request.getSession(true);
	    // idとパスワードが一致しているかチェックする
	    boolean check = authUser(id, this.passEncryption(pwd, request));
	    if(check) {

	    	//クッキーでセッションが切れてもログイン情報を保持できる処理
	    	// ログイン情報を保持するにチェックがついていたら一意な暗号化文字列を生成して
		    // DBとクッキーに保存する.
	    	String remember = request.getParameter("remember_me");
		    if(remember!=null){
		    	String login_hash = DigestUtils.sha1Hex(id);
		    	// クッキーを生成
		    	Cookie login_cookie = new Cookie("login_cookie", login_hash);
		    	// クッキーの有効期限(１秒単位)を設定
		    	int day = 60*60*24;
		    	login_cookie.setMaxAge(14 * day); 
		    	// テスト用に５分
		    	//login_cookie.setMaxAge(300); 
		    	// ユーザー側にクッキーを追加
		        response.addCookie(login_cookie);
		        // DB側にクッキーを保存
		        this.saveCookie(login_hash, id);
		        
		    }

	    	// セッションにログインユーザーIDを保存
	    	session.setAttribute("login", id);
	    	String[] userInfo = getAdmin(id);
	    	String adm = userInfo[0];
	    	if(adm==null){
	    		adm="";
	    	}
	    	session.setAttribute("admin", adm);
	    	session.setAttribute("username", userInfo[1]);
	    	response.sendRedirect("/staff_room"+accessURL);
	    	//RequestDispatcher dispatcher = request.getRequestDispatcher(accessURL);
            //dispatcher.forward(request, response);
	    	return;
	    } else {

	    	// ログイン回数をプラスする
	    	int n = Integer.valueOf(String.valueOf(session.getAttribute("count")));
	    	session.setAttribute("count", ++n);
	    	String msg = "idまたはパスワードが正しくありません。";
	    	request.setAttribute("error",msg);
	    	request.setAttribute("accessURL", accessURL);
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
	    }
	}
	
	//idとpasswordは一致しているかをデータベースに照合
	protected boolean authUser(String id, String pwd) {
		if(id == null || id.length() == 0 || pwd == null || pwd.length() == 0) {
			return false;
		}
/*		//　互換性を保つためにパスワードを暗号化に使用する
		pwd =  DigestUtils.sha1Hex(pwd);
		System.out.println(pwd);
*/
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
	
	/* shainkanriのcookieに文字列を保存する */
	private void saveCookie(String cookie, String id){
		ShainDB shaindb = new ShainDB();
		Connection con = shaindb.openShainDB();
		String sql = "update shainkanri set cookie = ? where shain_number ="
				     + "(SELECT number FROM shainmst WHERE id = ?)";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cookie);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			shaindb.closeShainDB(con);
		}
	}
	
	// ログインしたユーザー管理者かどうかを判断する
	private String getAdmin(String id){
		ShainDB shaindb = new ShainDB();
		Connection con = shaindb.openShainDB();
		String sql = "select administrator from shainmst where id=?";
		String result = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				result = rs.getString("administrator");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			shaindb.closeShainDB(con);
		}
		return result;
	}
	
	// クッキーがなければパスワードを暗号化する
	private String passEncryption(String pwd ,HttpServletRequest request){
		Cookie login_cookie = GetCookie.get("login_cookie", request);
		String pass = pwd;
		if(login_cookie==null){
			pass =  DigestUtils.sha1Hex(pwd);
		}
		return pass;
	}
}
