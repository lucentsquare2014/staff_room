package kkweb.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kkweb.common.C_CharConverter;

public class C_MailSend extends Thread{

	private String smtpHost; // SMTPサーバのホスト名

	private String from; // 送信者のメールアドレス

	private String to; // 受信者のメールアドレス

	private String subject; // メールの題名

	private String body; // メールの本文


	public void run() {

		try {

			// 指定SMTPサーバにメールを送るためのMimeMessageオブジェクトを作成
			Properties props = System.getProperties();
			props.put("mail.smtp.host", this.smtpHost);
			props.put("mail.smtp.port", 587);
			//props.put("mail.debug", true);
			Session session = Session.getDefaultInstance(props);
			MimeMessage message = new MimeMessage(session);

			// 送信者アドレスをセット
			InternetAddress from = new InternetAddress(this.from);
			message.setFrom(from);

			// 受信者アドレスをセット
			InternetAddress to[] = InternetAddress.parse(this.to);
			message.setRecipients(Message.RecipientType.TO, to);

			// メールの題名をセット
			message.setSubject(this.subject, "iso-2022-jp");

			// 送信時刻をセット
			message.setSentDate(new Date());

			// メールの本文をセット
			// セット前に「－」等を正しく処理するためにコンバートする
			C_CharConverter con = new C_CharConverter();
			String mailBody = con.convert( this.body );
			message.setText( mailBody, "iso-2022-jp");

			// 実際に送信する
			Transport.send(message);

			//System.out.println("C_MailSend送信タイム計測" + subject);

		} catch (Exception e) {

			//System.out.println("C_MailSendメール送信失敗" + subject);

		}

	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getSmtpHost() {
		return smtpHost;
	}

	public void setSmtpHost(String smtpHost) {
		this.smtpHost = smtpHost;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getTo() {
		return to;
	};

	public void setTo(String to) {
		this.to = to;
	}
	
	public String toString(){
		StringBuffer sb = new StringBuffer();
		String br = System.getProperty("line.separator");
		sb.append("from : " + getFrom() + br);
		sb.append("to : " + getTo() + br);
		sb.append("subject : " + getSubject() + br);
		sb.append("body : " + getBody() + br);
		sb.append("smtphost : " + getSmtpHost() + br);
		
		return sb.toString();
	}
}
