package news;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String shain_num = request.getParameter("shain_number");
		String news_id = request.getParameter("news_id");
		try {
			// String型の配列を一旦ArrayListに変換
			List<String> read_check = new ArrayList<String>(Arrays.asList(this.getReadchk(shain_num)));

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
			
			// read_checkを更新
			this.updateReadchk(update_str);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	/* read_checkを更新するメソッド */
	private String updateReadchk(String read_check) throws SQLException{
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		String sql = "update shainkanri set read_check=?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, read_check);
		
		pstmt.executeUpdate();
		shain.closeShainDB(con);
		return "";
	}
	
	/* 現在のread_checkにはいってるデータを取得してカンマ区切り配列として返すメソッド
	 * 
	 * 現在は配列に変換して返しているが将来的には正規表現で返す（正規表現で返すとは言ってない）
	 *  */
	private String[] getReadchk(String id) throws SQLException{
		ShainDB shain = new ShainDB();
		Connection con = shain.openShainDB();
		// 社員番号で誰の未読かを判別する
		String sql = "select read_check from shainkanri where shain_number = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		String read_check = null;
		// ResultSetのカーソルを先頭に持ってくる
		rs.first();
		while(rs.next()){
			read_check = new StringBuilder(rs.getString("read_check")).toString();
		}
		//　取得した文字列をカンマで区切って配列に変換 → 例："1,2,3,4"を{1,2,3,4}に
		String[] result = read_check.split(","); 
		shain.closeShainDB(con);
		return result;
	}

}
