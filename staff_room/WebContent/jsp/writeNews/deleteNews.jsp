<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.NewsDAO"%>
<%
// writeNews.jspから送信された削除する記事のIDを取得
String del_id = request.getParameter("del_id");
// 送信されてきた記事IDの文字列を配列に変換
String[] ids = del_id.split(",",0);
NewsDAO dao = new NewsDAO();
//dao.deleteNews(ids);
%>