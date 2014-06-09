package kkweb.common;

public class C_HolidayBackcolor {

	public String holidaycolor(String youbi, String holiday) {

		try {
			String bgcolor = "";

			if (youbi.equals("土")) {

				bgcolor = "#6495ED";

			} else if (youbi.equals("日")) {

				bgcolor = "#FA8072";

			} else if (!holiday.equals("")) {

				bgcolor = "#FA8072";

			} else {

				bgcolor = "#F5F5F5";

			}

			return bgcolor;

		} catch (Exception e) {

			e.printStackTrace();

			return "";
		}
	}

}
