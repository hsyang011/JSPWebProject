<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userName = request.getParameter("user_name");
String userEmail = request.getParameter("user_email");

MemberDAO dao = new MemberDAO();
String findId = dao.getMemberId(userName, userEmail);
dao.close();

if (findId != null) {
	request.setAttribute("FindId", findId);
	JSFunction.alertLocation("아이디는 " + findId + "입니다.", "./login.jsp", out);
} else {
	JSFunction.alertBack("아이디를 찾지 못하였습니다.", out);
}
%>