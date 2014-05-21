package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

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
	    	session.setAttribute("login", id);
	        response.sendRedirect("./jsp/top/top.jsp");
	    } else {
	    	session.setAttribute("status", "Not Auth");
	    	String msg = "idまたはパスワードが正しくありません。";
	    	request.setAttribute("error",msg);
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
            dispatcher.forward(request, response);
	        
	    }
	}
	
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

}
