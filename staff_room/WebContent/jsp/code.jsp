<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
// 譁�ｭ励さ繝ｼ繝峨ｒ螟画鋤縺吶ｋ
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