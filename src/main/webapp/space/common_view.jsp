<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String tname = session.getAttribute("tname").toString();

// num가져오기
String num = request.getParameter("num");
BoardDAO dao = new BoardDAO();
// 조회수 증가
dao.updateVisitCount(num, tname);

// 상세보기 페이지 출력
BoardDTO dto = dao.selectView(num, tname);
dao.close();
%>