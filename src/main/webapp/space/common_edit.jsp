<%@page import="utils.JSFunction"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");
String tname = session.getAttribute("tname").toString();
BoardDAO dao = new BoardDAO();
// view.jsp와 동일하지만 조회수 증가하는 로직은 추가되면 안된다.
/* dao.updateVisitCount(num); */

// 기존 게시물의 내용을 일거온다.
BoardDTO dto = dao.selectView(num, tname);
// 세션영역에 저장된 회원아이디를 가져와서 문자열로 변환한다.
String sessionId = session.getAttribute("UserId").toString();
// 로그인한 회원이 해당게시물의 작성자인지 확인한다.
if (!sessionId.equals(dto.getId())) {
	// 작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다.
	JSFunction.alertLocation("작성자 본인만 수정할 수 있습니다.", "./sub01_list.jsp", out);
	return;
}
dao.close();
%>