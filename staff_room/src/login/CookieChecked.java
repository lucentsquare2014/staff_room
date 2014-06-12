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

import dao.ShainDB;
/**
 * Servlet implementation class CookieChecked
 */
//@WebServlet("/CookieChecked")
public class CookieChecked extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CookieChecked() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cookie login_cookie = GetCookie.get("login_cookie", request);
		if(login_cookie!=null){
			
			// クッキーが渡されているかを確認テスト
			System.out.println(login_cookie.getName());
			System.out.println(login_cookie.getValue());
			String[] data = getInfo(login_cookie.getValue());
			String fwstr = "/Login?id="+data[0]+"&password="+data[1];
			request.setAttribute("id", data[0]);
			request.setAttribute("password", data[1]);
			RequestDispatcher dispatch = request.getRequestDispatcher(fwstr);
			dispatch.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	
	private String[] getInfo(String cookie_id){
		String sql = "select id, pw from shainmst where number=" +
				"(select shain_number from shainkanri where cookie=?)";
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		PreparedStatement pstmt;
		String[] data = new String[2];
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cookie_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				data[0] = rs.getString("id");
				data[1] = rs.getString("pw");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			shain.closeShainDB(con);
		}
		return data;
	}

}
