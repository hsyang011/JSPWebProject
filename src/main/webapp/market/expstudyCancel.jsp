<%@page import="market.ExpstudyDAO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");
ExpstudyDAO dao = new ExpstudyDAO();
int result = dao.exCancel(num);
dao.close();

if (result == 1) {
	JSFunction.alertLocation(num + "번 접수를 취소시켰습니다.", "../main/super.do", out);
} else {
	JSFunction.alertBack(num + "번 접수를 취소하는 데 실패하였습니다.", out);
}
%>