package kkweb.beans;

import java.text.DecimalFormat;
import java.util.ArrayList;

// 給与明細書を表すクラス
public class Payslip extends Paper{
	// 給与明細書データベースに登録されている値
	/* Paperが持っているフィールド
	 * private String id; // 書類ID
	 * private String number; // 社員番号
	 * private String year; // 年
	 * private String month; // 月
	 *
	 */
	private String sikyuukubun; // 支給区分
	private String nennreikyu; // 年齢給
	private String syokunoukyu; // 職能給
	private String jissekikyu; // 実績給
	private String sairyouteate; // 裁量手当
	private String syokuiteate; // 職位手当
	private String chiikiteate; // 地域手当
	private String huyouteate; // 扶養手当
	private String tyouseiteate; // 調整手当

	private String tyuuzaiteate; // 駐在手当
	private String tanhuteate; // 単赴手当
	private String kazeiryohi; // 課税旅費
	private String sonotakyu; // その他(休)
	private String genbutusikyu; // 現物支給
	private String sonotatoku; // その他(特)
	private String hikazeisonota; // 非課税その他

	private String tuukinteate; // 通勤手当
	private String kazeituukin; // 課税通勤
	private String tokubetutyouseigaku; // 特別調整額
	private String kazeisikyukei; // 課税支給計
	private String hikazeikei; // 非課税計
	private String sikyuugakugoukei; // 支給額合計

	private String kenkouhokenryou; // 健康保険料
	private String kaigohokenryou; // 介護保険料
	private String kouseinennkin; // 厚生年金
	private String kouseikikin; // 厚生基金
	private String koyouhokenryou; // 雇用保険料
	private String hokenryougoukei; // 保険料合計
	private String kazeitaisyougaku; // 課税対象額
	private String syotokuzei; // 所得税
	private String juuminzei; // 住民税

	private String kihonkenporyou; // 基本健保料
	private String zaikeitumitate; // 財形積み立て
	private String ryouhi; // 寮費
	private String tatekaekin; // 立て替え金
	private String maebaraikin; // 前払い金
	private String kabusikikyosyutukin; // 株式拠出金
	private String sonota; // その他

	private String tokuteikenporyou; // 特定健保料
	private String ippankoujokei; // 一般控除計
	private String koujogoukei; // 控除合計

	private String yuukyuuzannjitu; // 有休残日

	private String hurikomi1; // 振込1
	private String hurikomi2; // 振込2
	private String sasihikisikyuugaku; // 差引支給額

	private String owner_bill; // 事業主掛金
	private String member_bill; // 加入者掛金

	private boolean update; // update flag

	// 支給のヘッダー
	private ArrayList<String> hedder1;
	// 控除のヘッダー
	private ArrayList<String> hedder2;
	// 勤怠のヘッダー
	private ArrayList<String> hedder3;
	// 記事のヘッダー
	private ArrayList<String> hedder4;

	public Payslip(){
		// 各ヘッダーを初期化
		String[] h1 = {
				"年齢給", "職能給","実績給","裁量手当","職位手当","地域手当","扶養手当","調整手当",	"",
				"駐在手当","単赴手当",	"課税旅費",	"その他(休)",	"現物支給","その他(特)","非税その他",	"",	"",
				"","",	"通勤手当","課税通勤","特別調整額","","課税支給計","非課税計",	"支給額合計"
		};
		hedder1  = new ArrayList<String>();
		for(String str : h1) hedder1.add(str);

		String[] h2 = {
				"健康保険料","介護保険料","厚生年金","厚生基金","雇用保険料","保険料合計","DC掛金","課税対象額","所得税",
				"(基本健保料)","","財形積立","寮費","立替金","前払い金","株式拠出金","その他","一般控除計",
				"(特定健保料)","","","","","","",	"住民税","控除合計"
		};
		hedder2  = new ArrayList<String>();
		for(String str : h2) hedder2.add(str);

		String[] h3 = {
				"有休残日","","","","","","","",""
		};
		hedder3  = new ArrayList<String>();
		for(String str : h3) hedder3.add(str);

		String[] h4 = {
				"","DC拠出金","","","現物支給","振込1","振込2","","差引支給額"
		};
		hedder4  = new ArrayList<String>();
		for(String str : h4) hedder4.add(str);

	}
	public ArrayList<String> getSikyuuHedder(){
		return hedder1;
	}
	public ArrayList<String> getKoujoHedder(){
		return hedder2;
	}
	public ArrayList<String> getKintaiHedder(){
		return hedder3;
	}
	public ArrayList<String> getKijiHedder(){
		return hedder4;
	}

	// 支給に該当する値を返す
	public ArrayList<String> getSikyuu(){
		ArrayList<String> list = new ArrayList<String>();
		// 1行目
		list.add(nennreikyu); // 年齢給
		list.add(syokunoukyu); // 職能給
		list.add(jissekikyu); // 実績給
		list.add(sairyouteate); // 裁量手当
		list.add(syokuiteate); // 職位手当
		list.add(chiikiteate); // 地域手当
		list.add(huyouteate); // 扶養手当
		list.add(tyouseiteate); // 調整手当
		list.add(""); //　スペース
		// 2行目
		list.add(tyuuzaiteate); // 駐在手当
		list.add(tanhuteate); // 単赴手当
		list.add(kazeiryohi); // 課税旅費
		list.add(sonotakyu); // その他(休)
		list.add(genbutusikyu); // 現物支給
		list.add(sonotatoku); // その他(特)
		list.add(hikazeisonota); // 非課税その他
		list.add("");
		list.add("");
		// 3行目
		list.add("");
		list.add("");
		list.add(tuukinteate); // 通勤手当
		list.add(kazeituukin); // 課税通勤
		list.add(tokubetutyouseigaku); // 特別調整額
		list.add("");
		list.add(kazeisikyukei); // 課税支給計
		list.add(hikazeikei); // 非課税計
		list.add(sikyuugakugoukei); // 支給額合計

		return list;
	}

	// 控除に該当する値を返す
	public ArrayList<String> getKoujo(){
		ArrayList<String> list = new ArrayList<String>();
		// 1行目
		list.add(kenkouhokenryou); // 健康保険料
		list.add(kaigohokenryou); // 介護保険料
		list.add(kouseinennkin); // 厚生年金
		list.add(kouseikikin); // 厚生基金
		list.add(koyouhokenryou); // 雇用保険料
		list.add(hokenryougoukei); // 保険料合計
		list.add(member_bill); // 加入者掛金
		list.add(kazeitaisyougaku); // 課税対象額
		list.add(syotokuzei); // 所得税
		// 2行目
		list.add("(" + kihonkenporyou + ")" ); // 基本健保料
		list.add("");
		list.add(zaikeitumitate); // 財形積み立て
		list.add(ryouhi); // 寮費
		list.add(tatekaekin); // 立て替え金
		list.add(maebaraikin); // 前払い金
		list.add(kabusikikyosyutukin); // 株式拠出金
		list.add(sonota); // その他
		list.add(ippankoujokei); // 一般控除計
		// 3行目
		list.add("("+tokuteikenporyou+")"); // 特定健保料
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add(juuminzei); // 住民税
		list.add(koujogoukei); // 控除合計

		return list;
	}

	// 勤怠に該当する値を返す
	public ArrayList<String> getKintai(){
		float zann = 0l;
		ArrayList<String> list = new ArrayList<String>();
		try {
			zann = Float.parseFloat(yuukyuuzannjitu);
			DecimalFormat df = new DecimalFormat("##0.0");
			list.add(df.format(zann)); // 有休残日
		} catch (NumberFormatException e) {
			//e.printStackTrace();
			list.add("");
		}
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");
		list.add("");

		return list;
	}

	// 記事に該当する値を返す
	public ArrayList<String> getKiji(){
		ArrayList<String> list = new ArrayList<String>();
		list.add("");
		list.add(owner_bill); // 事業主掛金
		list.add("");
		list.add("");
		list.add(genbutusikyu); // 現物支給
		list.add(hurikomi1); // 振込1
		list.add(hurikomi2); // 振込2
		list.add("");
		list.add(sasihikisikyuugaku); // 差引支給額

		return list;
	}

	//
	public String toStatus(){
		String up = "更新";
		String nw = "公開";
		if(isUpdate()){
			return up;
		}
		return nw;
	}

	public String getSikyuukubun() {
		return sikyuukubun;
	}
	public void setSikyuukubun(String sikyuukubun) {
		this.sikyuukubun = sikyuukubun;
	}
	public String getNennreikyu() {
		return nennreikyu;
	}
	public void setNennreikyu(String nennreikyu) {
		this.nennreikyu = nennreikyu;
	}
	public String getSyokunoukyu() {
		return syokunoukyu;
	}
	public void setSyokunoukyu(String syokunoukyu) {
		this.syokunoukyu = syokunoukyu;
	}
	public String getJissekikyu() {
		return jissekikyu;
	}
	public void setJissekikyu(String jissekikyu) {
		this.jissekikyu = jissekikyu;
	}
	public String getSairyouteate() {
		return sairyouteate;
	}
	public void setSairyouteate(String sairyouteate) {
		this.sairyouteate = sairyouteate;
	}
	public String getSyokuiteate() {
		return syokuiteate;
	}
	public void setSyokuiteate(String syokuiteate) {
		this.syokuiteate = syokuiteate;
	}
	public String getChiikiteate() {
		return chiikiteate;
	}
	public void setChiikiteate(String chiikiteate) {
		this.chiikiteate = chiikiteate;
	}
	public String getHuyouteate() {
		return huyouteate;
	}
	public void setHuyouteate(String huyouteate) {
		this.huyouteate = huyouteate;
	}
	public String getTyouseiteate() {
		return tyouseiteate;
	}
	public void setTyouseiteate(String tyouseiteate) {
		this.tyouseiteate = tyouseiteate;
	}
	public String getTyuuzaiteate() {
		return tyuuzaiteate;
	}
	public void setTyuuzaiteate(String tyuuzaiteate) {
		this.tyuuzaiteate = tyuuzaiteate;
	}
	public String getTanhuteate() {
		return tanhuteate;
	}
	public void setTanhuteate(String tanhuteate) {
		this.tanhuteate = tanhuteate;
	}
	public String getKazeiryohi() {
		return kazeiryohi;
	}
	public void setKazeiryohi(String kazeiryohi) {
		this.kazeiryohi = kazeiryohi;
	}
	public String getSonotakyu() {
		return sonotakyu;
	}
	public void setSonotakyu(String sonotakyu) {
		this.sonotakyu = sonotakyu;
	}
	public String getGenbutusikyu() {
		return genbutusikyu;
	}
	public void setGenbutusikyu(String genbutusikyu) {
		this.genbutusikyu = genbutusikyu;
	}
	public String getSonotatoku() {
		return sonotatoku;
	}
	public void setSonotatoku(String sonotatoku) {
		this.sonotatoku = sonotatoku;
	}
	public String getHikazeisonota() {
		return hikazeisonota;
	}
	public void setHikazeisonota(String hikazeisonota) {
		this.hikazeisonota = hikazeisonota;
	}
	public String getTuukinteate() {
		return tuukinteate;
	}
	public void setTuukinteate(String tuukinteate) {
		this.tuukinteate = tuukinteate;
	}
	public String getKazeituukin() {
		return kazeituukin;
	}
	public void setKazeituukin(String kazeituukin) {
		this.kazeituukin = kazeituukin;
	}
	public String getTokubetutyouseigaku() {
		return tokubetutyouseigaku;
	}
	public void setTokubetutyouseigaku(String tokubetutyouseigaku) {
		this.tokubetutyouseigaku = tokubetutyouseigaku;
	}
	public String getKazeisikyukei() {
		return kazeisikyukei;
	}
	public void setKazeisikyukei(String kazeisikyukei) {
		this.kazeisikyukei = kazeisikyukei;
	}
	public String getHikazeikei() {
		return hikazeikei;
	}
	public void setHikazeikei(String hikazeikei) {
		this.hikazeikei = hikazeikei;
	}
	public String getSikyuugakugoukei() {
		return sikyuugakugoukei;
	}
	public void setSikyuugakugoukei(String sikyuugakugoukei) {
		this.sikyuugakugoukei = sikyuugakugoukei;
	}
	public String getKenkouhokenryou() {
		return kenkouhokenryou;
	}
	public void setKenkouhokenryou(String kenkouhokenryou) {
		this.kenkouhokenryou = kenkouhokenryou;
	}
	public String getKaigohokenryou() {
		return kaigohokenryou;
	}
	public void setKaigohokenryou(String kaigohokenryou) {
		this.kaigohokenryou = kaigohokenryou;
	}
	public String getKouseinennkin() {
		return kouseinennkin;
	}
	public void setKouseinennkin(String kouseinennkin) {
		this.kouseinennkin = kouseinennkin;
	}
	public String getKouseikikin() {
		return kouseikikin;
	}
	public void setKouseikikin(String kouseikikin) {
		this.kouseikikin = kouseikikin;
	}
	public String getKoyouhokenryou() {
		return koyouhokenryou;
	}
	public void setKoyouhokenryou(String koyouhokenryou) {
		this.koyouhokenryou = koyouhokenryou;
	}
	public String getHokenryougoukei() {
		return hokenryougoukei;
	}
	public void setHokenryougoukei(String hokenryougoukei) {
		this.hokenryougoukei = hokenryougoukei;
	}
	public String getKazeitaisyougaku() {
		return kazeitaisyougaku;
	}
	public void setKazeitaisyougaku(String kazeitaisyougaku) {
		this.kazeitaisyougaku = kazeitaisyougaku;
	}
	public String getSyotokuzei() {
		return syotokuzei;
	}
	public void setSyotokuzei(String syotokuzei) {
		this.syotokuzei = syotokuzei;
	}
	public String getJuuminzei() {
		return juuminzei;
	}
	public void setJuuminzei(String juuminzei) {
		this.juuminzei = juuminzei;
	}
	public String getKihonkenporyou() {
		return kihonkenporyou;
	}
	public void setKihonkenporyou(String kihonkenporyou) {
		this.kihonkenporyou = kihonkenporyou;
	}
	public String getZaikeitumitate() {
		return zaikeitumitate;
	}
	public void setZaikeitumitate(String zaikeitumitate) {
		this.zaikeitumitate = zaikeitumitate;
	}
	public String getRyouhi() {
		return ryouhi;
	}
	public void setRyouhi(String ryouhi) {
		this.ryouhi = ryouhi;
	}
	public String getTatekaekin() {
		return tatekaekin;
	}
	public void setTatekaekin(String tatekaekin) {
		this.tatekaekin = tatekaekin;
	}
	public String getMaebaraikin() {
		return maebaraikin;
	}
	public void setMaebaraikin(String maebaraikin) {
		this.maebaraikin = maebaraikin;
	}
	public String getKabusikikyosyutukin() {
		return kabusikikyosyutukin;
	}
	public void setKabusikikyosyutukin(String kabusikikyosyutukin) {
		this.kabusikikyosyutukin = kabusikikyosyutukin;
	}
	public String getSonota() {
		return sonota;
	}
	public void setSonota(String sonota) {
		this.sonota = sonota;
	}
	public String getTokuteikenporyou() {
		return tokuteikenporyou;
	}
	public void setTokuteikenporyou(String tokuteikenporyou) {
		this.tokuteikenporyou = tokuteikenporyou;
	}
	public String getIppankoujokei() {
		return ippankoujokei;
	}
	public void setIppankoujokei(String ippankoujokei) {
		this.ippankoujokei = ippankoujokei;
	}
	public String getKoujogoukei() {
		return koujogoukei;
	}
	public void setKoujogoukei(String koujogoukei) {
		this.koujogoukei = koujogoukei;
	}
	public String getYuukyuuzannjitu() {
		return yuukyuuzannjitu;
	}
	public void setYuukyuuzannjitu(String yuukyuuzannjitu) {
		this.yuukyuuzannjitu = yuukyuuzannjitu;
	}
	public String getHurikomi1() {
		return hurikomi1;
	}
	public void setHurikomi1(String hurikomi1) {
		this.hurikomi1 = hurikomi1;
	}
	public String getHurikomi2() {
		return hurikomi2;
	}
	public void setHurikomi2(String hurikomi2) {
		this.hurikomi2 = hurikomi2;
	}
	public String getSasihikisikyuugaku() {
		return sasihikisikyuugaku;
	}
	public void setSasihikisikyuugaku(String sasihikisikyuugaku) {
		this.sasihikisikyuugaku = sasihikisikyuugaku;
	}
	public String getOwner_bill() {
		return owner_bill;
	}
	public void setOwner_bill(String owner_bill) {
		this.owner_bill = owner_bill;
	}
	public String getMember_bill() {
		return member_bill;
	}
	public void setMember_bill(String member_bill) {
		this.member_bill = member_bill;
	}
	public boolean isUpdate() {
		return update;
	}
	public void setUpdate(boolean update) {
		this.update = update;
	}

	public String toString(){
		String str = "";
		str += getNumber() + ":"; // 社員番号
		str += getYear() + ":"; // 年
		str += getMonth() + ":"; // 月
		str += sikyuukubun + ":"; // 支給区分

		str += nennreikyu + ":"; // 年齢給
		str += syokunoukyu + ":"; // 職能給
		str += jissekikyu + ":"; // 実績給
		str += sairyouteate + ":"; // 裁量手当
		str += syokuiteate + ":"; // 職位手当
		str += chiikiteate + ":"; // 地域手当
		str += huyouteate + ":"; // 扶養手当
		str += tyouseiteate + ":"; // 調整手当

		str += tyuuzaiteate + ":"; // 駐在手当
		str += tanhuteate + ":"; // 単赴手当
		str += kazeiryohi + ":"; // 課税旅費
		str += sonotakyu + ":"; // その他(休)
		str += genbutusikyu + ":"; // 現物支給
		str += sonotatoku + ":"; // その他(特)
		str += hikazeisonota + ":"; // 非課税その他

		str += tuukinteate + ":"; // 通勤手当
		str += kazeituukin + ":"; // 課税通勤
		str += tokubetutyouseigaku + ":"; // 特別調整額
		str += kazeisikyukei + ":"; // 課税支給計
		str += hikazeikei + ":"; // 非課税計
		str += sikyuugakugoukei + ":"; // 支給額合計

		str += kenkouhokenryou + ":"; // 健康保険料
		str += kaigohokenryou + ":"; // 介護保険料
		str += kouseinennkin + ":"; // 厚生年金
		str += kouseikikin + ":"; // 厚生基金
		str += koyouhokenryou + ":"; // 雇用保険料
		str += hokenryougoukei + ":"; // 保険料合計
		str += kazeitaisyougaku + ":"; // 課税対象額
		str += syotokuzei + ":"; // 所得税
		str += juuminzei + ":"; // 住民税

		str += kihonkenporyou + ":"; // 基本健保料
		str += zaikeitumitate + ":"; // 財形積み立て
		str += ryouhi + ":"; // 寮費
		str += tatekaekin + ":"; // 立て替え金
		str += maebaraikin + ":"; // 前払い金
		str += kabusikikyosyutukin + ":"; // 株式拠出金
		str += sonota + ":"; // その他

		str += tokuteikenporyou + ":"; // 特定健保料
		str += ippankoujokei + ":"; // 一般控除計
		str += koujogoukei + ":"; // 控除合計

		str += yuukyuuzannjitu + ":"; // 有休残日

		str += hurikomi1 + ":"; // 振込1
		str += hurikomi2 + ":"; // 振込2
		str += sasihikisikyuugaku + ":"; // 差引支給額

		str += owner_bill + ":"; // 事業主掛金
		str += member_bill + ":"; // 加入者掛金

		str += update; // update flag

		return str;
	}
}
