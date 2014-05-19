<%@ page language="java"
    contentType="text/html; charset=Windows-31J" %>
<%!
// 文字コードを変換する
	public String jpn2unicode(String original, String encode)
		throws java.io.UnsupportedEncodingException
			{
				if (original == null)
					{
						return null;
					}
		 return new String(original.getBytes("8859_1"), encode);
		 	}
%>