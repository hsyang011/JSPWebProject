<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그아웃 처리한다.
session.removeAttribute("UserId");
session.removeAttribute("UserName");

// 로그아웃 했다는 메세지를 띄우고 login.jsp로 이동한다.
JSFunction.alertLocation("로그아웃하였습니다.", "../main/main.jsp", out);
%>
