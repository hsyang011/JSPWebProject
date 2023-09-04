<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(userId, userPwd);
dao.close();

if (dto.getId() != null) {
	session.setAttribute("UserId", dto.getId());
	session.setAttribute("UserName", dto.getName());
	JSFunction.alertLocation("로그인에 성공하였습니다!", "../main/main.jsp", out);
} else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	JSFunction.alertBack("로그인에 실패하였습니다.", out);
}
%>