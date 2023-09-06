<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 폼값 받기
String name = request.getParameter("name");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String tel = request.getParameter("tel1") + "-" + request.getParameter("tel2") + "-" + request.getParameter("tel3");
String mobile = request.getParameter("mobile1") + "-" + request.getParameter("mobile2") + "-" + request.getParameter("mobile3");
String email = request.getParameter("email_1") + "@" + request.getParameter("email_2");
String mailing = request.getParameter("mailing");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

// DTO객체에 저장하기
MemberDTO dto = new MemberDTO();
dto.setName(name);
dto.setId(id);
dto.setPass(pass);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setMailing(mailing);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);

// DAO객체 생성 및 insert처리
MemberDAO dao = new MemberDAO();
int result = dao.joinInsert(dto);
dao.close();

if (result == 1) {
	JSFunction.alertLocation("회원가입에 성공하였습니다!", "../main/main.do", out);
} else {
	JSFunction.alertBack("회원가입에 실패하였습니다.", out);
}
%>