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

// 로그인 상태로 간주한다.
if (dto.getId() != null) {
	session.setAttribute("UserId", dto.getId());
	session.setAttribute("UserPw", dto.getPass());
	session.setAttribute("UserName", dto.getName());
	session.setAttribute("UserEmail", dto.getEmail());
	session.setAttribute("UserGrade", dto.getGrade());
	
	if (dto.getGrade().equals("Normal")) {
		JSFunction.alertLocation("로그인에 성공하였습니다!", "../main/main.do", out);
	} else if (dto.getGrade().equals("Super")) {
		JSFunction.alertLocation("슈퍼 계정으로 접속합니다.", "../main/super.do", out);
	}
// 로그인 실패로 간주한다.
} else {
	JSFunction.alertBack("로그인에 실패하였습니다.", out);
}
%>