package kkweb.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kkweb.beans.Payslip;
import kkweb.common.C_DBConnectionAbs;
import kkweb.common.C_DBConnectionPaperschest;
import kkweb.error.NotFoundIDException;


// 給与明細書に必要なデータにアクセスするクラス
public class PayslipDAO {
	// アクセスする列名
	// 20140407 modify 白賀　401k導入に伴い項目追加
	private final String[] cols_name = {
			"number","yearmonth", "pay_type",
			"nennreikyu","syokunoukyu", "jissekikyu", "sairyouteate","syokuiteate",	"chiikiteate", "huyouteate", "tyouseiteate",
			"tyuuzaiteate",	"tanhuteate","kazeiryohi","sonotakyu","genbutusikyu","sonotatoku","hikazeisonota",
			"tuukinteate","kazeituukin","tokubetutyouseigaku","kazeisikyukei","hikazeikei","sikyuugakugoukei",
			"kenkouhokenryou","kaigohokenryou","kouseinennkin","kouseikikin","koyouhokenryou","hokenryougoukei","kazeitaisyougaku","syotokuzei","juuminzei",
			"kihonkenporyou","zaikeitumitate","ryouhi","tatekaekin","maebaraikin","kabusikikyosyutukin","sonota",
			"tokuteikenporyou","ippankoujokei",	"koujogoukei",
			"yuukyuuzannjitu",
			"genbutusikyu","hurikomi1","hurikomi2","sasihikisikyuugaku",
			"owner_bill","member_bill"
	};

	// 年月, 社員番号, 支給区分コード
	public Payslip payslip(Date yearmonth, String number , String code){
		Payslip ps = new Payslip();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql =
				"select * from payslip " +
						"inner join paytype " +
						"on payslip.sikyuukubun = paytype.code " +
						"where yearmonth = ? and number = ? and code = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int index = 0;
		try {
			stmt = conn.prepareStatement(sql);

			stmt.setDate(1, yearmonth);
			stmt.setString(2, number);
			stmt.setString(3, code);
			rs = stmt.executeQuery();
			// 使用する給与明細書データ

			while(rs.next()){
				ps.setNumber(rs.getString(cols_name[index++]));
				String[] ymd = rs.getDate(cols_name[index++]).toString().split("-");
				ps.setYear(ymd[0]);
				ps.setMonth(ymd[1]);
				ps.setSikyuukubun(rs.getString(cols_name[index++]));
				// 3桁ごとにカンマを挿入
				ps.setNennreikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokunoukyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJissekikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSairyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokuiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setChiikiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHuyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyouseiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyuuzaiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTanhuteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeiryohi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotakyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotatoku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeisonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTuukinteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeituukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokubetutyouseigaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeisikyukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeikei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSikyuugakugoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKenkouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKaigohokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseinennkin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseikikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoyouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHokenryougoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeitaisyougaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyotokuzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJuuminzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKihonkenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setZaikeitumitate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setRyouhi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTatekaekin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMaebaraikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKabusikikyosyutukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokuteikenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setIppankoujokei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoujogoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				//ps.setYuukyuuzannjitu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setYuukyuuzannjitu(rs.getString(cols_name[index++]));
				if(ps.getYuukyuuzannjitu() == null) ps.setYuukyuuzannjitu("");
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi1(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi2(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSasihikisikyuugaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setOwner_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMember_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(!stmt.isClosed()) stmt.close();
				if(!rs.isClosed()) rs.close();
				if(!conn.isClosed()) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}
		// ヒットしたデータが無かった場合エラーを投げる
		if (index == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				//e.printStackTrace();
			}
		}
		return ps;

	}

	// 年月, 社員番号
	public ArrayList<Payslip> payslip(Date yearmonth, String number){
		ArrayList<Payslip> list = new ArrayList<Payslip>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql = "select * from payslip " +
				"inner join paytype " +
				"on payslip.sikyuukubun = paytype.code " +
				"where number=? " +
				"and yearmonth=? order by yearmonth desc";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			stmt.setDate(2, yearmonth);

			rs = stmt.executeQuery();

			while(rs.next()){
				Payslip ps = new Payslip();
				int index = 0;
				ps.setNumber(rs.getString(cols_name[index++]));
				String[] ymd = rs.getDate(cols_name[index++]).toString().split("-");
				ps.setYear(ymd[0]);
				ps.setMonth(ymd[1]);
				ps.setSikyuukubun(rs.getString(cols_name[index++]));
				// 3桁ごとにカンマを挿入
				ps.setNennreikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokunoukyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJissekikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSairyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokuiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setChiikiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHuyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyouseiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyuuzaiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTanhuteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeiryohi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotakyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotatoku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeisonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTuukinteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeituukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokubetutyouseigaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeisikyukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeikei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSikyuugakugoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKenkouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKaigohokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseinennkin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseikikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoyouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHokenryougoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeitaisyougaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyotokuzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJuuminzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKihonkenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setZaikeitumitate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setRyouhi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTatekaekin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMaebaraikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKabusikikyosyutukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokuteikenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setIppankoujokei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoujogoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				//ps.setYuukyuuzannjitu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setYuukyuuzannjitu(rs.getString(cols_name[index++]));
				if(ps.getYuukyuuzannjitu() == null) ps.setYuukyuuzannjitu("");
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi1(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi2(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSasihikisikyuugaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setOwner_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMember_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				list.add(ps);
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);
			} catch (SQLException e) {
			}
		}
		// ヒットしたデータが無かった場合エラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 検索区間の開始年月, 終了年月, 社員番号, 支給区分コード
	public ArrayList<Payslip> payslip(Date start, Date end , String number){
		ArrayList<Payslip> list = new ArrayList<Payslip>();
		C_DBConnectionAbs dbconn = new C_DBConnectionPaperschest();
		Connection conn = null;
		// コネクション作成
		conn = dbconn.createConnection();

		//sqlを実行して給与明細書データを取得
		String sql = "select * from payslip " +
				"inner join paytype " +
				"on payslip.sikyuukubun = paytype.code " +
				"where number=? " +
				"and yearmonth >=? " +
				"and yearmonth <=? order by yearmonth desc";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);

			stmt.setString(1, number);
			stmt.setDate(2, start);
			stmt.setDate(3, end);

			rs = stmt.executeQuery();
			// 使用する給与明細書データ

			while(rs.next()){
				Payslip ps = new Payslip();
				int index = 0;
				ps.setNumber(rs.getString(cols_name[index++]));
				String[] ymd = rs.getDate(cols_name[index++]).toString().split("-");
				ps.setYear(ymd[0]);
				ps.setMonth(ymd[1]);
				ps.setSikyuukubun(rs.getString(cols_name[index++]));
				// 3桁ごとにカンマを挿入
				ps.setNennreikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokunoukyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJissekikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSairyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyokuiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setChiikiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHuyouteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyouseiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTyuuzaiteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTanhuteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeiryohi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotakyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonotatoku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeisonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTuukinteate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeituukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokubetutyouseigaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeisikyukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHikazeikei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSikyuugakugoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKenkouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKaigohokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseinennkin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKouseikikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoyouhokenryou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHokenryougoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKazeitaisyougaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSyotokuzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setJuuminzei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKihonkenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setZaikeitumitate(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setRyouhi(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTatekaekin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMaebaraikin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKabusikikyosyutukin(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSonota(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setTokuteikenporyou(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setIppankoujokei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setKoujogoukei(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				//ps.setYuukyuuzannjitu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setYuukyuuzannjitu(rs.getString(cols_name[index++]));
				if(ps.getYuukyuuzannjitu() == null) ps.setYuukyuuzannjitu("");
				ps.setGenbutusikyu(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi1(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setHurikomi2(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setSasihikisikyuugaku(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setOwner_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				ps.setMember_bill(String.format("%1$,3d", rs.getInt(cols_name[index++])));
				list.add(ps);
			}
			stmt.close();
			rs.close();
			dbconn.closeConection(conn);
		} catch (SQLException e) {
			//e.printStackTrace();
		}finally{
			try {
				if(stmt != null ? !stmt.isClosed() : false) stmt.close();
				if(rs != null ? !rs.isClosed() : false) rs.close();
				if(conn != null ? !conn.isClosed() : false) dbconn.closeConection(conn);

			} catch (SQLException e) {
			}
		}
		// ヒットしたデータが無かった場合エラーを投げる
		if (list.size() == 0){
			try {
				throw new NotFoundIDException();
			} catch (NotFoundIDException e) {
				//e.printStackTrace();
			}
		}
		return list;
	}
}
