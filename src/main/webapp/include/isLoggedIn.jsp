<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if (session.getAttribute("UserId") == null) {
	JSFunction.alertLocation("로그인 후 이용해주십시오.", "../member/login.jsp", out);
	// return이후의 문장은 실행되지 않는다.
	return;
}
%>