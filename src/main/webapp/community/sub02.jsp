<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
//세션영역에 tname속성으로 테이블명 저장
session.setAttribute("tname", "protector_board");
session.setAttribute("seqname", "seq_protector_num");
response.sendRedirect("../board/list.do");
%>
