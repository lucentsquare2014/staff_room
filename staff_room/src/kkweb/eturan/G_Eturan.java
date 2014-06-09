package kkweb.eturan;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kkweb.dao.EturangamenDAO;
import kkweb.superclass.C_ChangePageBase;

public class G_Eturan extends C_ChangePageBase{

	public void doMain(HttpServletRequest request){

		try {

			EturangamenDAO dao = new EturangamenDAO();

			ArrayList namenengetuDATA = new ArrayList();

			String sql = "";
			sql = "where flg = '0' or flg = '1' and zaiseki_flg = '1' order by to_number(year_month,'999999') desc";

			namenengetuDATA = dao.eturanTbl(sql);

			//セッションにshounindataを保存
			HttpSession session = request.getSession(true);

			session.setAttribute("namenengetuDATA",namenengetuDATA);

			}catch(Exception e){
			//e.printStackTrace();
		   }
		}



	public ArrayList HojinBunrui1List() {

		try {
			// DB検索処理
			kkweb.dao.EturangamenDAO B1ListDao = new kkweb.dao.EturangamenDAO();
			String sql = "";

			ArrayList b1List = B1ListDao.eturanTbl(sql);
			return b1List;

		} catch (Exception e) {
			/* 例外をキャッチしスタックダンプを出力する */
			//e.printStackTrace();

			return null;

		}
	}


	public String nextPage(HttpServletRequest request){

		try{
			String nextpage = "/jsp/shanai_s/Eturan_Gamen.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return null;
		}
	}

	public String backPage(HttpServletRequest request){

		try{

			String nextpage = "/jsp/shanai_s/Nyuryoku_file_error.jsp";

			return nextpage;

		}catch(Exception e){

			//e.printStackTrace();

			return null;
		}
	}

}
