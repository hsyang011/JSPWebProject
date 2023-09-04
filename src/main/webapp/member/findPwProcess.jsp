<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("user_id");
String userName = request.getParameter("user_name");
String userEmail = request.getParameter("user_email");

MemberDAO dao = new MemberDAO();
String findPw = dao.getMemberPw(userId, userName, userEmail);
dao.close();

if (findPw != null) {
	request.setAttribute("FindId", findPw);
	JSFunction.alertLocation("비밀번호는 " + findPw + "입니다.", "./login.jsp", out);
} else {
	JSFunction.alertBack("비밀번호를 찾지 못하였습니다.", out);
}
%>