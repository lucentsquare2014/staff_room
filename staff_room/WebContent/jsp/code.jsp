<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
// 入力フォームからJSPに渡す文字データを日本語コードに直すメソッド。インクルードして使用
//例：jpn2unicode(request.getParameter("name"), "任意の日本語コード→UTF-8など"));
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