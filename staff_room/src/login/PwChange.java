package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import dao.AccessDB;

/**
 * Servlet implementation class PwChange
 */
//@WebServlet("/PwChange")
public class PwChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PwChange() {
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
		String pwd = DigestUtils.sha1Hex(request.getParameter("now_pw1"));
		String id = session.getAttribute("login").toString();
		String new_pwd = DigestUtils.sha1Hex(request.getParameter("new_pw1"));
		if(pwCheck(id, pwd, new_pwd)){
			response.sendRedirect("/staff_room/jsp/pwChange/pwChange_finish.jsp");
		}else{
			String msg = "現在のパスワードが間違っています。もう一度入力してください。";
	    	request.setAttribute("error",msg);
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/pwChange/pwChange.jsp");
	    	dispatcher.forward(request, response);
		}
	}
	
	private boolean pwCheck(String id, String pwd, String new_pwd){
		AccessDB shain = new AccessDB();
		Connection con = shain.openDB();
		String sql = "SELECT * FROM shainmst WHERE id = ? AND pw = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
		    pstmt.setString(2, pwd);
		    ResultSet rs = pstmt.executeQuery();
		    if(!rs.next()){
		    	return false;
		    }else{
		    	String update = "UPDATE shainmst SET " + "pw=?" + " WHERE id=?";
		    	pstmt = con.prepareStatement(update);
		    	pstmt.setString(1, new_pwd);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				return true;
		    }
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			shain.closeDB(con);
		}
	}

}
