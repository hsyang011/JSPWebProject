<%@page import="utils.CookieManager"%>
<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");
String chkVal = request.getParameter("savedId");

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(userId, userPwd);
dao.close();

// 쿠키 추가
if (chkVal!=null && chkVal.equals("1")) {
	CookieManager.makeCookie(response, "SavedId", userId, 60*60*24);
// 쿠키 삭제
} else {
	CookieManager.deleteCookie(response, "SavedId");
}

if (dto.getId() != null) {
	session.setAttribute("UserId", dto.getId());
	session.setAttribute("UserName", dto.getName());
	JSFunction.alertLocation("로그인에 성공하였습니다!", "../main/main.jsp", out);
} else {
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	JSFunction.alertBack("로그인에 실패하였습니다.", out);
}
%>