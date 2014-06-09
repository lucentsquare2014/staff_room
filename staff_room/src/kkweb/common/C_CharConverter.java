package kkweb.common;

import java.text.ParseException;

public class C_CharConverter {

	public String convert(String s) throws ParseException {
		
		StringBuffer sb = new StringBuffer();
		char c;
		for (int i = 0; i < s.length(); i++) {
		    c  = s.charAt(i);

		    switch (c) {
			    case 0xff3c:		// FULLWIDTH REVERSE SOLIDUS ->
				c = 0x005c;			// REVERSE SOLIDUS
				break;
			    case 0xff5e:		// FULLWIDTH TILDE ->
				c = 0x301c;			// WAVE DASH
				break;
			    case 0x2225:		// PARALLEL TO ->
				c = 0x2016;			// DOUBLE VERTICAL LINE
				break;
			    case 0xff0d:		// FULLWIDTH HYPHEN-MINUS ->
				c = 0x2212;			// MINUS SIGN
				break;
			    case 0xffe0:		// FULLWIDTH CENT SIGN ->
				c = 0x00a2;			// CENT SIGN
				break;
			    case 0xffe1:		// FULLWIDTH POUND SIGN ->
				c = 0x00a3;			// POUND SIGN
				break;
			    case 0xffe2:		// FULLWIDTH NOT SIGN ->
				c = 0x00ac;			// NOT SIGN
				break;
			    }
			    sb.append(c);
		}

		return new String(sb);
	}
}
