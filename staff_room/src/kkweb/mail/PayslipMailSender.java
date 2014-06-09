package kkweb.mail;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kkweb.beans.*;
import kkweb.common.C_CharConverter;
import kkweb.dao.*;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Servlet implementation class PayslipMailSend
 */
public class PayslipMailSender extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PayslipMailSender() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id2 = (String)session.getAttribute("key");
		if(id2 != null ? id2.equals("鍵") : false)
			mailSend(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id2 = (String)session.getAttribute("key");
		if(id2 != null ? id2.equals("鍵") : false)
			mailSend(request, response);
	}

	/// payslip_urlを更新してからメールを送信する
	/// 送信した方には最新の給与明細書への年月がpayslip_urlに登録される
	private void mailSend(HttpServletRequest request, HttpServletResponse response) throws IOException{
		// 文字コードを指定
		request.setCharacterEncoding("shift-jis");
		// 文字コードコンバータ
		C_CharConverter con = new C_CharConverter();
		// 在籍する社員情報を取得
		HttpSession session = request.getSession();
		SendList sendlist = (SendList)session.getAttribute("SendList");
		B_ShainMST login_user = (B_ShainMST)session.getAttribute("ShainMST");
		// ユーザーリストを取り出す
		ArrayList<ShainInfo> users = sendlist.getUsers();
		// 社員番号リストを作成
		ArrayList<String> numberList = new ArrayList<String>();
		for (ShainInfo s : users)
			numberList.add(s.getNumber());

		// form　から送られたネームリスト
		Enumeration<String> names = request.getParameterNames();
		String flag = (String)session.getAttribute("pagefrom");
		if(flag.equals("sendselect")){
			ArrayList<ShainInfo> usersmst = new ArrayList<ShainInfo>(users);
			users.clear();
			while (names.hasMoreElements()) {
				String name = names.nextElement();
				// 選ばれた社員番号ならば
				if(numberList.contains(name)){
					//System.out.println(name);
					users.add(usersmst.get(numberList.indexOf(name)));
				}
			}
			sendlist.setUsers(users);
			session.setAttribute("SendList", sendlist);
			numberList.clear();
			for (ShainInfo s : users)
				numberList.add(s.getNumber());
		}

		//for(ShainInfo s : users) System.out.println(s);


		String body = request.getParameter("body");
		String subject = request.getParameter("subject");
		String kakidasi = request.getParameter("kakidasi");
		String url_flg = request.getParameter("url");
		/*//
		System.out.println(url_flg);
		//*/
		// PayslipURLDAO
		PayslipURLDAO plistDAO = new PayslipURLDAO();

		// URLデータベースに選ばれた社員番号を新規追加
		Map<String, Date> inserted = plistDAO.insert(numberList);
		ArrayList<String> update_numberList = new ArrayList<String>();
		for(String s : numberList)
			if(!inserted.containsKey(s)) update_numberList.add(s);

		// URLデータベースに登録されている選ばれた社員番号を更新
		Map<String, Date> updated = plistDAO.updateLimit(update_numberList);

		/*// 書棚に選ばれた社員番号の最新給与明細書を追加
		PapersChestDAO paperschest_dao = new PapersChestDAO();
		ArrayList<String> unin = paperschest_dao.insertPayslipByNumber(numberList);
		///System.out.println("unin");
		for(String s : unin) System.out.println(s);
		///
		if(unin.size() > 0){
			paperschest_dao.updatePayslipByNumber(unin);
		}
		//*/
		// 本文用バッファ
		StringBuffer sb = new StringBuffer();
		String br = System.getProperty("line.separator"); // 改行文字
		// 本文用URL
		String url = "http://www.lucentsquare.co.jp:8080/kk_web/SalaryPage?code=";
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy'年'MM'月'dd'日'");
		SimpleDateFormat sdf_ym = new SimpleDateFormat("yyyy'年'MM'月'");
		try{
			for (ShainInfo s : users) {
				C_MailSend mail = new C_MailSend();
				sb = new StringBuffer();
				mail.setSmtpHost("mail.lucentsquare.co.jp");
				mail.setFrom(login_user.getMail());
				mail.setTo(s.getMail());
				Date d = new Date(0l);
				if(inserted.containsKey(s.getNumber())){
					d = inserted.get(s.getNumber());
				}else{
					d = updated.get(s.getNumber());
				}
				//String[] ymd = d.toString().split("-");
				//ymd[0] + "年" + ymd[1] + "月支給分";
				String kyuyo = sdf_ym.format(d);
				if(subject != null ? subject.length() > 0 : false){
					mail.setSubject("[社内文書システム] "+ con.convert(subject));
				}else{
					// subjectが空の場合
					mail.setSubject("[社内文書システム] 給与明細書("+kyuyo+")を公開しました。");
				}
				sb.append(s.getName() + "さんへ" + br);
				if(kakidasi != null){
					if(kakidasi.equals("1"))
						sb.append(kyuyo + "の給与明細書を公開しました。" + br);
					if(kakidasi.equals("2"))
						sb.append(kyuyo + "の給与明細書を更新しました。" + br);
				}
				// body
				if(body != null ? body.length() > 0 : false){
					sb.append(body);
				}
				sb.append(br);
				sb.append(br);
				// URLを付与する場合
				if(url_flg == null ? true : Boolean.valueOf(url_flg)){
					sb.append("以下のURLから支給年月が最も新しい給与明細書がPDF形式でご確認できます。" + br);
					sb.append("-------------------------------------------------------------------"
							+ br);

					sb.append("URL : " + url
							+ DigestUtils.shaHex(s.getNumber()+d.toString()) + br);
					sb.append("-------------------------------------------------------------------"+ br);
					cal.setTime(d);
					cal.add(Calendar.MONTH, 2); // 支給日から2ヵ月後
					sb.append("URLの有効期限は " + sdf.format(cal.getTime()) + "までです。" + br);

				}

				sb.append(login_user.getName() + "より" + br);
				// bodyをセット
				mail.setBody(sb.toString());
				// メール送信
				mail.run();
				//System.out.println(mail);

			}
		}catch (ParseException e){

		}
		response.sendRedirect("./MailSendPayslip.jsp");
	}
}
