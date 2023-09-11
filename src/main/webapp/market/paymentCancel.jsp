<%@page import="utils.JSFunction"%>
<%@page import="market.PaymentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
PaymentDAO dao = new PaymentDAO();
int result = dao.paCancel(id);
dao.close();

if (result == 1) {
	JSFunction.alertLocation(id + "회원의 결제 요청을 취소시켰습니다.", "../main/super.do", out);
} else {
	JSFunction.alertBack(id + "회원의 결제 요청을 취소하는 데 실패하였습니다.", out);
}
%>