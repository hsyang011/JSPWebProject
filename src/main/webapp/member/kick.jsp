<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
int result = dao.kickMember(id);
dao.close();

if (result == 1) {
	JSFunction.alertLocation(id + " 회원을 퇴출시켰습니다.", "../main/super.do", out);
} else {
	JSFunction.alertBack(id + " 회원 퇴출에 실패하였습니다.", out);
}
%>