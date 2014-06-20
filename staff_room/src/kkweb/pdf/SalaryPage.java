package kkweb.pdf;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kkweb.beans.*;
import kkweb.dao.*;
import kkweb.error.*;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * Servlet implementation class SalaryPage
 */

public class SalaryPage extends HttpServlet {
	//private static final long serialVersionUID = 1L;
	private final int cell_height = 13;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SalaryPage() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id2 = (String)session.getAttribute("key");
		if(id2 != null ? id2.equals("鍵") : false){
			//System.out.println("make get");
			createPDF(request, response);
		}else{
			//System.out.println("dispatch get");
			String target = request.getRequestURI();
			target = target.substring(target.lastIndexOf("/"));
			Enumeration<String> names = request.getParameterNames();
			if(names.hasMoreElements()) target += "?";
			while(names.hasMoreElements()){
				String n = names.nextElement();
				target += n + "=";
				target += request.getParameter(n);
				if(names.hasMoreElements()) target += "&";
			}
			System.out.println("doGet-> dispatcher ID_PW... (kkweb.pdf.SalalyPage.java)");
			session.setAttribute("target", target);
			request.getRequestDispatcher("ID_PW_Nyuryoku.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id2 = (String)session.getAttribute("key");
		if(id2 != null ? id2.equals("鍵") : false){
			//System.out.println("make post");
			createPDF(request, response);
		}else{
			//System.out.println("dispatch post");
			String target = request.getRequestURI();
			target = target.substring(target.lastIndexOf("/"));
			Enumeration<String> names = request.getParameterNames();
			if(names.hasMoreElements()) target += "?";
			while(names.hasMoreElements()){
				String n = names.nextElement();
				target += n + "=";
				target += request.getParameter(n);
				if(names.hasMoreElements()) target += "&";
			}
			System.out.println("doGet-> dispatcher ID_PW... (kkweb.pdf.SalalyPage.java)");
			session.setAttribute("target", target);
			request.getRequestDispatcher("ID_PW_Nyuryoku.jsp").forward(request, response);
		}
	}

	// PDFを作成して表示する
	private void createPDF(HttpServletRequest request, HttpServletResponse response){
		/*//
		DecimalFormat f1 = new DecimalFormat("#,###KB");
	    DecimalFormat f2 = new DecimalFormat("##.#");
	    long free = Runtime.getRuntime().freeMemory() / 1024;
	    long total = Runtime.getRuntime().totalMemory() / 1024;
	    long max = Runtime.getRuntime().maxMemory() / 1024;
	    long used = total - free;
	    double ratio = (used * 100 / (double)total);
	    String info = "開始時 ::: " +
	    "Java メモリ情報 : 合計=" + f1.format(total) + "、" +
	    "使用量=" + f1.format(used) + " (" + f2.format(ratio) + "%)、" +
	    "使用可能最大="+f1.format(max);
	    System.out.println(info);
		//*/
	    // PDFを表すdocument
		Document document = null;
		// ブラウザに出力するストリーム
		ServletOutputStream out = null;
		// エラー用ページURL
		String disp = "PayslipError.jsp";
//		String url = "http://www.lucentsquare.co.jp:8080/kk_web";
		String url = "/staff_room/jsp/shanai_s/";
		// エラー用ページへのディスパッチャー
		RequestDispatcher dispatch = request.getRequestDispatcher(disp);
		HttpSession session = request.getSession();
		try{
			// リクエストの文字コードをUTF-8に設定
			request.setCharacterEncoding("UTF-8");

			// セッションからログインユーザ情報と年月を取得
			B_ShainMST user = (B_ShainMST)session.getAttribute("ShainMST");

			String pos = request.getParameter("position");
			String year1 = request.getParameter("year1");
			String year2 = request.getParameter("year2");
			String accesscode = request.getParameter("code");
			PayslipDAO payslip_dao = new PayslipDAO();
			ByteArrayOutputStream baos = null;
			/*//
			System.out.println("pos : " + pos);
			System.out.println("code : " + accesscode);
			System.out.println("year1 : " + year1);
			System.out.println("year2 : " + year2);
			System.out.println("user : " + user);
			//*/
			// 社員情報は必須
			if(user == null) throw new IllegalAccessException();
			if(pos != null ? pos.length() > 0 : false){
				// 一枚用のページを作成
				NewInfoBox nibox = (NewInfoBox)session.getAttribute("newinfobox");
				ArrayList<PaperStatus> status = nibox.getStatus();
				PayslipStatus ps = (PayslipStatus)status.get(Integer.parseInt(pos));
				baos = this.aMonth(document, payslip_dao.payslip(ps.getYearmonth(), user.getNumber(), ps.getSikyuukubun()), user, ps.getYearmonth());
			}
			else if(year1 != null && year2 != null ? year1.length() + year2.length() > 1 : false){
				// 複数用のページを作成
				long y1 = 0l;
				try {
					y1= Long.parseLong(year1);
				} catch (Exception e) {
					//e.printStackTrace();
				}
				long y2 = 0l;
				try {
					y2 = Long.parseLong(year2);
				} catch (Exception e) {
					//e.printStackTrace();
				}
				// どちらかは日付である
				if(y1 > 0l || y2 > 0l){
					if(y1 == 0l) y1 = Long.parseLong(year2);
					if(y2 == 0l) y2 = Long.parseLong(year1);
					if(y1 > y2){
						long tmp = y1;
						y1 = y2;
						y2 = tmp;
					}
				}else{
					throw new NumberFormatException();
				}
				Date start = new Date(y1);
				Date end = new Date(y2);

				baos = fewMonth(document, payslip_dao.payslip(start, end, user.getNumber()), user, start, end);
			}
			else if(accesscode != null ? accesscode.length() > 0 : false){
				// payslip_urlに登録されている給与明細を表示
				PayslipURLDAO url_dat = new PayslipURLDAO();
				//System.out.println("use? : " + url_dat.useThisCode(user.getNumber(),accesscode));
				if(url_dat.useThisCode(user.getNumber(), accesscode)){
					//System.out.println(url_dat.getYearmonth(user.getNumber()));
					ArrayList<Payslip> kyuyo = payslip_dao.payslip
							(url_dat.getYearmonth(user.getNumber()), user.getNumber());
					baos = this.fewMonth(document, kyuyo, user, url_dat.getYearmonth(user.getNumber()),url_dat.getYearmonth(user.getNumber()));
				}else{
					// 使用期限が切れている旨を表示する
					throw new ExpiredException();
				}
			}
			else{
				throw new IllegalAccessException();
			}

			// レスポンスヘッダー
			response.setHeader("Pragma","no-cache");
			response.setHeader("Cache-Control","no-cache");
			response.setDateHeader("Expires",0);
			//response.setHeader("Expires", "0");
			//response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
			//response.setHeader("Pragma", "public");

			// コンテンツタイプを設定する
			response.setContentType("application/pdf");
			// コンテンツの長さを設定する
			response.setContentLength(baos .size());
			// 出力のストリームに内容を書き出す
			out = response.getOutputStream();
			out.write(baos.toByteArray());
			//baos.writeTo(out);
			out.flush();

		}catch (NumberFormatException e){
			// パラメーターからidが取得できない
			// idが数値ではない
			try {
				session.setAttribute("error", "年月が選ばれていません。");
				session.setAttribute("errorDescription", "最低1つは年月を選択してから表示ボタンを押してください。");
				session.setAttribute("exception", e);
				response.sendRedirect(url + disp);
				e.printStackTrace();
				//dispatch.forward(request, response);
				//} catch (ServletException e1) {
			} catch (IOException e1) {
			}
		}catch (IOException e){
			try {
				session.setAttribute("error", "IOで例外が発生しました");
				session.setAttribute("exception", e);
				response.sendRedirect(url + disp);
				//dispatch.forward(request, response);
				//} catch (ServletException e1) {
			} catch (IOException e1) {
			}
		} catch (DocumentException e){
			try {
				session.setAttribute("error", "PDF作成で例外が発生しました");
				session.setAttribute("exception", e);
				response.sendRedirect(url + disp);
				//dispatch.forward(request, response);
				//} catch (ServletException e1) {
			} catch (IOException e1) {
			}
		} catch (ExpiredException e) {
			try {
				session.setAttribute("error", "アクセスコードの有効期限が切れています");
				session.setAttribute("exception", e);
				response.sendRedirect(url + disp);
				//dispatch.forward(request, response);
				//} catch (ServletException e1) {
			} catch (IOException e1) {
			}
		}catch (Exception e){
			try {
				session.setAttribute("error", "予期せぬ例外が発生しました");
				session.setAttribute("exception", e);
				e.printStackTrace();
				//dispatch.forward(request, response);
				response.sendRedirect(url + disp);
				//} catch (ServletException e1) {
			} catch (IOException e1) {
			}
		} finally {
			// ドキュメントのクローズ
			if(document != null ? document.isOpen() : false){
				document.close();
			}
		}
		/*//
		long af_free = Runtime.getRuntime().freeMemory() / 1024;
		used = total - af_free;
		long real = free - af_free;
	    ratio = (used * 100 / (double)total);
	    info = "終了時 ::: " +
	    "Java メモリ情報 : 合計=" + f1.format(total) + "、" +
	    "使用量=" + f1.format(used) + " (" + f2.format(ratio) + "%)," +
	    "実質使用量=" + f1.format(real);
	    System.out.println(info);
	    //*/
	}

	private ByteArrayOutputStream aMonth(Document document, Payslip kyuyo , B_ShainMST user, Date ym) throws DocumentException, IOException{
		//System.out.println(kyuyo);
		// 用紙サイズはA5横 余白は四方24pt
		document = new Document(PageSize.A5.rotate(), 24,24,24,24);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		PdfWriter.getInstance(document, baos);
		document.open();

		OshiraseDAO oshi = new OshiraseDAO();
		ArrayList<Oshirase> oshirase = oshi.Oshirase(ym, user.getNumber());
		document = createPayslipDocument(document, kyuyo, user);
		if (oshirase.size() > 0) {
			document = createOshiraseDocument(document,oshirase,user);
			document.newPage();
		}
		document.close();
		return baos;

	}

	private ByteArrayOutputStream fewMonth(Document document, ArrayList<Payslip> kyuyo , B_ShainMST user, Date start, Date end) throws DocumentException, IOException{
		// 用紙サイズはA5横
		document = new Document(PageSize.A5.rotate(), 24,24,24,24);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		PdfWriter.getInstance(document, baos);

		OshiraseDAO oshi = new OshiraseDAO();
		ArrayList<Oshirase> oshirase = oshi.oshirase(start, end, user.getNumber());
		ArrayList<Oshirase> oshirase2 = new ArrayList<Oshirase>();
		ArrayList<Date> payslipYearmonth=oshi.payslipYearmonth(start, end, user.getNumber());

		document.open();
		for(Payslip p : kyuyo){
			oshirase2.clear();
			Date py= payslipYearmonth.remove(0);
			document = createPayslipDocument(document, p, user);
			document.newPage();
			for(int i=0; i<oshirase.size();i++){
				if(oshirase.get(i).getYearmonth().equals(py)){
					oshirase2.add(oshirase.get(i));
				}
			}
			if(oshirase2.size() > 0){
				document = createOshiraseDocument(document,oshirase2,user);
				document.newPage();
			}

		}
		document.close();
		return baos;
	}

	private Document createPayslipDocument(Document document, Payslip kyuyo , B_ShainMST user) throws DocumentException, IOException{
		// ドキュメントが開かれていなければ開く
		if(!document.isOpen()){
			document.open();
		}

		// ゴシック10pt
		Font font_m10 = new Font(BaseFont.createFont("HeiseiKakuGo-W5","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),10);
		// ゴシック12pt
		Font font_m12 = new Font(BaseFont.createFont("HeiseiKakuGo-W5","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),12);
		// ゴシック14pt
		Font font_m14 = new Font(BaseFont.createFont("HeiseiKakuGo-W5","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),14);
		// 明朝10pt
		Font m_font_m10 = new Font(BaseFont.createFont("HeiseiMin-W3","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),10);
		// 明朝12pt
		Font m_font_m12 = new Font(BaseFont.createFont("HeiseiMin-W3","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),12);
		// 明朝14pt
		Font m_font_m14 = new Font(BaseFont.createFont("HeiseiMin-W3","UniJIS-UCS2-H",BaseFont.NOT_EMBEDDED),14);



		// tb1を作成   列数2
		PdfPTable tb1 = new PdfPTable(1);
		PdfPTable tb1_inner = new PdfPTable(2);

		tb1.setWidthPercentage(50); // 幅:用紙の50%
		tb1.setHorizontalAlignment(Element.ALIGN_LEFT); // 用紙の左詰
		// tb1に配置するセルを作成
		//PdfPCell title = new PdfPCell(new Paragraph("給与明細書",font_m12));
		PdfPCell title = new PdfPCell(new Paragraph("給与明細書",m_font_m14));
		title.setHorizontalAlignment(Element.ALIGN_LEFT);
		title.setPaddingLeft(10f);
		title.setBorderColor(BaseColor.WHITE); // 枠を白に

		PdfPCell time = new PdfPCell(new Paragraph(
				kyuyo.getYear() + "年" + kyuyo.getMonth() + "月分" + kyuyo.getSikyuukubun(),font_m12));

		time.setHorizontalAlignment(Element.ALIGN_CENTER);
		time.setBorderColor(BaseColor.WHITE);

		PdfPCell code = new PdfPCell(new Paragraph(
				user.getGROUPnumber() + " - " + user.getNumber() ,font_m12));

		code.setHorizontalAlignment(Element.ALIGN_CENTER);
		code.setBorderColor(BaseColor.WHITE);
		/*
		PdfPCell name = new PdfPCell(new Paragraph(
				user.getName() + " 様", font_m10));
		*/
		PdfPCell name = new PdfPCell(new Paragraph(
				user.getName() + " 様", m_font_m12));
		name.setHorizontalAlignment(Element.ALIGN_LEFT);
		name.setBorderColor(BaseColor.WHITE);

		/*
		PdfPCell lucent = new PdfPCell(new Paragraph(
				"(株)ルーセントスクエア", font_m8));
		*/
		PdfPCell lucent = new PdfPCell(new Paragraph(
				"(株)ルーセントスクエア", m_font_m10));

		lucent.setHorizontalAlignment(Element.ALIGN_CENTER);
		lucent.setBorderColor(BaseColor.WHITE);

		// 空白用のセル
		PdfPCell space = new PdfPCell();
		space.setMinimumHeight(cell_height);
		space.setBorderColor(BaseColor.WHITE);

		// tb1にセルを配置
		tb1_inner.addCell(title);
		tb1_inner.addCell(time);
		tb1_inner.addCell(code);
		tb1_inner.addCell(name);
		tb1_inner.addCell(space);
		tb1_inner.addCell(lucent);
		tb1.addCell(tb1_inner);
		// 以下、支給、控除、勤怠、記事のテーブル作成
		float[] tb_width = { 0.05f, 0.95f }; // tb2　の列は 1:19 の列幅
		int tb2_innner_cols = 9;
		space.setBorderColor(BaseColor.BLACK);
		int list_s = 0, list_e = 8;

		// 支給
		PdfPTable tb2 = new PdfPTable(tb_width);
		PdfPTable tb2_inner = new PdfPTable(tb2_innner_cols);
		// テーブル内の文字は、中央揃え
		tb2_inner.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tb2_inner.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		tb2.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tb2.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		// 外側のテーブルのデフォルトセルを余白0に設定
		tb2.getDefaultCell().setPadding(0f);
		//テーブルの幅を印刷領域と同じにする
		tb2.setWidthPercentage(100);
		ArrayList<String> values = kyuyo.getSikyuu();
		ArrayList<String> hedder = kyuyo.getSikyuuHedder();
		// 1行目
		//addColorCellTo(tb2_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb2_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb2_inner, font_m10, values, list_s, list_e); // 9列分
		// 2行目
		//addColorCellTo(tb2_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb2_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb2_inner, font_m10, values, list_s, list_e); // 9列分
		// 3行目
		//addColorCellTo(tb2_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb2_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb2_inner, font_m10, values, list_s, list_e); // 9列分

		// tb2 の作成
		//PdfPCell tb_left = new PdfPCell(new Paragraph("支\n給",font_m8));
		PdfPCell tb_left = new PdfPCell(new Paragraph("支\n給",m_font_m10));
		tb_left.setHorizontalAlignment(Element.ALIGN_CENTER);
		tb_left.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tb2.addCell(tb_left);
		tb2.addCell(tb2_inner);

		// 控除
		PdfPTable tb3 = new PdfPTable(tb_width);
		PdfPTable tb3_inner = new PdfPTable(tb2_innner_cols);
		// テーブル内の文字は、中央揃え
		tb3_inner.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tb3.getDefaultCell().setHorizontalAlignment(Element.ALIGN_MIDDLE);
		// 外側のテーブルのデフォルトセルを余白0に設定
		tb3.getDefaultCell().setPadding(0f);
		//テーブルの幅を印刷領域と同じにする
		tb3.setWidthPercentage(100);

		values = kyuyo.getKoujo();
		hedder = kyuyo.getKoujoHedder();
		// 1行目
		//addColorCellTo(tb3_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb3_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb3_inner, font_m10, values, list_s, list_e); // 9列分
		//tb2_inner.addCell(space);
		// 2行目
		//addColorCellTo(tb3_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb3_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb3_inner, font_m10, values, list_s, list_e); // 9列分
		//tb2_inner.addCell(space);
		//tb2_inner.addCell(space);
		// 3行目
		//addColorCellTo(tb3_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb3_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb3_inner, font_m10, values, list_s, list_e); // 9列分
		// tb3 の作成
		//tb3.addCell(new PdfPCell(new Paragraph("\n控\n\n除",font_m8)));
		//tb_left = new PdfPCell(new Paragraph("控\n除",font_m8));
		tb_left = new PdfPCell(new Paragraph("控\n除",m_font_m10));
		tb_left.setHorizontalAlignment(Element.ALIGN_CENTER);
		tb_left.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tb3.addCell(tb_left);
		tb3.addCell(tb3_inner);


		// 勤怠
		PdfPTable tb4 = new PdfPTable(tb_width);
		PdfPTable tb4_inner = new PdfPTable(tb2_innner_cols);
		// テーブル内の文字は、中央揃え
		tb4_inner.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tb4.getDefaultCell().setHorizontalAlignment(Element.ALIGN_MIDDLE);
		// 外側のテーブルのデフォルトセルを余白0に設定
		tb4.getDefaultCell().setPadding(0f);
		//テーブルの幅を印刷領域と同じにする
		tb4.setWidthPercentage(100);

		values = kyuyo.getKintai();
		hedder = kyuyo.getKintaiHedder();
		// 1行目
		//addColorCellTo(tb4_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb4_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb4_inner, font_m10, values, list_s, list_e); // 9列分
		// 3行分の空白
		for(int i = 0; i < tb2_innner_cols*3; i++)
			tb4_inner.addCell(space);

		// tb4 の作成
		//tb4.addCell(new PdfPCell(new Paragraph("\n勤\n\n怠",font_m8)));
		//tb_left = new PdfPCell(new Paragraph("勤\n怠",font_m8));
		tb_left = new PdfPCell(new Paragraph("勤\n怠", m_font_m10));
		tb_left.setHorizontalAlignment(Element.ALIGN_CENTER);
		tb_left.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tb4.addCell(tb_left);
		tb4.addCell(tb4_inner);

		// 記事
		PdfPTable tb5 = new PdfPTable(tb_width);
		PdfPTable tb5_inner = new PdfPTable(tb2_innner_cols);
		// テーブル内の文字は、中央揃え
		tb5_inner.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		tb5.getDefaultCell().setHorizontalAlignment(Element.ALIGN_MIDDLE);
		// 外側のテーブルのデフォルトセルを余白0に設定
		tb5.getDefaultCell().setPadding(0f);
		//テーブルの幅を印刷領域と同じにする
		tb5.setWidthPercentage(100);
		values = kyuyo.getKiji();
		hedder = kyuyo.getKijiHedder();
		// 1行目
		//addColorCellTo(tb5_inner, font_m8, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addColorCellTo(tb5_inner, m_font_m10, BaseColor.LIGHT_GRAY, hedder, list_s, list_e);
		addCellTo(tb5_inner, font_m10, values, list_s, list_e); // 9列分

		// tb5 の作成
		//tb5.addCell(new PdfPCell(new Paragraph("記\n事",font_m8)));
		//tb_left = new PdfPCell(new Paragraph("記\n事",font_m8));
		tb_left = new PdfPCell(new Paragraph("記\n事", m_font_m10));
		tb_left.setHorizontalAlignment(Element.ALIGN_CENTER);
		tb_left.setVerticalAlignment(Element.ALIGN_MIDDLE);
		tb5.addCell(tb_left);
		tb5.addCell(tb5_inner);

		// ドキュメントに要素を配置
		document.add(tb1);
		document.add(new Paragraph("＊休業者控除は「課税その他」にマイナス表示します。", m_font_m10));
		tb2.setSpacingBefore(10f);
		document.add(tb2);
		tb3.setSpacingBefore(10f);
		document.add(tb3);
		tb4.setSpacingBefore(10f);
		document.add(tb4);
		document.add(tb5);

		document.addTitle(kyuyo.getYear() + "年" + kyuyo.getMonth() + "月分" +
				kyuyo.getSikyuukubun());

		// 開かれたドキュメントをそのまま返す
		return document;
	}

	private Document createOshiraseDocument(Document document, ArrayList<Oshirase> oshirase , B_ShainMST user) throws DocumentException, IOException{
		// ドキュメントが開かれていなければ開く
		if(!document.isOpen()){
			document.open();
		}

		// 明朝10pt
		Font font_m10 = new Font(BaseFont.createFont("HeiseiKakuGo-W5","UniJIS-UCS2-H",BaseFont.EMBEDDED),10);
		// 明朝12pt
		Font font_m12 = new Font(BaseFont.createFont("HeiseiKakuGo-W5","UniJIS-UCS2-H",BaseFont.EMBEDDED),12);



		// tb1を作成   列数1
		PdfPTable tb1 = new PdfPTable(1);
		PdfPTable tb1_inner = new PdfPTable(1);

		tb1.setWidthPercentage(100); // 幅:用紙の100%
		tb1.setHorizontalAlignment(Element.ALIGN_LEFT); // 用紙の左詰
		tb1.getDefaultCell().setBorderColor(BaseColor.WHITE);

		// tb1に配置するセルを作成
		PdfPCell name = new PdfPCell(new Paragraph(
				user.getName() + " 様", font_m10));
		name.setHorizontalAlignment(Element.ALIGN_LEFT);
		name.setBorderColor(BaseColor.WHITE);

		PdfPCell time = new PdfPCell(new Paragraph(
				oshirase.get(0).getYear() + "年" + oshirase.get(0).getMonth() + "月分給与に関するお知らせ",font_m12));
		time.setHorizontalAlignment(Element.ALIGN_CENTER);
		time.setBorderColor(BaseColor.WHITE);

		// 空白用のセル
		PdfPCell space = new PdfPCell();
		space.setMinimumHeight(cell_height);
		space.setBorderColor(BaseColor.WHITE);

		// tb1にセルを配置
		tb1_inner.addCell(name);
		tb1_inner.addCell(time);
		tb1.addCell(tb1_inner);

		// tb2 の作成
		float[] tb_width={0.1f, 0.9f };
		PdfPTable tb2 = new PdfPTable(tb_width);
		tb2.setWidthPercentage(100); // 幅:用紙の100%
		tb2.setHorizontalAlignment(Element.ALIGN_LEFT); // 用紙の左詰
		tb2.getDefaultCell().setBorderColor(BaseColor.WHITE);

		// tb2に配置するセルを作成
		for (int i = 0; i < oshirase.size(); i++) {
			PdfPCell kouban = new PdfPCell(new Paragraph(i+1+"、", font_m10));
			kouban.setHorizontalAlignment(Element.ALIGN_RIGHT);
			kouban.setBorderColor(BaseColor.WHITE);

			PdfPCell koumoku = new PdfPCell(new Paragraph(oshirase.get(i).getKoumoku(),font_m10));
			koumoku.setHorizontalAlignment(Element.ALIGN_LEFT);
			koumoku.setBorderColor(BaseColor.WHITE);

			// tb2にセルを配置
			tb2.addCell(kouban);
			tb2.addCell(koumoku);
		}

		// ドキュメントに要素を配置
		document.add(tb1);
		tb2.setSpacingBefore(15f);
		document.add(tb2);

		// 開かれたドキュメントをそのまま返す
		return document;
	}

	// 指定された table に list の start から end までの要素を font で追加する。
	private void addCellTo(PdfPTable table, Font font ,ArrayList<String> list, int start, int end){
		for(int i = start; i <= end; i++){
			// listの先頭を取り出してセルを作成
			PdfPCell cell = new PdfPCell(new Paragraph(list.remove(0), font));
			// 最小の高さ
			cell.setMinimumHeight(cell_height);
			//　折り返しなし
			cell.setNoWrap(true);
			// 右揃え
			cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(cell);
		}
	}
	// リストを全て追加する場合
	/*
	private void addCellTo(PdfPTable table, Font font ,ArrayList<String> list){
		addCellTo(table, font, list, 0, list.size()-1);
	}
	 */
	// cellに背景色が設定される
	private void addColorCellTo(PdfPTable table, Font font ,BaseColor color, ArrayList<String> list, int start, int end){
		for(int i = start; i <= end; i++){
			PdfPCell cell = new PdfPCell(new Paragraph(list.remove(0), font));
			// 最小の高さ
			cell.setMinimumHeight(cell_height);
			//　折り返しなし
			cell.setNoWrap(true);
			// 背景色設定
			cell.setBackgroundColor(color);
			// 中央揃え
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(cell);
		}
	}

}
