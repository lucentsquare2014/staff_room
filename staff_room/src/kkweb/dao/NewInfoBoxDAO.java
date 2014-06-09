package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kkweb.beans.NewInfoBox;
import kkweb.beans.Paper;
import kkweb.beans.PaperStatus;
import kkweb.beans.PayslipStatus;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundIDException;

public class NewInfoBoxDAO {
	// アクセスする列名
	private final String[] cols_name = {
			"code", "yearmonth", "update_stamp", "paper_type", "comment"
	};

	public NewInfoBox getNewInfoBox(String number, int limit){
		NewInfoBox box = new NewInfoBox();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して書棚データを取得する
		String sql =
				"select distinct pc.number, pc.yearmonth, pc.update_stamp, pc.code, pc.comment ," +
				" pt.paper_type, pat.pay_type, ps.sikyuukubun " +
				"from paperschest as pc left join paperstype as pt " +
						"on pc.code = pt.code " +
						"left join payslip ps " +
						"on pc.code = ps.paper_code and pc.yearmonth=ps.yearmonth " +
						"left join paytype pat " +
						"on ps.sikyuukubun=pat.code " +
						"where pc.number = ? " +
						"order by update_stamp desc , pc.yearmonth desc " +
						"offset 0 limit ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			stmt.setInt(2, limit);
			rs = stmt.executeQuery();
			// 各書類のタイプコード
			ArrayList<String> code = new ArrayList<String>();
			// 各書類の書類名
			ArrayList<String> names = new ArrayList<String>();
			// 各書類の年月
			ArrayList<Date> ym = new ArrayList<Date>();
			// 各書類の更新日時
			ArrayList<Date> updateStamp = new ArrayList<Date>();
			// 各書類のコメント
			ArrayList<String> comments = new ArrayList<String>();
			// 各書類のキーになる値
			ArrayList<String> anyKey = new ArrayList<String>();
			// 作成日時と更新日時を追加
			while(rs.next()){
				int index = 0;
				code.add(rs.getString("code"));
				ym.add(rs.getDate("yearmonth"));
				updateStamp.add(rs.getDate("update_stamp"));
				names.add(rs.getString("paper_type"));
				comments.add(rs.getString("comment"));
				if(rs.getString("code").equals("01")){
					anyKey.add(rs.getString("sikyuukubun")+ ":" + rs.getString("pay_type") );
				}
			}
			box.setCodes(code);
			box.setNames(names);
			box.setUpdateStamps(updateStamp);
			box.setYearmonth(ym);
			box.setComments(comments);
			box.setStatus(createPaperStatus(ym, names, comments, anyKey));
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		/*
		catch (NotFoundIDException e) {
			e.printStackTrace();
		}
		*/
		finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}
		return box;
	}

	/*
	private ArrayList<Paper> createPaper(ArrayList<Date> yearmonth, ArrayList<String> pcode, String number) throws SQLException, NotFoundIDException{
		ArrayList<Paper> list = new ArrayList<Paper>();
		for(int i = 0; i < yearmonth.size(); i++){
			Paper p = null;
			String code = pcode.get(i);
			// 該当するコードに対応するオブジェクトを作成
			// 現状、支給区分給与のみに対応。　他区分に対応する必要あり
			if(code.equals("01")) p = new PayslipDAO().payslip(yearmonth.get(i), number, "01");
			// ここから下に新しい書類を作成する
			// if(code.equals("hoge")) p = new Hogehoge().hoge(pid.get(i));
			if(p == null) throw new NotFoundIDException();
			list.add(p);
		}
		return list;
	}
	*/

	private ArrayList<PaperStatus> createPaperStatus(
			ArrayList<Date> yearmonth, ArrayList<String> names, ArrayList<String> comments,
			ArrayList<String> anyKey
			){
		ArrayList<PaperStatus> list = new ArrayList<PaperStatus>();

		for(int i = 0; i < yearmonth.size(); i++){
			Date ym = yearmonth.get(i);
			String name = names.get(i);
			String comment = comments.get(i);
			PaperStatus status = null;
			if(name.equals("給与明細書")){
				status = new PayslipStatus();
				String[] strs = anyKey.get(i).split(":");
				((PayslipStatus)status).setSikyuukubun(strs[0]);
				((PayslipStatus)status).setPaytype(strs[1]);
			}
			/* 以下新しい書類名を追加
			if(name.equals("hoge")) status = new HogeStatus();
			*/
			if(status == null) return list;
			status.setName(name);
			status.setComment(comment);
			status.setYearmonth(ym);
			list.add(status);
		}

		return list;
	}
}
