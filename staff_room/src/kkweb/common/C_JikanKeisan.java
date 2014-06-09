package kkweb.common;

import java.text.*;
import java.util.*;

import kkweb.beans.B_Code;
import kkweb.dao.CodeDAO;

// 金澤　無駄なＤＢ処理をやらないようにした。(新しいメソッドの作成なども) 7/25
public class C_JikanKeisan {

	private String checkT(int hour, int minute) {

		String h = Integer.toString(hour);
		String m = Integer.toString(minute);

		String h_m = "";

		if (minute < 10) {

			h_m = h + "0" + m;

		} else {

			h_m = h + m;
		}

		return h_m;

	}

	public String sumJikan(String cyouka, String sinya) {

		try {

			SimpleDateFormat format = new SimpleDateFormat("HHmm");

			if (cyouka.equals("")) {
				cyouka = "0000";
			}

			long c = format.parse(cyouka).getTime();

			if (sinya.equals("")) {
				sinya = "0000";
			}

			long s = format.parse(sinya).getTime();

			long m = (c + s) / 60000;

			String sum = Long.toString(m);

			return sum;

		} catch (Exception e) {

			e.printStackTrace();

			return "";
		}
	}

	public String cyokusetuJikan(String start, String end, String code,
			String cyoku_work, String cyouka_work, String pcode, B_Code ctbl) {

		try {
			if (start.equals("") || end.equals("") || code.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				return cyoku_work;

			}

			// CodeDAO cdao = new CodeDAO();
			// String sql =
			// "select * from codeMST where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+code+"'";
			// ArrayList clist = cdao.selectTbl(sql);

			// B_Code ctbl = new B_Code();
			// ctbl = (B_Code)clist.get(0);

			String starttime = ctbl.getStartTIME();
			String endtime = ctbl.getEndTIME();

			int start_h = Integer.parseInt(start.substring(0, 2));
			int start_m = Integer.parseInt(start.substring(2));
			int end_h = Integer.parseInt(end.substring(0, 2));
			int end_m = Integer.parseInt(end.substring(2));
			int starttime_h = Integer.parseInt(starttime.substring(0, 2));
			int starttime_m = Integer.parseInt(starttime.substring(2));
			int endtime_h = Integer.parseInt(endtime.substring(0, 2));
			int endtime_m = Integer.parseInt(endtime.substring(2));
			/* 20111101 河村・金澤追加　休憩時間をプロジェクトマスタから取得 */
			int rest = Integer.parseInt(ctbl.getRestTIME());

			// if(((start_h*60)+start_m)<((starttime_h*60)+starttime_m)){
			// start_h=starttime_h;
			// start_m=starttime_m;
			// }
			int work_today = ((end_h * 60) + end_m)
					- ((start_h * 60) + start_m);
			int kihon = ((endtime_h * 60) + endtime_m)
					- ((starttime_h * 60) + starttime_m);
			int cyokusetu;
			String cyokusetujikan;

			if (code.equals("96")) {
				int cyoukatime = Integer.parseInt(cyouka_work);
				if (end_h >= 22) {
					if (work_today > 360 && work_today <= 480) {
						work_today = work_today - 45;
					} else if (work_today > 480) {
						work_today = work_today - 60;
					}
					int c_h = work_today / 60;
					int c_m = work_today % 60;
					cyokusetu = c_h * 100 + c_m;

				} else {
					cyokusetu = cyoukatime;
				}
				cyokusetujikan = Integer.toString(cyokusetu);
				return cyokusetujikan;
			}

			if (work_today < 0) {

				return "入力された値では正しく計算できません";

			}

			/* 20111101 河村・金澤追加　休憩時間の値をプロジェクトマスタから取得した値に変更 */
			if (work_today > 360 && work_today <= 480) {
				// work_today -= 45;
				// work_today -= 60;
				work_today -= rest;

			} else if (work_today > 480
					&& end_h * 60 + end_m > endtime_h * 60 + endtime_m) {
				int cyouka = work_today - kihon;
				// int cyouka=((end_h*60)+end_m)-((endtime_h*60)+endtime_m);
				if (cyouka < 30) {
					// work_today = work_today - cyouka - 60;
					work_today = work_today - cyouka - rest;
				} else {
					// work_today -= 90;
					work_today -= (rest + 30);
				}
			} else if (work_today > 480) {
				// work_today -= 60;
				work_today -= rest;
			}

			int cyoku_h = work_today / 60;
			int cyoku_m = work_today % 60;

			cyokusetujikan = checkT(cyoku_h, cyoku_m);

			return cyokusetujikan;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
	}

	public String cyoukaJikan(String end, String pcode, String code,
			String cyouka_work, String start, B_Code ctbl) {

		try {

			if (end.equals("") || pcode.equals("") || code.equals("")
					|| start.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				return cyouka_work;

			}

			if (code.equals("96")) {

				int cyouka;

				int start_h = Integer.parseInt(start.substring(0, 2));
				int start_m = Integer.parseInt(start.substring(2));
				int endjikan = Integer.parseInt(end);
				int end_h = Integer.parseInt(end.substring(0, 2));
				int end_m = Integer.parseInt(end.substring(2));
				int work_today = ((end_h * 60) + end_m)
						- ((start_h * 60) + start_m);

				if (endjikan > 2200) {

					cyouka = 22 * 60 - ((start_h * 60) + start_m);

				} else {

					cyouka = ((end_h * 60) + end_m)
							- ((start_h * 60) + start_m);

				}

				if (work_today > 360 && work_today <= 480) {
					if (cyouka < 45) {
						cyouka = 0;
					} else {
						cyouka -= 45;
					}
				} else if (work_today > 480) {
					if (cyouka < 60) {
						cyouka = 0;
					} else {
						cyouka -= 60;
					}
				}

				int sa_h = cyouka / 60;
				int sa_m = cyouka % 60;

				return checkT(sa_h, sa_m);

			}

			// CodeDAO cdao = new CodeDAO();
			// String sql =
			// "select * from codeMST where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+code+"'";
			// ArrayList clist = cdao.selectTbl(sql);

			// B_Code ctbl = new B_Code();
			// ctbl = (B_Code)clist.get(0);

			String endtime = ctbl.getEndTIME();
			String starttime = ctbl.getStartTIME();

			int start_h = Integer.parseInt(start.substring(0, 2));
			int start_m = Integer.parseInt(start.substring(2));
			int end_h = Integer.parseInt(end.substring(0, 2));
			int end_m = Integer.parseInt(end.substring(2));
			// int end_hm = Integer.parseInt(end);
			int starttime_h = Integer.parseInt(starttime.substring(0, 2));
			int starttime_m = Integer.parseInt(starttime.substring(2));
			int endtime_h = Integer.parseInt(endtime.substring(0, 2));
			int endtime_m = Integer.parseInt(endtime.substring(2));
			// if(((start_h*60)+start_m)<((starttime_h*60)+starttime_m)){
			// start_h=starttime_h;
			// start_m=starttime_m;
			// }
			// int work_today = ((end_h*60)+end_m)-((start_h*60)+start_m);
			// int kihon =
			// ((endtime_h*60)+endtime_m)-((starttime_h*60)+starttime_m);
			int cyouka = 0;

			String cyoukajikan = "";
			int cyouka_h;
			int cyouka_m;
			int end1 = end_h * 60 + end_m;
			int endtime1 = endtime_h * 60 + endtime_m + 30;
			int start1 = start_h * 60 + start_m;
			int starttime1 = starttime_h * 60 + starttime_m;

			if (start1 < starttime1) {
				cyouka = starttime1 - start1;
			}
			if (end1 >= endtime1) {
				if (end1 <= 1320) {
					cyouka = cyouka + (end1 - endtime1);
				} else {
					cyouka = cyouka + (22 * 60 - endtime1);
				}
			}
			cyouka_h = cyouka / 60;
			cyouka_m = cyouka % 60;
			cyoukajikan = checkT(cyouka_h, cyouka_m);

			return cyoukajikan;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
	}

	public String sinyaJikan(String start, String end, String code,
			String sinya_work) {

		try {

			if (end.equals("") || code.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				return sinya_work;

			}

			String start_hm = start;
			String end_hm = end;
			int start_h;
			int start_m;
			int end_h;
			int end_m;
			int sinya;
			int sinya_h;
			int sinya_m;
			String sinyajikan = "";
			int work_today;

			if (code.equals("96")) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));
				end_h = Integer.parseInt(end.substring(0, 2));
				end_m = Integer.parseInt(end.substring(2));
				work_today = end_h * 60 + end_m - start_h * 60 - start_m;
				int cyouka = (22 * 60) - ((start_h * 60) + start_m);
				sinya = ((end_h * 60) + end_m) - (22 * 60);

				if (work_today > 360 && work_today <= 480 && cyouka < 45) {
					int A = 45 - cyouka;
					sinya = sinya - A;
					sinya_h = (sinya / 60);
					sinya_m = sinya % 60;
					sinyajikan = checkT(sinya_h, sinya_m);
					return sinyajikan;
				} else if (work_today > 480 && cyouka < 60) {
					int A = 60 - cyouka;
					sinya = sinya - A;
					sinya_h = (sinya / 60);
					sinya_m = sinya % 60;
					sinyajikan = checkT(sinya_h, sinya_m);
					return sinyajikan;
				}

			}

			if (Integer.parseInt(start_hm) > 500
					&& Integer.parseInt(start_hm) <= 2200
					&& Integer.parseInt(end_hm) > 2200
					&& Integer.parseInt(end_hm) <= 2900) {
				end_h = Integer.parseInt(end.substring(0, 2));
				end_m = Integer.parseInt(end.substring(2));

				sinya = ((end_h * 60) + end_m) - (22 * 60);
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else if (Integer.parseInt(start_hm) > 500
					&& Integer.parseInt(start_hm) <= 2200
					&& Integer.parseInt(end_hm) > 2200
					&& Integer.parseInt(end_hm) > 2900) {

				sinyajikan = "700";

			} else if (Integer.parseInt(start_hm) < 500
					&& Integer.parseInt(end_hm) <= 2200) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));

				sinya = (5 * 60) - ((start_h * 60) + start_m);
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else if (Integer.parseInt(start_hm) < 500
					&& Integer.parseInt(end_hm) > 2200
					&& Integer.parseInt(end_hm) <= 2900) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));
				end_h = Integer.parseInt(end.substring(0, 2));
				end_m = Integer.parseInt(end.substring(2));

				sinya = ((5 * 60) - ((start_h * 60) + start_m))
						+ (((end_h * 60) + end_m) - (22 * 60));
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else if (Integer.parseInt(start_hm) < 500
					&& Integer.parseInt(end_hm) > 2200
					&& Integer.parseInt(end_hm) > 2900) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));

				sinya = ((5 * 60) - ((start_h * 60) + start_m)) + 420;
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else if (Integer.parseInt(start_hm) >= 2200
					&& Integer.parseInt(end_hm) <= 2900) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));
				end_h = Integer.parseInt(end.substring(0, 2));
				end_m = Integer.parseInt(end.substring(2));

				sinya = ((end_h * 60) + end_m) - ((start_h * 60) + start_m);
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else if (Integer.parseInt(start_hm) >= 2200
					&& Integer.parseInt(end_hm) > 2900) {
				start_h = Integer.parseInt(start.substring(0, 2));
				start_m = Integer.parseInt(start.substring(2));

				sinya = (29 * 60) - ((start_h * 60) + start_m);
				sinya_h = sinya / 60;
				sinya_m = sinya % 60;

				sinyajikan = checkT(sinya_h, sinya_m);

			} else {
				sinyajikan = "0";

			}

			return sinyajikan;

		} catch (Exception e) {

			e.printStackTrace();
			return "";
		}
	}

	public String furoujikan(String start, String end, String pcode,
			String code, String furou_work, B_Code ctbl) {

		try {
			if (start.equals("") || end.equals("") || pcode.equals("")
					|| code.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				return furou_work;

			}

			if (code.equals("96") || /* code.equals("97") || */code.equals("98")
					|| code.equals("99")) {

				return "0";

			}

			// CodeDAO cdao = new CodeDAO();
			// String sql =
			// " select * from codeMST where PROJECTcode ='"+pcode+"' AND KINMUcode ='"+code+"'";
			// ArrayList clist = cdao.selectTbl(sql);

			// B_Code ctbl = new B_Code();
			// ctbl = (B_Code)clist.get(0);

			String s = ctbl.getStartTIME();
			String e = ctbl.getEndTIME();

			int s_w = Integer.parseInt(start);
			int e_w = Integer.parseInt(end);
			int s_k = Integer.parseInt(s);
			int e_k = Integer.parseInt(e);

			int start_h = Integer.parseInt(start.substring(0, 2));
			int start_m = Integer.parseInt(start.substring(2));
			int end_h = Integer.parseInt(end.substring(0, 2));
			int end_m = Integer.parseInt(end.substring(2));
			int starttime_h = Integer.parseInt(s.substring(0, 2));
			int starttime_m = Integer.parseInt(s.substring(2));
			int endtime_h = Integer.parseInt(e.substring(0, 2));
			int endtime_m = Integer.parseInt(e.substring(2));

			int work_today = ((end_h * 60) + end_m)
					- ((start_h * 60) + start_m);
			int kihon = ((endtime_h * 60) + endtime_m)
					- ((starttime_h * 60) + starttime_m);
			String furoujikan = "";

			if (work_today < kihon) {
				int furou = kihon - work_today;
				int furou_h = furou / 60;
				int furou_m = furou % 60;

				furoujikan = checkT(furou_h, furou_m);
			} else {
				// 修正箇所
				int furou_s = 0;
				int furou_e = 0;
				int furou = 0;

				if (s_w > s_k) {
					furou_s = (start_h * 60 + start_m)
							- (starttime_h * 60 + starttime_m);
				}
				if (e_w < e_k) {
					furou_e = (endtime_h * 60 + endtime_m)
							- (end_h * 60 + end_m);
				}

				furou = furou_s + furou_e;

				int furou_h = furou / 60;
				int furou_m = furou % 60;

				furoujikan = checkT(furou_h, furou_m);

				// furoujikan = "0";

			}

			return furoujikan;

		} catch (Exception e) {

			e.printStackTrace();

			return "";
		}
	}

	public String restJikan(String start, String end, String code,
			String cyoku, String rest_work) {

		try {
			if (start.equals("") || end.equals("") || code.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				return rest_work;

			}

			int start_h = Integer.parseInt(start.substring(0, 2));
			int start_m = Integer.parseInt(start.substring(2));
			int end_h = Integer.parseInt(end.substring(0, 2));
			int end_m = Integer.parseInt(end.substring(2));
			int cyoku_h = 0;
			int cyoku_m = 0;
			int cyoku_lgh = cyoku.length();

			switch (cyoku_lgh) {
			case 1:
				cyoku_h = 0;
				cyoku_m = Integer.parseInt(cyoku.substring(0, 1));
				break;
			case 2:
				cyoku_h = 0;
				cyoku_m = Integer.parseInt(cyoku.substring(0, 2));
				break;
			case 3:
				cyoku_h = Integer.parseInt(cyoku.substring(0, 1));
				cyoku_m = Integer.parseInt(cyoku.substring(1));
				break;
			case 4:
				cyoku_h = Integer.parseInt(cyoku.substring(0, 2));
				cyoku_m = Integer.parseInt(cyoku.substring(2));
				break;
			}

			int rest = (((end_h * 60) + end_m) - ((start_h * 60) + start_m))
					- ((cyoku_h * 60) + cyoku_m);
			// System.out.println(end_h*60+" "+end_m+" "+start_h*60+" "+start_m+" "+cyoku_h*60+" "+cyoku_m+" rest"+rest);
			return Integer.toString(rest);

		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public String checkPname(String pcode, String code) {

		try {

			String shift_kinmu = "";

			if (pcode.equals("") || code.equals("")) {

				return "";

			}

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				code = code.substring(1);

				shift_kinmu = "<シフト勤務>";

			}

			CodeDAO cdao = new CodeDAO();
			String sql2 = " where projectcode ='" + pcode
					+ "' AND KINMUcode ='" + code + "'";

			if (cdao.isThereTbl(sql2)) {

				// sql =
				// " select * from codeMST where projectcode ='"+pcode+"' AND KINMUcode ='"+code+"'";

				// ArrayList clist = cdao.selectTbl(sql);

				// B_Code bcode = new B_Code();
				// bcode = (B_Code)clist.get(0);

				// return
				// bcode.getPROJECTname()+shift_kinmu+"("+bcode.getBikou()+")";
				return shift_kinmu;
			} else {

				return "ERROR";

			}

		} catch (Exception e) {

			e.printStackTrace();

			return "";

		}
	}

	public B_Code checkPname2(String pcode, String code) {

		try {

			CodeDAO cdao = new CodeDAO();
			String sql = " select * from codeMST where projectcode ='" + pcode
					+ "' AND KINMUcode ='" + code + "'";

			ArrayList clist = cdao.selectTbl(sql);
			B_Code bcode = new B_Code();
			bcode = (B_Code) clist.get(0);

			return bcode;

		} catch (Exception e) {

			return null;

		}
	}

	public String deletePname(String pcode, String code, String pname) {

		try {
			if (pname.equals("")) {

				return pname;

			}

			if (pcode.equals("") || code.equals("")) {

				return pname;

			}

			String shift_kinmu = "";

			if (code.substring(0, 1).equals("f")
					|| code.substring(0, 1).equals("F")) {

				code = code.substring(1);

				shift_kinmu = "<シフト勤務>";

			}

			CodeDAO cdao = new CodeDAO();
			String sql = " where projectcode ='" + pcode + "' AND KINMUcode ='"
					+ code + "'";

			if (cdao.isThereTbl(sql)) {

				sql = " select * from codeMST where projectcode ='" + pcode
						+ "' AND KINMUcode ='" + code + "'";

				ArrayList clist = cdao.selectTbl(sql);

				B_Code bcode = new B_Code();
				bcode = (B_Code) clist.get(0);
				String work = bcode.getPROJECTname() + shift_kinmu + "("
						+ bcode.getBikou() + ")";

				int i = pname.lastIndexOf(work);

				if (i >= 0) {

					if (pname.length() > work.length()) {

						pname = pname.substring(work.length());

					} else {

						pname = "";

					}

				}

				return pname;

			} else {

				return pname;

			}

		} catch (Exception e) {

			e.printStackTrace();

			return pname;

		}

	}

	public boolean Nyuryokucheck(String strWhere) {

		if (strWhere.equals("")) {

			return true;

		} else if (checkHanNum(strWhere) == true) {

			return true;

		} else {

			return false;

		}
	}

	private boolean checkHanNum(String item) { // チェックする文字列
		boolean flag = true;

		for (int i = 0; item.length() > i && flag == true; i++) {
			if ('0' <= item.charAt(i) && item.charAt(i) <= '9') {
			} else {
				flag = false;
			}
		}
		return flag;
	}

	public boolean check_start_end(String start, String end) {

		try {
			if (start.equals("") || end.equals("")) {

				return true;

			} else {

				int s = Integer.parseInt(start);
				int e = Integer.parseInt(end);

				// if(s > e){
				if (s >= e) {

					return false;

				} else {

					return true;

				}

			}

		} catch (Exception e) {

			e.printStackTrace();

			return false;

		}
	}

	public String bikou(String bikou, String holiday) {

		try {

			if (bikou.equals("")) {

				return bikou;

			}

			if (holiday.equals("")) {

				return bikou;

			}

			bikou = bikou.trim();
			holiday = holiday.trim();

			int i = bikou.lastIndexOf(holiday);

			if (i >= 0) {

				if (bikou.length() > holiday.length()) {

					bikou = bikou.replaceAll(holiday, "");
					// bikou = bikou.substring(holiday.length());

				} else {

					bikou = "";

				}

			}

			return bikou;

		} catch (Exception e) {

			e.printStackTrace();

			return bikou;

		}

	}

	public boolean checkDigit(String start, String end) {

		try {
			if (start.equals("") || end.equals("")) {
				return true;
			}

			int startDigit = start.length();
			int endDigit = end.length();

			if (startDigit != 4 || endDigit != 4) {
				return false;

			} else {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean checkMinute(String start, String end) {

		try {
			if (start.equals("") || end.equals("")) {
				return true;
			} else if (start.length() != 4 || end.length() != 4) {
				return true;
			}

			int start_minute = Integer.parseInt(start.substring(2));
			int end_minute = Integer.parseInt(end.substring(2));

			if (start_minute >= 60 || end_minute >= 60) {
				return false;
			} else {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public String testtest(String pcode, String code) {

		return pcode + code;
	}

}
